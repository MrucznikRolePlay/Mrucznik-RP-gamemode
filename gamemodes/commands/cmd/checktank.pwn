//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ checktank ]-----------------------------------------------//
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
YCMD:checktank(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new giveid;
		if( sscanf(params, "k<fix>", giveid))
		{
			sendTipMessage(playerid, "U¿yj /checktank [id gracza/czêœæ nicku]");
			return 1;
		}

        if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid))
        {
            new carid = GetPlayerVehicleID(giveid);
            if(!carid) return sendErrorMessage(playerid, sprintf("%s [%d] musi znajdowaæ siê w pojeŸdzie!", GetNick(giveid), giveid));
            
            new Float:vhealth;
            GetVehicleHealth(carid, vhealth);
            SetVehicleHealth(carid, vhealth - 15);
            SetTimerEx("CheckTankMode", 100, false, "iiif", playerid, giveid, carid, vhealth);
        }
        else
        {
            noAccessMessage(playerid);
        }
    }
    return 1;
}