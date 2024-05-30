if config.EnablePersephone == true then
    -- =================================================
    --               Persephone KEEPSAKE
    -- =================================================
    function CreateKeepsake_Persephone()
        -- Creating Keepsake Order
        table.insert(game.ScreenData.KeepsakeRack.ItemOrder, "ChamberStackTrait")
        
        -- Creating Gift Data
        game.GiftData.NPC_Persephone_01 = {
            [1] = {
                Gift = "ChamberStackTrait"
            },
            InheritFrom = { "DefaultGiftData" },
            Name = "ChamberStackTrait"
        }

        -- Creating Keepsake Data
        game.TraitData.ChamberStackTrait = {
            InheritFrom = { "GiftTrait" },
            Name = "ChamberStackTrait",
            Icon = "Keepsake_02",
            -- InRackTitle = "ChamberStackTrait_Rack",
            -- EquipSound = "/SFX/Menu Sounds/KeepsakePersephonePomBlossom",
            ShowInHUD = true,
            PriorityDisplay = true,
            NoFrame = true,
            ChamberThresholds = { 25, 50 },
            HideInRunHistory = true,
            Slot = "Keepsake",
            InfoBackingAnimation = "KeepsakeSlotBase",
            RecordCacheOnEquip = true,
            TraitOrderingValueCache = -1,
            ActiveSlotOffsetIndex =  0,
            
            CustomRarityLevels = {
                "TraitLevel_Keepsake1",
                "TraitLevel_Keepsake2",
                "TraitLevel_Keepsake3",
                "TraitLevel_Keepsake4",
            },
            
            RarityLevels = {
                Common = { Multiplier = 1.0 },
                Rare = { Multiplier = 5/6 },
                Epic = { Multiplier = 4/6 },
            },
            
            RoomsPerUpgrade = 
            { 
                Amount = {BaseValue = 6},
                TraitStacks = 1, -- Adding cause of TraitLogic in h2
                ReportValues = 
                { 
                    ReportedRoomsPerUpgrade = "Amount" 
                },
            },
            CurrentRoom = 0,
            ExtractValues =
            {
                {
                    Key = "ReportedRoomsPerUpgrade",
                    ExtractAs = "TooltipRoomInterval",
                }
            },
            
            SignOffData =
            {
                {
                    Text = "SignoffPersephone",
                }
            }
        }
    end

    -- Call the Function
    CreateKeepsake_Persephone()

    -- =================================================
    --                Persephone SJSON
    -- =================================================
    -- Used for when you have it equipped and in the rack
    local keepsakerack_persephone = sjson.to_object({
        Id = "ChamberStackTrait",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Pom Blossom",
        Description = "After every {#AltUpgradeFormat}{$TooltipData.ExtractData.TooltipRoomInterval} {#Prev}{$Keywords.EncounterPlural}, gain {#UseGiftPointFormat}+1 Lv.{!Icons.Pom} {#Prev}{#ItalicFormat}(a random {$Keywords.GodBoon} grows stronger){#Prev}"
    }, Order)

    -- From which Character
    local signoff_persephone = sjson.to_object({
        Id = "SignoffPersephone",
        DisplayName = "From Persephone",
    }, Order)

    -- Inserting into SJSON
    sjson.hook(TraitTextFile, function(data)
        table.insert(data.Texts, keepsakerack_persephone)
        table.insert(data.Texts, signoff_persephone)
        print("Persephone Hook Done")
    end)

    print("Persephone Keepsake Data Complete")
end