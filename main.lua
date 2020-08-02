--- This section is for letting people know that you leveled up ---
local Ding_EventFrame = CreateFrame("Frame")
Ding_EventFrame:RegisterEvent("PLAYER_LEVEL_UP")
Ding_EventFrame:SetScript("OnEvent",
	function(self, event, ...)
		local level, healthDelta, powerDelta, numNewTalents, numNewPvpTalentSlots, strengthDelta, agilityDelta, staminaDelta, intellectDelta = ...
		print('Fuck You and Congratulations on reaching level ' .. level .. '')
	end)