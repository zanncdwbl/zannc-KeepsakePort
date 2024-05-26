---@meta _
---@diagnostic disable: lowercase-global

-- local package = "zannc-KeepsakePort"
-- modutil.mod.Path.Wrap("SetupMap", function()
--     LoadPackages({Names = package})
-- end)

modutil.mod.Path.Wrap("StartEncounterEffects", function( base, currentRun )
    base(currentRun)
    return StartEncounterEffects_wrap( base, currentRun )
end)

modutil.mod.Path.Wrap("EndEncouterEffects", function( base, args )
    base(args)
    return EndEncouterEffects_wrap( base, args )
end)

modutil.mod.Path.Wrap("CheckOnRoomClearTraits", function( base, args )
    base(args)
    return CheckOnRoomClearTraits_wrap( base, args )
end)