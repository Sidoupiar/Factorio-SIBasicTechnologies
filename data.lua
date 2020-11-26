load()

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.Init( SIBT )
.NewGroup( "sibt" )

needlist( "zprototype/age-stone/" , "stones" , "trees" )
needlist( "zprototype/age-wood/" , "items" , "entities" , "recipes" )
needlist( "zprototype/age-animal/" , "items" , "entities" , "recipes" )
needlist( "zprototype/age-wind/" , "items" , "entities" , "recipes" )
needlist( "zprototype/age-steam/" , "pipes" , "entities" , "recipes" )
needlist( "zprototype" , "molds" , "tools" , "technologies" )

SIGen.Finish()