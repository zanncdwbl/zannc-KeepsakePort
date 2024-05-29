-- Adding Keepsake to Rack in order
function CreateKeepsake_Order()
    -- =================================================
    --                     Thanatos
    -- =================================================
    if config.EnableThanatos == true then
        table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "PerfectClearDamageBonusKeepsake")
        
        game.GiftData.NPC_Thanatos_01 = {
            [1] = {
                Gift = "PerfectClearDamageBonusKeepsake"
            },
            InheritFrom = { "DefaultGiftData" },
            Name = "PerfectClearDamageBonusKeepsake"
        }
    end

    -- =================================================
    --                     Persephone
    -- =================================================
    if config.EnablePersephone == true then
        table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "ChamberStackTrait")
        
        game.GiftData.NPC_Persephone_01 = {
            [1] = {
                Gift = "ChamberStackTrait"
            },
            InheritFrom = { "DefaultGiftData" },
            Name = "ChamberStackTrait"
        }
    end
end

--Creating Keepsakes With all data since its not automatic like the base game
function CreateKeepsake_Data()
    -- =================================================
    --                     Thanatos
    -- =================================================
    if config.EnableThanatos == true then
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
                Heroic = { Multiplier = 2.5 },
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
    end

    -- =================================================
    --                     Persephone
    -- =================================================
    if config.EnablePersephone == true then
        game.TraitData.ChamberStackTrait = {
            InheritFrom = { "GiftTrait" },
            Name = "ChamberStackTrait",
            Icon = "Keepsake_02",
            -- InRackTitle = "ChamberStackTrait_Rack",
            -- EquipSound = "/SFX/Menu Sounds/KeepsakePersephonePomBlossom",
            ShowInHUD = true,
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
                Rare = { Multiplier = 5/6 },
                Epic = { Multiplier = 4/6 },
            },

            RoomsPerUpgrade = 
            { 
                Amount = {BaseValue = 6},
                TraitStacks = 1, -- Adding cause of TraitLogic in h2
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
end

-- Calling Functions
CreateKeepsake_Order()
CreateKeepsake_Data()

-- Specifically for Thanatos Keepsake
-- ONLY REAL ONES WILL KNOW THIS WAS PAINFUL AND YET SO SIMPLES
function EndEncounterEffects_wrap( base, currentRun, currentRoom, currentEncounter )
	if currentEncounter == currentRoom.Encounter or currentEncounter == MapState.EncounterOverride then
        if game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage ~= nil then
            currentEncounter.PlayerTookDamage = game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage
        end
    end
end