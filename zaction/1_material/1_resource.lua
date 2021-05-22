-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIBTResource =
{
	
}

SIGlobal.Create( "SIBTResourceData" , function( data )
	data.newRockList = {}
	local rockList = { "rock-big" , "rock-huge" , "sand-rock-big" }
	for i , v in pairs( rockList ) do
		local rock = game.get_filtered_entity_prototypes{ { filter = "name" , name = v } }[v]
		if rock then table.insert( data.newRockList , "sibt-simple-矿山石"..i ) end
	end
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 触发配方 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------



-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIBTResource.OnChunkGenerated( event )
	local surface = event.surface
	for index , entity in pairs( surface.find_entities_filtered{ area = event.area , type = SITypes.entity.resource } ) do
		if entity and entity.valid then
			local name = SIBTResourceData.newRockList[math.random( #SIBTResourceData.newRockList )]
			if name then surface.create_entity{ name = name , position = entity.position , force = forceNeutral } end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_chunk_generated , SIBTResource.OnChunkGenerated )