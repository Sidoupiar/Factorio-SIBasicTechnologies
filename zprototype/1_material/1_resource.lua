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
				{
					type = "create-entity" ,
					entity_name = "grenade-explosion"
				} ,
				{
					type = "invoke-tile-trigger" ,
					repeat_count = 1
				} ,
				{
					type = "destroy-decoratives" ,
					from_render_layer = "decorative" ,
					to_render_layer = "object" ,
					include_soft_decoratives = true , -- soft decoratives are decoratives with grows_through_rail_path = true
					include_decals = false ,
					invoke_decorative_trigger = true ,
					decoratives_with_trigger_only = false , -- if true, destroys only decoratives that have trigger_effect set
					radius = 2.25 -- large radius for demostrative purposes
				}
			}
		}
	} ,
	{
		type = "area" ,
		radius = 3.5 ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				{
					type = "damage" ,
					damage = { type = "poison" , amount = 1 }
				} ,
				{
					type = "damage" ,
					damage = { type = "sicfl-water" , amount = 1 }
				} ,
				{
					type = "create-entity" ,
					entity_name = "explosion"
				}
			}
		}
	}
}
local action2 =
{
	{
		type = "direct" ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				{
					type = "create-fire" ,
					entity_name = "fire-flame"
				}
			}
		}
	} ,
	{
		type = "area" ,
		radius = 5 ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				{
					type = "damage" ,
					damage = { type = "fire" , amount = 2 }
				} ,
				{
					type = "create-sticker" ,
					sticker = "fire-sticker"
				} ,
				{
					type = "create-fire" ,
					entity_name = "fire-flame"
				}
			}
		}
	}
}
local action3 =
{
	{
		type = "direct" ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				{
					type = "create-particle" ,
					particle_name = "stone-particle" ,
					repeat_count = 12 ,
					initial_height = 0.5 ,
					initial_vertical_speed = 0.08 ,
					initial_vertical_speed_deviation = 0.15 ,
					speed_from_center = 0.08 ,
					speed_from_center_deviation = 0.15 ,
					offset_deviation = { { -0.8984 , -0.5 } , { 0.8984 , 0.5 } }
				}
			}
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
				{
					type = "damage" ,
					damage = { type = "impact" , amount = 1 }
				} ,
				{
					type = "damage" ,
					damage = { type = "electric" , amount = 1 }
				} ,
				{
					type = "create-particle" ,
					particle_name = "stone-particle" ,
					repeat_count = 2 ,
					initial_height = 0.5 ,
					initial_vertical_speed = 0.08 ,
					initial_vertical_speed_deviation = 0.15 ,
					speed_from_center = 0.08 ,
					speed_from_center_deviation = 0.15 ,
					offset_deviation = { { -0.8984 , -0.5 } , { 0.8984 , 0.5 } }
				}
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
			target_effects =
			{
				{
					type = "create-particle" ,
					particle_name = "stone-particle" ,
					repeat_count = 12 ,
					initial_height = 0.5 ,
					initial_vertical_speed = 0.08 ,
					initial_vertical_speed_deviation = 0.15 ,
					speed_from_center = 0.08 ,
					speed_from_center_deviation = 0.15 ,
					offset_deviation = { { -0.8984 , -0.5 } , { 0.8984 , 0.5 } }
				}
			}
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
				{
					type = "damage" ,
					damage = { type = "physical" , amount = 1 }
				} ,
				{
					type = "create-particle" ,
					particle_name = "stone-particle" ,
					repeat_count = 2 ,
					initial_height = 0.5 ,
					initial_vertical_speed = 0.08 ,
					initial_vertical_speed_deviation = 0.15 ,
					speed_from_center = 0.08 ,
					speed_from_center_deviation = 0.15 ,
					offset_deviation = { { -0.8984 , -0.5 } , { 0.8984 , 0.5 } }
				}
			}
		}
	}
}

CreateResource( "清水石" , "清水矿" , action1 , SIPackers.Color256( 31 , 173 , 225 ) )
CreateResource( "火苗石" , "火苗矿" , action2 , SIPackers.Color256( 237 , 111 , 8 ) )
CreateResource( "悠远石" , "悠远矿" , action3 , SIPackers.Color256( 240 , 36 , 129 ) )
CreateResource( "宁寂石" , "宁寂矿" , action4 , SIPackers.Color256( 102 , 10 , 138 ) )

-- ------------------------------------------------------------------------------------------------
-- --------- 创建矿山石 ---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local action5 =
{
	{
		type = "direct" ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				{
					type = "create-particle" ,
					particle_name = "stone-particle" ,
					repeat_count = 35 ,
					initial_height = 0.5 ,
					initial_vertical_speed = 0.08 ,
					initial_vertical_speed_deviation = 0.15 ,
					speed_from_center = 0.08 ,
					speed_from_center_deviation = 0.15 ,
					offset_deviation = { { -0.8984 , -0.5 } , { 0.8984 , 0.5 } }
				}
			}
		}
	} ,
	{
		type = "area" ,
		radius = 1.7 ,
		action_delivery =
		{
			type = "instant" ,
			target_effects =
			{
				{
					type = "damage" ,
					damage = { type = "physical" , amount = 6 }
				} ,
				{
					type = "create-particle" ,
					particle_name = "stone-particle" ,
					repeat_count = 7 ,
					initial_height = 0.5 ,
					initial_vertical_speed = 0.08 ,
					initial_vertical_speed_deviation = 0.15 ,
					speed_from_center = 0.08 ,
					speed_from_center_deviation = 0.15 ,
					offset_deviation = { { -0.8984 , -0.5 } , { 0.8984 , 0.5 } }
				}
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
		newRock.max_health = ( newRock.max_health or 500 ) * 25
		local minable = newRock.minable
		if minable and minable.result then
			minable.result = nil
			minable.count = nil
		else minable = {} end
		if minable.mining_time then minable.mining_time = minable.mining_time * 10
		else minable.mining_time = 35 end
		local results = {}
		table.insert( results , SIPackers.SingleItemProduct( "stone" , 0.2 , 1 , 5 ) )
		table.insert( results , SIPackers.SingleItemProduct( SIBT.item["矿山石"] , 0.1 , 1 , 3 ) )
		minable.results = results
		newRock.minable = minable
		if newRock.flags and not table.Has( newRock.flags , SIFlags.entityFlags.notOnMap ) then table.insert( newRock.flags , SIFlags.entityFlags.notOnMap )
		else newRock.flags = { SIFlags.entityFlags.notOnMap } end
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