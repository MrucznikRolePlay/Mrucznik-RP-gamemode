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
command_adminjail_Impl(playerid, params[256])
{
    new string[128];

    if(IsPlayerConnected(playerid))
    {
		new playa, money, result[64];
		if( sscanf(params, "k<fix>ds[64]", playa, money, result))
		{
			sendTipMessage(playerid, "U�yj /aj [id/nick] [czas(w minutach)] [powod]");
			return 1;
		}
		if (money < 0) {
			sendErrorMessage(playerid, "Czas nie mo�e by� ujemny!");
			return 1;
		}
		if(IsPlayerConnected(playa) && playa != INVALID_PLAYER_ID)
		{
			if (PlayerInfo[playa][pJailed] == 0)
			{
				if (PlayerInfo[playerid][pAdmin] >= 1 || IsAZasluzony(playerid) || (PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3) || IsAScripter(playerid) || IsAZaufanyGracz(playerid))
				{
					if(PlayerInfo[playa][pAdmin] > 0 || PlayerInfo[playa][pNewAP] > 0)
					{
						sendTipMessage(playerid, "Nie mo�esz dawa� /aj administratorowi!");
						return 1;
					}
					if(OnDuty[playa] == 1 || OnDutyCD[playa] == 1)
					{
					    OnDuty[playa] = 0;
						SecretAgent[playa] = 0;
					    OnDutyCD[playa] = 0;
						RmvLSPDMemberFromThiefMapIcons(playa);
					}
					//Wykonanie:
					if(strfind((result), "DM2", true) == -1
					&& strfind((result), "Death Match 2", true) == -1)
					{
						SetPlayerAdminJail(playa, playerid, money, result);
						if(kary_TXD_Status == 1)
						{
							AJPlayerTXD(playa, playerid, (result), money); 
						}
						else if(kary_TXD_Status == 0)
						{
							format(string, sizeof(string), "AdmCmd: %s zostal uwieziony w 'AJ' przez Admina %s. Czas: %d min Powod: %s.", GetNick(playa), GetNickEx(playerid), money, (result));
							SendPunishMessage(string, playa);
						}
						return 1;
					}
			
					
					//CZYNNO�CI - GDY NADA� Dm2
					SetPVarInt(playa, "DostalDM2", 1);
					sendTipMessage(playa, "Marcepan Marks m�wi: Otrzyma�e� AJ'ota z powodem DM2, za kar� zabior� twoj� bro�!"); 
					PlayerInfo[playa][pJailed] = 3;
					PlayerInfo[playa][pJailTime] = money*60;
					SetPlayerVirtualWorld(playa, 1000+playa);
					PlayerInfo[playa][pMuted] = 1;
					SetPlayerPos(playa, AJ_POSX, AJ_POSY, AJ_POSZ);
					poscig[playa] = 0;
					Log(punishmentLog, INFO, "Admin %s ukara� %s kar� AJ %d minut, pow�d: %s", 
						GetPlayerLogName(playerid),
						GetPlayerLogName(playa),
						money,
						result);
					//Admin stats - /adminduty
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscAJ[playerid]++;
					}
					else if(GetPlayerAdminDutyStatus(playerid) == 0)
					{
						iloscPozaDuty[playerid]++; 
					}
					if(kary_TXD_Status == 1)
					{
						AJPlayerTXD(playa, playerid, (result), money); 
					}
					else if(kary_TXD_Status == 0)
					{
						format(string, sizeof(string), "AdmCmd: %s zostal uwieziony w 'AJ' przez Admina %s. Czas: %d min Powod: %s.", GetNickEx(playa), GetNickEx(playerid), money, (result));
						SendPunishMessage(string, playa);
					}
					//adminowe logi
					format(string, sizeof(string), "Admini/%s.ini", GetNickEx(playerid));
					dini_IntSet(string, "Ilosc_AJ", dini_Int(string, "Ilosc_AJ")+1 );
					SendClientMessage(playa, COLOR_NEWS, "Sprawd� czy otrzymana kara jest zgodna z list� kar i zasad, znajdziesz j� na www.Mrucznik-RP.pl");
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
				sendErrorMessage(playerid, "Ten gracz ju� siedzi w wi�zieniu !");
			}
		}
		else
		{
		    sendErrorMessage(playerid, "Nie ma takiego gracza!");
			return 1;
		}
	}
	return 1;
}

//end
