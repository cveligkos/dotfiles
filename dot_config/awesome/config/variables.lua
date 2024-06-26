local terminal = "kitty"
local editor = os.getenv("EDITOR") or "nvim"

return {
	modkey = "Mod4",
	terminal = terminal,
	editor = editor,
	editor_cmd = terminal .. " -e " .. editor,
	launcher_cmd = "rofi -show drun",
	web_browser = "firefox",
}
