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
command_nazywo_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
		{
		    if(TalkingLive[playerid] != INVALID_PLAYER_ID)
		    {
		        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wywiad zakonczony.");
		        SendClientMessage(TalkingLive[playerid], COLOR_LIGHTBLUE, "* Wywiad zakoñczony.");
	            TalkingLive[TalkingLive[playerid]] = INVALID_PLAYER_ID;
                TalkingLive[playerid] = INVALID_PLAYER_ID;
		        return 1;
		    }
			
			new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /wywiad [playerid/CzêœæNicku]");
				return 1;
			}
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				sendErrorMessage(playerid, "Nie mo¿esz dawaæ wywiadu podczas @Duty!");
				return 1;
			}
			if(GetPlayerAdminDutyStatus(giveplayerid) == 1)
			{
				sendErrorMessage(playerid, "Ta osoba jest podczas s³u¿by administratora!");
				return 1;
			}


			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if (ProxDetectorS(5.0, playerid, giveplayerid) || Mobile[playerid] == giveplayerid)
					{
					    if(giveplayerid == playerid) { SendClientMessage(playerid, COLOR_GREY, "Nie mo¿esz robiæ wywiadu z samym sob¹!"); return 1; }
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* Oferujesz %s wywiad na ¿ywo.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s chce z tob¹ przeprowadziæ wywiad, wpisz (/akceptuj wywiad) aby akceptowaæ.", sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						LiveOffer[giveplayerid] = playerid;
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Jesteœ za daleko od tego gracza.");
					    sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz przeprowadziæ wywiad telefoniczny dzwoni¹c do gracza i oferuj¹c mu wywiad komend¹ /wywiad.");
					    return 1;
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza!");
			    return 1;
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ Reporterem !");
		}
	}
	return 1;
}

//end
