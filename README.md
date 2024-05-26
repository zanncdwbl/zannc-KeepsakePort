# KeepsakePort_zannc
 Porting some Keepsakes over from Hades 1 to Hades 2


# funcs from h1
## keepsake only
PerfectClearDamageBonusTrait
InRackTitle = "PerfectClearDamageBonusTrait_Rack",
UnequippedKeepsakeTitle = "PerfectClearDamageBonusTrait_Dead",
CustomTrayNameWhileDead = "PerfectClearDamageBonusTrait_Tray",

## PerfectClearDamageBonus =
```
function StartEncounterEffects( currentRun )
	BuildSuperMeter( currentRun, GetTotalHeroTraitValue("StartingSuperAmount"))
	currentRun.CurrentRoom.Encounter.StartTime = _worldTime
	CurrentRun.Hero.HitShields = 0
	if not currentRun.CurrentRoom.BlockClearRewards then
		for i, traitData in pairs( currentRun.Hero.Traits) do
			if traitData.PerfectClearDamageBonus then
				PerfectClearTraitStartPresentation( traitData )
			end
			if traitData.FastClearDodgeBonus then
				SetupDodgeBonus( currentRun.CurrentRoom.Encounter, traitData )
			end
			if traitData.EncounterStartWeapon then
				FireWeaponFromUnit({ Weapon = traitData.EncounterStartWeapon, Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
			end
			if traitData.GoldBonusDrop then
				TraitUIActivateTrait( traitData )
			end

			if traitData.BossEncounterShieldHits then
				if currentRun.CurrentRoom.Encounter.EncounterType == "Boss"  then
					CurrentRun.Hero.HitShields = traitData.BossEncounterShieldHits
					ApplyEffectFromWeapon({ WeaponName = "EurydiceDefenseApplicator", EffectName = "EurydiceDefenseEffect", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
					UpdateTraitNumber( traitData )
				end
			end
		end
	end
end

EndEncounterEffects( currentRun, currentRoom, currentEncounter )
CheckOnRoomClearTraits( currentRun, currentRoom, currentEncounter )

DamageHero( victim, triggerArgs )

function PerfectClearTraitSuccessPresentation( traitData )
	TraitUIDeactivateTrait( traitData )
	thread( PlayVoiceLines, HeroVoiceLines.PerfectClearDamageBonusUpgradedVoiceLines, true )
	local existingTraitData = GetExistingUITrait( traitData )
	if existingTraitData then
		Flash({ Id = existingTraitData.AnchorId, Speed = 2, MinFraction = 0, MaxFraction = 0.8, Color = Color.LimeGreen, ExpireAfterCycle = true })
		CreateAnimation({ Name = "SkillProcFeedbackFx", DestinationId = existingTraitData.AnchorId, GroupName = "Overlay" })
		thread( InCombatText, existingTraitData.AnchorId, "PerfectClearDamageBonus", 1.5 , { ScreenSpace = true, OffsetX = 170, OffsetY = 10, Angle = 0, LuaKey = "TempTextData", LuaValue = traitData })
	end
	wait( 0.45, RoomThreadName )

	local soundId = PlaySound({ Name = "/SFX/ThanatosAttackBell" })
	SetVolume({ Id = soundId, Value = 0.3 })
	CreateAnimation({ Name = "ThanatosDeathsHead_Small", DestinationId = CurrentRun.Hero.ObjectId, Group = "FX_Standing_Top" })
	ShakeScreen({ Speed = 500, Distance = 4, FalloffSpeed = 1000, Duration = 0.3 })
end

function TraitUIActivateTraits()
	if not CurrentRun or not CurrentRun.Hero then
		return
	end

	for i, traitData in pairs(CurrentRun.Hero.Traits) do
		local thresholdData = traitData.LowHealthThresholdText
		if thresholdData ~= nil and ( CurrentRun.Hero.Health / CurrentRun.Hero.MaxHealth ) < thresholdData.Threshold then
			TraitUIActivateTrait( traitData )
		end

		if not CurrentRun.CurrentRoom.BlockClearRewards then
			local currentRoom = CurrentRun.CurrentRoom
			local perfectClearDamageData = traitData.PerfectClearDamageBonus
			if not CurrentRun.Hero.IsDead and perfectClearDamageData ~= nil then
				if currentRoom and currentRoom.Encounter ~= nil and currentRoom.Encounter.EncounterType ~= "NonCombat" and not currentRoom.Encounter.Completed and not currentRoom.Encounter.PlayerTookDamage then
					TraitUIActivateTrait( traitData )
				end
			end
			local fastClearData = traitData.FastClearSpeedBonus
			if fastClearData ~= nil then
				if not CurrentRun.Hero.IsDead and currentRoom and currentRoom.Encounter ~= nil and currentRoom.Encounter.StartTime and currentRoom.Encounter.EncounterType ~= "NonCombat" and not currentRoom.Encounter.Completed then
					local currentEncounter = currentRoom.Encounter
					local elapsedTime = _worldTime - currentEncounter.StartTime
					local clearTimeThreshold = currentEncounter.FastClearThreshold or traitData.FastClearThreshold
					TraitUIActivateTrait( traitData, { CustomAnimation = "ActiveTraitSingle", PlaySpeed = 30 / clearTimeThreshold })
					local existingTraitData = GetExistingUITrait( traitData )
					SetAnimation({ Name = "ActiveTraitSingle", StartFrameFraction = 1 - elapsedTime/clearTimeThreshold, DestinationId = existingTraitData.TraitActiveOverlay })
				end
			end
		end
	end
end
```