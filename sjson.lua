local file = rom.path.combine(rom.paths.Content, 'Game/Text/en/TraitText.en.sjson')

local order = {
    'Id',
    'InheritFrom',
    'DisplayName',
    'Description',
}

local keepsake = sjson.to_object({
    Id = "PerfectClearDamageBonusKeepsake",
    InheritFrom = "BaseBoonMultiline",
    DisplayName = "Pierced Butterfly",
    Description = "Gain {#UpgradeFormat}{$TooltipData.ExtractData.TooltipPerfectClearBonus:P} {#Prev}damage each time you clear an {$Keywords.EncounterAlt} without taking damage."
}, order)

local signoff = sjson.to_object({
    Id = "SignoffThanatos",
    DisplayName = "From Thanatos",
}, order)

local clear = sjson.to_object({
    Id = "PerfectClearDamageBonus",
    DisplayName = "Clear! {#UpgradeFormat}{$TempTextData.ExtractData.TooltipPerfectClearBonus:P}",
}, order)

function sjson_clearText(data)
	for _,v in ipairs(data.Texts) do
		if v.Id == 'PerfectClearDamageBonus' then
			v.DisplayName = "Clear! {#UpgradeFormat}{$TempTextData.ExtractData.TooltipPerfectClearBonus:P}"
			break
		end
	end
end

sjson.hook(file, function(data)
    table.insert(data.Texts, keepsake)
    table.insert(data.Texts, signoff)
    table.insert(data.Texts, clear)
    return sjson_clearText(data)
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