#!/usr/bin/env bash

SWAPFILE="/swap/swapfile"

# Cancel execution of script if error encountered
set -euo pipefail

cmd="${1:-report}"
SWAPFILE="/swap/swapfile"

confirm() {
    local prompt="$1"
    read -r -p "$prompt [y/N]: " reply

    case "$reply" in
        y|Y|yes|YES)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}


has_active_swapfile() {
    swapon --show=NAME --noheadings | grep -qx "$SWAPFILE"
}


case "$cmd" in
    ### REPORT CASE ###
    report)
        echo "MEMORY"
        echo "------"
        free -h
        echo

        echo "SWAP"
        echo "----"
        swapon --show || true
        echo

        echo "ZRAM"
        echo "----"
        zramctl || true
        echo

        echo "MEMORY PRESSURE"
        echo "---------------"
        cat /proc/pressure/memory || true
        ;;


    ### CHECKUP CASE ###
    checkup)
        echo "MEMORY CHECKUP"
        echo "--------------"

        echo -n "swapfile: "
        if [[ -f "$SWAPFILE" ]]; then
            echo "present"
        else
            echo "missing"
            echo "  fix: ahelper memory swap --size 16G"
        fi

        echo -n "swap active: "
        if has_active_swapfile; then
            echo "yes"
        else
            echo "no"
            echo "  fix: ahelper memory swap --size 16G"
        fi

        echo -n "fstab entry: "
        if grep -q "$SWAPFILE" /etc/fstab; then
            echo "present"
        else
            echo "missing"
            echo "  fix: ahelper memory swap --size 16G"
        fi

        echo -n "zram devices: "
        if zramctl | grep -q '^/dev/zram'; then
            echo "present"
        else
            echo "none"
            echo "  fix: install and configure zram-generator"
        fi

        echo -n "earlyoom: "
        if systemctl is-active --quiet earlyoom.service; then
            echo "active"
        else
            echo "inactive"
            echo "  fix: ahelper memory earlyoom"
        fi

        echo -n "memory PSI: "
        if [[ -r /proc/pressure/memory ]]; then
            echo "available"
        else
            echo "unavailable"
            echo "  fix: use a kernel with PSI enabled"
        fi
        ;;  ### END 


    ### SWAP CASE ###
    swap)
        size="${3:-16G}"

        if [[ "${2:-}" == "--size" ]]; then
            size="$3"
        fi

        echo "About to create and enable a btrfs swapfile:"
        echo "  path: $SWAPFILE"
        echo "  size: $size"
        echo "  fstab: add persistent entry if missing"
        echo

        if [[ -f "$SWAPFILE" ]] || has_active_swapfile; then
            echo "Existing swapfile detected:"
            swapon --show || true
            echo

            if ! confirm "Recreate $SWAPFILE?"; then
                echo "aborted"
                exit 0
            fi

        else
            if ! confirm "Continue?"; then
                echo "aborted"
                exit 0
            fi
        fi

        # 
        # remove pre-existing /swap dir with /swap/swapfile if exists
        sudo swapoff "$SWAPFILE" 2>/dev/null || true
        sudo rm -rf /swap

        # initialize the subvolume and make swapfile
        sudo btrfs subvolume create /swap
        sudo btrfs filesystem mkswapfile --size "$size" "$SWAPFILE"
        sudo swapon --fixpgsz "$SWAPFILE"

        # register the logical volume in the file system table
        if ! grep -q "$SWAPFILE" /etc/fstab; then
            echo "$SWAPFILE none swap defaults 0 0" | sudo tee -a /etc/fstab
        fi

        # display newly-available swap
        swapon --show
        ;;  
        ### END SWAP CASE ###

    ### ZRAM CASE ###
        zram)
        ZRAM_CONF="/etc/systemd/zram-generator.conf"

        echo "About to configure zram using zram-generator:"
        echo "  config: $ZRAM_CONF"
        echo "  device: /dev/zram0"
        echo "  size: ram / 2"
        echo "  algorithm: zstd"
        echo

        if zramctl | grep -q '^/dev/zram'; then
            echo "Existing zram device detected:"
            zramctl
            echo

            if ! confirm "Reconfigure zram anyway?"; then
                echo "aborted"
                exit 0
            fi
        else
            if ! confirm "Continue?"; then
                echo "aborted"
                exit 0
            fi
        fi

        sudo pacman -S --needed zram-generator

        sudo tee "$ZRAM_CONF" >/dev/null <<'EOF'
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
EOF

        sudo systemctl daemon-reload
        sudo systemctl start systemd-zram-setup@zram0.service

        echo
        zramctl
        swapon --show
        ;;  ### END ZRAM CASE ###

    ### EARLYOOM - out of memory - CASE ###
        earlyoom)
        echo "About to install and enable earlyoom:"
        echo "  package: earlyoom"
        echo "  service: earlyoom.service"
        echo "  purpose: prevent full-system lockups under memory pressure"
        echo

        if systemctl is-active --quiet earlyoom.service; then
            echo "earlyoom is already active."
            systemctl status earlyoom.service --no-pager
            exit 0
        fi

        if ! confirm "Continue?"; then
            echo "aborted"
            exit 0
        fi

        sudo pacman -S --needed earlyoom
        sudo systemctl enable --now earlyoom.service

        echo
        systemctl status earlyoom.service --no-pager
        ;;  ### END EARLYOOM ###


    ### FINAL CATCH-ALL CASE ###
    *)
        echo "Unknown memory command: $cmd"
        echo
        echo "Usage:"
        echo "  ahelper memory report"
        echo "  ahelper memory checkup"
        echo "  ahelper memory swap --size 16G"
        exit 1
        ;;
esac
