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