---@meta _
---@diagnostic disable: lowercase-global

-- Relative Path goes from
-- HadesII/Content/Packages/1080P or 720P to HadesII/Ship/etc to load the zannc-Keepsake.pkg
-- local package = rom.path.combine('../../../Ship/ReturnOfModding/plugins_data', _PLUGIN.guid, _PLUGIN.guid)


-- Absolute Path links to plugins_data folder - mod folder, then package name - which MUST contain mod author name for uniqueness
local package = rom.path.combine(_PLUGIN.plugins_data_mod_folder_path, _PLUGIN.guid)
print(package)
modutil.mod.Path.Wrap("SetupMap", function(base)
    LoadPackages({Name = package})
    base()
end)

modutil.mod.Path.Wrap("EndEncounterEffects", function( base, currentRun, currentRoom, currentEncounter )
    EndEncounterEffects_wrap( base, currentRun, currentRoom, currentEncounter )
    base(currentRun, currentRoom, currentEncounter)
end)