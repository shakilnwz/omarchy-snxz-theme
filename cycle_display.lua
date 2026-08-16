local function cycle_display()
	local function get_output(cmd)
		local handle = io.popen(cmd)
		if not handle then return "" end
		local result = handle:read("*a")
		handle:close()
		return result
	end

	local all_monitors = get_output("hyprctl monitors all")
	local active_monitors = get_output("hyprctl monitors")

	local all = {}
	local active = {}

	for name in all_monitors:gmatch("Monitor (%S+) %(") do
		table.insert(all, name)
	end

	for name in active_monitors:gmatch("Monitor (%S+) %(") do
		active[name] = true
	end

	local internal_mon = nil
	local external_mons = {}

	for _, name in ipairs(all) do
		if name:match("^eDP") or name:match("^LVDS") then
			internal_mon = name
		else
			table.insert(external_mons, name)
		end
	end

	if not internal_mon then internal_mon = all[1] end

	if #external_mons == 0 then
		os.execute('notify-send -t 2000 "Display Switcher" "No secondary monitor connected."')
		if internal_mon and not active[internal_mon] then
			os.execute('hyprctl keyword monitor "' .. internal_mon .. ', preferred, auto, 1"')
		end
		return
	end

	local external_mon = external_mons[1]
	local internal_active = active[internal_mon] or false
	local external_active = active[external_mon] or false

	if internal_active and external_active then
		os.execute('hyprctl keyword monitor "' .. internal_mon .. ', disable"')
		os.execute('hyprctl keyword monitor "' .. external_mon .. ', preferred, auto, 1"')
		os.execute('notify-send -t 2000 "Display Switcher" "Secondary Display Only: ' .. external_mon .. '"')
	elseif external_active then
		os.execute('hyprctl keyword monitor "' .. internal_mon .. ', preferred, auto, 1"')
		os.execute('hyprctl keyword monitor "' .. external_mon .. ', disable"')
		os.execute('notify-send -t 2000 "Display Switcher" "Laptop Display Only: ' .. internal_mon .. '"')
	else
		os.execute('hyprctl keyword monitor "' .. internal_mon .. ', preferred, auto, 1"')
		os.execute('hyprctl keyword monitor "' .. external_mon .. ', preferred, auto, 1"')
		os.execute('notify-send -t 2000 "Display Switcher" "Both Displays Enabled"')
	end
end

return cycle_display
