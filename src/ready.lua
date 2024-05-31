---@meta _
---@diagnostic disable: lowercase-global

-- Relative Path goes from
-- HadesII/Content/Packages/1080P or 720P to HadesII/Ship/etc to load the zannc-Keepsake.pkg
-- local package = rom.path.combine('../../../Ship/ReturnOfModding/plugins', _PLUGIN.guid, _PLUGIN.guid)
-- local package = rom.path.combine(_PLUGIN.plugins_mod_folder_path, _PLUGIN.guid)
-- modutil.mod.Path.Wrap("SetupMap", function(base)
--     LoadPackages({Name = package})
--     base()
-- end)

modutil.mod.Path.Wrap("EndEncounterEffects", function( base, currentRun, currentRoom, currentEncounter )
    EndEncounterEffects_wrap( base, currentRun, currentRoom, currentEncounter )
    base(currentRun, currentRoom, currentEncounter)
end)