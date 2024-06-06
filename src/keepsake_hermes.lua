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

    -- Creating Keepsake Data
    game.TraitData.FastClearDodgeBonusKeepsake = {
        Icon = "Lambent_Plume",
        InheritFrom = { "GiftTrait" },
        Name = "FastClearDodgeBonusKeepsake",
        CustomTrayText = "FastClearDodgeBonusKeepsake_Tray",

        -- Always add these, so it SHUTS UP
        ShowInHUD = true,
        Ordered = true,
        HUDScale = 0.435,
        PriorityDisplay = true,
        ChamberThresholds = { 25, 50 },
        HideInRunHistory = true,
        Slot = "Keepsake",
        InfoBackingAnimation = "KeepsakeSlotBase",
        RecordCacheOnEquip = true,
        TraitOrderingValueCache = -1,
        ActiveSlotOffsetIndex =  0,

        FrameRarities = {
			Common = "Frame_Keepsake_Rank1",
			Rare = "Frame_Keepsake_Rank2",
			Epic = "Frame_Keepsake_Rank3",
		},

        CustomRarityLevels = {
            "TraitLevel_Keepsake1",
            "TraitLevel_Keepsake2",
            "TraitLevel_Keepsake3",
            "TraitLevel_Keepsake4",
        },

        RarityLevels = {
            Common = { Multiplier = config.Hermes.a_KeepsakeCommon },
            Rare = { Multiplier = config.Hermes.b_KeepsakeRare },
            Epic = { Multiplier = config.Hermes.c_KeepsakeEpic },
            Heroic = { Multiplier = config.Hermes.d_KeepsakeHeroic },
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

-- Icon JSON data
local keepsakeicon_hermes = sjson.to_object({
    Name = "Lambent_Plume",
    InheritFrom = "KeepsakeIcon",
    FilePath = rom.path.combine('keepsakes/Lambent_Plume')
}, IconOrder)

-- Clear Message in room, fixed from default
function sjson_clearText_Hermes(data)
    for _,v in ipairs(data.Texts) do
        if v.Id == 'FastClearDamageBonus' then
            v.DisplayName = "Clear! {#UpgradeFormat}{$TempTextData.ExtractData.TooltipFastClearDodgeBonus:P}"
            break
        end
    end
end

-- Inserting into SJSON
sjson.hook(TraitTextFile, function(data)
    table.insert(data.Texts, keepsake_hermes)
    table.insert(data.Texts, keepsakerack_hermes)
end)

-- Insert for Icons
sjson.hook(GUIAnimationsFile, function (data)
    table.insert(data.Animations, keepsakeicon_hermes)
end)

sjson.hook(HelpTextFile, function (data)
    return sjson_clearText_Hermes(data)
end)

-- =================================================
--            SJSON for Clear Times
-- =================================================