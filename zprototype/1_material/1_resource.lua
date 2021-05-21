-- ------------------------------------------------------------------------------------------------
-- ---------- 创建矿物 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewGroup( SIBT.group.item )
.NewSubGroup( "矿物" )

local function CreateResource( itemName , resourceName , action , color , category )
	local item = SIGen.NewCapsule( itemName ).SetAction( action , color ).GetCurrentEntity()
	SIBT.item[itemName] = SIGen.GetCurrentEntityName()
	SIGen.NewResource( resourceName )
	.E.SetCanGlow( true )
	.E.SetItem( item )
	.SetSize( 1 , 1 )
	.SetMapColor( color )
	.SetStagesEffectsSettings( 5 , 1 , 3.6 , 0.2 , 0.3 )
	.AddFlags( SIFlags.entityFlags.notOnMap )
	.SetTreeSettings( 0.8 , 32*32 )
	.FillImage()
	.SetSound( "walking_sound" , SISounds.BaseSoundList( "walking/resources/ore" , 10 , 0.7 ) )
	if category then SIGen.SetRecipeTypes( category ) end
	SIGen.SetAutoPlace(
	{
		order = "d" ,
		base_density = 0.9 ,
		base_spots_per_km2 = 1.25 ,
		random_spot_size_minimum = 2 ,
		random_spot_size_maximum = 4 ,
		regular_rq_factor_multiplier = 1 ,
		has_starting_area_placement = false
	} , { 100000 , 30000 , 10000 , 3000 , 1000 , 300 , 100 , 30 } )
	return item
end

CreateResource( "清水石" , "清水矿" , action1 , SIPackers.Color256( 31 , 173 , 225 ) )
CreateResource( "火苗石" , "火苗矿" , action2 , SIPackers.Color256( 237 , 111 , 8 ) )
CreateResource( "悠远石" , "悠远矿" , action3 , SIPackers.Color256( 240 , 36 , 129 ) )
CreateResource( "宁寂石" , "宁寂矿" , action4 , SIPackers.Color256( 102 , 10 , 138 ) )

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建岩石 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIBT.item["矿山石"] = SIGen.NewCapsule( "矿山石" ).SetAction( action5 ).GetCurrentEntityName()
local rockList = { "red-desert-rock-big" , "red-desert-rock-huge" , "rock-big" , "rock-huge" , "sand-rock-big" }
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