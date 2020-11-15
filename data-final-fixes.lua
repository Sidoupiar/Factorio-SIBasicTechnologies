-- ------------------------------------------------------------------------------------------------
-- -------- 调整玩家能力 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local character = SIGen.GetData( SITypes.entity.character , "character" )
table.insert( character.crafting_categories , SIBT.handRub ) -- 允许手搓的制作方式
character.max_health = 350            -- 最大血量 , 默认 250
character.inventory_size = 40         -- 背包容量 , 默认 80
character.build_distance = 5          -- 建造建筑距离 , 默认 10
character.reach_distance = 5          -- 操作建筑距离 , 默认 10
character.drop_item_distance = 5      -- 丢弃物品距离 , 默认 10
character.item_pickup_distance = 1    -- 捡起物品距离 , 默认 1 , 比如传送点
character.loot_pickup_distance = 4    -- 捡起掉落物品距离 , 默认 2 , 杀怪掉落之类
character.enter_vehicle_distance = 3  -- 进入载具距离 , 默认 3 , 离这么远按 Enter 可以直接进载具
character.reach_resource_distance = 4 -- 资源开采距离 , 默认 2.7

-- ------------------------------------------------------------------------------------------------
-- -------- 调整原版矿物 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local resourceNameList = { "coal" , "stone" , "iron-ore" , "copper-ore" }
for i , v in pairs( resourceNameList ) do
	local ore = SIGen.GetData( SITypes.entity.resource , v )
	if ore then
		local minable = ore.minable
		if minable then
			if minable.mining_time then
				if minable.mining_time < 2 then minable.mining_time = 2 end
			end
			if not minable.fluid_amount then minable.fluid_amount = 100 end
			if not minable.required_fluid then minable.required_fluid = "water" end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ----- 调整原版石头和树木 -----------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------
if false then
local rockList = { "red-desert-rock-big" , "red-desert-rock-huge" , "rock-big" , "rock-huge" , "sand-rock-big" }
for i , v in pairs( rockList ) do
	local rock = SIGen.GetList( SITypes.entity.simpleEntity , v )
	if rock then
		local minable = rock.minable
		if minable then
			if minable.mining_time then minable.mining_time = minable.mining_time * 2 end
			local results = minable.results
			if not results then
				results = {}
				if minable.result then
					table.insert( results , SIPackers.SingleItemProduct( minable.result , minable.count ) )
					minable.result = nil
					minable.count = nil
				end
			end
			table.insert( results , SIPackers.SingleItemProduct( SIBT.stone.hard , 1 , 0.2 ) ) -- 硬石块
			table.insert( results , SIPackers.SingleItemProduct( SIBT.stone.chippings , nil , 1 , 15 , 100 ) ) -- 碎石
			table.insert( results , SIPackers.SingleItemProduct( "iron-ore" , nil , 0.2 , 1 , 3 ) ) -- 铁矿
			table.insert( results , SIPackers.SingleItemProduct( "copper-ore" , nil , 0.2 , 1 , 3 ) ) -- 铜矿
			minable.results = results
		end
	end
end
for i , v in pairs( SIGen.GetList( SITypes.entity.tree ) ) do
	if v then
		local minable = v.minable
		if minable then
			if minable.mining_time then minable.mining_time = minable.mining_time * 2 end
			local results = minable.results
			if not results then
				results = {}
				if minable.result then
					table.insert( results , SIPackers.SingleItemProduct( minable.result , minable.count ) )
					minable.result = nil
					minable.count = nil
				end
			end
			table.insert( results , SIPackers.SingleItemProduct( SIBT.wood.fruit , nil , 0.2 , 1 , 5 ) ) -- 果实
			table.insert( results , SIPackers.SingleItemProduct( SIBT.wood.leaf , nil , 1 , 20 , 50 ) ) -- 树叶
			table.insert( results , SIPackers.SingleItemProduct( SIBT.wood.bark , nil , 1 , 1 , 8 ) ) -- 树皮
			table.insert( results , SIPackers.SingleItemProduct( SIBT.wood.root , 1 ) ) -- 树根
			table.insert( results , SIPackers.SingleItemProduct( SIBT.wood.sawdust , nil , 1 , 20 , 80 ) ) -- 木屑
			minable.results = results
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- --- 创建原版材料的替代配方 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local moldWheelIn = SIPackers.SingleItemIngredient( SIBT.mold.wheel , 1 )
local moldPipeIn = SIPackers.SingleItemIngredient( SIBT.mold.pipe , 1 )
local toolHammerIn = SIPackers.SingleItemIngredient( SIBT.tool.iron.hammer , 1 )
local toolSawIn = SIPackers.SingleItemIngredient( SIBT.tool.iron.saw , 1 )
local toolBoltDriverIn = SIPackers.SingleItemIngredient( SIBT.tool.iron.boltDriver , 1 )

local moldWheelOut = SIPackers.SingleItemProduct( SIBT.mold.wheel , 1 , 0.99 )
local moldPipeOut = SIPackers.SingleItemProduct( SIBT.mold.pipe , 1 , 0.99 )
local toolHammerOut = SIPackers.SingleItemProduct( SIBT.tool.iron.hammer , 1 , 0.99 )
local toolSawOut = SIPackers.SingleItemProduct( SIBT.tool.iron.saw , 1 , 0.99 )
local toolBoltDriverOut = SIPackers.SingleItemProduct( SIBT.tool.iron.boltDriver , 1 , 0.99 )

local recipeList =
{
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "iron-gear-wheel" ) ) , moldWheelIn , toolHammerIn ) , moldWheelOut , toolHammerOut ) ,
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "iron-stick" ) ) , toolSawIn ) , toolSawOut ) ,
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "stone-furnace" ) ) , toolHammerIn , toolSawIn ) , toolHammerOut , toolSawOut ) ,
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "wooden-chest" ) ) , toolHammerIn , toolSawIn ) , toolHammerOut , toolSawOut ) ,
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "pipe" ) ) , moldPipeIn , toolHammerIn ) , moldPipeOut , toolHammerOut ) ,
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "copper-cable" ) ) , toolHammerIn , toolSawIn , toolBoltDriverIn ) , toolHammerOut , toolSawOut , toolBoltDriverOut )
}
for i , v in pairs( recipeList ) do
	v.name = "si" .. SIKeyw[SITypes.recipe] .. v.name
	v.category = "crafting"
	if v.energy_required then v.energy_required = v.energy_required * 2
	else v.energy_required = 1 end
	if not v.enabled then v.enabled = true end
	if not v.overload_multiplier then v.overload_multiplier = 5 end
	if not v.request_paste_multiplier then v.request_paste_multiplier = 5 end
	if not v.emissions_multiplier then v.emissions_multiplier = 1 end
	if v.always_show_made_in == nil then v.always_show_made_in = true end
	if v.always_show_products == nil then v.always_show_products = true end
	if v.show_amount_in_title == nil then v.show_amount_in_title = false end
	if v.allow_decomposition == nil then v.allow_decomposition = false end
end
SIGen.Extend( recipeList )
end
-- ------------------------------------------------------------------------------------------------
-- ------ 调整原版物品配方 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local recipeList =
{
	"iron-gear-wheel" ,
	"iron-stick" ,
	"stone-furnace" ,
	"wooden-chest" ,
	"pipe" ,
	"copper-cable" ,
	"assembling-machine-1" ,
	"assembling-machine-2" ,
	"assembling-machine-3"
}
for i , v in pairs( recipeList ) do SIGen.GetData( SITypes.recipe , v ).category = "advanced-crafting" end

-- ------------------------------------------------------------------------------------------------
-- ------ 调整原版地板能力 ------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local floorList =
{
	"stone-path" ,
	"concrete" ,
	"hazard-concrete-left" ,
	"hazard-concrete-right" ,
	"refined-concrete" ,
	"refined-hazard-concrete-left" ,
	"refined-hazard-concrete-right"
}
for i , v in pairs( floorList ) do
	local floorItem = SIGen.GetData( SITypes.tile , v )
	if floorItem then
		if floorItem.walking_speed_modifier then floorItem.walking_speed_modifier = ( floorItem.walking_speed_modifier - 1 ) * 2 + 2 end
		if floorItem.decorative_removal_probability then floorItem.decorative_removal_probability = floorItem.decorative_removal_probability * 1.5 end
	end
end