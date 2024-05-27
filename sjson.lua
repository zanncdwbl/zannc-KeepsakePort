local file = rom.path.combine(rom.paths.Content, 'Game/Text/en/TraitText.en.sjson')
local helpfile = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')
local iconfile = rom.path.combine(rom.paths.Content, 'Game/Animations/GUIAnimations.sjson')

-- Order for TraitText SJSON
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

-- =================================================
--                     Thanatos
-- =================================================

-- Used for when you have it equipped
local keepsake_thanatos = sjson.to_object({
    Id = "PerfectClearDamageBonusKeepsake_Tray",
    InheritFrom = "PerfectClearDamageBonusKeepsake",
    Description = "Gain bonus damage each time you clear an {$Keywords.EncounterAlt} without taking damage.\n{#StatFormat}Bonus Damage: {#UpgradeFormat}{$TooltipData.ExtractData.TooltipAccumulatedBonus:P} {#Prev}"
}, order)

-- In rack description
local keepsakerack_thanatos = sjson.to_object({
    Id = "PerfectClearDamageBonusKeepsake",
    InheritFrom = "BaseBoonMultiline",
    DisplayName = "Pierced Butterfly",
    Description = "Gain {#UpgradeFormat}{$TooltipData.ExtractData.TooltipPerfectClearBonus:P} {#Prev}damage each time you clear an {$Keywords.EncounterAlt} without taking damage."
}, order)

local signoff_thanatos = sjson.to_object({
    Id = "SignoffThanatos",
    DisplayName = "From Thanatos",
}, order)

-- Clear Message in room
function sjson_clearText(data)
	for _,v in ipairs(data.Texts) do
		if v.Id == 'PerfectClearDamageBonus' then
			v.DisplayName = "Clear! {#UpgradeFormat}{$TempTextData.ExtractData.TooltipPerfectClearBonus:P}"
			break
		end
	end
end

-- =================================================
--                     Persephone
-- =================================================

local keepsakerack_persephone = sjson.to_object({
    Id = "ChamberStackTrait",
    InheritFrom = "BaseBoonMultiline",
    DisplayName = "Pom Blossom",
    Description = "After every {#AltUpgradeFormat}{$TooltipData.ExtractData.TooltipRoomInterval} {#Prev}{$Keywords.EncounterPlural}, gain {#UseGiftPointFormat}+1 Lv.{!Icons.Pom} {#Prev}{#ItalicFormat}(a random {$Keywords.GodBoon} grows stronger){#Prev}"
}, order)

local signoff_persephone = sjson.to_object({
    Id = "SignoffPersephone",
    DisplayName = "From Persephone",
}, order)


sjson.hook(file, function(data)
    -- Thanatos Hooks
    table.insert(data.Texts, keepsake_thanatos)
    table.insert(data.Texts, keepsakerack_thanatos)
    table.insert(data.Texts, signoff_thanatos)

    -- Persephone Hooks
    table.insert(data.Texts, keepsakerack_persephone)
    table.insert(data.Texts, signoff_persephone)
end)

sjson.hook(helpfile, function (data)
    return sjson_clearText(data)
end)

-- =================================================
--     Icon Hooks - DON'T WORK UNTIL PACKAGES DO
-- =================================================

local keepsakeicon = sjson.to_object({
    Name = "Keepsake_Butterfly",
    InheritFrom = "KeepsakeIcon",
    -- FilePath = "../Ship/ReturnOfModding/plugins/zannc-KeepsakePort/icons/img/zannc-KeepsakePort/Keepsake_Butterfly"
    FilePath = "zannc-KeepsakePort/Keepsake_Butterfly"
}, iconorder)

sjson.hook(iconfile, function (data)
    table.insert(data.Animations, keepsakeicon)
    -- print(sjson.encode(data))
end)