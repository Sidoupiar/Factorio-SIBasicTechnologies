load()

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIBT.group.agriculture = SIGen.Init( SIBT ).NewGroup( "agriculture" ).GetCurrentEntityName()

needlist( "zprototype/1_material" , "1_resource" , "2_paint" , "3_tool" , "4_food" )
needlist( "zprototype/2_cycle" , "1_carbon" , "2_science" , "3_elepanel" )
needlist( "zprototype/3_level" , "1_machine" , "2_generator" , "3_minedrill" , "4_container" , "5_module" , "6_equipment" )

needlist( "zprototype/9_special" , "1_transbelt" , "2_pipe" , "3_railway" )

SIGen.Finish()