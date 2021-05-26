return
{
	base = "BasicTechnologies" ,
	autoLoad = true ,
	autoName = true ,
	
	
	
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
	item = {}
}