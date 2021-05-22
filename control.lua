require( "__SICoreFunctionLibrary__/util" )

needlist( "__SICoreFunctionLibrary__" , "define/load" , "function/load" )
needlist( "__SICoreFunctionLibrary__/runtime/structure" , "sievent_bus" , "siglobal" , "siunlocker" )

load()

-- ------------------------------------------------------------------------------------------------
-- ---------- 装载数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

needlist( "zaction" , "1_common" )
needlist( "zaction/1_material" , "1_resource" , "2_paint" , "3_tool" , "4_food" )
needlist( "zaction/2_cycle" , "1_carbon" , "2_science" , "3_elepanel" )
needlist( "zaction/3_level" , "1_machine" , "2_generator" , "3_minedrill" , "4_container" , "5_module" , "6_equipment" , "7_weapon" )

needlist( "zaction/9_special" , "1_transbelt" , "2_pipe" , "3_railway" )

forceNeutral = "neutral"

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

