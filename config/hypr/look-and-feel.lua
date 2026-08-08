-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 7,
        border_size = 3,

        col = {
            active_border   = {
              colors = {"rgba(cc77aaee)", "rgba(33ffeeee)"}, angle = 69 },
            inactive_border = "rgba(aa77aaaa)",
        },

        -- Click and drag on window borders to resize
        resize_on_border = true,

        layout = "master",
    },

    decoration = {
        rounding       = 2,
        rounding_power = 10,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = false,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})
