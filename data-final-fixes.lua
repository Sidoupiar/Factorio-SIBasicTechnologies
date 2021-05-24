-- ------------------------------------------------------------------------------------------------
-- ----- 修改部分实体的属性 -----------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 修改树木血量
for name , prototype in pairs( SIGen.GetList( SITypes.entity.tree ) ) do
	if prototype.max_health then prototype.max_health = prototype.max_health * 30 end
end

-- ------------------------------------------------------------------------------------------------
-- ------- 阻止在矿上建造 -------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local maskTypes =
{
	[SITypes.entity.boiler]          = {} ,
	[SITypes.entity.generator]       = {} ,
	[SITypes.entity.burnerGenerator] = {} ,
	[SITypes.entity.solar]           = {} ,
	[SITypes.entity.reactor]         = {} ,
	[SITypes.entity.acc]             = {} ,
	[SITypes.entity.pump]            = {} ,
	[SITypes.entity.pumpOffshore]    = {} ,
	[SITypes.entity.furnace]         = {} ,
	[SITypes.entity.machine]         = {} ,
	[SITypes.entity.lab]             = {} ,
	[SITypes.entity.beacon]          = {} ,
	[SITypes.entity.rocket]          = {} ,
	[SITypes.entity.belt]            = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	[SITypes.entity.beltGround]      = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	[SITypes.entity.beltLinked]      = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	[SITypes.entity.beltLoader]      = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	[SITypes.entity.beltLoaderSmall] = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	[SITypes.entity.beltSplitter]    = { "object-layer" , "item-layer" , "transport-belt-layer" , "water-tile" } ,
	[SITypes.entity.pipe]            = {} ,
	[SITypes.entity.pipeGround]      = {} ,
	[SITypes.entity.pipeHeat]        = { "object-layer" , "floor-layer" , "water-tile" } ,
	[SITypes.entity.railStraight]    = { "item-layer" , "object-layer" , "rail-layer" , "floor-layer" , "water-tile" } ,
	[SITypes.entity.railCurved]      = { "item-layer" , "object-layer" , "rail-layer" , "floor-layer" , "water-tile" } ,
	[SITypes.entity.railStop]        = {} ,
	[SITypes.entity.railSign]        = { "floor-layer" , "rail-layer" , "item-layer" } ,
	[SITypes.entity.railChain]       = { "floor-layer" , "rail-layer" , "item-layer" } ,
	[SITypes.entity.inserter]        = {} ,
	[SITypes.entity.container]       = {} ,
	[SITypes.entity.containerLogic]  = {} ,
	[SITypes.entity.containerLinked] = {} ,
	[SITypes.entity.containerFluid]  = {} ,
	[SITypes.entity.pole]            = {} ,
	[SITypes.entity.powerSwitch]     = {} ,
	[SITypes.entity.lamp]            = {} ,
	[SITypes.entity.roboport]        = {} ,
	[SITypes.entity.playerPort]      = { "object-layer" , "floor-layer" , "water-tile" } ,
	[SITypes.entity.radar]           = {} ,
	[SITypes.entity.wall]            = {} ,
	[SITypes.entity.gate]            = { "item-layer" , "object-layer" , "player-layer" , "water-tile" , "train-layer" } ,
	[SITypes.entity.turretAmmo]      = {} ,
	[SITypes.entity.turretElectric]  = {} ,
	[SITypes.entity.turretArtillery] = {} ,
	[SITypes.entity.combAri]         = {} ,
	[SITypes.entity.combDec]         = {} ,
	[SITypes.entity.combCon]         = {} ,
	[SITypes.entity.speaker]         = {}
}

local blackList =
{
	
}

local resourceLayer = "resource-layer"
local defaultMask = { "item-layer" , "object-layer" , "player-layer" , "water-tile" , resourceLayer }

for maskType , maskList in pairs( maskTypes ) do
	if table.Size( maskList ) > 0 then table.insert( maskList , resourceLayer )
	else maskList = defaultMask end
	for name , entity in pairs( SIGen.GetList( maskType ) ) do
		if not table.Has( blackList , name ) then
			if entity.collision_mask then
				if not table.Has( entity.collision_mask , resourceLayer ) then table.insert( entity.collision_mask , resourceLayer ) end
			else entity.collision_mask = maskList end
		end
	end
end