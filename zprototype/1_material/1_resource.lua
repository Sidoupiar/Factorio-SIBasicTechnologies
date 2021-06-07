-- ------------------------------------------------------------------------------------------------
-- ---------- 创建矿物 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewGroup( SIBT.group.item ).NewSubGroup( "矿物" )

local throwSound = SISounds.BaseSoundList( "fight/throw-projectile" , 6 , 0.4 )
local walkSound = SISounds.BaseSoundList( "walking/resources/ore" , 10 , 0.7 )

local function CreateThrowItem( itemName , action , color , range )
	if not range then range = 19 end
	local projectileName = SIGen.NewProjectile( itemName )
	.E.SetScale( 0.5 )
	.SetSize( 1 , 1 )
	.SetAction( action )
	.SetAcceleration( 0 )
	.FillImage()
	.GetCurrentEntityName()
	local capsuleAction =
	{
		type = "throw" ,
		attack_parameters =
		{
			type = "projectile" ,
			activation_type = "throw" ,
			ammo_category = "grenade" ,
			cooldown = 40 ,
			projectile_creation_distance = 0.6 ,
			range = range ,
			ammo_type =
			{
				category = "grenade" ,
				target_type = "position" ,
				action =
				{
					{
						type = "direct" ,
						action_delivery =
						{
							type = "projectile" ,
							projectile = projectileName ,
							starting_speed = 0.25
						}
					} ,
					{
						type = "direct" ,
						action_delivery =
						{
							type = "instant" ,
							target_effects =
							{
								type = "play-sound" ,
								sound = throwSound
							}
						}
					}
				}
			}
		}
	}
	return SIGen.NewCapsule( itemName ).SetAction( capsuleAction , SIPackers.ColorCopyWithA( color , 0.2 ) ).GetCurrentEntity()
end

local function CreateResource( itemName , resourceName , action , color , category )
	local item = CreateThrowItem( itemName , action , color )
	SIGen.NewResource( resourceName )
	.E.SetCanGlow( true )
	.E.SetItem( item )
	.SetSize( 1 , 1 )
	.SetMapColor( color )
	.SetStagesEffectsSettings( 5 , 1 , 3.6 , 0.2 , 0.3 )
	.AddFlags( SIFlags.entityFlags.notOnMap , SIFlags.entityFlags.hidden )
	.SetTreeSettings( 0.8 , 32*32 )
	.FillImage()
	.SetSound( "walking_sound" , walkSound )
	.SetAutoPlace(
	{
		order = "d" ,
		base_density = 0.9 ,
		base_spots_per_km2 = 1.25 ,
		random_spot_size_minimum = 2 ,
		random_spot_size_maximum = 4 ,
		regular_rq_factor_multiplier = 1 ,
		has_starting_area_placement = false
	} , { 100000 , 30000 , 10000 , 3000 , 1000 , 300 , 100 , 30 } )
	if category then SIGen.SetRecipeTypes( category ) end
	return item
end

local action1 =
{
	{
		type = "direct" ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				type = "create-entity" ,
				entity_name = "grenade-explosion"
			}
		}
	} ,
	{
		type = "area" ,
		radius = 1.9 ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				SIPackers.Attack_EffectDamage( SIBT.damageType.poison , 1 ) ,
				SIPackers.Attack_EffectDamage( SIBT.damageType.water , 1 )
			}
		}
	}
}
local createFire =
{
	type = "create-fire" ,
	entity_name = "fire-flame"
}
local action2 =
{
	{
		type = "direct" ,
		action_delivery =
		{
			type = "instant" ,
			target_effects = createFire
		}
	} ,
	{
		type = "area" ,
		radius = 4.2 ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				SIPackers.Attack_EffectDamage( SIBT.damageType.fire , 2 ) ,
				{
					type = "create-sticker" ,
					sticker = "fire-sticker"
				} ,
				createFire
			}
		}
	}
}
local targetParticle =
{
	type = "create-particle" ,
	particle_name = "stone-particle" ,
	repeat_count = 12 ,
	initial_height = 0.5 ,
	initial_vertical_speed = 0.05 ,
	initial_vertical_speed_deviation = 0.1 ,
	speed_from_center = 0.05 ,
	speed_from_center_deviation = 0.1 ,
	offset_deviation = { { -0.8984 , -0.5 } , { 0.8984 , 0.5 } }
}
local areaParticle = table.deepcopy( targetParticle )
areaParticle.repeat_count = 2
local action3 =
{
	{
		type = "direct" ,
		action_delivery =
		{
			type = "instant" ,
			target_effects = targetParticle
		}
	} ,
	{
		type = "area" ,
		radius = 0.8 ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				SIPackers.Attack_EffectDamage( SIBT.damageType.impact , 1 ) ,
				SIPackers.Attack_EffectDamage( SIBT.damageType.electric , 1 ) ,
				areaParticle
			}
		}
	}
}
local action4 =
{
	{
		type = "direct" ,
		action_delivery =
		{
			type = "instant" ,
			target_effects = targetParticle
		}
	} ,
	{
		type = "area" ,
		radius = 0.8 ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				SIPackers.Attack_EffectDamage( SIBT.damageType.twist , 1 ) ,
				SIPackers.Attack_EffectDamage( SIBT.damageType.void , 1 ) ,
				areaParticle
			}
		}
	}
}

CreateResource( "清水石" , "清水矿" , action1 , SIPackers.Color256( 31 , 173 , 225 ) )
CreateResource( "火苗石" , "火苗矿" , action2 , SIPackers.Color256( 237 , 111 , 8 ) )
CreateResource( "悠远石" , "悠远矿" , action3 , SIPackers.Color256( 240 , 36 , 129 ) )
local ore = CreateResource( "宁寂石" , "宁寂矿" , action4 , SIPackers.Color256( 102 , 10 , 138 ) )

SIGen.NewResource( "宁寂矿-活化" )
.E.SetCanGlow( true )
.E.SetItem( ore )
.SetSize( 1 , 1 )
.SetMapColor( color )
.SetStagesEffectsSettings( 5 , 1 , 3.6 , 0.2 , 0.3 )
.AddFlags( SIFlags.entityFlags.notOnMap , SIFlags.entityFlags.hidden )
.SetTreeSettings( 0.8 , 32*32 )
.FillImage()
.SetSound( "walking_sound" , walkSound )
.SetAutoPlace( nil , { 100000 , 30000 , 10000 , 3000 , 1000 , 300 , 100 , 30 } )

-- ------------------------------------------------------------------------------------------------
-- --------- 创建矿山石 ---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local function CreateStoneAction( areaRadius , damage )
	local stoneParticle =
	{
		type = "create-particle" ,
		particle_name = "stone-particle" ,
		repeat_count = 45 ,
		initial_height = 0.5 ,
		initial_vertical_speed = 0.08 ,
		initial_vertical_speed_deviation = 0.15 ,
		speed_from_center = 0.08 ,
		speed_from_center_deviation = 0.15 ,
		offset_deviation = { { -0.8984 , -0.5 } , { 0.8984 , 0.5 } }
	}
	local areaParticle = table.deepcopy( stoneParticle )
	areaParticle.repeat_count = 8
	return
	{
		{
			type = "direct" ,
			action_delivery =
			{
				type = "instant" ,
				target_effects = stoneParticle
			}
		} ,
		{
			type = "area" ,
			radius = areaRadius ,
			action_delivery =
			{
				type = "instant" ,
				target_effects =
				{
					SIPackers.Attack_EffectDamage( SIBT.damageType.physical , damage ) ,
					areaParticle
				}
			}
		}
	}
end
CreateThrowItem( "矿山石核" , CreateStoneAction( 1.6 , 5.5 ) , SIPackers.Color256( 224 , 160 , 83 ) , 15 )
CreateThrowItem( "矿山石核-多孔" , CreateStoneAction( 1.5 , 4 ) , SIPackers.Color256( 166 , 107 , 36 ) , 16 )

local rockList = { "rock-big" , "rock-huge" , "sand-rock-big" }
for i , v in pairs( rockList ) do
	local rock = SIGen.GetData( SITypes.entity.simpleEntity , v )
	if rock then
		local newRock = table.deepcopy( rock )
		newRock.name = SIGen.CreateName( "矿山石"..i , SITypes.entity.simpleEntity )
		newRock.localised_name = { "SI-name.矿山石" }
		newRock.localised_description = { "SI-description.矿山石" }
		newRock.max_health = 51000
		local minable = newRock.minable
		if minable and minable.result then
			minable.result = nil
			minable.count = nil
		else minable = {} end
		minable.mining_time = 33
		local results = {}
		table.insert( results , SIPackers.SingleItemProduct( "stone" , 0.8 , 1 , 5 ) )
		table.insert( results , SIPackers.SingleItemProduct( "矿山石核" , 0.3 , 1 , 3 ) )
		minable.results = results
		newRock.minable = minable
		local loots = {}
		table.insert( loots , SIPackers.LootItem( "stone" , 1 , 1 , 4 ) )
		table.insert( loots , SIPackers.LootItem( "矿山石核-多孔" , 0.3 , 1 , 2 ) )
		newRock.loot = loots
		if newRock.flags and not table.Has( newRock.flags , SIFlags.entityFlags.notOnMap ) then table.insert( newRock.flags , SIFlags.entityFlags.notOnMap )
		else newRock.flags = { SIFlags.entityFlags.notOnMap } end
		if newRock.collision_mask and not table.Has( newRock.collision_mask , "not-colliding-with-itself" ) then table.insert( newRock.collision_mask , "not-colliding-with-itself" )
		else newRock.collision_mask = { "item-layer" , "object-layer" , "player-layer" , "water-tile" , "not-colliding-with-itself" } end
		SIGen.Extend{ newRock }
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 去壳流程 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewSubGroup( "矿物副产物" )
local function CreateShellAction( particleCount , areaRadius , damage )
	return
	{
		{
			type = "direct" ,
			action_delivery =
			{
				type = "instant" ,
				target_effects =
				{
					type = "create-particle" ,
					particle_name = "stone-particle" ,
					repeat_count = particleCount ,
					initial_height = 0.5 ,
					initial_vertical_speed = 0.08 ,
					initial_vertical_speed_deviation = 0.15 ,
					speed_from_center = 0.08 ,
					speed_from_center_deviation = 0.15 ,
					offset_deviation = { { -0.8984 , -0.5 } , { 0.8984 , 0.5 } }
				}
			}
		} ,
		{
			type = "area" ,
			radius = areaRadius ,
			action_delivery =
			{
				type = "instant" ,
				target_effects = SIPackers.Attack_EffectDamage( SIBT.damageType.physical , damage )
			}
		}
	}
end
CreateThrowItem( "矿石壳屑" , CreateShellAction( 2 , 0.4 , 0.1 ) , SIPackers.Color256( 200 , 200 , 200 ) , 21 )
CreateThrowItem( "矿石壳" , CreateShellAction( 12 , 1.1 , 0.5 ) , SIPackers.Color256( 200 , 200 , 200 ) , 21 )

local function CreateFluid( oreName , fluidName , fuelValue , heat , defaultTemp , maxTemp , gasTemp , fluidColor , otherIngredients )
	local flowColor = SIPackers.ColorBright( fluidColor , 0.5 )
	SIGen
	.NewGroup( SIBT.group.fluid )
	.NewSubGroup( "矿物内胆" )
	.NewFluid( fluidName )
	.SetFuel( fuelValue , heat )
	.SetTemperature( defaultTemp , maxTemp , gasTemp )
	.SetMapColor( fluidColor , flowColor )
	.SetCustomData{ auto_barrel = false }
	
	.NewGroup( SIBT.group.item )
	.NewSubGroup( "矿物敲碎" )
	.NewRecipe( "敲碎-"..oreName )
	.SetEnergy( 2 )
	.SetRecipeTypes( SIBT.recipeType.advanced )
	.AddCosts( oreName , 2 )
	.AddCosts( "工具-锤子" )
	.AddCosts( SIPackers.IngredientsWithList( otherIngredients ) )
	.AddResults( SIPackers.SingleFluidProduct( fluidName , 0.6 , 2 , 2 , nil , 2 ) )
	.AddResults( SIPackers.SingleItemProduct( "工具-锤子" , 0.92 , 1 , 1 , 1 ) )
	.AddResults( SIPackers.SingleItemProduct( "矿石壳屑" , 1 , nil , nil , 1 ) )
	.SetSelfIcon( "敲碎-"..oreName )
	
	.NewSubGroup( "矿物开壳" )
	.NewRecipe( "开壳-"..oreName )
	.SetEnergy( 4 )
	.SetRecipeTypes( SIBT.recipeType.advanced )
	.AddCosts( oreName )
	.AddCosts( "工具-钻头" )
	.AddCosts( SIPackers.IngredientsWithList( otherIngredients ) )
	.AddResults( SIPackers.SingleFluidProduct( fluidName , 0.85 , 1 , 1 , nil , 1 ) )
	.AddResults( SIPackers.SingleItemProduct( "工具-钻头" , 0.9 , 1 , 1 , 1 ) )
	.AddResults( SIPackers.SingleItemProduct( "矿石壳屑" , 0.07 , 1 , 1 , 1 ) )
	.AddResults( SIPackers.SingleItemProduct( "矿石壳" , 0.85 , 1 , 1 , 1 ) )
	.SetSelfIcon( "开壳-"..oreName )
	
	.NewRecipe( "去壳-"..oreName )
	.SetEnergy( 5 )
	.SetRecipeTypes( SIBT.recipeType["分离机"] )
	.AddCosts( oreName )
	.AddCosts( "工具-钻头" )
	.AddCosts( SIPackers.IngredientsWithList( otherIngredients ) )
	.AddResults( SIPackers.SingleFluidProduct( fluidName , 1 , nil , nil , nil , 1 ) )
	.AddResults( SIPackers.SingleItemProduct( "工具-钻头" , 0.97 , 1 , 1 , 1 ) )
	.AddResults( SIPackers.SingleItemProduct( "矿石壳" , 1 , nil , nil , 1 ) )
	.SetSelfIcon( "去壳-"..oreName )
end
CreateFluid( "清水石" , "清水" , "480KJ" , "12J" , -1 , 223 , 14 , SIPackers.Color256( 31 , 173 , 225 ) )
CreateFluid( "火苗石" , "火苗" , "13.35MJ" , "445J" , 135 , 1200000 , 140000 , SIPackers.Color256( 237 , 111 , 8 ) )
CreateFluid( "悠远石" , "呼唤" , "0J" , "980KJ" , 0 , 10 , 8 , SIPackers.Color256( 240 , 36 , 129 ) )
CreateFluid( "宁寂石" , "安宁" , "0J" , "1.45MJ" , 0 , 25 , 1 , SIPackers.Color256( 102 , 10 , 138 ) , { { "稳定剂-躁动抑制" } } )

-- ------------------------------------------------------------------------------------------------
-- ---------- 反应流程 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.NewGroup( SIBT.group.fluid )
.NewSubGroup( "流体反应" )

.NewRecipe( "清火中和" )
.SetEnergy( 0.1 )
.SetRecipeTypes( SIBT.recipeType.withFluid )
.AddCosts( "清水" , 100 )
.AddCosts( "火苗" , 100 )
.AddResults( SIPackers.SingleItemProduct( "矿石壳屑" , 0.5 , 1 , 1 , 1 ) )
.SetSelfIcon( "清火中和" )

.NewRecipe( "清水稀释" )
.SetEnergy( 1.5 )
.SetRecipeTypes( SIBT.recipeType.withFluid )
.AddCosts( "清水" , 100 )
.AddCosts( "火苗" , 25 )
.AddCosts( "water" , 1 )
.AddResults( SIPackers.SingleFluidProduct( "water" , 60 , nil , nil , nil , 60 ) )
.AddResults( SIPackers.SingleItemProduct( "矿石壳屑" , 0.3125 , 1 , 1 , 1 ) )
.SetSelfIcon( "清水稀释" )

.NewRecipe( "爆热蒸发" )
.SetEnergy( 4 )
.SetRecipeTypes( SIBT.recipeType.withFluid )
.AddCosts( "火苗" , 50 )
.AddCosts( "water" , 85 )
.AddResults( SIPackers.SingleFluidProduct( "steam" , 85 , nil , nil , 165 , 85 ) )
.AddResults( SIPackers.SingleItemProduct( "矿石壳屑" , 0.125 , 1 , 1 , 1 ) )
.SetSelfIcon( "爆热蒸发" )

.NewRecipe( "极寒凝结" )
.SetEnergy( 5 )
.SetRecipeTypes( SIBT.recipeType.withFluid )
.AddCosts( "清水" , 50 )
.AddCosts( SIPackers.SingleFluidIngredientsPack( "steam" , 85 , 160 , 170 ) )
.AddResults( SIPackers.SingleFluidProduct( "water" , 85 , nil , nil , nil , 85 ) )
.AddResults( SIPackers.SingleItemProduct( "矿石壳屑" , 0.125 , 1 , 1 , 1 ) )
.SetSelfIcon( "极寒凝结" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 冶炼流程 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

.NewGroup( SIBT.group.itme )
.NewSubGroup( "矿物萃取" )

.NewRecipe( "冰澄物质萃取" )
.SetEnergy( 20 )
.SetRecipeTypes( SIBT.recipeType["萃取炉"] )
.AddCosts( "矿山石核-多孔" , 3 )
.AddCosts( "清水" , 100 )
.AddResults( SIPackers.SingleFluidProduct( "water" , 75 , nil , nil , nil , 75 ) )
.AddResults( SIPackers.SingleFluidProduct( "清水" , 20 , nil , nil , nil , 20 ) )
.AddResults( SIPackers.SingleItemProduct( "稳定剂-清霜激荡" , 0.8 , 1 , 1 , 1 ) )
.AddResults( SIPackers.SingleItemProduct( "矿山石核-多孔" , 2 , nil , nil , 2 ) )
.AddResults( SIPackers.SingleItemProduct( "矿石壳屑" , 0.2 , 1 , 1 , 1 ) )
.SetSelfIcon( "冰澄物质萃取" )

.NewRecipe( "躁动物质萃取" )
.SetEnergy( 25 )
.SetRecipeTypes( SIBT.recipeType["萃取炉"] )
.AddCosts( "矿山石核-多孔" , 3 )
.AddCosts( "火苗" , 100 )
.AddResults( SIPackers.SingleFluidProduct( "water" , 75 , nil , nil , nil , 75 ) )
.AddResults( SIPackers.SingleFluidProduct( "火苗" , 20 , nil , nil , nil , 20 ) )
.AddResults( SIPackers.SingleItemProduct( "稳定剂-焦香四溢" , 0.8 , 1 , 1 , 1 ) )
.AddResults( SIPackers.SingleItemProduct( "矿山石核-多孔" , 2 , nil , nil , 2 ) )
.AddResults( SIPackers.SingleItemProduct( "矿石壳屑" , 0.2 , 1 , 1 , 1 ) )
.SetSelfIcon( "躁动物质萃取" )

.NewRecipe( "永恒物质萃取" )
.SetEnergy( 50 )
.SetRecipeTypes( SIBT.recipeType["萃取炉"] )
.AddCosts( "矿山石核-多孔" , 3 )
.AddCosts( "呼唤" , 100 )
.AddResults( SIPackers.SingleFluidProduct( "water" , 75 , nil , nil , nil , 75 ) )
.AddResults( SIPackers.SingleFluidProduct( "呼唤" , 20 , nil , nil , nil , 20 ) )
.AddResults( SIPackers.SingleItemProduct( "稳定剂-梦回千古" , 0.8 , 1 , 1 , 1 ) )
.AddResults( SIPackers.SingleItemProduct( "矿山石核-多孔" , 2 , nil , nil , 2 ) )
.AddResults( SIPackers.SingleItemProduct( "矿石壳屑" , 0.2 , 1 , 1 , 1 ) )
.SetSelfIcon( "消逝物质萃取" )

.NewRecipe( "静谧物质萃取" )
.SetEnergy( 130 )
.SetRecipeTypes( SIBT.recipeType["萃取炉"] )
.AddCosts( "矿山石核-多孔" , 3 )
.AddCosts( "安宁" , 100 )
.AddResults( SIPackers.SingleFluidProduct( "water" , 75 , nil , nil , nil , 75 ) )
.AddResults( SIPackers.SingleFluidProduct( "安宁" , 20 , nil , nil , nil , 20 ) )
.AddResults( SIPackers.SingleItemProduct( "稳定剂-躁动抑制" , 0.8 , 1 , 1 , 1 ) )
.AddResults( SIPackers.SingleItemProduct( "矿山石核-多孔" , 2 , nil , nil , 2 ) )
.AddResults( SIPackers.SingleItemProduct( "矿石壳屑" , 0.2 , 1 , 1 , 1 ) )
.SetSelfIcon( "静谧物质萃取" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 免疫设施 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

.NewEquipment( SITypes.equipment.battery , "抵抗模块-宁寂矿-活化" )
.Size( SIUtils.PointsBorder( 4 , 4 ) )
.SetEnergy( SIPackers.ElectricEnergySource( SITypes.electricUsagePriority.tertiary , "1MJ" , nil , "1MW" , "1MW" ) )
.AddPluginTypes( SIBT.equipmentType.armor )

.NewEquipment( SITypes.equipment.battery , "抵抗模块-宁寂矿-伤害" )
.Size( 2 , 2 )
.SetEnergy( SIPackers.ElectricEnergySource( SITypes.electricUsagePriority.tertiary , "500KJ" , nil , "500KW" , "500KW" ) )
.AddPluginTypes( SIBT.equipmentType.armor )