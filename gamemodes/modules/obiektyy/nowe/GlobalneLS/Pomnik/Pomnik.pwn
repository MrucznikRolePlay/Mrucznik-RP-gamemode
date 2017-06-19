//pomnik.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//----------------------------------------[ Obiekty: pomnik.pwn ]------------------------------------------//
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
pomnik_Init()
{
	StworzObiekty();
	return 1;
}

pomnik_Connect(playerid)
{
	UsunObiekty(playerid);
	return 1;
}

//-----------------<[ Funkcje: ]>-------------------
static StworzObiekty()
{
	new gj_Object[18];
    gj_Object[0] = CreateDynamicObject(7093, 1002.0709, -1858.4283, 15.8426, 0.0000, 0.0000, -56.3999, 0); //weddingsifgn1
    SetDynamicObjectMaterialText_Kolejnosc(gj_Object[0], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0x0, 0);
    SetDynamicObjectMaterialText_Kolejnosc(gj_Object[0], " ", 1, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFF840410, 0);
    gj_Object[1] = CreateDynamicObject(19327, 999.2027, -1860.0245, 13.1923, 0.0000, -48.7000, 121.7998, 0); //7_11_sign02
    SetDynamicObjectMaterialText_Kolejnosc(gj_Object[1], "Los", 0, 50, "Arial", 60, 1, 0xFF000000, 0x0, 1);
    gj_Object[2] = CreateDynamicObject(19430, 999.6309, -1860.9099, 13.5526, 46.9999, 0.0000, 31.6999, 0); //wall070
    SetDynamicObjectMaterialText_Kolejnosc(gj_Object[2], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFFFFFFF, 0);
    gj_Object[3] = CreateDynamicObject(19430, 998.3532, -1858.8419, 14.7693, -42.9999, 0.0000, 31.6999, 0); //wall070
    SetDynamicObjectMaterialText_Kolejnosc(gj_Object[3], " ", 0, 90, "Arial", 24, 1, 0xFFFFFFFF, 0xFFFFFFFF, 0);
    gj_Object[4] = CreateDynamicObject(19327, 998.3379, -1858.6088, 14.9434, 0.0000, -48.7000, 121.6998, 0); //7_11_sign02
    SetDynamicObjectMaterialText_Kolejnosc(gj_Object[4], "Santos", 0, 50, "Arial", 46, 1, 0xFF000000, 0x0, 1);
    gj_Object[5] = CreateDynamicObject(19121, 1006.4047, -1868.3803, 12.3357, 0.0000, 0.0000, 25.3999, 0); //BollardLight1
    gj_Object[6] = CreateDynamicObject(19327, 999.9622, -1861.2386, 13.9853, 0.0000, -48.7000, 121.6998, 0); //7_11_sign02
    SetDynamicObjectMaterialText_Kolejnosc(gj_Object[6], "I", 0, 50, "Arial", 80, 1, 0xFF000000, 0x0, 1);
    gj_Object[7] = CreateDynamicObject(19121, 1004.2367, -1869.4093, 12.3357, 0.0000, 0.0000, 25.3999, 0); //BollardLight1
    gj_Object[8] = CreateDynamicObject(19121, 1001.9874, -1870.4776, 12.3357, 0.0000, 0.0000, 25.3999, 0); //BollardLight1
    gj_Object[9] = CreateDynamicObject(19121, 1010.3888, -1856.9323, 12.3489, 0.0000, -0.4999, 16.7999, 0); //BollardLight1
    gj_Object[10] = CreateDynamicObject(19121, 1009.0083, -1854.7476, 12.3429, 0.0000, -0.4999, 16.7999, 0); //BollardLight1
    gj_Object[11] = CreateDynamicObject(19121, 1007.4966, -1852.6130, 12.3356, 0.0000, -0.4999, 16.7999, 0); //BollardLight1
    gj_Object[12] = CreateDynamicObject(19121, 1006.0682, -1850.5466, 12.3289, 0.0000, -0.4999, 16.7999, 0); //BollardLight1
    gj_Object[13] = CreateDynamicObject(19121, 986.2158, -1857.5692, 12.3389, 0.0000, -0.4999, -5.9000, 0); //BollardLight1
    gj_Object[14] = CreateDynamicObject(19121, 986.4830, -1854.9947, 12.3489, 0.0000, -0.4999, -5.9000, 0); //BollardLight1
    gj_Object[15] = CreateDynamicObject(19121, 986.7458, -1852.4589, 12.3389, 0.0000, -0.4999, -5.9000, 0); //BollardLight1
    gj_Object[16] = CreateDynamicObject(19121, 986.9475, -1850.5100, 12.3389, 0.0000, -0.4999, -5.9000, 0); //BollardLight1
    gj_Object[17] = CreateDynamicObject(19426, 999.2198, -1860.2264, 11.8179, 0.0000, 90.0000, 119.9000, 0); //wall066
    SetDynamicObjectMaterial(gj_Object[17], 0, 16093, "a51_ext", "ws_trans_concr", 0xFFFFFFFF);
	return 1;
}

static UsunObiekty(playerid)
{
	RemoveBuildingForPlayer(playerid, 748, 997.5547, -1858.2188, 11.9063, 0.25);
    RemoveBuildingForPlayer(playerid, 748, 999.6875, -1861.1016, 11.9063, 0.25);
    RemoveBuildingForPlayer(playerid, 712, 998.7266, -1859.5781, 21.0938, 0.25);
	return 1;
}