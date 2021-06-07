local data =
{
	base = "BasicTechnologies" ,
	autoLoad = true ,
	autoName = true ,
	categories = {} ,
	
	
	
	group =
	{
		logistics   = { name = "logistics" } ,
		machine     = { name = "production" } ,
		item        = { name = "intermediate-products" } ,
		weapon      = { name = "combat" } ,
		fluid       = { name = "fluids" } ,
		signal      = { name = "signals" } ,
		agriculture = { name = "agriculture" , autoName = true }
	} ,
	damageType =
	{
		physical  = "physical" ,
		impact    = "impact" ,
		poison    = "poison" ,
		explosion = "explosion" ,
		fire      = "fire" ,
		laser     = "laser" ,
		acid      = "acid" ,
		electric  = "electric" ,
		
		blood     = "sicfl-blood" ,
		water     = "sicfl-water" ,
		ice       = "sicfl-ice" ,
		radiation = "sicfl-radiation" ,
		disease   = "sicfl-disease" ,
		energy    = "sicfl-energy" ,
		fear      = "sicfl-fear" ,
		spirit    = "sicfl-spirit" ,
		twist     = "sicfl-twist" ,
		void      = "sicfl-void"
	} ,
	equipmentType = 
	{
		armor = "armor"
	} ,
	fuelType =
	{
		["永燃"] = "sibt-永燃"
	} ,
	recipeType =
	{
		["分离机"] = "sibt-分离机" ,
		["萃取炉"] = "sibt-萃取炉"
	} ,
	machine =
	{
		machine_1 = "assembling-machine-1"
	}
}

for name , category in pairs
{
	fuelType = SITypes.category.fuel ,
	recipeType = SITypes.category.recipe
} do
	local types = {}
	for key , value in pairs( data[name] ) do table.insert( types , value ) end
	data.categories[category] = types
end

-- 补充部分数据
data.fuelType.chemical    = "chemical"            -- 化学燃料
data.recipeType.advanced  = "advanced-crafting"   -- 高级组装
data.recipeType.withFluid = "crafting-with-fluid" -- 带有液体的组装


return data