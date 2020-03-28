//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ ucisz ]-------------------------------------------------//
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

YCMD:ucisz(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /ucisz [playerid/CzêœæNicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHalfAdmin] >= 1 && PlayerInfo[playerid][pHalfAdmin] <= 5 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
				    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					if(PlayerInfo[playa][Mute] == 0)
					{
						PlayerInfo[playa][Mute] = 1;
        				Log(adminLog, INFO, "Admin %s uciszy³ %s", GetPlayerLogName(playerid), GetPlayerLogName(playa));
						format(string, sizeof(string), "AdmCmd: %s uciszyl %s",GetNickEx(playerid), giveplayer);
						ABroadCast(COLOR_LIGHTRED,string,1);
						format(string, sizeof(string), "Zosta³eœ uciszony przez administratora %s, widocznie powiedzia³eœ coœ z³ego :)", GetNickEx(playerid));
						SendClientMessage(playa, COLOR_PANICRED, string);
					}
					else
					{
						PlayerInfo[playa][Mute] = 0;
        				Log(adminLog, INFO, "Admin %s odciszy³ %s", GetPlayerLogName(playerid), GetPlayerLogName(playa));
						format(string, sizeof(string), "AdmCmd: %s odciszy³ %s",GetNickEx(playerid), giveplayer);
						ABroadCast(COLOR_LIGHTRED,string,1);
						format(string, sizeof(string), "Zosta³eœ odciszony przez administratora %s, popraw siê :)", GetNickEx(playerid));
						SendClientMessage(playa, COLOR_PANICRED, string);
					}
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
