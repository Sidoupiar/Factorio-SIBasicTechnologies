-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIBTForceData =
{
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIBTForceData.OnPlayerJoin( event )
	local player = game.players[event.player_index]
	local force = player.force
	force.manual_crafting_speed_modifier = -0.9   -- 采矿速度增加比率 , 默认 0
	force.manual_mining_speed_modifier = -0.9     -- 制作速度增加比率 , 默认 0
	force.character_running_speed_modifier = -0.4 -- 移动速度增加比率 , 默认 0
end

function SIBTForceData.OnResearchTechnologies( event )
	local technology = event.on_research_finished
	for i , effect in pairs( technology.effects ) do
		if effect.type == "nothing" then
			local description = effect.effect_description
			if description == "SIBT.character-crafting-speed" then force.manual_crafting_speed_modifier = force.manual_crafting_speed_modifier + 0.1
			elseif description == "SIBT.character-mining-speed" then force.manual_mining_speed_modifier = force.manual_mining_speed_modifier + 0.1
			elseif description == "SIBT.character-running-speed" then force.character_running_speed_modifier = force.character_running_speed_modifier + 0.08 end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Add( SIEvents.on_player_joined_game , SIBTForceData.OnPlayerJoin )
.Add( SIEvents.on_research_finished , SIBTForceData.OnResearchTechnologies )