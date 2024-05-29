function CreateKeepsake_Data_Hermes()
    FastClearDodgeBonusTrait = {
		Icon = "Keepsake_03",
		-- EquipSound = "/SFX/Menu Sounds/KeepsakeHermesFastClear",
		InheritFrom = { "GiftTrait" },
		InRackTitle = "FastClearDodgeBonusTrait_Rack",
		UnequippedKeepsakeTitle = "FastClearDodgeBonusTrait_Dead",
		CustomTrayNameWhileDead = "FastClearDodgeBonusTrait_Tray",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.1,

			},
			Epic =
			{
				Multiplier = 1.2,
			}
		},
		FastClearThreshold = 30,
		FastClearDodgeBonus =
		{
			BaseValue = 0.01,
			DecimalPlaces = 4,
		},
		FastClearSpeedBonus =
		{
			BaseValue = 0.01,
			DecimalPlaces = 4,
		},
		AccumulatedDodgeBonus = 0,
		ExtractValues =
		{
			{
				Key = "FastClearDodgeBonus",
				ExtractAs = "TooltipFastClearDodgeBonus",
				Format = "Percent",
				DecimalPlaces = 2,
			},
			{
				Key = "AccumulatedDodgeBonus",
				ExtractAs = "TooltipAccumulatedBonus",
				Format = "Percent",
				DecimalPlaces = 2,
			},
		},

		SignOffData =
		{
            {
                Text = "HermesSignoff",
            },
            
            {
                RequiredAnyTextLines = { "HermesGift08", "HermesGift08B" },
                Text = "HermesSignoff_Max"
            }
		}
	}
end

CreateKeepsake_Data_Hermes()

local keepsake_hermes = sjson.to_object({
    Id = "",
    InheritFrom = "",
    Description = ""
}, Order)

sjson.hook(TraitTextFile, function(data)
    table.insert(data.Texts, keepsake_hermes)
end)

{
    Id = "FastClearDodgeBonusTrait"
    DisplayName = "Lambent Plume"
    Description = "Gain greater {$Keywords.Dodge} chance and move speed each time you quickly clear an {$Keywords.EncounterAlt}. {#StatFormat}Dodge Chance & Move Speed: {#UpgradeFormat}{$TooltipData.TooltipAccumulatedBonus:P} {#PreviousFormat}"
}
{
    Id = "FastClearDodgeBonusTrait_Rack"
    InheritFrom = "FastClearDodgeBonusTrait"
    Description = "Gain greater {$Keywords.Dodge} chance and move speed each time you quickly clear an {$Keywords.EncounterAlt}. {#StatFormat}Dodge Chance & Move Speed: {#UpgradeFormat}{$TooltipData.TooltipAccumulatedBonus:P} {#PreviousFormat} \n\n {#AwardFlavorFormat}{$TooltipData.SignoffText}"
}
{
    Id = "FastClearDodgeBonusTrait_Dead"
    DisplayName = "Lambent Plume"
    Description = "Gain {#UpgradeFormat}{$TooltipData.TooltipFastClearDodgeBonus:P} {#PreviousFormat}{$Keywords.Dodge} chance and move speed each time you quickly clear an {$Keywords.EncounterAlt}. \n\n {#AwardFlavorFormat}{$TooltipData.SignoffText}"
}
{
    Id = "FastClearDodgeBonusTrait_Tray"
    DisplayName = "Lambent Plume"
    Description = "Gain {#UpgradeFormat}{$TooltipData.TooltipFastClearDodgeBonus:P} {#PreviousFormat}{$Keywords.Dodge} chance and move speed each time you quickly clear an {$Keywords.EncounterAlt}."
}