load()

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.Init( SIBT )
.NewGroup( "sibt" )

need( "zprototype/base" )

local directoryList = { "stone" , "wood" , "animal" , "wind" , "steam" }
local fileList = { "items" , "entities" , "recipes" }
for i , v in pairs( directoryList ) do for n , m in pairs( fileList ) do need( "zprototype/age-"..v.."/"..m ) end end

SIGen.Finish()