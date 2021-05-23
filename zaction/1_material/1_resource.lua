-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIBTResource =
{
	oreName = "sibt-resource-宁寂矿" ,
	oreActiveName = "sibt-resource-宁寂矿-活化" ,
	oreActiveDelay = 120 ,
	oreActiveRadius = 25 ,
	oreActiveDamageType = "sicfl-twist" ,
	oreActiveBuff =
	{
		id = "sibt-resource-宁寂矿-活化" ,
		name = { "SIBT.buff-name-sibt-resource-宁寂矿-活化" } ,
		description = { "SIBT.buff-description-sibt-resource-宁寂矿-活化" } ,
		delay = 7200 ,
		removeOnDeath = true ,
		value =
		{
			
		}
	}
}

SIGlobal.Create( "SIBTResourceData" , function( data )
	data.newRockList = {}
	data.muteList = {}
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
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------



-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIBTResource.OnChunkGenerated( event )
	local surface = event.surface
	for index , entity in pairs( surface.find_entities_filtered{ area = event.area , type = SITypes.entity.resource } ) do
		if entity and entity.valid then
			-- 如果是宁寂矿则选择特殊个体
			if entity.name == SIBTResource.oreName then
				if math.random( 100 ) < 2 then
					local newEntity = surface.create_entity{ name = SIBTResource.oreActiveName , position = entity.position , force = forceNeutral , amount = entity.amount }
					table.insert( SIBTResourceData.muteList , newEntity )
					entity.destroy()
					entity = newEntity
				end
			end
			-- 矿物覆盖矿山石
			if #SIBTResourceData.newRockList > 0 then
				local x = entity.position.x
				local y = entity.position.y
				local box = entity.prototype.collision_box
				local width = ( math.ceil( box.right_bottom.x-box.left_top.x ) - 1 ) / 2
				local height = ( math.ceil( box.right_bottom.y-box.left_top.y ) - 1 ) / 2
				for x = x-width , x+width , 1 do
					for y = y-height , y+height , 1 do
						local name = SIBTResourceData.newRockList[math.random( #SIBTResourceData.newRockList )]
						if name then surface.create_entity{ name = name , position = { x = x , y = y } , force = forceNeutral } end
					end
				end
				for x = x-width-5 , x+width+5 , 1 do
					for y = y-height-5 , y+height+5 , 1 do
						if math.random( 100 ) < 8 then
							local name = SIBTResourceData.newRockList[math.random( #SIBTResourceData.newRockList )]
							if name then surface.create_entity{ name = name , position = { x = x , y = y } , force = forceNeutral } end
						end
					end
				end
			end
		end
	end
end

function SIBTResource.OnTick( event )
	local currentTick = math.fmod( event.tick , SIBTResource.oreActiveDelay ) + 1
	local maxSize = #SIBTResourceData.muteList
	for index = currentTick , maxSize , SIBTResource.oreActiveDelay do
		local entity = SIBTResourceData.muteList[index]
		if not entity or not entity.valid then
			SIBTResourceData.muteList[index] = nil
			break
		end
		local position = entity.position
		for code , character in pairs( entity.surface.find_entities_filtered{ area = { { position.x-SIBTResource.oreActiveRadius , position.y-SIBTResource.oreActiveRadius } , { position.x+SIBTResource.oreActiveRadius , position.y+SIBTResource.oreActiveRadius } } , type = SITypes.entity.character } ) do
			if character and character.valid then
				character.damage( 25 , forceNeutral , SIBTResource.oreActiveDamageType , entity )
				if character.is_player() and character.player then SIPlayerStatus.AddBuff( character.player.index , SIBTResource.oreActiveBuff ) end
			end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_chunk_generated , SIBTResource.OnChunkGenerated )
.Add( SIEvents.on_tick , SIBTResource.OnTick )