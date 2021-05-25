-- ------------------------------------------------------------------------------------------------
-- ---------- 创建矿物 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewGroup( SIBT.group.item )
.NewSubGroup( "矿物" )

local throwSound = SISounds.BaseSoundList( "fight/throw-projectile" , 6 , 0.4 )
local walkSound = SISounds.BaseSoundList( "walking/resources/ore" , 10 , 0.7 )

local function CreateThrowItem( itemName , action , color )
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
			range = 17 ,
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
	return SIGen.NewCapsule( itemName ).SetAction( capsuleAction , color ).GetCurrentEntity()
end

local function CreateResource( itemName , resourceName , action , color , category )
	local item = CreateThrowItem( itemName , action , SIPackers.ColorCopyWithA( color , 0.3 ) )
	SIBT.item[itemName] = SIGen.GetCurrentEntityName()
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
				SIPackers.Attack_EffectDamage( "poison" , 1 ) ,
				SIPackers.Attack_EffectDamage( "sicfl-water" , 1 )
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
				SIPackers.Attack_EffectDamage( "fire" , 2 ) ,
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
				SIPackers.Attack_EffectDamage( "impact" , 1 ) ,
				SIPackers.Attack_EffectDamage( "electric" , 1 ) ,
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
				SIPackers.Attack_EffectDamage( "physical" , 1 ) ,
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
local action5 =
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
		radius = 1.6 ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				SIPackers.Attack_EffectDamage( "physical" , 6 ) ,
				areaParticle
			}
		}
	}
}
CreateThrowItem( "矿山石" , action5 )
SIBT.item["矿山石"] = SIGen.GetCurrentEntityName()
local rockList = { "rock-big" , "rock-huge" , "sand-rock-big" }
for i , v in pairs( rockList ) do
	local rock = SIGen.GetData( SITypes.entity.simpleEntity , v )
	if rock then
		local newRock = table.deepcopy( rock )
		newRock.name = SIGen.CreateName( "矿山石"..i , SITypes.entity.simpleEntity )
		newRock.localised_name = { "entity-name.sibt-simple-矿山石" }
		newRock.localised_description = { "entity-description.sibt-simple-矿山石" }
		newRock.max_health = 51000
		local minable = newRock.minable
		if minable and minable.result then
			minable.result = nil
			minable.count = nil
		else minable = {} end
		minable.mining_time = 33
		local results = {}
		table.insert( results , SIPackers.SingleItemProduct( "stone" , 0.8 , 1 , 5 ) )
		table.insert( results , SIPackers.SingleItemProduct( SIBT.item["矿山石"] , 0.3 , 1 , 3 ) )
		minable.results = results
		newRock.minable = minable
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

-- ------------------------------------------------------------------------------------------------
-- ---------- 反应流程 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 冶炼流程 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------
-- ---------- 免疫设施 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------