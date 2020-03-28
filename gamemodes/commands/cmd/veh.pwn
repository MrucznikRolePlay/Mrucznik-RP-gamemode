//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ veh ]--------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:veh(playerid, params[], help) //TODO: naprawiæ/usun¹æ
{
	new string[64];

    if(IsPlayerConnected(playerid))
    {
        if (PlayerInfo[playerid][pAdmin] != 5000)
		{
		    noAccessMessage(playerid);
		    return 1;
		}
		new car, color1, color2;
		if( sscanf(params, "ddd", car, color1, color2))
		{
			sendTipMessage(playerid, "U¿yj /veh [car] [color1] [color2]");
			return 1;
		}


		if(car < 400 || car > 611) { sendTipMessageEx(playerid, COLOR_GREY, "   Numer pojazdu musi byæ wiêkszy od 400 i mniejszy od 611 !"); return 1; }
		if(color1 < 0 || color1 > 255) { sendTipMessageEx(playerid, COLOR_GREY, "   Numery kolorów od 0 do 255 !"); return 1; }
		if(color2 < 0 || color2 > 255) { sendTipMessageEx(playerid, COLOR_GREY, "   Numery kolorów od 0 do 255 !"); return 1; }
		new Float:X,Float:Y,Float:Z;
		GetPlayerPos(playerid, X,Y,Z);

		CreatedCars[CreatedCar] = car;
		CreatedCar ++;
		format(string, sizeof(string), "   Pojazd %d zespawnowany.", car);
		Log(adminLog, INFO, "Admin %s zespawnowa³ pojazd %d", GetPlayerLogName(playerid), car);
		sendTipMessageEx(playerid, COLOR_GREY, string);
	}
	return 1;
}
