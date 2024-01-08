local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.disable_default_key_bindings = false

-- Function from: https://stackoverflow.com/a/17878208
local function prequire(m)
	local ok, err = pcall(require, m)
	if not ok then
		return nil, err
	end
	return err
end

local modules = {
	"appearence",
	"fonts",
	"keys",
	"overrides",
}

for _, s in ipairs(modules) do
	local mod = prequire(s)
	if mod then
		mod.apply_to_config(config)
	end
end

config.scrollback_lines = 10000

return config
