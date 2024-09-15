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
command_kradnij_Impl(playerid, params[256])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
   	    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
   	    {
			new vehicleid = GetPlayerVehicleID(playerid);
            if(Car_IsValid(vehicleid) && !Car_IsStealable(vehicleid))
            {
                return sendTipMessageEx(playerid, COLOR_GRAD2, "Tego pojazdu nie da siê ukraœæ, poniewa¿ jest z wypo¿yczalni!");
            }
			
			if(NieSpamujKradnij[playerid] == 0)
			{
				if(KradniecieWozu[playerid] > 1 && vehicleid == KradniecieWozu[playerid])
				{
					sendErrorMessage(playerid, "Ju¿ ukrad³eœ ten wóz.");
					return 1;
				}
				
				new skillz;
				if(PlayerInfo[playerid][pJackSkill] < 50)
				{
					skillz = 1;
				}
				else if(PlayerInfo[playerid][pJackSkill] >= 50 && PlayerInfo[playerid][pJackSkill] <= 99)
				{
					skillz = 2;
				}
				else if(PlayerInfo[playerid][pJackSkill] >= 100 && PlayerInfo[playerid][pJackSkill] <= 199)
				{
					skillz = 3;
				}
				else if(PlayerInfo[playerid][pJackSkill] >= 200 && PlayerInfo[playerid][pJackSkill] <= 399)
				{
					skillz = 4;
				}
				else if(PlayerInfo[playerid][pJackSkill] >= 400)
				{
					skillz = 5;
				}
				new kradnij = random(100);
				new mnoznik = skillz*19;

				#if defined _ZLODZIEJ_AUT
					new Float:modelMultiplier = GetStealChanceMultiplier(vehicleid);
					mnoznik = floatround(float(mnoznik) * modelMultiplier);
				#endif

				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string),"* %s wyci¹ga m³otek i rozwala os³onkê po czym wyjmuje 2 kabelki.", sendername);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				NieSpamujKradnij[playerid] = 1;
				new timer;
				if(kradnij < 98 && kradnij <= mnoznik)
				{
					timer = SetTimerEx("udalo1",6000,0,"d",playerid);
					KradniecieWozu[playerid] = 1;
				}
				else
				{
					timer = SetTimerEx("nieudalo1",6000,0,"d",playerid);
					KradniecieWozu[playerid] = 1;
				}
				SetPVarInt(playerid, "timerKradnij", timer);
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Ju¿ próbujesz ukraœæ wóz !");
			}
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w pojeŸdzie !");
		}
	}//not connected
	return 1;
}

//end
