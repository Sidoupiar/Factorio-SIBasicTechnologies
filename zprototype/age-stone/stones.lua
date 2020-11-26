-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local coalItem = SIGen.GetData( SITypes.item.item , "coal" )
local coalFuel = coalItem.fuel_value
local coalFuelValue , coalFuelClass = tostring( coalFuel ):GetEnergyClass()
local coalFuelType = coalItem.fuel_category

-- ------------------------------------------------------------------------------------------------
-- ------- 创建物品和配方 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewSubGroup( "stone-item" )
.NewItem( "stone-hard" , 25 )
.NewItem( "stone-chippings" , 500 )
.NewItem( "coal-chippings" , 700 ).SetEnergy( (coalFuelValue*0.009)..coalFuelClass , coalFuelType )

.NewRecipe( "sibt-item-stone-hard" )
.SetEnergy( 1 )
.SetEnabled( true )
.AddCosts( "stone" , 5 )
.AddResults( SIPackers.SingleItemProduct( "sibt-item-stone-hard" , 1 , 1 , 3 ) )
.AddResults( SIPackers.SingleItemProduct( "sibt-item-stone-chippings" , 1 , 8 , 75 ) )
.SetSelfIcon( "stone-hard" )

.NewRecipe( "sibt-item-coal-chippings" )
.SetEnergy( 2 )
.SetEnabled( true )
.AddCosts( "coal" , 3 )
.AddCosts( "sibt-item-tool-stone-hammer" )
.AddResults( SIPackers.SingleItemProduct( "sibt-item-coal-chippings" , 1 , 25 , 550 ) )
.AddResults( SIPackers.SingleItemProduct( "sibt-item-tool-stone-hammer" , 0.99 , 1 , 1 ) )
.SetSelfIcon( "coal-chippings" )

