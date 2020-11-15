-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

local stonePacks =
{
	"sibt-item-stone-panel"
}

local woodPacks =
{
	"sibt-item-wood-log"
}

local animalPacks =
{
	"sibt-item-egg-nest"
}

local windPacks =
{
	"sibt-item-windmill-wheel"
}

local steamPacks =
{
	"sibt-item-book-pack"
}

local allPacks = {}
for i , v in pairs{ stonePacks , woodPacks , animalPacks , windPacks , steamPacks } do for n , m in pairs( v ) do table.insert( allPacks , m ) end end

-- ------------------------------------------------------------------------------------------------
-- -------- 玩家能力科技 --------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen

-- 背包大小
.NewTechnology( "character-inventory-slot-1" )
.SetLevel( 1 , 40 )
.SetCosts( allPacks , "35+L*5" )
.SetSpeed( 10 )
.AddResults( SIPackers.SingleModifier( SITypes.modifier.characterInventorySlotsBonus , 1 ) )

-- 制作速度
.NewTechnology( "character-crafting-speed-1" )
.SetLevel( 1 , 4 )
.SetCosts( windPacks , "L*20" )
.SetSpeed( 15 )
.AddResults( SIPackers.SingleNothingModifier( "SIBT.character-crafting-speed" ) )

.NewTechnology( "character-crafting-speed-5" )
.SetLevel( 5 , 9 )
.SetCosts( steamPacks , "L*40" )
.SetSpeed( 30 )
.AddResults( SIPackers.SingleNothingModifier( "SIBT.character-crafting-speed" ) )

-- 采矿速度
.NewTechnology( "character-mining-speed-1" )
.SetLevel( 1 , 2 )
.SetCosts( woodPacks , "L*10" )
.SetSpeed( 10 )
.AddResults( SIPackers.SingleNothingModifier( "SIBT.character-mining-speed" ) )

.NewTechnology( "character-mining-speed-3" )
.SetLevel( 3 , 4 )
.SetCosts( animalPacks , "L*20" )
.SetSpeed( 20 )
.AddResults( SIPackers.SingleNothingModifier( "SIBT.character-mining-speed" ) )

.NewTechnology( "character-mining-speed-5" )
.SetLevel( 5 , 6 )
.SetCosts( windPacks , "L*40" )
.SetSpeed( 40 )
.AddResults( SIPackers.SingleNothingModifier( "SIBT.character-mining-speed" ) )

.NewTechnology( "character-mining-speed-7" )
.SetLevel( 7 , 9 )
.SetCosts( steamPacks , "L*80" )
.SetSpeed( 80 )
.AddResults( SIPackers.SingleNothingModifier( "SIBT.character-mining-speed" ) )

-- 移动速度
.NewTechnology( "character-running-speed-1" )
.SetLevel( 1 , 1 )
.SetCosts( windPacks , "L*100" )
.SetSpeed( 30 )
.AddResults( SIPackers.SingleNothingModifier( "SIBT.character-running-speed" ) )

.NewTechnology( "character-running-speed-2" )
.SetLevel( 2 , 5 )
.SetCosts( steamPacks , "L*200" )
.SetSpeed( 60 )
.AddResults( SIPackers.SingleNothingModifier( "SIBT.character-running-speed" ) )










