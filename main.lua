---@meta _
-- grabbing our dependencies,
-- these funky (---@) comments are just there
--	 to help VS Code find the definitions of things

---@diagnostic disable-next-line: undefined-global
local mods = rom.mods

---@module 'SGG_Modding-ENVY-auto'
mods['SGG_Modding-ENVY'].auto()
-- ^ this gives us `public` and `import`, among others
--	and makes all globals we define private to this plugin.
---@diagnostic disable: lowercase-global

---@diagnostic disable-next-line: undefined-global
rom = rom
---@diagnostic disable-next-line: undefined-global
_PLUGIN = PLUGIN

---@module 'SGG_Modding-Hades2GameDef-Globals'
game = rom.game

---@module 'SGG_Modding-SJSON'
sjson = mods['SGG_Modding-SJSON']

---@module 'SGG_Modding-ModUtil'
modutil = mods['SGG_Modding-ModUtil']

---@module 'SGG_Modding-Chalk'
chalk = mods["SGG_Modding-Chalk"]

---@module 'SGG_Modding-ReLoad'
reload = mods['SGG_Modding-ReLoad']

---@module 'KeepsakePort-zannc-config'
config = chalk.auto 'config.lua'
public.config = config

local function on_ready()
    if config.enabled == false then return end
    
    import_as_fallback(rom.game)
    import 'sjson.lua'
    import 'ready.lua'

    -- local package = "zannc-KeepsakePort"
    -- LoadPackages({Names = package})
end

local function on_reload()
    import_as_fallback(rom.game)
    import 'reload.lua'
end

local loader = reload.auto_single()

modutil.on_ready_final(function()
	loader.load(on_ready, on_reload)
end)