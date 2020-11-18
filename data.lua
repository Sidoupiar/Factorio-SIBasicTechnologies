load()

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.Init( SIBT )
.NewGroup( "sibt" )

needlist( "zprototype" , "tools" , "technologies" )
needlist( "zprototype/age-stone/" , "items" , "entities" , "recipes" )
needlist( "zprototype/age-wood/" , "items" , "entities" , "recipes" )
needlist( "zprototype/age-animal/" , "items" , "entities" , "recipes" )
needlist( "zprototype/age-wind/" , "items" , "entities" , "recipes" )
needlist( "zprototype/age-steam/" , "pipes" , "entities" , "recipes" )

SIGen.NewSubGroup( "base-recipe" ).Finish()