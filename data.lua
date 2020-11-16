load()

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.Init( SIBT )
.NewGroup( "sibt" )

needlist( "zprototype" , "tools" , "technologies" )
for i , v in pairs{ "stone" , "wood" , "animal" , "wind" , "steam" } do needlist( "zprototype/age-"..v.."/" , "items" , "entities" , "recipes" ) end

SIGen.Finish()