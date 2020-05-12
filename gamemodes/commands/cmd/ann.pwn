//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ ann ]--------------------------------------------------//
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

YCMD:ann(playerid, params[], help)
{
	if(PlayerInfo[playerid][pAdmin] > 1500 || IsAScripter(playerid))
	{
		new string[128];
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /ann [cnn textformat ~n~=nowa linia ~r~=czerwony ~g~=zielony ~b~=niebieski ~w~=bia³y ~y~=¿ó³ty]");
			return 1;
		}
		format(string, sizeof(string), "  ~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~                         %s",params);
        if(!issafefortextdraw(string)) return sendErrorMessage(playerid, "Niekompletny tekst (tyldy etc)");
        GameTextForAll(string, 3000, 3);
		format(string, sizeof(string), "AdmCmd: %s [ID: %d] napisal cos na /ann", GetNickEx(playerid), playerid);
		SendMessageToAdmin(string, COLOR_PANICRED);

        Log(adminLog, INFO, "Admin %s u¿y³ /ann o treœci: %s", GetPlayerLogName(playerid), params);
	}
	else
	{
	    noAccessMessage(playerid);
	}
	return 1;
}
