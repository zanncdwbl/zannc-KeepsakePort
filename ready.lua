---@meta _
---@diagnostic disable: lowercase-global

-- Relative Path goes from
-- HadesII/Content/Packages/1080P or 720P to HadesII/Ship/etc to load the zannc-Keepsake.pkg
local package = rom.path.combine('../../../Ship/ReturnOfModding/plugins', _PLUGIN.guid, _PLUGIN.guid)
modutil.mod.Path.Wrap("SetupMap", function(base)
    LoadPackages({Name = package})
    base()
end)

modutil.mod.Path.Wrap("StartEncounterEffects", function( base, currentRun )
    base(currentRun)
    return StartEncounterEffects_wrap( base, currentRun )
end)

modutil.mod.Path.Wrap("EndEncouterEffects", function( base, args )
    base(args)
    return EndEncouterEffects_wrap( base, args )
end)

-- modutil.mod.Path.Wrap("CheckOnRoomClearTraits", function( base, args )
--     base(args)
--     return CheckOnRoomClearTraits_wrap( base, args )
-- end)