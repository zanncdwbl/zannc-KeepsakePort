local file = rom.path.combine(rom.paths.Content, 'Game/Text/en/TraitText.en.sjson')
-- local iconfile = rom.path.combine(rom.paths.Content, 'Game/Animations/GUIAnimations.sjson')

local order = {
    'Id',
    'InheritFrom',
    'DisplayName',
    'Description',
}

local iconorder = {
    'Name',
    'InheritFrom',
    'FilePath',
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

-- local keepsakeicon = sjson.to_object({
--     Name = "Keepsake_Butterfly",
--     InheritFrom = "KeepsakeIcon",
--     FilePath = "plugins/zannc-KeepsakePort/icons/img/zannc-KeepsakePort/Keepsake_Butterfly"
-- }, iconorder)

function sjson_clearText(data)
	for _,v in ipairs(data.Texts) do
		if v.Id == 'PerfectClearDamageBonus' then
			v.DisplayName = "Clear! {#UpgradeFormat}{$TempTextData.ExtractData.TooltipPerfectClearBonus:P}"
			break
		end
	end
end

-- sjson.hook(iconfile, function (data)
--     table.insert(data.Animations, keepsakeicon)
--     -- print(sjson.encode(data))
-- end)

sjson.hook(file, function(data)
    table.insert(data.Texts, keepsake)
    table.insert(data.Texts, signoff)
    table.insert(data.Texts, clear)
    return sjson_clearText(data)
end)