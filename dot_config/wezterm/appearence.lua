local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
    config.color_scheme = "Catppuccin Mocha"
    config.font = wezterm.font("CaskaydiaCove Nerd Font")

    config.use_fancy_tab_bar = false
    config.enable_tab_bar = false

    config.audible_bell = "Disabled"
    config.visual_bell = {
        fade_in_duration_ms = 75,
        fade_out_duration_ms = 75,
        target = "CursorColor",
    }
    config.max_fps = 165
end

return module
