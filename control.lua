require( "__SICoreFunctionLibrary__/util" )

needlist( "__SICoreFunctionLibrary__" , "define/load" , "function/load" )
needlist( "__SICoreFunctionLibrary__/runtime/structure" , "sievent_bus" , "siglobal" )

load()

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Init( function()

end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 玩家事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Add( SIEvents.on_player_joined_game , function( event )
	local player = game.players[event.player_index]
	local force = player.force
	force.manual_crafting_speed_modifier = -0.9   -- 采矿速度增加比率 , 默认 0
	force.manual_mining_speed_modifier = -0.9     -- 制作速度增加比率 , 默认 0
	force.character_running_speed_modifier = -0.4 -- 移动速度增加比率 , 默认 0
	-- 修改玩家能力
	--if player.character then
	--	player.character_crafting_speed_modifier = -0.9 -- 制作速度增加比率 , 默认 0
	--	player.character_mining_speed_modifier = -0.9   -- 采矿速度增加比率 , 默认 0
	--	player.character_running_speed_modifier = -0.5  -- 移动速度增加比率 , 默认 0
	--end
end )

-- ------------------------------------------------------------------------------------------------
-- ---------- 研究事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Add( SIEvents.on_research_finished , function( event )
	local technology = event.on_research_finished
	for i , effect in pairs( technology.effects ) do
		if effect.type == "nothing" then
			local description = effect.effect_description
			if description == "SIBT.character-crafting-speed" then force.manual_crafting_speed_modifier = force.manual_crafting_speed_modifier + 0.1
				--for n , player in pairs( technology.force.players ) do player.character_crafting_speed_modifier = player.character_crafting_speed_modifier + 0.1 end
			elseif description == "SIBT.character-mining-speed" then force.manual_mining_speed_modifier = force.manual_mining_speed_modifier + 0.1
				--for n , player in pairs( technology.force.players ) do player.character_mining_speed_modifier = player.character_mining_speed_modifier + 0.1 end
			elseif description == "SIBT.character-running-speed" then force.character_running_speed_modifier = force.character_running_speed_modifier + 0.08
				--for n , player in pairs( technology.force.players ) do player.character_running_speed_modifier = player.character_running_speed_modifier + 0.1 end
			end
		end
	end
end )










