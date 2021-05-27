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
	recipeType =
	{
		["分离机"] = "sibt-分离机"
	}
}

local recipeTypes = {}
for key , value in pairs( data.recipeType ) do table.insert( recipeTypes , value ) end

data.categories[SITypes.category.recipe] = recipeTypes

-- 补充部分数据
data.recipeType.advanced = "advanced-crafting"

return data