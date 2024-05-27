---@meta _
---@diagnostic disable: lowercase-global

local package = rom.path.combine('../../../../../Ship/plugins/ReturnOfModding/zannc-KeepsakePort/zannc-KeepsakePort')
modutil.mod.Path.Wrap("SetupMap", function(base)
    LoadPackages({Name = package})
    base()
end)

modutil.mod.Path.Wrap("StartEncounterEffects", function( base, currentRun )
    StartEncounterEffects_wrap( base, currentRun )
    base(currentRun)
end)

modutil.mod.Path.Wrap("EndEncouterEffects", function( base, args )
    EndEncouterEffects_wrap( base, args )
    base(args)
end)

-- modutil.mod.Path.Wrap("CheckOnRoomClearTraits", function( base, args )
--     base(args)
--     return CheckOnRoomClearTraits_wrap( base, args )
-- end)