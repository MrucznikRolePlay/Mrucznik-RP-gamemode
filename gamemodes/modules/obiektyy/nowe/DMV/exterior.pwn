//exterior.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//----------------------------------------[ Obiekty: exterior.pwn ]------------------------------------------//
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

//-----------------<[ G³ówne funkcje: ]>-------------------
DMV::exterior_Init()
{
	StworzObiekty();
	return 1;
}

DMV::exterior_Connect(playerid)
{
	UsunObiekty(playerid);
	return 1;
}

//-----------------<[ Funkcje: ]>-------------------
static StworzObiekty()
{
	new g_Object[103];
	g_Object[0] = CreateDynamicObject(982, 1498.7767, -1720.8066, 13.2489, 0.0000, 0.0000, 90.0000, 0); //fenceshit
	g_Object[1] = CreateDynamicObject(19545, 1480.3741, -1719.7373, 12.5537, 0.0000, 0.0000, 90.0000, 0); //Plane62_5x15Conc1
	SetDynamicObjectMaterial(g_Object[1], 0, 7555, "bballcpark1", "ws_carparknew2", 0xFFFFFFFF);
	g_Object[2] = CreateDynamicObject(982, 1461.9541, -1720.7667, 13.2489, 0.0000, 0.0000, 90.0000, 0); //fenceshit
	g_Object[3] = CreateDynamicObject(983, 1484.4007, -1720.8027, 13.2440, 0.0000, 0.0000, 90.0000, 0); //fenceshit3
	g_Object[4] = CreateDynamicObject(983, 1474.7679, -1720.7624, 13.2440, 0.0000, 0.0000, 90.0000, 0); //fenceshit3
    g_Object[5] = CreateDynamicObject(19929, 1448.6894, -1725.0295, 12.5438, 0.0000, 0.0000, 0.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[5], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[5], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[6] = CreateDynamicObject(19929, 1447.6988, -1726.8094, 12.5340, 0.0000, 0.0000, -90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[6], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[6], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[7] = CreateDynamicObject(19929, 1448.6894, -1722.1695, 12.5438, 0.0000, 0.0000, 0.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[7], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[7], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[8] = CreateDynamicObject(19929, 1444.8481, -1726.8094, 12.5340, 0.0000, 0.0000, -90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[8], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[8], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[9] = CreateDynamicObject(19929, 1441.5472, -1722.1783, 12.5340, 0.0000, 0.0000, 180.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[9], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[9], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[10] = CreateDynamicObject(19929, 1441.5472, -1725.0378, 12.5340, 0.0000, 0.0000, 180.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[10], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[10], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[11] = CreateDynamicObject(19929, 1442.5383, -1726.8088, 12.5241, 0.0000, 0.0000, -90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[11], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[11], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[12] = CreateDynamicObject(19929, 1446.8979, -1721.1793, 12.5340, 0.0000, 0.0000, 90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[12], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[12], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[13] = CreateDynamicObject(19929, 1444.0373, -1721.1793, 12.5340, 0.0000, 0.0000, 90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[13], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[13], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[14] = CreateDynamicObject(19929, 1442.5660, -1721.1893, 12.5241, 0.0000, 0.0000, 90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[14], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[14], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[15] = CreateDynamicObject(19790, 1445.8293, -1724.0758, 8.0214, 0.0000, 0.0000, 0.0000, 0); //Cube5mx5m
    SetDynamicObjectMaterial(g_Object[15], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[16] = CreateDynamicObject(19790, 1444.2978, -1724.0758, 8.0115, 0.0000, 0.0000, 0.0000, 0); //Cube5mx5m
    SetDynamicObjectMaterial(g_Object[16], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[17] = CreateDynamicObject(19929, 1512.0301, -1722.1783, 12.5340, 0.0000, 0.0000, 180.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[17], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[17], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[18] = CreateDynamicObject(19929, 1512.0301, -1725.0384, 12.5340, 0.0000, 0.0000, 180.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[18], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[18], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[19] = CreateDynamicObject(19929, 1513.0201, -1726.7695, 12.5241, 0.0000, 0.0000, -90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[19], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[19], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[20] = CreateDynamicObject(19929, 1515.8813, -1726.7695, 12.5241, 0.0000, 0.0000, -90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[20], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[20], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[21] = CreateDynamicObject(19929, 1517.5644, -1725.0356, 12.5340, 0.0000, 0.0000, 0.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[21], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[21], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[22] = CreateDynamicObject(19929, 1513.8110, -1721.1794, 12.5241, 0.0000, 0.0000, 90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[22], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[22], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[23] = CreateDynamicObject(19929, 1517.5644, -1722.1767, 12.5340, 0.0000, 0.0000, 0.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[23], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[23], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[24] = CreateDynamicObject(19929, 1516.5721, -1726.7595, 12.5038, 0.0000, 0.0000, -90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[24], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[24], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[25] = CreateDynamicObject(19929, 1515.8923, -1721.1993, 12.5141, 0.0000, 0.0000, 90.0000, 0); //MKWorkTop5
    SetDynamicObjectMaterial(g_Object[25], 0, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(g_Object[25], 1, 17542, "eastls1b_lae2", "tanstucco1_LA", 0xFFFFFFFF);
    g_Object[26] = CreateDynamicObject(19790, 1514.7923, -1724.0758, 8.0115, 0.0000, 0.0000, 0.0000, 0); //Cube5mx5m
    SetDynamicObjectMaterial(g_Object[26], 0, 4829, "airport_las", "Grass_128HV", 0xFFFFFFFF);
    g_Object[27] = CreateDynamicObject(19121, 1480.9116, -1726.8905, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[28] = CreateDynamicObject(11700, 1449.0589, -1727.1811, 12.2220, 0.0000, 0.0000, 0.0000); //SAMPRoadSign47
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[28], "P", 2, 60, "Arial", 100, 1, 0xFFFFFFFF, 0xFF134573, 1);
    g_Object[29] = CreateDynamicObject(11700, 1511.6330, -1727.1811, 12.2220, 0.0000, 0.0000, 0.0000, 0); //SAMPRoadSign47
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[29], "P", 2, 60, "Arial", 100, 1, 0xFFFFFFFF, 0xFF134573, 1);
    g_Object[31] = CreateDynamicObject(19121, 1478.1070, -1726.9017, 13.0762, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[32] = CreateDynamicObject(19121, 1479.4403, -1726.8905, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[33] = CreateDynamicObject(19880, 1508.4095, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[33], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[34] = CreateDynamicObject(718, 1445.1634, -1724.1783, 12.4995, 0.0000, 0.0000, 0.0000, 0); //vgs_palm04
    g_Object[35] = CreateDynamicObject(19880, 1505.2574, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[35], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[36] = CreateDynamicObject(19880, 1502.0266, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[36], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[37] = CreateDynamicObject(19880, 1499.0952, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[37], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[38] = CreateDynamicObject(19880, 1496.0334, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[38], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[39] = CreateDynamicObject(19880, 1492.9914, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[39], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[40] = CreateDynamicObject(19880, 1489.7905, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[40], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[41] = CreateDynamicObject(19880, 1486.4582, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[41], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[42] = CreateDynamicObject(718, 1514.8702, -1724.1783, 12.4995, 0.0000, 0.0000, 0.0000, 0); //vgs_palm04
    g_Object[43] = CreateDynamicObject(19880, 1452.7137, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[43], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[44] = CreateDynamicObject(19880, 1455.9748, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[44], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[45] = CreateDynamicObject(19880, 1459.2569, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[45], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[46] = CreateDynamicObject(19880, 1462.6595, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[46], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[47] = CreateDynamicObject(19880, 1466.1810, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[47], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[48] = CreateDynamicObject(19880, 1469.9326, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[48], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[49] = CreateDynamicObject(19880, 1473.6539, -1723.1035, 12.5579, 0.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[49], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
    g_Object[50] = CreateDynamicObject(19880, 1482.5886, -1723.1385, 12.5311, 90.0000, 0.0000, 90.0000, 0); //WellsFargoGrgDoor1
    SetDynamicObjectMaterial(g_Object[50], 0, 4004, "civic07_lan", "badmarb1_LAn", 0xFFFFFFFF);
    g_Object[51] = CreateDynamicObject(970, 1482.5716, -1724.2054, 13.1198, 0.0000, 0.0000, 90.0000, 0); //fencesmallb
    g_Object[52] = CreateDynamicObject(970, 1477.7187, -1724.2054, 13.1198, 0.0000, 0.0000, 90.0000, 0); //fencesmallb
    g_Object[53] = CreateDynamicObject(19121, 1482.3719, -1726.8905, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[54] = CreateDynamicObject(1280, 1482.1948, -1724.2745, 12.9483, 0.0000, 0.0000, 0.0000, 0); //parkbench1
    SetDynamicObjectMaterial(g_Object[54], 1, 3820, "boxhses_sfsx", "sw_barnwoodblu", 0xFFFFFFFF);
    g_Object[55] = CreateDynamicObject(1280, 1478.0825, -1724.2745, 12.9483, 0.0000, 0.0000, 180.0000, 0); //parkbench1
    SetDynamicObjectMaterial(g_Object[55], 1, 3820, "boxhses_sfsx", "sw_barnwoodblu", 0xFFFFFFFF);
    g_Object[56] = CreateDynamicObject(19957, 1479.6113, -1720.7148, 13.6844, 0.0000, 180.0000, 0.0000, 0); //SAMPRoadSign10
    g_Object[57] = CreateDynamicObject(19321, 1476.6909, -1738.8724, 11.1044, 0.0000, 0.0000, 90.0000, 0); //cuntainer
    SetDynamicObjectMaterial(g_Object[57], 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
    g_Object[58] = CreateDynamicObject(19321, 1483.8416, -1738.8724, 11.1044, 0.0000, 0.0000, 90.0000, 0); //cuntainer
    SetDynamicObjectMaterial(g_Object[58], 0, 9514, "711_sfw", "ws_carpark2", 0xFFFFFFFF);
    g_Object[59] = CreateDynamicObject(19327, 1483.8363, -1738.8355, 12.5689, -90.0000, 0.0000, 90.0000, 0); //7_11_sign02
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[59], "TAXI", 0, 90, "Arial", 90, 1, 0xFFD78E10, 0x0, 1);
    g_Object[60] = CreateDynamicObject(19978, 1486.1904, -1740.4149, 12.1356, 0.0000, 0.0000, 180.0000, 0); //SAMPRoadSign31
    g_Object[61] = CreateDynamicObject(19327, 1477.1947, -1738.8349, 12.5689, -90.0000, 0.0000, -90.0000, 0); //7_11_sign02
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[61], "TAXI", 0, 90, "Arial", 90, 1, 0xFFD78E10, 0x0, 1);
    g_Object[62] = CreateDynamicObject(19834, 1476.6031, -1740.4232, 12.5655, 90.0000, 0.0000, 0.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[62], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[63] = CreateDynamicObject(19834, 1474.2724, -1740.4232, 12.5655, 90.0000, 0.0000, 0.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[63], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[64] = CreateDynamicObject(19834, 1478.9338, -1740.4232, 12.5655, 90.0000, 0.0000, 0.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[64], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[65] = CreateDynamicObject(19834, 1481.2641, -1740.4232, 12.5655, 90.0000, 0.0000, 0.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[65], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[66] = CreateDynamicObject(19834, 1483.5848, -1740.4232, 12.5655, 90.0000, 0.0000, 0.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[66], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[67] = CreateDynamicObject(19834, 1485.9155, -1740.4232, 12.5655, 90.0000, 0.0000, 0.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[67], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[68] = CreateDynamicObject(19834, 1487.3460, -1738.4630, 12.5655, 90.0000, 0.0000, 90.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[68], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[69] = CreateDynamicObject(19834, 1487.3460, -1739.3038, 12.5655, 90.0000, 0.0000, 90.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[69], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[70] = CreateDynamicObject(19834, 1486.2458, -1740.4232, 12.5655, 90.0000, 0.0000, 0.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[70], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[71] = CreateDynamicObject(19834, 1473.1513, -1738.4537, 12.5655, 90.0000, 0.0000, 90.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[71], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[72] = CreateDynamicObject(19834, 1473.1513, -1739.3244, 12.5655, 90.0000, 0.0000, 90.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[72], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[73] = CreateDynamicObject(19834, 1480.5543, -1739.2020, 12.5655, 90.0000, 0.0000, 90.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[73], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[74] = CreateDynamicObject(19834, 1480.5543, -1738.4511, 12.5655, 90.0000, 0.0000, 90.0000, 0); //PoliceLineTape1
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[74], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFD78E10, 0);
    g_Object[75] = CreateDynamicObject(19121, 1480.9116, -1742.4707, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[76] = CreateDynamicObject(19121, 1479.5610, -1742.4707, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[77] = CreateDynamicObject(19121, 1478.2397, -1742.4707, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[78] = CreateDynamicObject(19121, 1482.1606, -1742.4707, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[79] = CreateDynamicObject(983, 1486.6811, -1742.2812, 13.2440, 0.0000, 0.0000, 90.0000, 0); //fenceshit3
    g_Object[80] = CreateDynamicObject(983, 1473.8612, -1742.2812, 13.2440, 0.0000, 0.0000, 90.0000, 0); //fenceshit3
    g_Object[81] = CreateDynamicObject(997, 1489.9320, -1740.7539, 12.6357, 0.0000, 0.0000, 90.0000, 0); //lhouse_barrier3
    g_Object[82] = CreateDynamicObject(997, 1470.6616, -1740.7539, 12.6357, 0.0000, 0.0000, 90.0000, 0); //lhouse_barrier3
    g_Object[83] = CreateDynamicObject(995, 1492.0567, -1737.6324, 13.2077, 90.0000, 0.0000, 0.0000, 0); //bar_barrier16
    g_Object[84] = CreateDynamicObject(995, 1499.1783, -1737.6324, 13.2077, 90.0000, 0.0000, 0.0000, 0); //bar_barrier16
    g_Object[85] = CreateDynamicObject(995, 1506.2008, -1737.6324, 13.2077, 90.0000, 0.0000, 0.0000, 0); //bar_barrier16
    g_Object[86] = CreateDynamicObject(995, 1464.8887, -1737.6324, 13.2077, 90.0000, 0.0000, 0.0000, 0); //bar_barrier16
    g_Object[87] = CreateDynamicObject(995, 1458.4781, -1737.6324, 13.2077, 90.0000, 0.0000, 0.0000, 0); //bar_barrier16
    g_Object[88] = CreateDynamicObject(995, 1452.1481, -1737.6324, 13.2077, 90.0000, 0.0000, 0.0000, 0); //bar_barrier16
    g_Object[89] = CreateDynamicObject(19121, 1510.8190, -1739.0108, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[90] = CreateDynamicObject(19121, 1510.8190, -1740.8721, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[91] = CreateDynamicObject(19121, 1510.8190, -1742.7738, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[92] = CreateDynamicObject(19121, 1451.3779, -1740.9923, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[93] = CreateDynamicObject(19121, 1451.3779, -1739.1905, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[94] = CreateDynamicObject(19121, 1451.3779, -1742.8613, 13.0964, 0.0000, 0.0000, 0.0000, 0); //BollardLight1
    g_Object[95] = CreateDynamicObject(970, 1510.9552, -1746.2923, 13.5847, 0.0000, 0.0000, 90.0000, 0); //fencesmallb
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[95], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[95], " ", 1, 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[96] = CreateDynamicObject(970, 1510.9552, -1750.4635, 13.5847, 0.0000, 0.0000, 90.0000, 0); //fencesmallb
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[96], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[96], " ", 1, 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[97] = CreateDynamicObject(970, 1451.0101, -1746.2728, 13.5467, 0.0000, 0.0000, 90.0000, 0); //fencesmallb
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[97], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[97], " ", 1, 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[98] = CreateDynamicObject(970, 1451.0101, -1749.9726, 13.5467, 0.0000, 0.0000, 90.0000, 0); //fencesmallb
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[98], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText_Kolejnosc(g_Object[98], " ", 1, 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    g_Object[99] = CreateDynamicObject(19957, 1510.9355, -1753.4069, 13.6844, 0.0000, 180.0000, 0.0000, 0); //SAMPRoadSign10
    g_Object[100] = CreateDynamicObject(19957, 1510.9355, -1754.6882, 13.6844, 0.0000, 180.0000, 0.0000, 0); //SAMPRoadSign10
    g_Object[101] = CreateDynamicObject(19957, 1451.0260, -1754.6882, 13.6844, 0.0000, 180.0000, 0.0000, 0); //SAMPRoadSign10
    g_Object[102] = CreateDynamicObject(19957, 1451.0260, -1753.4970, 13.6844, 0.0000, 180.0000, 0.0000, 0); //SAMPRoadSign10
	return 1;
}

static UsunObiekty(playerid)
{
	RemoveBuildingForPlayer(playerid, 1283, 1441.8594, -1733.0078, 15.6250, 0.25);
    RemoveBuildingForPlayer(playerid, 1283, 1414.4141, -1731.4297, 15.6250, 0.25);
    RemoveBuildingForPlayer(playerid, 1283, 1430.1719, -1719.4688, 15.6250, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 1451.6250, -1727.6719, 16.4219, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 1467.9844, -1727.6719, 16.4219, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 1485.1719, -1727.6719, 16.4219, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 1505.1797, -1727.6719, 16.4219, 0.25);
    RemoveBuildingForPlayer(playerid, 1283, 1513.2344, -1732.9219, 15.6250, 0.25);
    RemoveBuildingForPlayer(playerid, 1283, 1545.7656, -1731.6719, 15.6250, 0.25);
    RemoveBuildingForPlayer(playerid, 1283, 1530.1172, -1717.0078, 15.6250, 0.25);
	return 1;
}