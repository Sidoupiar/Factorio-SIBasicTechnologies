require( "__SICoreFunctionLibrary__/util" )

need( "__SICoreFunctionLibrary__/define/load" )
need( "__SICoreFunctionLibrary__/function/load" )
need( "__SICoreFunctionLibrary__/runtime/globalData" )

load()

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- 初始化
function OnInit()
	
end

script.on_init( OnInit )
script.on_configuration_changed( OnInit )

-- ------------------------------------------------------------------------------------------------
-- ---------- 玩家事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function EventPlayerCreated( event )
	local player = game.players[event.player_index]
	-- 修改玩家能力
	if player.haracter then
		player.character_crafting_speed_modifier = 0.1 -- 制作速度比率 , 默认 1
		player.character_mining_speed_modifier = 0.1   -- 采矿速度比率 , 默认 1
		player.character_running_speed_modifier = 0.5  -- 移动速度比率 , 默认 1
	end
end

script.on_event( SIEvents.on_player_created , EventPlayerCreated )

-- ------------------------------------------------------------------------------------------------
-- ---------- 研究事件 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function EventTechnologyResearched( event )
	local technology = event.on_research_finished
	for i , effect in pairs( technology.effects ) do
		if effect.type == "nothing" then
			local description = effect.effect_description
			if description == "sibt.character-crafting-speed" then
				for n , player in pairs( technology.force.players ) do player.character_crafting_speed_modifier = player.character_crafting_speed_modifier + 0.1 end
			elseif description == "sibt.character-mining-speed" then
				for n , player in pairs( technology.force.players ) do player.character_mining_speed_modifier = player.character_mining_speed_modifier + 0.1 end
			elseif description == "sibt.character-running-speed" then
				for n , player in pairs( technology.force.players ) do player.character_running_speed_modifier = player.character_running_speed_modifier + 0.1 end
			end
		end
	end
end

script.on_event( SIEvents.on_research_finished , EventTechnologyResearched )










