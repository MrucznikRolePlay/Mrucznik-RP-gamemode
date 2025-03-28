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
command_wyscig_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

	if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RACE))
	{
		if(PlayerInfo[playerid][pRank] >= 2)
		{
			if(owyscig[playerid] != 666)
			{
				new playa;
				if( sscanf(params, "k<fix>", playa))
				{
					sendTipMessage(playerid, "U�yj /wyscig [Nick/ID]");
					return 1;
				}


				//
				if(ProxDetectorS(10.0, playerid, playa))
				{
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "%s przydzieli� ci udzia� w wy�cigu \"%s\".", sendername, Wyscig[owyscig[playerid]][wNazwa]);
					SendClientMessage(playa, 0xFFC0CB, string);
					format(string, sizeof(string), "Przydzieli�e� %s udzia� w wy�cigu. Aby rozpocz�� wy�cig, popro� zawodnik�w o ustawienie si� na mecie i wpisz /wyscig-start.", giveplayer);
					SendClientMessage(playerid, 0xFFC0CB, string);
					ScigaSie[playa] = owyscig[playerid];
					SetPlayerRaceCheckpoint(playa,0,wCheckpoint[owyscig[playerid]][0][0], wCheckpoint[owyscig[playerid]][0][1], wCheckpoint[owyscig[playerid]][0][2],wCheckpoint[owyscig[playerid]][1][0], wCheckpoint[owyscig[playerid]][1][1], wCheckpoint[owyscig[playerid]][1][2], 10);
				}
				else
				{
					sendErrorMessage(playerid, "Jeste� za daleko od gracza");
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie organizuj wy�cigu! Aby to zbi�, u�yj panelu wy�cig�w (/wyscigi)" );
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie posiadasz uprawnie� (wymagana 2 ranga)");
		}
	}
	else
	{
		sendErrorMessage(playerid, "Twoja organizacja nie posiada biznesu Toru wy�cigowego.");
	}
	return 1;
}

//end
