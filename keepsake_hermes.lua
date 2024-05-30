if config.EnableHermes == true then
    -- =================================================
    --                 Hermes KEEPSAKE
    -- =================================================
    function CreateKeepsake_Hermes()
        -- Creating Keepsake Order
        table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "FastClearDodgeBonusKeepsake")
        
        -- Creating Gift Data - using 02 to avoid conflict
        game.GiftData.NPC_Hermes_02 = {
            [1] = {
                Gift = "FastClearDodgeBonusKeepsake"
            },
            InheritFrom = { "DefaultGiftData" },
            Name = "FastClearDodgeBonusKeepsake"
        }

        game.TraitData.FastClearDodgeBonusKeepsake = {
            Icon = "Keepsake_03",
            InheritFrom = { "GiftTrait" },
            Name = "FastClearDodgeBonusKeepsake",
            CustomTrayText = "FastClearDodgeBonusKeepsake_Tray",

            -- Always add these, so it SHUTS UP
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
                Rare = { Multiplier = 1.1 },
                Epic = { Multiplier = 1.2 },
                Heroic = { Multiplier = 1.3 },
            },

            FastClearThreshold = 30,
            FastClearDodgeBonus = {
                BaseValue = 0.01,
                DecimalPlaces = 4,
            },

            FastClearSpeedBonus = {
                BaseValue = 0.01,
                DecimalPlaces = 4,
            },

            AccumulatedDodgeBonus = 0,
            ExtractValues = {
                {
                    Key = "FastClearDodgeBonus",
                    ExtractAs = "TooltipFastClearDodgeBonus",
                    Format = "Percent",
                    DecimalPlaces = 2,
                },
                {
                    Key = "AccumulatedDodgeBonus",
                    ExtractAs = "TooltipAccumulatedBonus",
                    Format = "Percent",
                    DecimalPlaces = 2,
                },
            },

            SignOffData = {
                {
                    Text = "SignoffHermes",
                },
            }
        }
    end

    -- Call the Function
    CreateKeepsake_Hermes()

    -- =================================================
    --                 Hermes SJSON
    -- =================================================
    -- Used for when you have it equipped
    local keepsake_hermes = sjson.to_object({
        Id = "FastClearDodgeBonusKeepsake_Tray",
        InheritFrom = "FastClearDodgeBonusKeepsake",
        Description = "Gain greater {$Keywords.Dodge} chance and move speed each time you quickly clear an {$Keywords.EncounterAlt}.\n{#StatFormat}Dodge Chance & Move Speed: {#UpgradeFormat}{$TooltipData.ExtractData.TooltipAccumulatedBonus:P} {#Prev}"
    }, Order)
    
    -- In rack description
    local keepsakerack_hermes = sjson.to_object({
        Id = "FastClearDodgeBonusKeepsake",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Lambent Plume",
        Description = "Gain {#UpgradeFormat}{$TooltipData.ExtractData.TooltipFastClearDodgeBonus:P} {#Prev}{$Keywords.Dodge} chance and move speed each time you quickly clear an {$Keywords.EncounterAlt}."
    }, Order)

    -- Clear Message in room, fixed from default
    function sjson_clearText(data)
        for _,v in ipairs(data.Texts) do
            if v.Id == 'FastClearDamageBonus' then
                v.DisplayName = "Clear! {#UpgradeFormat}{$TempTextData.ExtractData.TooltipFastClearDodgeBonus:P}"
                break
            end
        end
    end

    sjson.hook(TraitTextFile, function(data)
        table.insert(data.Texts, keepsake_hermes)
        table.insert(data.Texts, keepsakerack_hermes)
        print("Hermes Hook Done")
    end)

    sjson.hook(HelpTextFile, function (data)
        return sjson_clearText(data)
    end)

    print("Hermes Keepsake Data Complete")
end