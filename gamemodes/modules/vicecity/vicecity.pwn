//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  vicecity                                                 //
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
// Autor: Roger Costa '[Ds]NikO', edited by mrucznik
// Data utworzenia: 13.04.2024
//Opis:
/*
	Vice City
*/

//

//-----------------<[ Funkcje: ]>-------------------
GetViceCityRadioStream(station)
{
	new url[128];
	switch(station)
	{
		case 0: { strcat(url, "http://samp.mrucznik-rp.pl:8090/fm"); } // Wildstyle
		case 1: { strcat(url, "http://samp.mrucznik-rp.pl:8091/fm"); } // Flash FM
		case 2: { strcat(url, "http://samp.mrucznik-rp.pl:8092/fm"); } // K-Chat
		case 3: { strcat(url, "http://samp.mrucznik-rp.pl:8093/fm"); } // Fever 105
		case 4: { strcat(url, "http://samp.mrucznik-rp.pl:8094/fm"); } // V-Rock
		case 5: { strcat(url, "http://samp.mrucznik-rp.pl:8095/fm"); } // VCPR
		case 6: { strcat(url, "http://samp.mrucznik-rp.pl:8096/fm"); } // Radio Espantoso
		case 7: { strcat(url, "http://samp.mrucznik-rp.pl:8097/fm"); } // Emotion 98.3
		case 8: { strcat(url, "http://samp.mrucznik-rp.pl:8098/fm"); } // Wave 103
	}
	return url;
}

ShowViceCityRadioDialog(playerid, dialogid, title[])
{
	ShowPlayerDialogEx(playerid, dialogid, DIALOG_STYLE_LIST, title,"Wildstyle\nFlash FM\nK-CHAT\nFever 105\nV-ROCK\nVCPR\nRadio Espantoso\nEmotion 98.3\nWave 103","Start",""); //zmieñ dialogid
}

CreateShippingPlacePickups()
{
	CreateDynamicPickup(2510, 1, 2696.2197,-2226.9309,13.5501);
	MruCreateDynamicMapIcon(2696.2197,-2226.9309,13.5501, 51, 0, -1, -1, -1, -1, MAPICON_GLOBAL);
	CreateDynamic3DTextLabel("WYSY£KA POJAZDÓW DO VICE CITY\n/transport", COLOR_LIGHTBROWN, 
		2696.2197,-2226.9309,13.5501,
		15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true);

	CreateDynamicPickup(2510, 1, 3778.3586,-2190.5291,14.1532);
	MruCreateDynamicMapIcon(3778.3586,-2190.5291,14.1532, 51, 0, -1, -1, -1, -1, MAPICON_GLOBAL);
	CreateDynamic3DTextLabel("WYSY£KA POJAZDÓW DO LOS SANTOS\n/transport", COLOR_LIGHTBROWN, 
		3778.3586,-2190.5291,14.1532,
		15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true);
}

GetPlayerShippingPlace(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 15.0, 2696.2197,-2226.9309,13.5501))
	{
		return 1; // Los Santos Cargo Terminal
	}
	if(IsPlayerInRangeOfPoint(playerid, 15.0, 3778.3586,-2190.5291,14.1532))
	{
		return 2; // Vice City Cargo Terminal
	}
	return 0;
}

GetTransportDestinationName(terminalType)
{
    new where[32];
    switch(terminalType)
    {
        case 1: // Los Santos Cargo Terminal
        {
            strcat(where, "na wyspê Vice City");
        }
        case 2: // Vice City Cargo Terminal
        {
            strcat(where, "do Los Santos");
        }
    }
	return where;
}

IsPlayerAtViceCity(playerid)
{
	if(IsPlayerInDynamicArea(playerid, areaViceCity))
	{
		return 1;
	}
	return 0;
}

IsPointInViceCity(Float:x, Float:y, Float:z)
{
	if(IsPointInDynamicArea(areaViceCity, x, y, z))
	{
		return 1;
	}
	return 0;
}

IsPlayerAtPrawnIsland(playerid)
{
	// TODO
	return 1;
}

IsPlayerAtViceCityMainland(playerid)
{
	// TODO
	return 1;
}

IsPlayerAtViceCityBeach(playerid)
{
	// TODO
	return 1;
}

IsCarAtViceCity(vehicleid)
{
	new Float:x, Float:y, Float:z;
	GetVehiclePos(vehicleid, x, y, z);
	if(IsPointInDynamicArea(areaViceCity, x, y, z))
	{
		return 1;
	}
	return 0;
}

//-----------------<[ Mapa vice city: ]>-------------------
/* Function created by Y_Less */
stock Float:positive(Float:number) {
    if(number<0.0) number = -number;
    return number;
}

// Voc? passa o X e Y do mapa (2 primeirps parâmetros) e os 2 últimos retorna o X Y da tela correspondente ao X.Y do mapa
stock GetXYForScreenMap(Float:x, Float:y, &Float:rmap_x, &Float:rmap_y) {
	rmap_x = SCREEN_MAP_MIN_X + ((positive(x) - 2981.0) / 10.6);
	
	if(positive(y) <= 1036) {
	    rmap_y = SCREEN_MAP_MAX_Y + (797 + (positive(x)) / 12.2);
	}
	else if(positive(y) >= 1037) {
	    new Float:temp = ((-2870 + positive(y)) / 12.2);
	    rmap_y = SCREEN_MAP_MIN_Y - positive(temp);
	}
}

/* Function created by Southclaws */
stock QuatToEulerZXY(Float:quat_x, Float:quat_y, Float:quat_z, Float:quat_w, &Float:x, &Float:y, &Float:z)
{
    x = -asin(2 * ((quat_x * quat_z) + (quat_w * quat_y)));
    y = atan2(2 * ((quat_y * quat_z) + (quat_w * quat_x)), (quat_w * quat_w) - (quat_x * quat_x) - (quat_y * quat_y) + (quat_z * quat_z));
    z = -atan2(2 * ((quat_x * quat_y) + (quat_w * quat_z)), (quat_w * quat_w) + (quat_x * quat_x) - (quat_y * quat_y) - (quat_z * quat_z));
    return 1;
}

//end