TraitTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/en/TraitText.en.sjson')
HelpTextFile = rom.path.combine(rom.paths.Content, 'Game/Text/en/HelpText.en.sjson')
GUIAnimationsFile = rom.path.combine(rom.paths.Content, 'Game/Animations/GUIAnimations.sjson')

-- Order for TraitText SJSON
Order = {
    'Id',
    'InheritFrom',
    'DisplayName',
    'Description',
}

-- Order for GUIAnimationsFile
IconOrder = {
    'Name',
    'InheritFrom',
    'FilePath',
}