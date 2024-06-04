-- Specifically for Thanatos Keepsake
-- ONLY REAL ONES WILL KNOW THIS WAS PAINFUL AND YET SO SIMPLES
function EndEncounterEffects_wrap( base, currentRun, currentRoom, currentEncounter )
	if currentEncounter == currentRoom.Encounter or currentEncounter == game.MapState.EncounterOverride then
        -- For Thanatos
        if game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage ~= nil then
            currentEncounter.PlayerTookDamage = game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage
        end
        -- For Hermes 
        currentEncounter.ClearTime = game._worldTime - game.CurrentRun.CurrentRoom.Encounter.StartTime
    end
end