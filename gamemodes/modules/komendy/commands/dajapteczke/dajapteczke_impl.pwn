//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_dajapteczke_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		new playa, ilosc;
		if( sscanf(params, "k<fix>D(0)", playa, ilosc))
		{
			sendTipMessage(playerid, "U¿yj /dajapteczke [playerid/CzêœæNicku] [ilosc]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 100 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					new string[144];
					if(ilosc > MAX_HEALTH_PACKS)
					{
						format(string, sizeof(string), "Tip: Maksymalna iloœæ apteczek na gracza to [%d]", MAX_HEALTH_PACKS);
						return sendTipMessage(playerid, string);
					}
					
					new giveplayer[MAX_PLAYER_NAME], sendername[MAX_PLAYER_NAME];
					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}

					PlayerInfo[playa][pHealthPacks] = ilosc;
					Log(adminLog, INFO, "Admin %s ustawi³ %s apteczki na %d", GetPlayerLogName(playerid), GetPlayerLogName(playa), ilosc);
					format(string, sizeof(string), "%s ustawi³ %d apteczki dla %s", sendername, ilosc, giveplayer);
					SendMessageToAdmin(string, COLOR_P@);
					if(playerid != playa) _MruAdmin(playa, sprintf("Admin %s [%d] ustawi³ Ci poziom apteczek na [%d]", GetNickEx(playerid), playerid, ilosc));
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

//end
