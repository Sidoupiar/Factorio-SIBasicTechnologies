-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local woodItem = SIGen.GetData( SITypes.item.item , "wood" )
local woodFuel = woodItem.fuel_value
local woodFuelValue , woodFuelClass = tostring( woodFuel ):GetEnergyClass()
local woodFuelType = woodItem.fuel_category

local fruit =
{
	type = SITypes.item.capsule ,
	capsule_action =
	{
		type = "use-on-self" ,
		attack_parameters =
		{
			type = "projectile" ,
			ammo_category = "capsule" ,
			cooldown = 15 ,
			range = 0 ,
			ammo_type =
			{
				category = "capsule" ,
				target_type = "position" ,
				action =
				{
					type = "direct" ,
					action_delivery =
					{
						type = "instant" ,
						target_effects =
						{
							{ type = "script" , effect_id = SIBT.throwFruit } ,
							{ type = "play-sound" , sound = SISounds.BaseSoundList( "eat" , 4 , 0.6 ) }
						}
					}
				}
			}
		}
	}
}

-- ------------------------------------------------------------------------------------------------
-- ------- 创建物品和配方 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewSubGroup( "wood-item" )
.NewItem( "tree-fruit" , 35 ).SetEnergy( (woodFuelValue*0.4)..woodFuelClass , woodFuelType ).SetCustomData( fruit )
.NewItem( "tree-leaf" , 450 ).SetEnergy( (woodFuelValue*0.008)..woodFuelClass , woodFuelType )
.NewItem( "tree-bark" , 220 ).SetEnergy( (woodFuelValue*0.05)..woodFuelClass , woodFuelType )
.NewItem( "tree-root" , 75 ).SetEnergy( (woodFuelValue*0.5)..woodFuelClass , woodFuelType )
.NewItem( "tree-sawdust" , 800 ).SetEnergy( (woodFuelValue*0.004)..woodFuelClass , woodFuelType )
.NewItem( "tree-fruit-nutlet" , 25 ).SetEnergy( (woodFuelValue*0.001)..woodFuelClass , woodFuelType )