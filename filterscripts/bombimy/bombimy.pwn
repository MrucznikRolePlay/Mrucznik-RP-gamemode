#include <a_samp>
#include <streamer>

#define EXPLOSTION_RADIUS 10.0
#define MAX_OBJECTS_FS 100

new objects[MAX_OBJECTS_FS];
new objectsCount;

new explosion_types[] = {
    0, 1, 2, 3, 10, 11, 12
};

new Float:bombs_pos[][] = {
    {1478.8127,-1022.1393,23.8281},
    {1491.8822,-1022.1393,23.8313},
    {1444.1449,-1022.1667,23.8281},
    {1462.5076,-1013.2291,26.8438},
    {1437.5432,-1014.8923,26.8197},
    {1479.7788,-1016.9085,26.8197},
    {1471.8121,-1017.0795,25.5877},
    {1452.3527,-1017.1438,25.5637}
};

CreateDynamicObjectFS(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, areaid = -1, priority = 0)
{
	objects[objectsCount] = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
	return objects[objectsCount++];
}


forward Bombimy(pos, count);
public Bombimy(pos, count)
{
    new rand_x = random(20)-10;
    new rand_y = random(20)-10;
    CreateExplosion(bombs_pos[pos][0]+rand_x, bombs_pos[pos][1]+rand_y, bombs_pos[pos][2], explosion_types[random(sizeof(explosion_types))], 10.0);

    if(count > 0)
    {
        new time = 100+random(800);
        SetTimerEx("Bombimy", time, 0, "%d%d", pos, count-1);
    }
    else
    {
        CreateBankSyfObjects();
    }
}

WysadzBank()
{
    for(new i=0; i<sizeof(bombs_pos); i++)
    {
        Bombimy(i, 50);
    }
}

CreateBankSyfObjects()
{
    if(objectsCount == 0) //only one time
    {
        CreateDynamicObjectFS(2907, 1459.515258, -1036.513549, 22.729791, 0.000000, 18.299989, -62.299987, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(12957, 1447.454589, -1026.225952, 23.496267, -0.200000, -0.299998, 83.100021, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(12957, 1447.454589, -1026.225952, 23.496267, -0.200000, -0.299998, 83.100021, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(807, 1483.267944, -1023.523864, 22.813955, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(2907, 1459.884765, -1026.467651, 22.918127, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(807, 1469.959960, -1027.660522, 22.828125, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(2676, 1465.707275, -1012.181396, 25.998020, 2.000010, -0.799998, -146.399917, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(3593, 1461.086425, -1036.667480, 22.826253, 0.000000, -171.900085, -106.099952, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(850, 1470.829833, -1033.238403, 22.746252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(2908, 1474.843872, -1033.333496, 22.656250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(850, 1466.840087, -1009.844116, 27.269863, -84.900009, -87.399963, 99.900009, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(849, 1449.533325, -1031.384643, 22.756252, 0.000000, 0.000000, -54.799999, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(850, 1464.994750, -1009.877746, 27.543216, 92.800010, -0.799998, -2.199999, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18726, 1447.991821, -1025.424804, 21.456251, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18689, 1455.656616, -1021.187133, 29.386304, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1449.423461, -1026.996215, 22.646249, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1465.281738, -1011.089355, 25.843750, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18689, 1442.009033, -1015.699707, 24.824319, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1453.721435, -1010.923950, 25.083732, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18689, 1434.324462, -1017.477844, 24.732250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1465.455078, -1013.023071, 24.673723, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18689, 1483.091186, -1015.746459, 24.871931, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1451.585083, -1019.761108, 23.437536, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18689, 1461.653564, -1037.702514, 22.256240, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1473.163208, -1019.876220, 23.408943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1497.238159, -1021.983520, 22.822998, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1432.161376, -1022.100891, 22.896465, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1469.857910, -1034.214111, 22.036235, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18689, 1461.927856, -1020.744995, 22.132816, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18689, 1446.769775, -1024.333496, 29.776506, 7.700000, -2.299994, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1476.574462, -1024.372314, 29.698186, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
        CreateDynamicObjectFS(18690, 1495.697265, -1023.909545, 30.071678, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    }
    return 1;
}

public OnFilterScriptInit()
{
    WysadzBank();
    return 1;
}

public OnFilterScriptExit()
{    
	for(new i; i<objectsCount; i++)
	{
		DestroyDynamicObject(objects[i]);
	}
    return 1;
}