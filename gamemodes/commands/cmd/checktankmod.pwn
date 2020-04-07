//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ checktankmod ]---------------------------------------------//
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
// Autor: Creative
// Data utworzenia: 07.04.2020

// Opis:
/*

*/


// Notatki skryptera:
/*
	
*/
YCMD:checktankmod(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new giveid;
		if( sscanf(params, "k<fix>", giveid))
		{
			sendTipMessage(playerid, "U¿yj /checktankmod [id gracza/czêœæ nicku]");
			return 1;
		}

        if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid))
        {
            new carid = GetPlayerVehicleID(giveid);
            if(!carid) return sendErrorMessage(playerid, sprintf("%s [%d] musi znajdowaæ siê w pojeŸdzie!", GetNick(giveid), giveid));
            
            new Float:vhealth, Float:newvhealth, result, string[144];
            GetVehicleHealth(carid, vhealth);
            SetVehicleHealth(carid, vhealth - 15);
            GetVehicleHealth(carid, newvhealth);
            result = (vhealth == newvhealth ? true : false);
            format(string, sizeof(string), "Admin %s [%d] sprawdzi³ tankmode gracza %s [%d]. Wynik: %s", GetNickEx(playerid), playerid, GetNick(giveid), giveid, (result ? "{fad052}prawdopodobny tankmode (zalecany /spec)" : "{fa5252}negatywny"));
            SendCommandLogMessage(string, COLOR_LIGHTGREEN);
        }
        else
        {
            noAccessMessage(playerid);
        }
    }
    return 1;
}