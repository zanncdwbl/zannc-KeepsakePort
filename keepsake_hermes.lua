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

sjson.hook(file, function(data)
    -- Thanatos Hooks
    if config.EnableThanatos == true then
        table.insert(data.Texts, keepsake_thanatos)
        table.insert(data.Texts, keepsakerack_thanatos)
        table.insert(data.Texts, signoff_thanatos)
    end

    -- Persephone Hooks
    if config.EnablePersephone == true then
        table.insert(data.Texts, keepsakerack_persephone)
        table.insert(data.Texts, signoff_persephone)
    end
end)

CreateKeepsake_Data_Hermes()