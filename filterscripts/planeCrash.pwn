#define FILTERSCRIPT

//----------------------------------------------<< Source >>-------------------------------------------------//
//-----------------------------------[ Filterscript: planeCrash.pwn ]--------------------------------------//
//Opis:
/*
	Epizodyczne obiekty - katastrofa samolotu.
*/
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//

//


#include <a_samp>
#include <streamer>	

#define MAX_OBJECTS_FS 100
#define MAX_ACTORS_FS 3

new objects[MAX_OBJECTS_FS];
new objectsCount;
new actors[MAX_ACTORS_FS];
new actorsCount;
new planeCrashFS;

CreateDynamicObjectFS(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, areaid = -1, priority = 0)
{
	objects[objectsCount] = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
	return objects[objectsCount++];
}

CreateActorFS(modelid, Float:X, Float:Y, Float:Z, Float:Rotation)
{
	actors[actorsCount] = CreateActor(modelid, X, Y, Z, Rotation);
	return actors[actorsCount++];
}

public OnFilterScriptInit()
{
	print("\n--Katastrofa samolotu zaladowana\n");
	
	planeCrashFS = CreateDynamicObjectFS(4514, 1193.907470, -2439.876220, 10.771887, 0.000000, 0.000000, -117.899932, 0, 0, -1, 450.00, 450.00); 
	SetDynamicObjectMaterial(planeCrashFS, 1, 981, "helixbarrier", "bridgehzrd_kb_128", 0x00000000);
	planeCrashFS = CreateDynamicObjectFS(1683, 1141.556518, -2369.374755, 4.878787, -8.399987, -23.200000, -22.799970, 0, 0, -1, 450.00, 450.00); 
	SetDynamicObjectMaterial(planeCrashFS, 1, -1, "none", "none", 0x00FFFFFF);
	planeCrashFS = CreateDynamicObjectFS(1562, 1111.910766, -2345.220214, 11.786445, -20.299972, -4.099998, 51.300006, 0, 0, -1, 450.00, 450.00); 
	SetDynamicObjectMaterial(planeCrashFS, 0, -1, "none", "none", 0xFF666666);
	planeCrashFS = CreateDynamicObjectFS(1562, 1110.573364, -2354.593017, 11.589861, -20.299972, -13.499986, 51.300006, 0, 0, -1, 450.00, 450.00); 
	SetDynamicObjectMaterial(planeCrashFS, 0, -1, "none", "none", 0xFF666666);
	planeCrashFS = CreateDynamicObjectFS(1562, 1121.455688, -2353.249023, 11.527084, -72.800094, -13.499986, 28.000009, 0, 0, -1, 450.00, 450.00); 
	SetDynamicObjectMaterial(planeCrashFS, 0, -1, "none", "none", 0xFF666666);
	planeCrashFS = CreateDynamicObjectFS(4514, 1056.814697, -2283.122802, 13.831888, 0.000000, 0.000000, 26.299999, 0, 0, -1, 450.00, 450.00); 
	SetDynamicObjectMaterial(planeCrashFS, 1, 981, "helixbarrier", "bridgehzrd_kb_128", 0x00000000);
	planeCrashFS = CreateDynamicObjectFS(4514, 1043.610107, -2289.650146, 13.831888, 0.000000, 0.000000, 26.299999, 0, 0, -1, 450.00, 450.00); 
	SetDynamicObjectMaterial(planeCrashFS, 1, 981, "helixbarrier", "bridgehzrd_kb_128", 0x00000000);
	planeCrashFS = CreateDynamicObjectFS(4514, 1200.804809, -2426.848632, 10.771889, 0.000000, 0.000000, -117.899932, 0, 0, -1, 450.00, 450.00); 
	SetDynamicObjectMaterial(planeCrashFS, 1, 981, "helixbarrier", "bridgehzrd_kb_128", 0x00000000);
	planeCrashFS = CreateDynamicObjectFS(1683, 1100.283325, -2331.255615, 11.767996, -30.499992, 49.500007, -23.299978, 0, 0, -1, 450.00, 450.00); 
	SetDynamicObjectMaterial(planeCrashFS, 1, -1, "none", "none", 0x00FFFFFF);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	planeCrashFS = CreateDynamicObjectFS(836, 1103.356689, -2335.888671, 12.601181, 0.000000, 11.099986, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(842, 1094.634887, -2336.027832, 11.443007, 0.399998, 0.999998, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(840, 1116.748413, -2351.117431, 12.719846, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18691, 1096.662963, -2336.448974, 10.291151, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(836, 1151.015014, -2373.976806, 11.653830, 1.099998, 0.000000, -140.299926, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18691, 1101.353515, -2335.676513, 9.683422, 0.000000, -27.299997, 8.099991, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18691, 1106.186035, -2337.172363, 10.477638, 3.799998, 3.999995, -106.000007, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18691, 1116.325195, -2351.314941, 10.164518, 3.799998, 3.999995, -106.000007, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18691, 1149.926391, -2374.881835, 8.527730, 3.799998, 3.999995, -106.000007, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(846, 1121.184814, -2370.580078, 11.265845, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(846, 1163.746215, -2372.945556, 11.425950, 2.799998, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(684, 1156.057861, -2423.709472, 10.008267, -1.599998, -0.100000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(825, 1152.402954, -2376.523925, 10.397440, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(826, 1162.073852, -2381.080810, 10.957694, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(826, 1101.013427, -2334.444824, 11.384181, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2407, 1110.159301, -2351.313476, 11.300927, -90.000000, 90.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2907, 1101.799194, -2348.696777, 11.233338, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2907, 1137.744506, -2361.148925, 11.104496, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2907, 1140.715087, -2380.971679, 10.442012, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2907, 1105.550048, -2339.908203, 11.425602, -21.399999, 19.500000, -161.000015, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2905, 1085.785400, -2353.753173, 11.247511, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2905, 1105.241943, -2365.749023, 11.111467, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2905, 1129.940551, -2381.527832, 10.405879, 0.000000, 0.000000, -118.699981, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2905, 1144.116577, -2366.872802, 10.871357, 20.799999, 18.600002, -3.499999, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2908, 1130.357910, -2360.810058, 11.048586, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(935, 1070.015380, -2346.394531, 11.980905, -90.400016, 0.000000, -60.799983, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1053.496582, -2323.801025, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(935, 1121.274658, -2380.664794, 10.993013, -90.199981, 6.399999, 2.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2944, 1122.322875, -2374.866210, 11.247549, 3.799998, -62.399936, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1051.614501, -2325.157714, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1049.733032, -2326.516601, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1047.858764, -2327.867675, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1045.969604, -2329.231445, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1044.079833, -2330.595214, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1042.189941, -2331.959472, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1040.307983, -2333.315917, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1038.425659, -2334.673583, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1036.528076, -2336.041992, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(11441, 1152.906982, -2379.791748, 11.136080, 0.000000, 123.600051, -2.699995, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1034.639282, -2337.406982, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1032.750488, -2338.770996, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1030.868408, -2340.127197, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19834, 1028.995239, -2341.479248, 13.263760, 0.000000, 0.000000, 35.800022, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2920, 1028.209960, -2342.109863, 6.734315, 0.000000, 0.000000, -52.000011, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(1097, 1155.616333, -2420.401367, 10.152716, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1045.865234, -2345.276611, 11.852219, 0.000000, 0.000000, -59.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(1097, 1164.277587, -2376.555175, 11.109351, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1045.282836, -2344.308593, 11.852219, 0.000000, 0.000000, -59.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(3005, 1118.091796, -2364.621093, 10.748316, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1044.680664, -2343.307128, 11.852219, 0.000000, 0.000000, -68.599975, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(915, 1148.715942, -2376.158447, 10.751018, 0.000000, 0.000000, 46.099994, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1046.672729, -2346.331054, 11.852219, 0.000000, 0.000000, -65.499992, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1047.065551, -2347.274414, 11.922221, 0.000000, 0.000000, -59.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1047.653686, -2348.253173, 11.922221, 0.000000, 0.000000, -74.399986, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(1354, 1122.229736, -2381.352294, 10.895861, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1049.598632, -2343.656738, 11.852219, 0.000001, -0.000000, -59.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1049.016235, -2342.688720, 11.852219, 0.000001, -0.000000, -59.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1048.414062, -2341.687255, 11.852219, 0.000001, 0.000000, -68.599975, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1050.406127, -2344.711181, 11.852219, 0.000001, -0.000000, -65.499992, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1050.798950, -2345.654541, 11.922221, 0.000001, -0.000000, -59.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1051.387084, -2346.633300, 11.922221, 0.000001, 0.000000, -74.399986, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1053.618530, -2341.615966, 11.852219, 0.000003, -0.000001, -59.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1053.036132, -2340.647949, 11.852219, 0.000003, -0.000001, -59.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1052.433959, -2339.646484, 11.852219, 0.000003, -0.000000, -68.599975, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1054.426025, -2342.670410, 11.852219, 0.000003, -0.000001, -65.499992, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1054.818847, -2343.613769, 11.922221, 0.000003, -0.000001, -59.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(19944, 1055.406982, -2344.592529, 11.922221, 0.000003, -0.000000, -74.399986, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(846, 1090.959472, -2329.988037, 12.105834, 1.299998, -1.799998, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18689, 1121.103515, -2375.008544, 10.304050, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18690, 1161.289672, -2378.593261, 11.917776, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18726, 1097.968872, -2336.108154, 11.751151, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18726, 1100.069702, -2331.684082, 11.751151, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18726, 1149.960449, -2375.104980, 10.581151, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(18726, 1095.468750, -2333.392578, 14.581172, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2676, 1131.803955, -2380.503906, 10.461321, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(2670, 1118.257202, -2354.931396, 11.151124, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 
	planeCrashFS = CreateDynamicObjectFS(826, 1159.193603, -2374.001464, 11.657698, 0.000000, 0.000000, 0.000000, 0, 0, -1, 450.00, 450.00); 


	CreateActorFS(280,1035.0519,-2339.6055,12.9941,36.4403);
	CreateActorFS(281,1045.8110,-2339.0095,12.9077,223.7919);
	CreateActorFS(301,1054.1748,-2328.3130,12.9906,39.8870);

	
	return 1;
}

public OnFilterScriptExit()
{
	for(new i; i<actorsCount; i++)
	{
		DestroyActor(actors[i]);
	}
	
	for(new i; i<objectsCount; i++)
	{
		DestroyDynamicObject(objects[i]);
	}
}


