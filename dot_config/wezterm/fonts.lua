local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
    config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
end

return module
