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
    
    game.GiftData.PiercedButterflyKeepsake =
    {
        InheritFrom = { "DefaultGiftData" },
        [1] = { Gift = "PiercedButterflyKeepsake" }
    }

    
end

function CreateKeepsake_Data()
    game.TraitSetData.Keepsakes.PiercedButterflyKeepsake = 
    {
        InheritFrom = { "GiftTrait" },
        InRackTitle = "LowHealthCritKeepsake_Rack",
        Icon = "Keepsake_10",
        EquipSound = "/SFX/Menu Sounds/KeepsakeArtemisArrow",
        PriorityDisplay = true,
        LowHealthThresholdText =
        {
            -- Display variable only, to change the data value change the value below under "LowHealthThreshold"
            Threshold = 30,
            Text = "Hint_Test",
        },
        AddOutgoingCritModifiers =
        {
            LowHealthThreshold = 30,
            LowHealthChance = { BaseValue = 0.2 },
            ReportValues = { ReportedHealthThreshold = "LowHealthThreshold", ReportedCritBonus = "LowHealthChance"}
        },
        ExtractValues =
        {
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

        EquipVoiceLines =
        {
            {
                PreLineWait = 0.3,
                BreakIfPlayed = true,
                SuccessiveChanceToPlay = 0.2,
                Cooldowns =
                {
                    { Name = "MelinoeAnyQuipSpeech" },
                },

                { Cue = "/VO/Melinoe_2651", Text = "The Antler." },
            },
            {
                PreLineWait = 0.3,
                BreakIfPlayed = true,
                RandomRemaining = true,
                ChanceToPlay = 0.25,
                Source = { LineHistoryName = "NPC_Artemis_Field_01", SubtitleColor = Color.ArtemisVoice },
                GameStateRequirements =
                {
                    {
                        Path = { "GameState", "TextLinesRecord" },
                        HasAll = { "ArtemisGift02" },
                    },
                },
                Cooldowns =
                {
                    { Name = "KeepsakeGiverSpeechPlayedRecently", Time = 90 },
                },
                { Cue = "/VO/ArtemisKeepsake_0214", Text = "Hey Sister." },
                { Cue = "/VO/ArtemisKeepsake_0215", Text = "Melinoë.", PlayFirst = true },
            },
            [3] = GlobalVoiceLines.AwardSelectedVoiceLines,
        },
        SignOffData =
        {
            {
                Text = "SignoffThanatos",
            },
        },
    }

    
    OverwriteTableKeys(game.TraitData, game.TraitSetData.Keepsakes)
    printTable(game.TraitSetData.Keepsakes)
end

CreateKeepsake_Order()
CreateKeepsake_Data()