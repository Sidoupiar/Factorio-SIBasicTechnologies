-- ------------------------------------------------------------------------------------------------
-- ------- 阻止在矿上建造 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local maskTypes =
{
	["boiler"] = nil ,
	["generator"] = nil ,
	["burner-generator"] = nil ,
	["solar-panel"] = nil ,
	["reactor"] = nil ,
	["accumulator"] = nil ,
	["pump"] = nil ,
	["offshore-pump"] = nil ,
	["furnace"] = nil ,
	["assembling-machine"] = nil ,
	["lab"] = nil ,
	["beacon"] = nil ,
	["rocket-silo"] = nil ,
	["transport-belt"] = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	["underground-belt"] = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	["linked-belt"] = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	["loader"] = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	["loader-1x1"] = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	["splitter"] = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	["pipe"] = nil ,
	["pipe-to-ground"] = nil ,
	["heat-pipe"] = { "object-layer" , "floor-layer" , "water-tile" } ,
	["straight-rail"] = { "item-layer" , "object-layer" , "rail-layer" , "floor-layer" , "water-tile" } ,
	["curved-rail"] = { "item-layer" , "object-layer" , "rail-layer" , "floor-layer" , "water-tile" } ,
	["train-stop"] = nil ,
	["rail-signal"] = { "floor-layer" , "rail-layer" , "item-layer" } ,
	["rail-chain-signal"] = { "floor-layer" , "rail-layer" , "item-layer" } ,
	["inserter"] = nil ,
	["container"] = nil ,
	["logistic-container"] = nil ,
	["linked-container"] = nil ,
	["storage-tank"] = nil ,
	["electric-pole"] = nil ,
	["power-switch"] = nil ,
	["lamp"] = nil ,
	["roboport"] = nil ,
	["player-port"] = { "object-layer" , "floor-layer" , "water-tile" } ,
	["radar"] = nil ,
	["wall"] = nil ,
	["gate"] = { "item-layer" , "object-layer" , "player-layer" , "water-tile" , "train-layer" } ,
	["ammo-turret"] = nil ,
	["electric-turret"] = nil ,
	["artillery-turret"] = nil ,
	["arithmetic-combinator"] = nil ,
	["decider-combinator"] = nil ,
	["constant-combinator"] = nil ,
	["programmable-speaker"] = nil
}

local blackList =
{
	
}

local resourceLayer = "resource-layer"
local defaultMask = { "item-layer" , "object-layer" , "player-layer" , "water-tile" , resourceLayer }

for maskType , maskList in pairs( maskTypes ) do
	if maskList then table.insert( maskList , resourceLayer ) end
	for name , entity in pairs( SIGen.GetList( maskType ) ) do
		if not table.Has( blackList , name ) then
			if entity.collision_mask then
				if table.Has( entity.collision_mask , resourceLayer ) then table.insert( entity.collision_mask , resourceLayer ) end
			else entity.collision_mask = maskList or defaultMask end
		end
	end
end