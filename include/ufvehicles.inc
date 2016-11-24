//-------------------------------------------------------------------------------

stock VehicleDriverID(vehicleid) //By Jan "DracoBlue" Schütze
{
  new i;
  for (i=0;i<MAX_PLAYERS;i++)
  {
   if ((IsPlayerConnected(i))&&(GetPlayerVehicleID(i)==vehicleid)&&(GetPlayerState(i)==2))  return i;
  }
  return -1;
}
native VehicleDriverID(vehicleid);

//-------------------------------------------------------------------------------

stock GetVehicles() //By Sacky
{
new Float:x;
new Float:y;
new Float:z;
new maxv;
 for(new i=0;i<MAX_VEHICLES;i++)
 {
  GetVehiclePos(i,x,y,z);
  if(z != 0 && x!= 0 && y != 0)
  {
   maxv++;
  }
 }
 return maxv;
}
native GetVehicles();

//-------------------------------------------------------------------------------

stock VehicleDriverName(vehicleid) //By Sacky
{
new playername[MAX_PLAYER_NAME];
 for(new i=0;i<MAX_PLAYERS;i++)
 {
  if(IsPlayerConnected(i))
  {
   if(IsPlayerInVehicle(i,vehicleid))
   {
     GetPlayerName(i,playername,sizeof(playername));
    return playername;
   }
  }
 }
 return playername;
}
native VehicleDriverName(vehicleid);

//-------------------------------------------------------------------------------

stock IsPlayerPassenger(playerid) //By Sacky (Edited by Smugller)
{
 if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
 {
  return 1;
 }
 return 0;
}
native IsPlayerPassenger(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerDriver(playerid) //By Sacky
{
 if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
 {
  return 1;
 }
 return 0;
}
native IsPlayerDriver(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerOnFoot(playerid) //By Sacky
{
 if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
 {
  return 1;
 }
 return 0;
}
native IsPlayerOnFoot(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerWasted(playerid) //By Smugller
{
 if(GetPlayerState(playerid) == PLAYER_STATE_WASTED)
 {
  return 1;
 }
 return 0;
}
native IsPlayerWasted(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerSpawned(playerid) //By Smugller
{
 if(GetPlayerState(playerid) == PLAYER_STATE_SPAWNED)
 {
  return 1;
 }
 return 0;
}
native IsPlayerSpawned(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerSpectating(playerid) //By Smugller
{
 if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
 {
  return 1;
 }
 return 0;
}
native IsPlayerSpectating(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerOnBike(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 448:return 1;
   case 461:return 1;
   case 462:return 1;
   case 463:return 1;
   case 468:return 1;
   case 521:return 1;
   case 522:return 1;
   case 523:return 1;
   case 581:return 1;
   case 586:return 1;
  }
 }
 return 0;
}
native IsPlayerOnBike(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerOnBicycle(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 481:return 1;
   case 509:return 1;
   case 510:return 1;
  }
 }
 return 0;
}
native IsPlayerOnBicycle(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerInBoat(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 430:return 1;
   case 446:return 1;
   case 452:return 1;
   case 453:return 1;
   case 454:return 1;
   case 472:return 1;
   case 473:return 1;
   case 484:return 1;
   case 493:return 1;
   case 595:return 1;
  }
 }
 return 0;
}
native IsPlayerInBoat(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerInHelicopter(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 417:return 1;
   case 425:return 1;
   case 447:return 1;
   case 465:return 1;
   case 469:return 1;
   case 487:return 1;
   case 488:return 1;
   case 497:return 1;
   case 501:return 1;
   case 548:return 1;
   case 563:return 1;
  }
 }
 return 0;
}
native IsPlayerInHelicopter(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerInMonsterTruck(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 406:return 1;
   case 444:return 1;
   case 556:return 1;
   case 557:return 1;
   case 573:return 1;
  }
 }
 return 0;
}
native IsPlayerInMonsterTruck(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerInPlane(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 460:return 1;
   case 464:return 1;
   case 476:return 1;
   case 511:return 1;
   case 512:return 1;
   case 513:return 1;
   case 519:return 1;
   case 520:return 1;
   case 539:return 1;
   case 553:return 1;
   case 577:return 1;
   case 592:return 1;
   case 593:return 1;
  }
 }
 return 0;
}
native IsPlayerInPlane(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerInQuad(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 471:return 1;
  }
 }
 return 0;
}
native IsPlayerInQuad(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerInCar(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 448:return 0;
   case 461:return 0;
   case 462:return 0;
   case 463:return 0;
   case 468:return 0;
   case 521:return 0;
   case 522:return 0;
   case 523:return 0;
   case 581:return 0;
   case 586:return 0;
   case 481:return 0;
   case 509:return 0;
   case 510:return 0;
   case 430:return 0;
   case 446:return 0;
   case 452:return 0;
   case 453:return 0;
   case 454:return 0;
   case 472:return 0;
   case 473:return 0;
   case 484:return 0;
   case 493:return 0;
   case 595:return 0;
   case 417:return 0;
   case 425:return 0;
   case 447:return 0;
   case 465:return 0;
   case 469:return 0;
   case 487:return 0;
   case 488:return 0;
   case 497:return 0;
   case 501:return 0;
   case 548:return 0;
   case 563:return 0;
   case 406:return 0;
   case 444:return 0;
   case 556:return 0;
   case 557:return 0;
   case 573:return 0;
   case 460:return 0;
   case 464:return 0;
   case 476:return 0;
   case 511:return 0;
   case 512:return 0;
   case 513:return 0;
   case 519:return 0;
   case 520:return 0;
   case 539:return 0;
   case 553:return 0;
   case 577:return 0;
   case 592:return 0;
   case 593:return 0;
   case 471:return 0;
  }
  return 1;
 }
 return 0;
}
native IsPlayerInCar(playerid);

//-------------------------------------------------------------------------------

stock IsPlayerInRCCam(playerid) //by [EGG]Marco
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 594:return 1;
  }
 }
 return 0;
}
native IsPlayerInRCCam(playerid);

//-------------------------------------------------------------------------------

new vehicleNames[212][] = {
   "Landstalker",
   "Bravura",
   "Buffalo",
   "Linerunner",
   "Pereniel",
   "Sentinel",
   "Dumper",
   "Firetruck",
   "Trashmaster",
   "Stretch",
   "Manana",
   "Infernus",
   "Voodoo",
   "Pony",
   "Mule",
   "Cheetah",
   "Ambulance",
   "Leviathan",
   "Moonbeam",
   "Esperanto",
   "Taxi",
   "Washington",
   "Bobcat",
   "Mr Whoopee",
   "BF Injection",
   "Hunter",
   "Premier",
   "Enforcer",
   "Securicar",
   "Banshee",
   "Predator",
   "Bus",
   "Rhino",
   "Barracks",
   "Hotknife",
   "Trailer", //artict1
   "Previon",
   "Coach",
   "Cabbie",
   "Stallion",
   "Rumpo",
   "RC Bandit",
   "Romero",
   "Packer",
   "Monster",
   "Admiral",
   "Squalo",
   "Seasparrow",
   "Pizzaboy",
   "Tram",
   "Trailer", //artict2
   "Turismo",
   "Speeder",
   "Reefer",
   "Tropic",
   "Flatbed",
   "Yankee",
   "Caddy",
   "Solair",
   "Berkley's RC Van",
   "Skimmer",
   "PCJ-600",
   "Faggio",
   "Freeway",
   "RC Baron",
   "RC Raider",
   "Glendale",
   "Oceanic",
   "Sanchez",
   "Sparrow",
   "Patriot",
   "Quad",
   "Coastguard",
   "Dinghy",
   "Hermes",
   "Sabre",
   "Rustler",
   "ZR3 50",
   "Walton",
   "Regina",
   "Comet",
   "BMX",
   "Burrito",
   "Camper",
   "Marquis",
   "Baggage",
   "Dozer",
   "Maverick",
   "News Chopper",
   "Rancher",
   "FBI Rancher",
   "Virgo",
   "Greenwood",
   "Jetmax",
   "Hotring",
   "Sandking",
   "Blista Compact",
   "Police Maverick",
   "Boxville",
   "Benson",
   "Mesa",
   "RC Goblin",
   "Hotring Racer", //hotrina
   "Hotring Racer", //hotrinb
   "Bloodring Banger",
   "Rancher",
   "Super GT",
   "Elegant",
   "Journey",
   "Bike",
   "Mountain Bike",
   "Beagle",
   "Cropdust",
   "Stunt",
   "Tanker", //petro
   "RoadTrain",
   "Nebula",
   "Majestic",
   "Buccaneer",
   "Shamal",
   "Hydra",
   "FCR-900",
   "NRG-500",
   "HPV1000",
   "Cement Truck",
   "Tow Truck",
   "Fortune",
   "Cadrona",
   "FBI Truck",
   "Willard",
   "Forklift",
   "Tractor",
   "Combine",
   "Feltzer",
   "Remington",
   "Slamvan",
   "Blade",
   "Freight",
   "Streak",
   "Vortex",
   "Vincent",
   "Bullet",
   "Clover",
   "Sadler",
   "Firetruck", //firela
   "Hustler",
   "Intruder",
   "Primo",
   "Cargobob",
   "Tampa",
   "Sunrise",
   "Merit",
   "Utility",
   "Nevada",
   "Yosemite",
   "Windsor",
   "Monster", //monstera
   "Monster", //monsterb
   "Uranus",
   "Jester",
   "Sultan",
   "Stratum",
   "Elegy",
   "Raindance",
   "RC Tiger",
   "Flash",
   "Tahoma",
   "Savanna",
   "Bandito",
   "Freight", //freiflat
   "Trailer", //streakc
   "Kart",
   "Mower",
   "Duneride",
   "Sweeper",
   "Broadway",
   "Tornado",
   "AT-400",
   "DFT-30",
   "Huntley",
   "Stafford",
   "BF-400",
   "Newsvan",
   "Tug",
   "Trailer", //petrotr
   "Emperor",
   "Wayfarer",
   "Euros",
   "Hotdog",
   "Club",
   "Trailer", //freibox
   "Trailer", //artict3
   "Andromada",
   "Dodo",
   "RC Cam",
   "Launch",
   "Police Car (LSPD)",
   "Police Car (SFPD)",
   "Police Car (LVPD)",
   "Police Ranger",
   "Picador",
   "S.W.A.T. Van",
   "Alpha",
   "Phoenix",
   "Glendale",
   "Sadler",
   "Luggage Trailer", //bagboxa
   "Luggage Trailer", //bagboxb
   "Stair Trailer", //tugstair
   "Boxville",
   "Farm Plow", //farmtr1
   "Utility Trailer" //utiltr1
};

//-------------------------------------------------------------------------------

stock GetVehicleName(vehicleid) //By Sacky (Edited by Smugller)
{
new tmp = GetVehicleModel(vehicleid) - 400;
return vehicleNames[tmp];
}
native GetVehicleName(vehicleid);

//-------------------------------------------------------------------------------

stock IsVehicleInUse(vehicleid) //By Sacky
{
new vdid = VehicleDriverID(vehicleid);
 if(vdid != -1)
 {
  return 1;
 }
 return 0;
}
native IsVehicleInUse(vehicleid);

//-------------------------------------------------------------------------------

stock AddStaticVehicle2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2) //By Boss
{
 if(VC<MAX_VEHICLES)
 {
  VC++;
  VehicleModels[VC] = modelid;
  VehicleAngles[VC] = floatround(z_angle);
  AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2);
 }
}
native AddStaticVehicle2(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2);

//-------------------------------------------------------------------------------

stock AddStaticVehicleLine(Modelid, Float:Start[2], Float:Rate[2], Float:Z, Float:Z_Angle, MaxAmount) //Toxic
{
	new Float:x = Start[0], Float:y = Start[1];
	new Float:xRate = Start[0] - Rate[0];
	new Float:yRate = Start[1] - Rate[1];
	for(new Amount = 0;Amount < MaxAmount;Amount++)
 {
	 AddStaticVehicle2(Modelid, x, y, Z, Z_Angle, -1, -1);
	 x -= xRate;
	 y -= yRate;
 }
	return 1;
}
native AddStaticVehicleLine(Modelid, Float:Start[2], Float:Rate[2], Float:Z, Float:Z_Angle, MaxAmount);

//-------------------------------------------------------------------------------

stock GetVehicleType(vid) //By YellowBlood
{
	new type;
// ================== CARS =======
	switch(GetVehicleModel(vehicleid))
 {
	case
	416,   //ambulan  -  car
	445,   //admiral  -  car
	602,   //alpha  -  car
	485,   //baggage  -  car
	568,   //bandito  -  car
	429,   //banshee  -  car
	499,   //benson  -  car
	424,   //bfinject,   //car
	536,   //blade  -  car
	496,   //blistac  -  car
	504,   //bloodra  -  car
	422,   //bobcat  -  car
	609,   //boxburg  -  car
	498,   //boxville,   //car
	401,   //bravura  -  car
	575,   //broadway,   //car
	518,   //buccanee,   //car
	402,   //buffalo  -  car
	541,   //bullet  -  car
	482,   //burrito  -  car
	431,   //bus  -  car
	438,   //cabbie  -  car
	457,   //caddy  -  car
	527,   //cadrona  -  car
	483,   //camper  -  car
	524,   //cement  -  car
	415,   //cheetah  -  car
	542,   //clover  -  car
	589,   //club  -  car
	480,   //comet  -  car
	596,   //copcarla,   //car
	599,   //copcarru,   //car
	597,   //copcarsf,   //car
	598,   //copcarvg,   //car
	578,   //dft30  -  car
	486,   //dozer  -  car
	507,   //elegant  -  car
	562,   //elegy  -  car
	585,   //emperor  -  car
	427,   //enforcer,   //car
	419,   //esperant,   //car
	587,   //euros  -  car
	490,   //fbiranch,   //car
	528,   //fbitruck,   //car
	533,   //feltzer  -  car
	544,   //firela  -  car
	407,   //firetruk,   //car
	565,   //flash  -  car
	455,   //flatbed  -  car
	530,   //forklift,   //car
	526,   //fortune  -  car
	466,   //glendale,   //car
	604,   //glenshit,   //car
	492,   //greenwoo,   //car
	474,   //hermes  -  car
	434,   //hotknife,   //car
	502,   //hotrina  -  car
	503,   //hotrinb  -  car
	494,   //hotring  -  car
	579,   //huntley  -  car
	545,   //hustler  -  car
	411,   //infernus,   //car
	546,   //intruder,   //car
	559,   //jester  -  car
	508,   //journey  -  car
	571,   //kart  -  car
	400,   //landstal,   //car
	403,   //linerun  -  car
	517,   //majestic,   //car
	410,   //manana  -  car
	551,   //merit  -  car
	500,   //mesa  -  car
	418,   //moonbeam,   //car
	572,   //mower  -  car
	423,   //mrwhoop  -  car
	516,   //nebula  -  car
	582,   //newsvan  -  car
	467,   //oceanic  -  car
	404,   //peren  -  car
	514,   //petro  -  car
	603,   //phoenix  -  car
	600,   //picador  -  car
	413,   //pony  -  car
	426,   //premier  -  car
	436,   //previon  -  car
	547,   //primo  -  car
	489,   //rancher  -  car
	441,   //rcbandit,   //car
	594,   //rccam  -  car
	564,   //rctiger  -  car
	515,   //rdtrain  -  car
	479,   //regina  -  car
	534,   //remingtn,   //car
	505,   //rnchlure,   //car
	442,   //romero  -  car
	440,   //rumpo  -  car
	475,   //sabre  -  car
	543,   //sadler  -  car
	605,   //sadlshit,   //car
	495,   //sandking,   //car
	567,   //savanna  -  car
	428,   //securica,   //car
	405,   //sentinel,   //car
	535,   //slamvan  -  car
	458,   //solair  -  car
	580,   //stafford,   //car
	439,   //stallion,   //car
	561,   //stratum  -  car
	409,   //stretch  -  car
	560,   //sultan  -  car
	550,   //sunrise  -  car
	506,   //supergt  -  car
	601,   //swatvan  -  car
	574,   //sweeper  -  car
	566,   //tahoma  -  car
	549,   //tampa  -  car
	420,   //taxi  -  car
	459,   //topfun  -  car
	576,   //tornado  -  car
	583,   //tug  -  car
	451,   //turismo  -  car
	558,   //uranus  -  car
	552,   //utility  -  car
	540,   //vincent  -  car
	491,   //virgo  -  car
	412,   //voodoo  -  car
	478,   //walton  -  car
	421,   //washing  -  car
	529,   //willard  -  car
	555,   //windsor  -  car
	456,   //yankee  -  car
	554,   //yosemite,   //car
	477   //zr3	50  -  car
	: type = VTYPE_CAR;

// ================== BIKES =======
	case
	581,   //bf400  -  bike
	523,   //copbike  -  bike
	462,   //faggio  -  bike
	521,   //fcr900  -  bike
	463,   //freeway  -  bike
	522,   //nrg500  -  bike
	461,   //pcj600  -  bike
	448,   //pizzaboy,   //bike
	468,   //sanchez  -  bike
	586,   //wayfarer,   //bike
	509,   //bike  -  bmx
	481,   //bmx  -  bmx
	510,   //mtbike  -  bmx
	471   //quad  -  quad
	: type = VTYPE_BIKE;

// ================== SEA =======
	case
	472,   //coastg  -  boat
	473,   //dinghy  -  boat
	493,   //jetmax  -  boat
	595,   //launch  -  boat
	484,   //marquis  -  boat
	430,   //predator,   //boat
	453,   //reefer  -  boat
	452,   //speeder  -  boat
	446,   //squalo  -  boat
	454   //tropic  -  boat
	: type = VTYPE_SEA;

// ================== AIR =======
	case
	548,   //cargobob,   //heli
	425,   //hunter  -  heli
	417,   //leviathn,   //heli
	487,   //maverick,   //heli
	497,   //polmav  -  heli
	563,   //raindanc,   //heli
	501,   //rcgoblin,   //heli
	465,   //rcraider,   //heli
	447,   //seaspar  -  heli
	469,   //sparrow  -  heli
	488,   //vcnmav  -  heli
	592,   //androm  -  plane
	577,   //at	400  -  plane
	511,   //beagle  -  plane
	512,   //cropdust,   //plane
	593,   //dodo  -  plane
	520,   //hydra  -  plane
	553,   //nevada  -  plane
	464,   //rcbaron  -  plane
	476,   //rustler  -  plane
	519,   //shamal  -  plane
	460,   //skimmer  -  plane
	513,   //stunt  -  plane
	539   //vortex  -  plane
	: type = VTYPE_AIR;

// ================== HEAVY =======
	case
	588,   //hotdog  -  car
	437,   //coach  -  car
	532,   //combine  -  car
	433,   //barracks,   //car
	414,   //mule  -  car
	443,   //packer  -  car
	470,   //patriot  -  car
	432,   //rhino  -  car
	525,   //towtruck,   //car
	531,   //tractor  -  car
	408,   //trash  -  car
	406,   //dumper  -  mtruck
	573,   //duneride,   //mtruck
	444,   //monster  -  mtruck
	556,   //monstera,   //mtruck
	557,   //monsterb,   //mtruck
	435,   //artict1  -  trailer
	450,   //artict2  -  trailer
	591,   //artict3  -  trailer
	606,   //bagboxa  -  trailer
	607,   //bagboxb  -  trailer
	610,   //farmtr1  -  trailer
	584,   //petrotr  -  trailer
	608,   //tugstair,   //trailer
	611,   //utiltr1  -  trailer
	590,   //freibox  -  train
	569,   //freiflat,   //train
	537,   //freight  -  train
	538,   //streak  -  train
	570,   //streakc  -  train
	449   //tram  -  train
	: type = VTYPE_HEAVY;
	}
	return type;
}
native GetVehicleType(vid);

//-------------------------------------------------------------------------------

stock AddVehicleHealth(vehicleid, Float:health) //by Smugller
{
	new Float:vHealth;
	GetVehicleHealth(vehicleid, vHealth);
	new Float:total=vHealth+health;
	if(total > 1000) SetVehicleHealth(vehicleid, 1000.0); else  SetVehicleHealth(vehicleid, vHealth+health);
	return 1;
}
native AddVehicleHealth(vehicleid, Float:health);

//-------------------------------------------------------------------------------

stock AddVehicleComponents(vehicleid, ...) //by 50p
{
 new args = numargs();
 for(new i=1; i<args; i++)
 {
  AddVehicleComponent(vehicleid, getarg(i));
 }
}
native AddVehicleComponents(vehicleid, ...);

//-------------------------------------------------------------------------------

stock AddRandomVehicle(Float:x,Float:y,Float:z,Float:angle) //by Pixels^
{
      new j = random(611);
      if(j <= 399) {
          new r = j - 400;
          new v = r + j + random(100);
          AddStaticVehicle(v,x,y,z,angle,random(30)+1,random(30)+1);
          return 1;
      }
      if(j >= 612) {
          new r  = j - 612;
          new v  = j - r - random(100);
          AddStaticVehicle(v,x,y,z,angle,random(30)+1,random(30)+1);
          return 1;
      }
      else AddStaticVehicle(j,x,y,z,random(30)+1,random(30)+1);
}
native AddRandomVehicle(Float:x,Float:y,Float:z,Float:angle);

//-------------------------------------------------------------------------------

stock AddVehicle(modelid,Float:x,Float:y,Float:z,Float:angle,color1,color2) //by Y_Less
{
    static
        sModels[(((212) + (cellbits) - 1) / (cellbits))]; // Static array 7 cells big
    if (modelid > 611 || modelid < 400) return 0; // Is modelid valid
    new
        pos = modelid - 400, // Array position
        slot = pos / cellbits, // Array cell
        val = 1 << (pos % cellbits); // Bit in cell
    if (sModels[slot] & val) return AddStaticVehicle(modelid, x, y, z, angle, color1, color2); // Model is used, add vehicle
    new
        count;
    for (new m = 0; m < 212; m++) if (sModels[m / cellbits] & (1 << (m % cellbits))) count++; // Count models used
    if(count >= 49) return 0; // If too many return
    sModels[slot] |= val; // Set model as used
    return AddStaticVehicle(modelid,x,y,z,angle,color1,color2); // Add the vehicle
}
native AddVehicle(modelid,Float:x,Float:y,Float:z,Float:angle,color1,color2);

//-------------------------------------------------------------------------------

stock AddCircleOfStaticVehicles(vehicleid, Float:X, Float:Y, Float:Z, Float:radius, num_of_vehicles, color1, color2) //by 50p
{
new i,
Float: radAngle,
Float: xCoord,
Float: yCoord;

for(i=0; i<num_of_vehicles; i++) {
radAngle = floatdiv(floatmul(i,PI), floatdiv(num_of_vehicles, 2));
xCoord = floatmul(floatcos(radAngle), radius);
yCoord = floatmul(floatsin(radAngle), radius);
AddStaticVehicle( vehicleid,
floatadd(xCoord, (X)),
floatadd(yCoord, (Y)),
Z,
floatadd(floatmul(radAngle, 60), 90),
color1,
color2);
}

return 1;
}
native AddCircleOfStaticVehicles(vehicleid, Float:X, Float:Y, Float:Z, Float:radius, num_of_vehicles, color1, color2);

//-------------------------------------------------------------------------------

stock AddStaticVehicle2Ex(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, interiorid) //by De[M]oN
{
	LinkVehicleToInterior(AddStaticVehicle(modelid,spawn_x,spawn_y,spawn_z,z_angle, color1, color2),interiorid):
}
native AddStaticVehicle2Ex(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, interiorid);

//-------------------------------------------------------------------------------

stock IsVehicleHavePassegner(vehicleid) // By Luby
{  
new temp;
	for(new i=0;i<200;i++)
 {
	 if(IsPlayerConnected(i) && IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i)==PLAYER_STATE_PASSENGER)
  {
  	temp++;
  }
	}
	if(temp > 0){ return true; } else return false;
}	
native IsVehicleHavePassegner(vehicleid);

//-------------------------------------------------------------------------------

stock	PlacePlayerInParamsVehicle(playerid) // By Luby
{  
 new distance = 90000;
 new distance2 = 0;
 for(new i=0;i<700;i++)
 {
  new Float:x, Float:y, Float:z;
  GetVehiclePos(i, x, y, z);
  new Float:x2, Float:y2, Float:z2;
  GetPlayerPos(playerid, x2, y2, z2);
  if(x!=0.0 && y!=0.0 && z!=0.0)
  {
   new Float:tmp2dis;
   tmp2dis = floatsqroot(floatpower(floatabs(floatsub(x,x2)),2)+floatpower(floatabs(floatsub(y,y2)),2)+floatpower(floatabs(floatsub(z,z2)),2));
   if(floatround(tmp2dis) < distance && !IsVehicleInUse(i))
   {
    distance2=i;
    distance=floatround(tmp2dis);
   }
  }
 }
 PutPlayerInVehicle(playerid, distance2,0);
}
native PlacePlayerInParamsVehicle(playerid);

//-------------------------------------------------------------------------------

stock AddCircleOfVehiclesEx(model, Float:X, Float:Y, Float:Z, Float:A, Float:dis, ilosc, c1, c2) // By Luby
{   
new Float:kat = floatdiv(360.0, ilosc);
new Float:x = X, Float:y = Y;
new g=1;while(g<ilosc+1){g++;
x = X;
y = Y;
x += (dis * floatsin(floatmul(kat,float(g)), degrees));
y += (dis * floatcos(floatmul(kat,float(g)), degrees));
AddStaticVehicle2(1, model, x, y, Z,floatadd(floatmul(kat,float(g)),A), c1, c2);
}
}
native AddCircleOfVehiclesEx(model, Float:X, Float:Y, Float:Z, Float:A, Float:dis, ilosc, c1, c2);

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
