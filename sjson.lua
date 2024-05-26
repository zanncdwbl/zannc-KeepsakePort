local file = rom.path.combine(rom.paths.Content, 'Game/Text/en/TraitText.en.sjson')

local keepsake = {
    Id = "PerfectClearDamageBonusKeepsake",
    InheritFrom = "BaseBoonMultiline",
    DisplayName = "Pierced Butterfly",
    Description = "Gain {#UpgradeFormat}{$TooltipData.ExtractData.TooltipPerfectClearBonus:P} {#Prev}damage each time you clear an {$Keywords.EncounterAlt} without taking damage."
}

local signoff = {
    Id = "SignoffThanatos",
    DisplayName = "From Thanatos",
}

sjson.hook(file, function(data)
    print("Hook fired")
    table.insert(data.Texts, keepsake)
    table.insert(data.Texts, signoff)
    print("Hook Done")
end)

-- {
--     Id = "PerfectClearDamageBonusKeepsake",
--     InheritFrom = "BaseBoonMultiline",
--     DisplayName = "Pierced Butterfly",
--     Description = "Gain {#UpgradeFormat}{$TooltipData.ExtractData.TooltipPerfectClearBonus:P} {#Prev}damage each time you clear an {$Keywords.EncounterAlt} without taking damage."
-- }

-- {
--     Id = "SignoffThanatos",
--     DisplayName = "From Thanatos",
-- }