local customData =
{
	damaged_trigger_effect =
	{
		type = "create-entity" ,
		entity_name = "spark-explosion" ,
		offset_deviation = { { -0.5 , -0.5 } , { 0.5 , 0.5 } } ,
		offsets = { { 0 , 1 } } ,
		damage_type_filters = "fire"
	} ,
	horizontal_window_bounding_box = { { -0.25 , -0.28125 } , { 0.25 , 0.15625 } } ,
	vertical_window_bounding_box = { { -0.28125 , -0.5 } , { 0.03125 , 0.125 } }
}
local list =
{
	straight = SIPackers.FluidBox( 1 , { { 1 , 0 } , { -1 , 0 } } ) ,
	corner = SIPackers.FluidBox( 1 , { { 1 , 0 } , { 0 , 1 } } ) ,
	tsize = SIPackers.FluidBox( 1 , { { 1 , 0 } , { 0 , 1 } , { -1 , 0 } } )
}
SIGen.NewSubGroup( "pipes" )
for name , box in pairs( list ) do
	SIGen.NewPipe( "pipe-"..name )
	.SetProperties( 1 , 1 , 100 )
	.SetCorpse( "pipe-remnants" , "pipe-explosion" )
	.SetFluidBox( box )
	.SetCustomData( customData )
	.NewRecipe( "sibt-item-pipe-"..name )
	.SetEnergy( 1 )
	.SetEnabled( true )
	.SetCosts( "pipe" )
	.SetResults{ SIPackers.SingleItemProduct( "sibt-item-pipe-"..name , 1 , nil , nil , 1 ) }
end