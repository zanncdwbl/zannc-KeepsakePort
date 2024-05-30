if config.EnableThanatos == true then
    -- =================================================
    --               Thanatos KEEPSAKE
    -- =================================================
    function CreateKeepsake_Thanatos()
        -- Creating Keepsake Order
        table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "PerfectClearDamageBonusKeepsake")
        
        -- Creating Gift Data
        game.GiftData.NPC_Thanatos_01 = {
            [1] = {
                Gift = "PerfectClearDamageBonusKeepsake"
            },
            InheritFrom = { "DefaultGiftData" },
            Name = "PerfectClearDamageBonusKeepsake"
        }

        -- Creating Keepsake Data
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

    -- Call the Function
    CreateKeepsake_Thanatos()

    -- =================================================
    --                 Thanatos SJSON
    -- =================================================
    -- Used for when you have it equipped
    local keepsake_thanatos = sjson.to_object({
        Id = "PerfectClearDamageBonusKeepsake_Tray",
        InheritFrom = "PerfectClearDamageBonusKeepsake",
        Description = "Gain bonus damage each time you clear an {$Keywords.EncounterAlt} without taking damage.\n{#StatFormat}Bonus Damage: {#UpgradeFormat}{$TooltipData.ExtractData.TooltipAccumulatedBonus:P} {#Prev}"
    }, Order)

    -- In rack description
    local keepsakerack_thanatos = sjson.to_object({
        Id = "PerfectClearDamageBonusKeepsake",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Pierced Butterfly",
        Description = "Gain {#UpgradeFormat}{$TooltipData.ExtractData.TooltipPerfectClearBonus:P} {#Prev}damage each time you clear an {$Keywords.EncounterAlt} without taking damage."
    }, Order)

    -- From which Character
    local signoff_thanatos = sjson.to_object({
        Id = "SignoffThanatos",
        DisplayName = "From Thanatos",
    }, Order)

    -- Clear Message in room, fixed from default
    function sjson_clearText(data)
        for _,v in ipairs(data.Texts) do
            if v.Id == 'PerfectClearDamageBonus' then
                v.DisplayName = "Clear! {#UpgradeFormat}{$TempTextData.ExtractData.TooltipPerfectClearBonus:P}"
                break
            end
        end
    end

    -- Inserting into SJSON
    sjson.hook(TraitTextFile, function(data)
        table.insert(data.Texts, keepsake_thanatos)
        table.insert(data.Texts, keepsakerack_thanatos)
        table.insert(data.Texts, signoff_thanatos)
        print("Thanatos Hook Done")
    end)

    sjson.hook(HelpTextFile, function (data)
        return sjson_clearText(data)
    end)

    print("Thanatos Keepsake Data Complete")
end