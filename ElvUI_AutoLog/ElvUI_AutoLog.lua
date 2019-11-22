local addon, ns = ...
local E, L, V, P, G, _ = unpack(ElvUI)
local AutoLog = E:NewModule('AutoLog')
local EP = LibStub("LibElvUIPlugin-1.0")

P['AutoLog'] = {
	['Partylog'] = true,
	['Raid'] = true,
}

function AutoLog:GenerateOptions()
	E.Options.args.AutoLog = {
		order = 9010,
		type = 'group',
		name = "AutoLog",
		args = {
			name = {
				order = 1,
				type = "header",
				name = "Autolog enabler",
			},
			desc = {
				order = 2,
				type = "description",
				name = "Auto enables combatlog based on instance/group",
			},
			spacer1 = {
				order = 3,
				type = "description",
				name = "",
			},
			apartylog = {
				order = 4,
				type = "group",
				name = "Config",
				guiInline = true,
				args = {
					party = {
						order = 1,
						name = "Party",
						desc = "Enable logging whenever you enter a party based instance.",
						type = 'toggle',
						get = function(info) return E.db.AutoLog[ info[#info] ] end,
						set = function(info, value) E.db.AutoLog[ info[#info] ] = value; end,
					},
					raid = {
						order = 2,
						name = "Raid",
						desc = "Enable logging whenever you enter a raid based instance.",
						type = 'toggle',
						get = function(info) return E.db.AutoLog[ info[#info] ] end,
						set = function(info, value) E.db.AutoLog[ info[#info] ] = value; end,
					},
				},
			},
		},
	}
end


function AutoLog:Initialize()
	EP:RegisterPlugin(addon, AutoLog.GenerateOptions)
end

local Autologcheck = CreateFrame("Frame")
Autologcheck:RegisterEvent("PLAYER_ENTERING_WORLD")
Autologcheck:RegisterEvent("PLAYER_LOGOUT")
Autologcheck:SetScript("OnEvent", function(self, event,...)
	if event == "PLAYER_LOGOUT" then
		LoggingCombat(0)
		DEFAULT_CHAT_FRAME:AddMessage("AutoLog: Combat log disabled due to logout.")
	else
		local inInstance, instanceType = IsInInstance()
		local loggingCombat = LoggingCombat()
		if(instanceType == "raid" and E.db.AutoLog.raid and not loggingCombat) then
			LoggingCombat(1)
			DEFAULT_CHAT_FRAME:AddMessage("AutoLog: Combat log enabled.")
		elseif(instanceType == "party" and E.db.AutoLog.party and not loggingCombat) then
			LoggingCombat(1)
			DEFAULT_CHAT_FRAME:AddMessage("AutoLog: Combat log enabled.")
		elseif(instanceType == "none" and loggingCombat) then
			LoggingCombat(0)
			DEFAULT_CHAT_FRAME:AddMessage("AutoLog: Combat log disabled.")
		end
	end
end)

function AutoLog:PLAYER_ENTERING_WORLD()
end
E:RegisterModule(AutoLog:GetName())
