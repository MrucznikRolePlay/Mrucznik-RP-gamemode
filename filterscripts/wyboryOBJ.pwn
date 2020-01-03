//STARE OBIEKTY WYBORCZE

#include <a_samp>
#include <streamer>

#define OBJECTS_NUMBER 99
new objects[OBJECTS_NUMBER];
new idx = 0;

public OnFilterScriptInit()
{
	CreateFSDynamicObject(19454, 1254.61267, -1443.97583, 14.24420,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(19454, 1249.76770, -1448.71826, 14.25150,   0.00000, 0.00000, 90.00000);
	CreateFSDynamicObject(19454, 1240.16455, -1448.65637, 14.24740,   0.00000, 0.00000, -90.60000);
	CreateFSDynamicObject(19454, 1235.42664, -1443.87891, 14.25320,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(19339, 1253.25452, -1448.23682, 12.79556,   0.00000, 90.00000, 90.00000);
	CreateFSDynamicObject(19339, 1250.28357, -1448.23242, 12.79273,   0.00000, 90.00000, 90.00000);
	CreateFSDynamicObject(19435, 1251.51770, -1447.94226, 14.25774,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(19435, 1248.90369, -1447.93164, 14.26899,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(19339, 1247.11584, -1448.23083, 12.80024,   0.00000, 90.00000, 90.00000);
	CreateFSDynamicObject(19435, 1245.61597, -1447.87268, 14.26864,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(19327, 1253.05005, -1448.62268, 15.13548,   0.00000, 0.00000, 180.00020);
	CreateFSDynamicObject(19327, 1250.19751, -1448.61975, 15.07540,   0.00000, 0.00000, 180.00020);
	CreateFSDynamicObject(19327, 1247.18738, -1448.62695, 14.96860,   0.00000, 0.00000, 180.00020);
	CreateFSDynamicObject(2773, 1248.88257, -1445.97095, 13.07530,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(2773, 1245.61609, -1445.92053, 13.07530,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(2773, 1251.50684, -1445.99243, 13.07530,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(2773, 1254.20728, -1446.09302, 13.07530,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(2773, 1244.96643, -1444.24414, 13.08530,   0.00000, 0.00000, 42.06000);
	CreateFSDynamicObject(2773, 1243.75024, -1442.76062, 13.10805,   0.00000, 0.00000, 36.24002);
	CreateFSDynamicObject(2773, 1242.34607, -1441.48438, 13.13728,   0.00000, 0.00000, 57.18000);
	CreateFSDynamicObject(2773, 1240.62085, -1440.64478, 13.14538,   0.00000, 0.00000, 69.17999);
	CreateFSDynamicObject(2773, 1238.78748, -1440.02112, 13.15547,   0.00000, 0.00000, 72.24000);
	CreateFSDynamicObject(19327, 1240.71619, -1448.57080, 15.13830,   0.00000, 0.00000, -180.66000);
	CreateFSDynamicObject(1723, 1244.73926, -1447.96167, 12.53912,   0.00000, 0.00000, -180.18008);
	CreateFSDynamicObject(1723, 1242.58118, -1445.01416, 12.56687,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1724, 1241.22998, -1447.13940, 12.56181,   0.00000, 0.00000, 90.24000);
	CreateFSDynamicObject(1724, 1239.59558, -1445.98535, 12.56150,   0.00000, 0.00000, -90.18000);
	CreateFSDynamicObject(1723, 1238.24268, -1448.04663, 12.54488,   0.00000, 0.00000, -180.17999);
	CreateFSDynamicObject(1723, 1236.24817, -1444.98364, 12.56312,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1723, 1238.43848, -1441.30859, 12.58790,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(2315, 1238.85022, -1442.99976, 12.58721,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(2315, 1236.51038, -1446.71863, 12.55888,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(2315, 1243.11560, -1446.63770, 12.56303,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1670, 1243.71655, -1446.63708, 13.07600,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(2702, 1239.70776, -1446.66040, 13.11013,   0.00000, 0.00000, 192.24001);
	CreateFSDynamicObject(2355, 1240.18579, -1442.64014, 13.16060,   208.55949, -158.57990, 0.00000);
	CreateFSDynamicObject(955, 1235.90002, -1442.68433, 12.96361,   0.00000, 0.00000, 90.77998);
	CreateFSDynamicObject(1668, 1237.64832, -1446.86536, 13.22150,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1667, 1237.60437, -1446.59338, 13.14320,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1455, 1236.89563, -1446.40295, 13.13330,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1216, 1254.21143, -1439.41516, 13.26765,   0.00000, 0.00000, -90.71998);
	CreateFSDynamicObject(1231, 1244.74438, -1442.86743, 15.18517,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1359, 1242.14648, -1442.28979, 13.28575,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1359, 1254.04895, -1441.85718, 13.22533,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1549, 1235.86157, -1441.61011, 12.54844,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1485, 1235.72546, -1441.59436, 13.28510,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1520, 1253.80945, -1441.85242, 13.10390,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(1520, 1239.16956, -1442.98621, 13.10030,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(3430, 1243.80798, -1431.42957, 13.82689,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(2614, 1253.33032, -1447.83020, 13.30343,   0.00000, 0.00000, -180.83992);
	CreateFSDynamicObject(2614, 1250.27515, -1447.83911, 13.33572,   0.00000, 0.00000, -174.36005);
	CreateFSDynamicObject(2614, 1247.10376, -1447.85083, 13.31327,   0.00000, 0.00000, -178.92001);
	CreateFSDynamicObject(11245, 1235.99280, -1439.03528, 15.20515,   0.78000, -68.64000, 0.00000);
	CreateFSDynamicObject(11245, 1254.19617, -1438.85999, 14.93956,   -0.24000, -72.48001, 153.35997);
	CreateFSDynamicObject(19893, 1238.13220, -1446.75769, 13.05247,   0.00000, 0.00000, 92.69997);
	CreateFSDynamicObject(4988, 1232.95642, -1433.01941, 26.71527,   0.00000, 0.00000, -80.04002);
	CreateFSDynamicObject(970, 1257.82129, -1424.89893, 12.96490,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(970, 1253.71948, -1424.89465, 12.96600,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(970, 1249.60156, -1424.90454, 12.96580,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(970, 1232.25720, -1426.94946, 13.00580,   0.00000, 0.00000, 90.00000);
	CreateFSDynamicObject(970, 1234.32495, -1424.87842, 13.00580,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(970, 1238.44983, -1424.87036, 13.00990,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(970, 1242.55933, -1424.86133, 13.00670,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(970, 1256.56335, -1438.79858, 13.07756,   0.00000, 0.00000, 12.60000);
	CreateFSDynamicObject(970, 1260.48767, -1437.63501, 13.06292,   0.00000, 0.00000, 21.24000);
	CreateFSDynamicObject(970, 1233.28711, -1448.64050, 12.98135,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(19608, 1243.39954, -1475.05249, 12.53090,   0.00000, 0.00000, -183.17990);
	CreateFSDynamicObject(19611, 1244.43958, -1469.39771, 12.53780,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(19623, 1244.44373, -1469.40161, 14.12969,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(19613, 1239.85938, -1473.08301, 12.57954,   0.00000, 0.00000, 177.00006);
	CreateFSDynamicObject(19613, 1247.13672, -1473.42603, 12.57913,   0.00000, 0.00000, -181.62004);
	CreateFSDynamicObject(19618, 1243.72937, -1473.79529, 12.87696,   0.00000, 0.00000, -4.14000);
	CreateFSDynamicObject(19618, 1243.74023, -1473.80444, 13.50187,   0.00000, 0.00000, -4.32000);
	CreateFSDynamicObject(19611, 1243.77966, -1473.57861, 12.54370,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(19610, 1243.78101, -1473.55347, 14.17559,   17.34000, 23.10000, -189.30005);
	CreateFSDynamicObject(19619, 1243.29114, -1474.01697, 12.97030,   0.00000, 0.00000, -3.60000);
	CreateFSDynamicObject(19630, 1243.66345, -1473.69751, 13.64058,   0.00000, 0.00000, 0.00000);
	CreateFSDynamicObject(323, 1239.48511, -1473.51648, 12.67313,   0.00000, 90.00000, 0.00000);
	CreateFSDynamicObject(2894, 1243.74182, -1473.82141, 13.97244,   0.00000, 0.00000, -5.10000);
	CreateFSDynamicObject(2614, 1243.79382, -1473.32458, 12.98000,   0.00000, 0.00000, -184.20000);
	CreateFSDynamicObject(1256, 1241.53967, -1466.83020, 13.11803,   0.00000, 0.00000, 86.45998);
	CreateFSDynamicObject(1256, 1245.72351, -1466.98755, 13.11800,   0.00000, 0.00000, 86.46000);
	CreateFSDynamicObject(1256, 1241.65405, -1464.45239, 13.11800,   0.00000, 0.00000, 86.46000);
	CreateFSDynamicObject(1256, 1245.79053, -1464.66541, 13.11800,   0.00000, 0.00000, 86.46000);
	CreateFSDynamicObject(1256, 1234.16064, -1468.24695, 13.12120,   0.00000, 0.00000, -180.12009);
	new obiektid =	CreateFSDynamicObject(19327, 1240.71619, -1448.57080, 15.13830, 0.00000, 0.00000, -180.66000);
	SetDynamicObjectMaterialText(obiektid, 0, "Ka¿dy g³os siê liczy!\nOddaj go 19 sierpnia!", OBJECT_MATERIAL_SIZE_256x128,
	"Georgia", 28, 0, 0xFFFF8200, 0xFF000000,  OBJECT_MATERIAL_TEXT_ALIGN_CENTER); //strefa
 	obiektid =  CreateFSDynamicObject(19327, 1253.05005, -1448.62268, 15.13548,   0.00000, 0.00000, 180.00020);
	SetDynamicObjectMaterialText(obiektid, 0, "Yep", OBJECT_MATERIAL_SIZE_256x128,
 	"Georgia", 28, 0, 0xFFFF8200, 0xFF000000,  OBJECT_MATERIAL_TEXT_ALIGN_CENTER); //wybor1
	obiektid =	CreateFSDynamicObject(19327, 1250.19751, -1448.61975, 15.07540,   0.00000, 0.00000, 180.00020);
	SetDynamicObjectMaterialText(obiektid, 0, "vs.", OBJECT_MATERIAL_SIZE_256x128,
 	"Georgia", 28, 0, 0xFFFF8200, 0xFF000000,  OBJECT_MATERIAL_TEXT_ALIGN_CENTER); //wybor2
	obiektid =	CreateFSDynamicObject(19327, 1247.18738, -1448.62695, 14.96860,   0.00000, 0.00000, 180.00020);
	SetDynamicObjectMaterialText(obiektid, 0, "Nope", OBJECT_MATERIAL_SIZE_256x128,
 	"Georgia", 28, 0, 0xFFFF8200, 0xFF000000,  OBJECT_MATERIAL_TEXT_ALIGN_CENTER); //wybor3
 	obiektid =  CreateFSDynamicObject(4988, 1232.95642, -1433.01941, 26.71527,   0.00000, 0.00000, -80.04002);
	SetDynamicObjectMaterialText(obiektid, 0, "Wybory Ma³ego Senatu\n19 sierpnia\n14:00-22:00\nWpisz /glosuj", OBJECT_MATERIAL_SIZE_256x128,
 	"Arial Black", 28, 0, 0xFFFFFFFF, 0xFF000000,  OBJECT_MATERIAL_TEXT_ALIGN_CENTER); //wybor3
	new Cobiekt=	CreateFSDynamicObject(19454, 1254.61267, -1443.97583, 14.24420,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(Cobiekt, 0, 18202, "w_towncs_t", "hatwall256hi", 0xFFFFFFFF);//sciany
 	Cobiekt=	CreateFSDynamicObject(19454, 1249.76770, -1448.71826, 14.25150,   0.00000, 0.00000, 90.00000);
 	SetDynamicObjectMaterial(Cobiekt, 0, 18202, "w_towncs_t", "hatwall256hi", 0xFFFFFFFF);//sciany
 	Cobiekt=	CreateFSDynamicObject(19454, 1240.16455, -1448.65637, 14.24740,   0.00000, 0.00000, -90.60000);
 	SetDynamicObjectMaterial(Cobiekt, 0, 18202, "w_towncs_t", "hatwall256hi", 0xFFFFFFFF);//sciany
	Cobiekt=    CreateFSDynamicObject(19454, 1235.42664, -1443.87891, 14.25320,   0.00000, 0.00000, 0.00000);
 	SetDynamicObjectMaterial(Cobiekt, 0, 18202, "w_towncs_t", "hatwall256hi", 0xFFFFFFFF);//sciany
	Cobiekt=	CreateFSDynamicObject(19435, 1251.51770, -1447.94226, 14.25774,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(Cobiekt, 0, 18202, "w_towncs_t", "hatwall256hi", 0xFFFFFFFF);//malesciany
	Cobiekt=	CreateFSDynamicObject(19435, 1248.90369, -1447.93164, 14.26899,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(Cobiekt, 0, 18202, "w_towncs_t", "hatwall256hi", 0xFFFFFFFF);//malesciany
	Cobiekt=	CreateFSDynamicObject(19435, 1245.61597, -1447.87268, 14.26864,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(Cobiekt, 0, 18202, "w_towncs_t", "hatwall256hi", 0xFFFFFFFF);//malesciany
	return 1;
}

public OnFilterScriptExit()
{
	for(new i; i<OBJECTS_NUMBER; i++)
	{
		DestroyDynamicObject(objects[i]);
	}
}

public OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 6068, 1247.9141, -1429.9688, 15.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1238.9844, -1468.0156, 12.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1250.6563, -1466.0000, 9.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1236.2813, -1443.0313, 12.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 6052, 1247.9141, -1429.9688, 15.1250, 0.25);
	return 1;
}

CreateFSDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, areaid = -1, priority = 0)
{
	objects[idx] = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
	return objects[idx++];
}
