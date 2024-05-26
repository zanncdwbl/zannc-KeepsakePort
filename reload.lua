function CreateKeepsake_Order()
    table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "PerfectClearDamageBonusKeepsake")
    
    game.GiftData.NPC_Thanatos_01 = {
        [1] = {
            GameStateRequirements = {
                {
					PathTrue = { "GameState", "TextLinesRecord", "ArtemisGift01" },
				},
            },
            Gift = "PerfectClearDamageBonusKeepsake"
        },
        InheritFrom = { "DefaultGiftData" },
        Name = "PerfectClearDamageBonusKeepsake"
    }
end

function CreateKeepsake_Data()
	game.TraitData.PerfectClearDamageBonusKeepsake = {
		InheritFrom = { "GiftTrait" },
		InRackTitle = "PerfectClearDamageBonusKeepsake_Rack",
		Icon = "Keepsake_10",
        ShowInHUD = true,
        Name = "PerfectClearDamageBonusKeepsake",
		-- EquipSound = "/SFX/Menu Sounds/KeepsakeArtemisArrow",
		PriorityDisplay = true,
        NoFrame = true,

        PerfectClearDamageBonus =
		{
			BaseValue = 1.01,
			SourceIsMultiplier = true,
			DecimalPlaces = 3,
		},
		AddOutgoingDamageModifiers =
		{
			UseTraitValue = "AccumulatedDamageBonus",
		},
		AccumulatedDamageBonus = 1,

        ExtractValues =
		{
			{
				Key = "PerfectClearDamageBonus", 
				ExtractAs = "TooltipPerfectClearBonus", 
				Format = "PercentDelta",
				DecimalPlaces = 1,
			},
			{
				Key = "AccumulatedDamageBonus",
				ExtractAs = "TooltipAccumulatedBonus",
				Format = "PercentDelta",
				DecimalPlaces = 1,
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
            Rare = { Multiplier = 1.5 },
            Epic = { Multiplier = 2.0 },
            Heroic = { Multiplier = 3.0 },
        },

        ChamberThresholds = { 25, 50 },
        HideInRunHistory = true,
        Slot = "Keepsake",
        InfoBackingAnimation = "KeepsakeSlotBase",
        RecordCacheOnEquip = true,
        TraitOrderingValueCache = -1,
        ActiveSlotOffsetIndex =  0,

		SignOffData = {
			{
				Text = "SignoffThanatos",
			},
		},
	}

	-- OverwriteTableKeys(game.TraitData, game.TraitSetData.Keepsakes)
end

CreateKeepsake_Order()
CreateKeepsake_Data()

function StartEncounterEffects_wrap( base, currentRun )
	if not currentRun.CurrentRoom.BlockClearRewards then
		for i, traitData in pairs( currentRun.Hero.Traits ) do
            if traitData.PerfectClearDamageBonus then
				PerfectClearTraitStartPresentation( traitData )
			end
        end
    end
end

function EndEncouterEffects_wrap( base, args )
    if not game.currentRoom.BlockClearRewards then
        for k, traitData in pairs(currentRun.Hero.Traits) do
            if not game.currentEncounter.PlayerTookDamage and traitData.PerfectClearDamageBonus then
                traitData.AccumulatedDamageBonus = traitData.AccumulatedDamageBonus + (traitData.PerfectClearDamageBonus - 1)
                PerfectClearTraitSuccessPresentation( traitData )
                game.CurrentRun.CurrentRoom.PerfectEncounterCleared = true
                CheckAchievement( { Name = "AchBuffedButterfly", CurrentValue = traitData.AccumulatedDamageBonus } )
            end
        end
    end
end

function CheckOnRoomClearTraits_wrap( base, args )
	if not game.currentRoom.BlockClearRewards and not game.currentEncounter.ProcessedOnRoomClear then
		game.currentEncounter.ProcessedOnRoomClear = true
		for k, traitData in pairs(game.currentRun.Hero.Traits) do
			if not game.currentEncounter.PlayerTookDamage and traitData.PerfectClearDamageBonus then
				traitData.AccumulatedDamageBonus = traitData.AccumulatedDamageBonus + (traitData.PerfectClearDamageBonus - 1)
				PerfectClearTraitSuccessPresentation( traitData )
				CurrentRun.CurrentRoom.PerfectEncounterCleared = true
			end
        end
    end
end

-- function PerfectClearTraitStartPresentation( traitData )
-- 	-- PlaySound({ Name = "/EmptyCue" })
-- 	TraitUIActivateTrait( traitData )
-- end

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

print("printing trait data keepsakes")
printTable(game.TraitData.PerfectClearDamageBonusKeepsake)
print("=============================================")
print("DONE TRAIT DATA KEEPSAKES")
print("=============================================")