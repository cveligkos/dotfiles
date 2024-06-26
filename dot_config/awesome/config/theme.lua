-- local gears = require("gears")
-- Theme handling library
local beautiful = require("beautiful")

local themes_dir = os.getenv("HOME") .. "/.config/awesome/themes"

-- Themes define colours, icons, font and wallpapers.
beautiful.init(themes_dir .. "/default/theme.lua")
