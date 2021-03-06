-- ------------------------------------------------------------------------------------------------
-- -------- 调整玩家能力 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local character = SIGen.GetData( SITypes.entity.character , "character" )
table.insert( character.crafting_categories , SIBT.handRub ) -- 允许手搓的制作方式
character.max_health = 400            -- 最大血量 , 默认 250
character.inventory_size = 40         -- 背包容量 , 默认 80
character.build_distance = 12         -- 建造建筑距离 , 默认 10
character.reach_distance = 12         -- 操作建筑距离 , 默认 10
character.drop_item_distance = 12     -- 丢弃物品距离 , 默认 10
character.item_pickup_distance = 2    -- 捡起物品距离 , 默认 1 , 比如传送点
character.loot_pickup_distance = 5    -- 捡起掉落物品距离 , 默认 2 , 杀怪掉落之类
character.enter_vehicle_distance = 3  -- 进入载具距离 , 默认 3 , 离这么远按 Enter 可以直接进载具
character.reach_resource_distance = 5 -- 资源开采距离 , 默认 2.7

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
			table.insert( results , SIPackers.SingleItemProduct( "sibt-item-stone-hard" , 0.2 , 1 , 1 ) ) -- 硬石块
			table.insert( results , SIPackers.SingleItemProduct( "sibt-item-stone-chippings" , 1 , 20 , 115 ) ) -- 碎石
			table.insert( results , SIPackers.SingleItemProduct( "iron-ore" , 0.1 , 1 , 3 ) ) -- 铁矿
			table.insert( results , SIPackers.SingleItemProduct( "copper-ore" , 0.1 , 1 , 3 ) ) -- 铜矿
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
			table.insert( results , SIPackers.SingleItemProduct( "sibt-item-tree-fruit" , 0.2 , 1 , 5 ) ) -- 果实
			table.insert( results , SIPackers.SingleItemProduct( "sibt-item-tree-leaf" , 1 , 15 , 85 ) ) -- 树叶
			table.insert( results , SIPackers.SingleItemProduct( "sibt-item-tree-bark" , 1 , 1 , 11 ) ) -- 树皮
			table.insert( results , SIPackers.SingleItemProduct( "sibt-item-tree-root" , 1 , 1 , 2 ) ) -- 树根
			table.insert( results , SIPackers.SingleItemProduct( "sibt-item-tree-sawdust" , 1 , 15 , 165 ) ) -- 木屑
			minable.results = results
		end
	end
end
end
-- ------------------------------------------------------------------------------------------------
-- --- 创建原版材料的替代配方 ---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local moldWheelIn = SIPackers.SingleItemIngredient( "sibt-item-mold-wheel" , 1 )
local moldPipeIn = SIPackers.SingleItemIngredient( "sibt-item-mold-pipe" , 1 )
local toolHammerIn = SIPackers.SingleItemIngredient( "sibt-item-tool-iron-hammer" , 1 )
local toolSawIn = SIPackers.SingleItemIngredient( "sibt-item-tool-iron-saw" , 1 )
local toolBoltDriverIn = SIPackers.SingleItemIngredient( "sibt-item-tool-iron-bolt-driver" , 1 )

local moldWheelOut = SIPackers.SingleItemProduct( "sibt-item-mold-wheel" , 0.99 , 1 , 1 )
local moldPipeOut = SIPackers.SingleItemProduct( "sibt-item-mold-pipe" , 0.99 , 1 , 1 )
local toolHammerOut = SIPackers.SingleItemProduct( "sibt-item-tool-iron-hammer" , 0.99 , 1 , 1 )
local toolSawOut = SIPackers.SingleItemProduct( "sibt-item-tool-iron-saw" , 0.99 , 1 , 1 )
local toolBoltDriverOut = SIPackers.SingleItemProduct( "sibt-item-tool-iron-bolt-driver" , 0.99 , 1 , 1 )

for i , v in pairs
{
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "iron-gear-wheel" ) ) , moldWheelIn , toolHammerIn ) , moldWheelOut , toolHammerOut ) ,
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "iron-stick" ) ) , toolSawIn ) , toolSawOut ) ,
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "stone-furnace" ) ) , toolHammerIn , toolSawIn ) , toolHammerOut , toolSawOut ) ,
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "wooden-chest" ) ) , toolHammerIn , toolSawIn ) , toolHammerOut , toolSawOut ) ,
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "pipe" ) ) , moldPipeIn , toolHammerIn ) , moldPipeOut , toolHammerOut ) ,
	SIPackers.AddProducts( SIPackers.AddIngredients( table.deepcopy( SIGen.GetData( SITypes.recipe , "copper-cable" ) ) , toolHammerIn , toolSawIn , toolBoltDriverIn ) , toolHammerOut , toolSawOut , toolBoltDriverOut )
} do
	local item = SIGen.GetData( SITypes.item.item , v.name )
	v.name = "sibt-" .. SIKeyw[SITypes.recipe] .. "-" .. v.name
	v.icon = item.icon
	v.icon_size = item.icon_size
	v.icon_mipmaps = item.icon_mipmaps
	v.category = SIBT.handRub
	v.group = "sibt-group-sibt"
	v.subgroup = "sibt-subgroup-base-recipe"
	v.order = i
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
	SIGen.Extend{ v }
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
	"assembling-machine-3" ,
	"pistol" ,
	"firearm-magazine"
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
		if floorItem.walking_speed_modifier then floorItem.walking_speed_modifier = ( floorItem.walking_speed_modifier - 1 ) * 3 + 2 end
		if floorItem.decorative_removal_probability then floorItem.decorative_removal_probability = floorItem.decorative_removal_probability * 1.5 end
	end
end