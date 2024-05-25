---@meta _
---@diagnostic disable: lowercase-global

function printTable(tbl, indent)
    indent = indent or 0
    local formatting = string.rep("  ", indent)
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            print(formatting .. k .. ":")
            printTable(v, indent + 1)
        else
            print(formatting .. k .. ": " .. tostring(v))
        end
    end
end

function CreateKeepsake_Order()
    table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "PiercedButterflyKeepsake")
    
    game.GiftData.Thanatos = {
        [1] = {
            GameStateRequirements = {
                {
					PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift01" },
				},
            },
            Gift = "PiercedButterflyKeepsake"
        },
        InheritFrom = { "DefaultGiftData" },
        Name = "PiercedButterflyKeepsake"
        -- Locked = 5,
        -- Value = 0,
        -- Maximum = 8
    }
    -- print("\n\n\n\n\n")
    -- print("printing item order")
    -- printTable(game.ScreenData.KeepsakeRack.ItemOrder)
    -- print("=============================================")
    -- print("DONE ITEM ORDER")
    -- print("=============================================")

    -- print("\n\n\n\n\n")
    -- print("printing gift data")
    -- printTable(game.GiftData)
    -- print("=============================================")
    -- print("DONE GIFT DATA")
    -- print("=============================================")
    -- print("\n\n\n\n\n")
end

-- function CreateKeepsake_Data()
-- 	game.TraitSetData.Keepsakes.PiercedButterflyKeepsake = 
-- 	{
-- 		InheritFrom = { "GiftTrait" },
-- 		InRackTitle = "PiercedButterflyKeepsake_Rack",
-- 		Icon = "Keepsake_10",
-- 		-- EquipSound = "/SFX/Menu Sounds/KeepsakeArtemisArrow",
-- 		PriorityDisplay = true,
-- 		LowHealthThresholdText =
-- 		{
-- 			-- Display variable only, to change the data value change the value below under "LowHealthThreshold"
-- 			Threshold = 30,
-- 			Text = "Hint_Thanatos",
-- 		},
-- 		AddOutgoingCritModifiers =
-- 		{
-- 			LowHealthThreshold = 30,
-- 			LowHealthChance = { BaseValue = 0.2 },
-- 			ReportValues = { ReportedHealthThreshold = "LowHealthThreshold", ReportedCritBonus = "LowHealthChance"}
-- 		},
-- 		ExtractValues =
-- 		{
-- 			{
-- 				Key = "ReportedHealthThreshold",
-- 				ExtractAs = "Health",
-- 			},
-- 			{
-- 				Key = "ReportedCritBonus",
-- 				ExtractAs = "Chance",
-- 				Format = "Percent",
-- 			},
-- 		},
-- 		SignOffData =
-- 		{
-- 		  {
-- 			Text = "SignoffThanatos",
-- 		  },
-- 		},
-- 	}
--     OverwriteTableKeys(game.TraitData, game.TraitSetData.Keepsakes)
--     print("printing trait data keepsakes")
--     printTable(game.TraitSetData.Keepsakes.PiercedButterflyKeepsake)
--     print("=============================================")
--     print("DONE TRAIT DATA KEEPSAKES")
--     print("=============================================")

--     printTable(game.TraitData)
--     print("=============================================")
--     print("DONE TRAIT DATA")
--     print("=============================================")
-- end

function CreateKeepsake_Data()
	local newKeepsakeData = {
		InheritFrom = { "GiftTrait" },
		InRackTitle = "PiercedButterflyKeepsake_Rack",
		Icon = "Keepsake_10",
        ShowInHUD = true,
        Name = "PiercedButterflyKeepsake",
		-- EquipSound = "/SFX/Menu Sounds/KeepsakeArtemisArrow",
		PriorityDisplay = true,
		LowHealthThresholdText = {
			-- Display variable only, to change the data value change the value below under "LowHealthThreshold"
			Threshold = 30,
			Text = "Hint_Thanatos",
		},
		AddOutgoingCritModifiers = {
			LowHealthThreshold = 30,
			LowHealthChance = { BaseValue = 0.2 },
			ReportValues = { ReportedHealthThreshold = "LowHealthThreshold", ReportedCritBonus = "LowHealthChance" }
		},
		ExtractValues = {
			{
				Key = "ReportedHealthThreshold",
				ExtractAs = "Health",
			},
			{
				Key = "ReportedCritBonus",
				ExtractAs = "Chance",
				Format = "Percent",
			},
		},
        CustomRarityLevels = {
            "TraitLevel_Keepsake1",
            "TraitLevel_Keepsake2",
            "TraitLevel_Keepsake3",
            "TraitLevel_Keepsake4",
        },

        RarityLevels = {
            Common = { Multiplier = 1.0 },
            Rare = { Multiplier = 1.25 },
            Epic = { Multiplier = 1.5 },
            Heroic = { Multiplier = 2.0 }
        },

        ChamberThresholds = { 25, 50 },

		SignOffData = {
			{
				Text = "SignoffThanatos",
			},
		},
	}
	-- Inject the new keepsake data into TraitSetData.Keepsakes
	game.TraitSetData.Keepsakes.PiercedButterflyKeepsake = newKeepsakeData
	
	-- Overwrite TraitData with the updated Keepsakes
	OverwriteTableKeys(game.TraitData, game.TraitSetData.Keepsakes)
end

CreateKeepsake_Order()
CreateKeepsake_Data()