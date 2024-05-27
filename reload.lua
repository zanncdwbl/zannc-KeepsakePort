-- Adding Keepsake to Rack in order
function CreateKeepsake_Order()
    -- =================================================
    --                     Thanatos
    -- =================================================
    table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "PerfectClearDamageBonusKeepsake")
    
    game.GiftData.NPC_Thanatos_01 = {
        [1] = {
            Gift = "PerfectClearDamageBonusKeepsake"
        },
        InheritFrom = { "DefaultGiftData" },
        Name = "PerfectClearDamageBonusKeepsake"
    }

    -- =================================================
    --                     Persephone
    -- =================================================
    table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "ChamberStackTrait")
    
    game.GiftData.NPC_Persephone_01 = {
        [1] = {
            Gift = "ChamberStackTrait"
        },
        InheritFrom = { "DefaultGiftData" },
        Name = "ChamberStackTrait"
    }
end

--Creating Keepsakes With all data since its not automatic like the base game
function CreateKeepsake_Data()
    -- =================================================
    --                     Thanatos
    -- =================================================
	game.TraitData.PerfectClearDamageBonusKeepsake = {
		InheritFrom = { "GiftTrait" },
        Name = "PerfectClearDamageBonusKeepsake",
		-- InRackTitle = "PerfectClearDamageBonusKeepsake_Rack",
		CustomTrayText = "PerfectClearDamageBonusKeepsake_Tray",
		Icon = "Keepsake_01",
        ShowInHUD = true,
		-- EquipSound = "/SFX/Menu Sounds/KeepsakeArtemisArrow",
		PriorityDisplay = true,
        NoFrame = true,
        ChamberThresholds = { 25, 50 },
        HideInRunHistory = true,
        Slot = "Keepsake",
        InfoBackingAnimation = "KeepsakeSlotBase",
        RecordCacheOnEquip = true,
        TraitOrderingValueCache = -1,
        ActiveSlotOffsetIndex =  0,

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

		SignOffData = {
			{
				Text = "SignoffThanatos",
			},
		},
	}

    -- =================================================
    --                     Persephone
    -- =================================================
    game.TraitData.ChamberStackTrait =
	{
		InheritFrom = { "GiftTrait" },
        Name = "ChamberStackTrait",
		Icon = "Keepsake_02",
		-- InRackTitle = "ChamberStackTrait_Rack",
		-- EquipSound = "/SFX/Menu Sounds/KeepsakePersephonePomBlossom",
        ShowInHUD = true,
		PriorityDisplay = true,
        NoFrame = true,
        ChamberThresholds = { 1, 2 },
        HideInRunHistory = true,
        Slot = "Keepsake",
        InfoBackingAnimation = "KeepsakeSlotBase",
        RecordCacheOnEquip = true,
        TraitOrderingValueCache = -1,
        ActiveSlotOffsetIndex =  0,

        CustomRarityLevels = {
            "TraitLevel_Keepsake1",
            "TraitLevel_Keepsake2",
            "TraitLevel_Keepsake3",
            "TraitLevel_Keepsake4",
        },

        RarityLevels = {
            Common = { Multiplier = 1.0 },
            Rare = { Multiplier = 5/6 },
            Epic = { Multiplier = 4/6 },
        },

        RoomsPerUpgrade = 
		{ 
			Amount = 6,
            TraitStacks = 1, -- Adding cause of TraitLogic in h2
            -- SourceIsMultiplier = true,
			-- TransformBlessing = true,
			ReportValues = 
			{ 
				ReportedRoomsPerUpgrade = "Amount" 
			},
		},
		CurrentRoom = 0,
		ExtractValues =
		{
			{
				Key = "ReportedRoomsPerUpgrade",
				ExtractAs = "TooltipRoomInterval",
			}
		},

		SignOffData =
		{
            {
                Text = "SignoffPersephone",
            }
	    }
    }
end

-- Calling Functions
CreateKeepsake_Order()
CreateKeepsake_Data()

-- Specifically for Thanatos Keepsake
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
                -- CheckAchievement( { Name = "AchBuffedButterfly", CurrentValue = traitData.AccumulatedDamageBonus } )
            end
        end
    end
    CheckChamberTraits() -- suddenly everything works now..
end

-- function CheckOnRoomClearTraits_wrap( base, args )
-- 	if not game.currentRoom.BlockClearRewards and not game.currentEncounter.ProcessedOnRoomClear then
-- 		game.currentEncounter.ProcessedOnRoomClear = true
-- 		for k, traitData in pairs(game.currentRun.Hero.Traits) do
-- 			if not game.currentEncounter.PlayerTookDamage and traitData.PerfectClearDamageBonus then
-- 				traitData.AccumulatedDamageBonus = traitData.AccumulatedDamageBonus + (traitData.PerfectClearDamageBonus - 1)
-- 				PerfectClearTraitSuccessPresentation( traitData )
-- 				CurrentRun.CurrentRoom.PerfectEncounterCleared = true
-- 			end
--         end
--     end
-- end

-- function PerfectClearTraitStartPresentation( traitData )
-- 	-- PlaySound({ Name = "/EmptyCue" })
-- 	TraitUIActivateTrait( traitData )
-- end