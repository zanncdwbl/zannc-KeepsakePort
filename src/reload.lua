-- Specifically for Thanatos Keepsake
-- ONLY REAL ONES WILL KNOW THIS WAS PAINFUL AND YET SO SIMPLES
function EndEncounterEffects_wrap(base, currentRun, currentRoom, currentEncounter)
    if currentEncounter == currentRoom.Encounter or currentEncounter == game.MapState.EncounterOverride then
        -- For Thanatos
        if game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage ~= nil then
            currentEncounter.PlayerTookDamage = game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage
        end
        -- For Hermes in fields
        if currentEncounter.EncounterType ~= "NonCombat" then -- Doesn't work if nemesis exists, sigh.
            currentEncounter.ClearTime = game._worldTime - game.CurrentRun.CurrentRoom.Encounter.StartTime
        end
    end
end

function StartEncounterEffects_wrap(base, currentRun)
    for k, traitData in pairs(currentRun.Hero.Traits) do
        if traitData.FastClearDodgeBonus then
            if currentRun.CurrentRoom.Encounter.FastClearThreshold then
                print("Current Room: " .. currentRun.CurrentRoom.Encounter.Name)
                print("Time Clear Threshold: " .. currentRun.CurrentRoom.Encounter.FastClearThreshold .. " seconds\n")
            else
                print("Current Room: " ..
                    currentRun.CurrentRoom.Encounter.Name .. ", has no custom threshold or is undefined")
            end
        end
    end
end
