# ahelper-memory

Memory management and observability tools for sustainable ARM64 Linux systems.

This module manages:

- swap
- zram
- memory pressure reporting
- early out-of-memory detection and intervention (`earlyoom`)


It is part of the broader Sustainable AArch Stack ecosystem.


---

# Primary Platform Targets

This module is currently designed primarily for:

- Arch Linux
- Btrfs
- ARM64 systems

including:

- Apple Silicon systems running Asahi Linux
- NVIDIA Jetson devices
- Raspberry Pi systems
- lightweight ARM64 laptops
- edge inference systems

The Sustainable AArch Stack is intentionally opinionated.

The goal is not to support every possible Linux configuration equally. The goal is to provide coherent, reproducible operational infrastructure for sustainable ARM64 systems.

Additional filesystem or distribution support may eventually exist as separate community modules.

---

# Why This Exists

Modern ARM64 systems are remarkably energy-efficient, but many operate under relatively constrained memory conditions compared to traditional workstation hardware.

These systems are extremely capable, but only if memory is managed carefully and transparently.

Out-of-memory crashes, hidden swap behavior, memory pressure spikes, and unstable inference workloads can make otherwise excellent hardware feel unreliable or fragile.

The goal of this module is to turn memory management from:

```text
mysterious system behavior
```

into:

```text
observable operational infrastructure
```

---

# Why Arch Linux Needs Explicit Memory Setup

Arch Linux intentionally provides minimal defaults.

This is a feature, not a flaw.

However, it means many important operational behaviors are left to the user, including:

- swap configuration
- zram setup
- low-memory handling
- pressure monitoring
- early out-of-memory intervention

On traditional high-memory desktop systems this may matter less.

On sustainable ARM64 systems running:

- local AI inference
- agent-based models
- Quarto rendering
- browser-heavy workflows
- robotics software
- GPU workloads

memory management becomes critical infrastructure.

---

# Why Btrfs

Btrfs aligns strongly with the goals of the Sustainable AArch Stack:

- snapshots
- subvolumes
- compression
- operational visibility
- reproducible deployment workflows

The stack is therefore designed around Btrfs as the primary filesystem target rather than treating all Linux filesystems as interchangeable.

This keeps:
- tooling cleaner
- documentation simpler
- operational assumptions more coherent
- testing surfaces smaller
- deployment behavior more reproducible

The architecture remains modular, so alternative filesystem modules can still exist independently.

---

# Sustainable Compute Requires Stable Memory

The Sustainable AArch Stack is not merely about low power consumption.

It is about:

- efficiency
- reproducibility
- observability
- durability
- operational clarity

Memory management is central to all of these.

A system that crashes unpredictably:
- wastes energy
- wastes time
- destroys trust
- discourages adoption

A system with transparent memory behavior:
- stays responsive longer
- handles workloads more gracefully
- supports inference workloads reliably
- extends the useful life of hardware
- reduces unnecessary hardware replacement

Good memory tooling is therefore a sustainability technology.

---

# Included Functionality

## Memory Reports

```bash
ahelper memory report
```

Prints:

- memory usage
- swap usage
- zram status
- Linux memory pressure information

This provides fast operational visibility into system health.

---

## Swap Setup

```bash
ahelper memory swap --size 16G
```

Creates and enables a swapfile optimized for:

- Arch Linux
- Btrfs
- ARM64 workflows

Current implementation focuses on reproducible swap setup for sustainable compute systems rather than generic Linux compatibility.

---


## ZRAM Setup

Compressed in-memory swap devices for improved responsiveness under memory pressure.

Especially important on:
- Jetson systems
- Raspberry Pi systems
- lower-memory ARM64 hardware


```bash
ahelper memory zram
```

Installs zram-generator, writes an opinionated /etc/systemd/zram-generator.conf, and starts /dev/zram0.

Current defaults:

```
size: ram / 2
compression: zstd
swap priority: 100
```

This provides compressed in-memory swap for better responsiveness under memory pressure.

---

## EarlyOOM

Early low-memory intervention to prevent catastrophic desktop lockups.

```bash
ahelper memory earlyoom
```

Installs and enables earlyoom, a small daemon that prevents catastrophic
low-memory lockups.

`earlyoom` watches free memory and swap. If the system gets dangerously low, it
kills a large memory-hungry process before the machine becomes completely
unresponsive.

This is especially useful on constrained ARM64 systems running browsers, local
inference workloads, Quarto renders, or other memory-heavy processes.

---

# Planned Features


## Web-available Memory Pressure and Efficiency Observability

Linux PSI (Pressure Stall Information) integration and future web dashboards.

Potential future integration:

```bash ahelper efficiency-watcher --port 7979 ```

with live: - memory pressure - swap activity - thermal state - inference
telemetry

---

# Philosophy

This module treats memory management as:

```text platform infrastructure ```

rather than:

```text afterthought tuning ```

The Sustainable AArch Stack aims to make advanced ARM64 systems:

- understandable - reproducible - stable - efficient - deployable by normal
humans

Good memory management is foundational to that mission.
