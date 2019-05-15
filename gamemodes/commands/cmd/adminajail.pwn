//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ adminajail ]----------------------------------------------//
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

YCMD:adminajail(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new playa, money, result[64];
		if( sscanf(params, "k<fix>ds[64]", playa, money, result))
		{
			sendTipMessage(playerid, "U¿yj /aj [id/nick] [czas(w minutach)] [powod]");
			return 1;
		}
		if(IsPlayerConnected(playa) && playa != INVALID_PLAYER_ID)
		{
			if (PlayerInfo[playa][pJailed] == 0)
			{
				if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 6 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3 || IsAScripter(playerid))
				{
					if (PlayerInfo[playerid][pZG] >= 6 && PlayerInfo[playerid][pZG] < 8 && money > 7)
					{
						sendTipMessageEx(playerid, COLOR_GRAD2, "Mozesz dac tylko do 7 minut AJ!");
						return 1;
					}
					if (PlayerInfo[playerid][pZG] >= 8 && PlayerInfo[playerid][pZG] < 9 && money > 12)
					{
						sendTipMessageEx(playerid, COLOR_GRAD2, "Mozesz dac tylko do 12 minut AJ!");
						return 1;
					}
					if (PlayerInfo[playerid][pZG] >= 9 && money > 17)
					{
						sendTipMessageEx(playerid, COLOR_GRAD2, "Mozesz dac tylko do 17 minut AJ!");
						return 1;
					}
					if(OnDuty[playa] == 1 || OnDutyCD[playa] == 1)
					{
					    OnDuty[playa] = 0;
					    OnDutyCD[playa] = 0;
					}
					//Wykonanie:
					if(strfind((result), "DM2", true) == -1
					&& strfind((result), "Death Match 2", true) == -1)
					{
						SetPlayerAdminJail(playa, playerid, money, result);
						if(kary_TXD_Status == 1)
						{
							AJPlayerTXD(playa, playerid, (result)); 
						}
						else if(kary_TXD_Status == 0)
						{
							format(string, sizeof(string), "AdmCmd: %s zostal uwieziony w 'AJ' przez Admina %s. Czas: %d min Powod: %s.", GetNick(playa, true), GetNick(playerid), money, (result));
							SendPunishMessage(string, playa);
						}
						return 1;
					}
			
					
					//CZYNNOŒCI - GDY NADA£ Dm2
					SetPVarInt(playerid, "DostalDM2", 1);
					sendTipMessage(playa, "Marcepan Marks mówi: Otrzyma³eœ AJ'ota z powodem DM2, za karê zabiorê twoj¹ broñ!"); 
					PlayerInfo[playa][pJailed] = 3;
					PlayerInfo[playa][pJailTime] = money*60;
					SetPlayerVirtualWorld(playa, 1000+playa);
					PlayerInfo[playa][pMuted] = 1;
					SetPlayerPosEx(playa, 1481.1666259766,-1790.2204589844,156.7875213623);
					poscig[playa] = 0;
					Log(kickLog, INFO, string);
					//Admin stats - /adminduty
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscAJ[playerid] = iloscAJ[playerid]+1;
					}
					if(kary_TXD_Status == 1)
					{
						AJPlayerTXD(playa, playerid, (result)); 
					}
					else if(kary_TXD_Status == 0)
					{
						format(string, sizeof(string), "AdmCmd: %s zostal uwieziony w 'AJ' przez Admina %s. Czas: %d min Powod: %s.", GetNick(playa, true), GetNick(playerid), money, (result));
						SendPunishMessage(string, playa);
					}
					//adminowe logi
					format(string, sizeof(string), "Admini/%s.ini", GetNick(playerid));
					dini_IntSet(string, "Ilosc_AJ", dini_Int(string, "Ilosc_AJ")+1 );
					SendClientMessage(playa, COLOR_NEWS, "SprawdŸ czy otrzymana kara jest zgodna z list¹ kar i zasad, znajdziesz j¹ na www.Mrucznik-RP.pl");
					Wchodzenie(playa);
					
					//inne
					PlayerPlaySound(playa, 1076, 0.0, 0.0, 0.0);
				
				}
				else
				{
					noAccessMessage(playerid);
				}
			}
			else
			{
				sendErrorMessage(playerid, "Ten gracz ju¿ siedzi w wiêzieniu !");
			}
		}
		else
		{
		    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			return 1;
		}
	}
	return 1;
}

