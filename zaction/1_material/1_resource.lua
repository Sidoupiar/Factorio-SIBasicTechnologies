-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIBTResource =
{
	oreName = SIFinder.Entity( "宁寂矿" , SITypes.entity.resource ) ,
	oreActiveName = SIFinder.Entity( "宁寂矿-活化" , SITypes.entity.resource ) ,
	oreActiveDelay = 120 ,
	oreActiveRadius = 28 ,
	oreActiveDamageType = SIBT.damageType.twist ,
	oreActiveImmuneModuleStatus = SIFinder.Equipment( "抵抗模块-宁寂矿-活化" ) ,
	oreActiveImmuneModuleDamage = SIFinder.Equipment( "抵抗模块-宁寂矿-伤害" ) ,
	oreActiveBuffData =
	{
		id = "状态-宁寂矿-活化" ,
		duration = 2700 ,
		removeOnDeath = true ,
		values =
		{
			[SIPlayerStatus.valueCode.speedCrafting] = { value = -1000000 } ,
			[SIPlayerStatus.valueCode.speedMining]   = { value = -1000000 } ,
			[SIPlayerStatus.valueCode.speedRunning]  = { value = -1000000 }
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

SIUnlocker
.NewItem( "解锁-敲碎清水石" , 1 )
.AddCondition_Craft( SIFinder.Recipe( "工具-锤子" ) )
.AddCondition_Use( SIFinder.Item( "清水石" , SITypes.item.capsule ) , 50 )
.AddResult_AddRecipe( SIFinder.Recipe( "敲碎-清水石" ) )
.AddResult_MessageForce( { "SIBT.new-recipe" } , true )
.Finish()

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
						if name then surface.create_entity{ name = name , position = { x , y } , force = forceNeutral } end
					end
				end
				for x = x-width-12 , x+width+12 , 1 do
					for y = y-height-12 , y+height+12 , 1 do
						if math.random( 360 ) < 2 then
							local name = SIBTResourceData.newRockList[math.random( #SIBTResourceData.newRockList )]
							if name and surface.can_place_entity{ name = name , position = { x , y } , force = forceNeutral } then surface.create_entity{ name = name , position = { x , y } , force = forceNeutral } end
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
				if character.player then
					local buffData = table.deepcopy( SIBTResource.oreActiveBuffData )
					buffData.damages =
					{
						{
							damageType = SIBTResource.oreActiveDamageType ,
							damage = 0.4 ,
							sourceEntity = entity
						}
					}
					SIPlayerStatus.AddBuff( character.player.index , buffData )
				end
				character.damage( 5.5 , forceNeutral , SIBTResource.oreActiveDamageType , entity )
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