-- ------------------------------------------------------------------------------------------------
-- ------- 阻止在矿上建造 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local maskTypes =
{
	"boiler" ,
	"generator" ,
	"burner-generator" ,
	"solar-panel" ,
	"reactor" ,
	"accumulator" ,
	"pump" ,
	"offshore-pump" ,
	"furnace" ,
	"assembling-machine" ,
	"lab" ,
	"beacon" ,
	"rocket-silo" ,
	"transport-belt" ,
	"underground-belt" ,
	"loader" ,
	"loader-1x1" ,
	"splitter" ,
	"pipe" ,
	"pipe-to-ground" ,
	"heat-pipe" ,
	"straight-rail" ,
	"curved-rail" ,
	"train-stop" ,
	"rail-signal" ,
	"rail-chain-signal" ,
	"inserter" ,
	"container" ,
	"logistic-container" ,
	"linked-container" ,
	"storage-tank" ,
	"electric-pole" ,
	"power-switch" ,
	"lamp" ,
	"roboport" ,
	"player-port" ,
	"radar" ,
	"wall" ,
	"gate" ,
	"ammo-turret" ,
	"electric-turret" ,
	"artillery-turret" ,
	"arithmetic-combinator" ,
	"decider-combinator" ,
	"constant-combinator" ,
	"programmable-speaker"
}

local blackList =
{
	
}

local resourceLayer = "resource-layer"
local defaultMask = { "item-layer" , "object-layer" , "player-layer" , "water-tile" , resourceLayer }

for i , maskType in pairs( maskTypes ) do
	for name , entity in pairs( SIGen.GetList( maskType ) ) do
		if not table.Has( blackList , name ) then
			if entity.collision_mask then
				if table.Has( entity.collision_mask , resourceLayer ) then table.insert( entity.collision_mask , resourceLayer ) end
			else entity.collision_mask = defaultMask end
		end
	end
end