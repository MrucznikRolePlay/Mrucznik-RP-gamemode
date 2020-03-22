//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ setvw ]-------------------------------------------------//
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

YCMD:setvw(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new gracz, intid;
		if( sscanf(params, "k<fix>d", gracz, intid))
		{
			sendTipMessage(playerid, "U¿yj /setvw [nick/id] [virtualworld]");
			return 1;
		}

		if(!IsPlayerConnected(gracz))
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza.");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid) || PlayerInfo[playerid][pNewAP] >= 1)
		{
			if(GetPlayerVirtualWorld(gracz) == intid) return SendClientMessage(playerid, COLOR_GRAD1, sprintf("%s ma ju¿ ustawiony %d virtualworld.", GetNick(gracz), intid));
			SetPlayerVirtualWorld(gracz, intid);
			format(string, sizeof(string), "Ustawi³eœ %s virtualworld nr %d.", GetNick(gracz), intid);
			SendClientMessage(playerid, COLOR_GRAD1, string);
			format(string, sizeof(string), "Admin %s ustawi³ ci virtualworld nr %d.", GetNickEx(playerid), intid);
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
