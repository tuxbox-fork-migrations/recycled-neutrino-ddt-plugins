--[[
	##########################################
	#            Auto Timer Menu             #
	#  simple menu for pr-auto-timer script  #
	#       by BPanther - 24-Jun-2023        #
	##########################################

	CHANNELNAME;			(Name/*Bouqnr)			(1)
	DAYOFWEEK[,TIMESPAN];		(WDay/*[,XX:XX-XX:XX])		(2)
	REGEX[,MODIFIER]		(SText[,!+-...]			(2)
	[;FLAGS]			(R/Z/I/F/O/D/W/M)		(8)
	[;RECDIR]			(RecDir)			(1)
]]

local lname = "Auto Timer Menu"
local version = "v1.25"
local lname_version = lname .. " - " .. version
local micon = arg[0]:match('.*/') .. "/pr-auto-timer_hint.png"

n = neutrino()

locale = {}
locale["deutsch"] = {
	options=lname_version,
	opt1 = "Sendername/Bouquet",
	opt2 = "Wochentag/Zeitspanne",
	opt3 = "Suchtext",
	opt4 = "Parameter (optional)",
	opt5 = "Aufnahmeverzeichnis (optional)",
	save_rules = "Speichere Einstellungen in pr-auto-timer.rules",
	save_rules_ok = "Einstellungen in pr-auto-timer.rules gespeichert.",
	save_rules_hint = "Die Einstellungen können in die pr-auto-timer.rules hinzugefügt werden.",
	show_rules = "Gespeicherte Einstellungen in pr-auto-timer.rules anzeigen/löschen",
	show_rules_hint = "Gespeicherte Einstellungen in pr-auto-timer.rules anzeigen/löschen",
	del_rule = "Löschen?",
	rem_rule = "Entfernt:",
	not_rem_rule = "NICHT entfernt:",
	no_rules = "Keine Einträge in pr-auto-timer.rules gefunden.",
	hint1 = "Sendername, z.B. 'Das Erste HD' oder Bouquetnummer, z.B. '*1'.",
	hint2 = "Wochentag (engl. Mon..Sun, Weekday, Weekend oder '*' für alle). Zeitspanne z.B. 09:00-12:00 mit Komma getrennt möglich, z.B. '*,09:00-12:00' oder 'Sun,09:00-12:00'",
	hint3 = "Suchtext, z.B. 'Tatort'.",
	hint4 = "Flags: R/Z/I/F/O/D/W/M - siehe Beschreibung in pr-auto-timer.rules",
	hint5 = "Aufnahmeverzeichnis",
	act = "Suche starten / Timer anlegen"
}
locale["english"] = {
	options=lname_version,
	opt1 = "Channelname/Bouquet",
	opt2 = "Day of week/Timespan",
	opt3 = "Text to search",
	opt4 = "Flags (optional)",
	opt5 = "Record dirrectory (optional)",
	save_rules = "Save settings to pr-auto-timer.rules",
	save_rules_ok = "Settings to pr-auto-timer.rules saved.",
	save_rules_hint = "Add settings to pr-auto-timer.rules.",
	show_rules = "Show/Remove saved settings in pr-auto-timer.rules",
	show_rules_hint = "Show/Remove saved settings in pr-auto-timer.rules",
	del_rule = "Delete?",
	rem_rule = "Removed",
	not_rem_rule = "NOT removed:",
	no_rules = "No valid entrys in pr-auto-timer.rules found.",
	hint1 = "Channel name, e.g. 'Das Erste HD' or Bouquet number, z.B. '*1'.",
	hint2 = "Day of week (Mon..Sun, Weekday, Weekend or '*' for all). Time span e.g. 09:00-12:00 also possible, e.g. '*,09:00-12:00' or 'Sun,09:00-12:00'",
	hint3 = "Search text, e.g. 'Tatort'.",
	hint4 = "Flags: R/Z/I/F/O/D/W/M - description see pr-auto-timer.rules",
	hint5 = "record directory",
	act = "Start search / create timer"
}

neutrino_conf = configfile.new()
neutrino_conf:loadConfig("/var/tuxbox/config/neutrino.conf")
rec_dir = neutrino_conf:getString("network_nfs_recordingdir", "/media/sda1/movies")
lang = neutrino_conf:getString("language", "english")
if locale[lang] == nil then
	lang = "english"
end

conf = {}
function save_config()
	local config = configfile.new()
	config:setString("#param_1", conf.param_1)
	config:setString("#param_2", conf.param_2)
	config:setString("#param_3", conf.param_3)
	config:setString("#param_4", conf.param_4)
	config:setString("#param_5", conf.param_5)
	config:saveConfig(arg[0]:match('.*/') .. "/pr-auto-timer-menu.conf")
	os.execute('echo "' .. conf.param_1 .. ";" .. conf.param_2 .. ";" .. conf.param_3 .. ";" .. conf.param_4 .. ";" .. conf.param_5 .. '" >> ' .. arg[0]:match('.*/') .. '/pr-auto-timer-menu.conf')
end
function load_config()
	local fh = filehelpers.new()
	if not fh:exist(arg[0]:match('.*/') .. "/pr-auto-timer.rules", "f") then
		fh:touch(arg[0]:match('.*/') .. "/pr-auto-timer.rules")
	end
	local config = configfile.new()
	config:loadConfig(arg[0]:match('.*/') .. "/pr-auto-timer-menu.conf")
	conf.param_1 = config:getString("#param_1", "*")
	conf.param_2 = config:getString("#param_2", "*")
	conf.param_3 = config:getString("#param_3", "*")
	conf.param_4 = config:getString("#param_4", "R,D")
	conf.param_5 = config:getString("#param_5", rec_dir)
end

function setVal(k, v)
	if k == "id1" then
		conf.param_1 = v
	elseif k == "id2" then
		conf.param_2 = v
	elseif k == "id3" then
		conf.param_3 = v
	elseif k == "id4" then
		conf.param_4 = v
	elseif k == "id5" then
		conf.param_5 = v
	end
end

function exec()
	save_config()
	os.execute(arg[0]:match('.*/') .. "/pr-auto-timer --menu --ext")
	return MENU_RETURN.REPAINT
end

function save_rules()
	os.execute('echo "' .. conf.param_1 .. ";" .. conf.param_2 .. ";" .. conf.param_3 .. ";" .. conf.param_4 .. ";" .. conf.param_5 .. '" >> ' .. arg[0]:match('.*/') ..  '/pr-auto-timer.rules')
	messagebox.exec{title=locale[lang].options, text=locale[lang].save_rules_ok, icon=micon, timeout=5, buttons={"ok"}}
	return MENU_RETURN.REPAINT
end

function del_rules(name)
	local res = messagebox.exec {
		title = locale[lang].options,
		icon = micon,
		text = locale[lang].del_rule .. "\n\n" .. name,
		timeout = 0,
		width = 350,
		buttons={ "yes", "no" },
		default = "no"
	}
	if res == "yes" then
		local f = io.open("/tmp/pr-auto-timer.rules", "wb")
		for line in io.lines(arg[0]:match('.*/') .. "/pr-auto-timer.rules") do
			if line ~= name then
				if f then
					f:write(line .. "\n")
				end
			end
		end
		if f then
			f:close()
		end
		os.execute("mv /tmp/pr-auto-timer.rules " .. arg[0]:match('.*/') .. "/pr-auto-timer.rules")
		messagebox.exec{title=locale[lang].options, text=locale[lang].rem_rule .. "\n\n" .. name, icon=micon, timeout=5, buttons={"ok"}, width=350}
	else
		messagebox.exec{title=locale[lang].options, text=locale[lang].not_rem_rule .. "\n\n" .. name, icon=micon, timeout=5, buttons={"ok"}, width=350}
	end
	return MENU_RETURN.EXIT
end

function show_rules()
	menu:hide()
	local lines = {}
	for line in io.lines(arg[0]:match('.*/') .. "/pr-auto-timer.rules") do
		if not line:match("#(.-)") and line:match("(.-);(.-)") then
			lines[#lines + 1] = line
		end
	end
	local found = 0
	local m = menu.new{name=locale[lang].options, mwidth=50, icon=micon}
	for i, n in ipairs(lines) do
		found = 1
		m:addItem{type="forwarder", action="del_rules", name=n, id=n}
	end
	if found ~= 0 then
		m:exec()
	else
		messagebox.exec{title=locale[lang].options, text=locale[lang].no_rules, icon=micon, timeout=5, buttons={"ok"}, width=350}
	end
	return MENU_RETURN.REPAINT
end

load_config()
if arg[1] and arg[2] and arg[3] then
	conf.param_1 = arg[1]
	conf.param_2 = arg[2]
	conf.param_3 = arg[3]
end

repeat
	msg, data = n:GetInput(500)
	menu = menu.new{icon=micon, name=locale[lang].options, mwidth=50}
	menu:addItem{type="back"}
	menu:addItem{type="separatorline"}
	menu:addItem{type="keyboardinput", name=locale[lang].opt1, action="setVal", id="id1", value=conf.param_1, size=32, icon="1", directkey=RC['1'], hint=locale[lang].hint1}
	menu:addItem{type="keyboardinput", name=locale[lang].opt2, action="setVal", id="id2", value=conf.param_2, size=32, icon="2", directkey=RC['2'], hint=locale[lang].hint2}
	menu:addItem{type="keyboardinput", name=locale[lang].opt3, action="setVal", id="id3", value=conf.param_3, size=32, icon="3", directkey=RC['3'], hint=locale[lang].hint3}
	menu:addItem{type="keyboardinput", name=locale[lang].opt4, action="setVal", id="id4", value=conf.param_4, size=32, icon="4", directkey=RC['4'], hint=locale[lang].hint4}
	menu:addItem{type="filebrowser",   name=locale[lang].opt5, action="setVal", id="id5", value=conf.param_5, size=32, icon="5", directkey=RC['5'], hint=locale[lang].hint5, dir_mode="1"}
	menu:addItem{type="separatorline"}
	menu:addItem{type="chooser", action="exec", options={locale[lang].act}, directkey=RC["red"], id="0"}
	menu:addItem{type="chooser", action="save_rules", options={locale[lang].save_rules}, directkey=RC["blue"], id="0", hint=locale[lang].save_rules_hint}
	menu:addItem{type="separatorline"}
	menu:addItem{type="chooser", action="show_rules", options={locale[lang].show_rules}, directkey=RC["yellow"], id="0", hint=locale[lang].show_rules_hint}
	menu:exec()
	save_config()
until msg == RC.home or true
