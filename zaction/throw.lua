-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIBTThrow =
{
	fruit =
	{
		recoveryCount = 2 ,
		damageCount = 2
	}
}

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIBTThrow.ThrowFruit( event )
	if event.effect_id == SIBT.throwFruit then
		local source = event.source_entity
		local target = event.target_entity
		if source and target then
			if math.random( 100 ) < 70 then
				local count = - math.random( 20 , 40 )
				target.damage( count , source.force , "physical" )
				if target.player then target.player.print( { "SIBT.fruit-recovery-"..math.random( SIBTThrow.fruit.recoveryCount ) , -count } , SIColors.printColor.green ) end
			elseif math.random( 100 ) < 50 then
				local count = math.random( 40 , 60 )
				target.damage( count , source.force , "physical" )
				if target.player then target.player.print( { "SIBT.fruit-damage-"..math.random( SIBTThrow.fruit.damageCount ) , count } , SIColors.printColor.green ) end
			end
			if math.random( 100 ) < 50 then
				local inventory = target.get_main_inventory()
				if inventory then
					local item = { name = "sibt-item-tree-fruit-nutlet" , count = 1 }
					if inventory.can_insert( item ) then
						inventory.insert( item )
						if target.player then target.player.print( { "SIBT.fruit-nutlet-insert" } , SIColors.printColor.green ) end
					else
						local surface = game.surfaces[event.surface_index]
						if surface then
							surface.spill_item_stack{ position = event.target_position , items = item , enable_looted = true , force = target.force }
							if target.player then target.player.print( { "SIBT.fruit-nutlet-drop" } , SIColors.printColor.orange ) end
						end
					end
				end
			end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus.Add( SIEvents.on_script_trigger_effect , SIBTThrow.ThrowFruit )