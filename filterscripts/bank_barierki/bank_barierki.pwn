#include <a_samp>
#include <streamer>

#define MAX_OBJECTS_FS 100
#define MAX_ACTORS_FS 6

new objects[MAX_OBJECTS_FS];
new objectsCount;
new actors[MAX_ACTORS_FS];
new actorsCount;

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
    SetPlayerPos(0, 1454.8818,-1046.4905,23.828);
    SetPlayerPos(1, 1454.8818,-1046.4905,23.828);
    SetPlayerPos(2, 1454.8818,-1046.4905,23.828);
    SetPlayerPos(3, 1454.8818,-1046.4905,23.828);
    new tmpobjid;
    tmpobjid = CreateDynamicObjectFS(4514, 1401.813842, -1037.722778, 25.420129, 2.900000, -0.399999, 100.599914, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 19962, "samproadsigns", "donotentersign", 0x00000000);
    tmpobjid = CreateDynamicObjectFS(4514, 1514.985717, -1039.813964, 24.420059, -0.000000, 0.000000, -91.199958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 19962, "samproadsigns", "donotentersign", 0x00000000);
    tmpobjid = CreateDynamicObjectFS(4514, 1482.886718, -1064.518676, 24.269859, -0.500001, 0.400000, 179.999801, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 19962, "samproadsigns", "donotentersign", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObjectFS(19834, 1518.394287, -1028.106445, 23.719917, -0.000002, -0.000000, 82.499923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19834, 1518.091796, -1030.417480, 23.719917, -0.000002, -0.000000, 82.499923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19834, 1517.788085, -1032.728393, 23.719917, -0.000002, -0.000000, 82.499923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19834, 1491.166259, -1067.083740, 23.709320, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(12957, 1448.445556, -1027.108032, 23.494817, 0.699999, -0.299999, 93.100006, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19944, 1484.631469, -1051.613647, 22.687685, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19944, 1484.631469, -1050.582641, 22.687685, 0.000000, 0.000000, -97.399887, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(18726, 1450.715698, -1026.543945, 18.656166, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19944, 1484.717285, -1049.171875, 22.687685, 0.000000, 0.000000, -87.599945, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19944, 1484.740844, -1047.643920, 22.677684, 0.000000, 0.000000, -91.999893, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19834, 1435.016601, -1047.112915, 23.928150, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19834, 1432.684326, -1047.112915, 23.928150, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19834, 1430.353393, -1047.112915, 23.928150, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19834, 1428.052246, -1047.112915, 23.928150, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19834, 1425.729980, -1047.112915, 23.928150, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObjectFS(19834, 1423.397705, -1047.112915, 23.928150, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 

    CreateActorFS(280,1517.0204,-1029.4967,23.7936,253.6645);
    CreateActorFS(281,1475.3717,-1067.2218,23.8286,185.6499);
    CreateActorFS(306,1491.0676,-1065.8577,23.8283,173.2420);
    CreateActorFS(300,1399.0547,-1030.2148,24.6773,83.8576);
    CreateActorFS(301,1388.5176,-1037.9237,25.5552,81.3299);
    CreateActorFS(307,1429.2924,-1046.7589,23.7356,185.6504);
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
    return 1;
}