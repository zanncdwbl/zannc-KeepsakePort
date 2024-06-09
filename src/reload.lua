-- Specifically for Thanatos Keepsake
-- ONLY REAL ONES WILL KNOW THIS WAS PAINFUL AND YET SO SIMPLES
function EndEncounterEffects_wrap(base, currentRun, currentRoom, currentEncounter)
    if currentEncounter == currentRoom.Encounter or currentEncounter == game.MapState.EncounterOverride then
        -- For Thanatos
        if game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage ~= nil then
            currentEncounter.PlayerTookDamage = game.CurrentRun.CurrentRoom.Encounter.PlayerTookDamage
        end

        -- For Hermes in fields, very crude but hopefully works.
        if currentEncounter.FastClearThreshold then
            for k, encounter in pairs(CurrentRun.CurrentRoom.ActiveEncounters) do
                -- Check clear time, used later in original function
                currentEncounter.ClearTime = game._worldTime - encounter.StartTime
            end
        else
            currentEncounter.ClearTime = 200 -- If no threshold, either its undefined, broken, or NPC/NonCombat room, set clear time to 200 to auto fail
        end
    end
end

function StartEncounterEffects_wrap(base, currentRun)
    -- Assign a start counter to all active encounters, specifically for Hermes boon
    if game.CurrentRun.CurrentRoom.ActiveEncounters ~= nil then
        for k, encounter in pairs(CurrentRun.CurrentRoom.ActiveEncounters) do
            encounter.StartTime = game._worldTime
        end
    end

    -- Remove this when publishing, don't need it.
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
