TraitTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/en/TraitText.en.sjson')
HelpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')
local iconfile = rom.path.combine(rom.paths.Content, 'Game/Animations/GUIAnimations.sjson')

-- Order for TraitText SJSON
Order = {
    'Id',
    'InheritFrom',
    'DisplayName',
    'Description',
}

-- =================================================
--   ICONS, Won't be done until absolute paths
-- =================================================

IconOrder = {
    'Name',
    'InheritFrom',
    'FilePath',
}

local keepsakeicon = sjson.to_object({
    Name = "Keepsake_Butterfly",
    InheritFrom = "KeepsakeIcon",
    
    -- Manifest Path is zannc-KeepsakePort/Keepsake_Butterfly
    FilePath = rom.path.combine(_PLUGIN.guid, 'Keepsake_Butterfly')
}, IconOrder)

sjson.hook(iconfile, function (data)
    table.insert(data.Animations, keepsakeicon)
    -- print(sjson.encode(data))
end)