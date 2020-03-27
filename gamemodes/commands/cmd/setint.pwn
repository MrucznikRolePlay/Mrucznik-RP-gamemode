//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ setint ]------------------------------------------------//
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

YCMD:setint(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new gracz, intid;
		if( sscanf(params, "k<fix>d", gracz, intid))
		{
			sendTipMessage(playerid, "U¿yj /setint [nick/id] [interiorid]");
			return 1;
		}

		if(!IsPlayerConnected(gracz))
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza.");
			return 1;
		}

		if (PlayerInfo[playerid][Admin] >= 1 || IsAScripter(playerid))
		{
			SetPlayerInterior(gracz,intid);
			PlayerInfo[gracz][pInt] = intid;
			format(string, sizeof(string), "Ustawi³eœ %s interior nr %d.", GetNick(gracz), intid);
			SendClientMessage(playerid, COLOR_GRAD1, string);
			format(string, sizeof(string), "Admin %s ustawi³ ci interior nr %d.", GetNickEx(playerid), intid);
			SendClientMessage(gracz, COLOR_LIGHTBLUE, string);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
