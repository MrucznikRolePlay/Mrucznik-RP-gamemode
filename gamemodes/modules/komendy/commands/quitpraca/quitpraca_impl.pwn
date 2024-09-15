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
command_quitpraca_Impl(playerid)
{
    new string[128];

    if(IsPlayerConnected(playerid))
   	{
		new job = PlayerInfo[playerid][pJob];
	    if(job > 0)
	    {
	        if(IsPlayerPremiumOld(playerid))
	        {
	            if(PlayerInfo[playerid][pContractTime] >= 2)
				{
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wype³ni³eœ 1 godzinny kontrakt wiêc mo¿esz zwolniæ siê z pracy.");
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zwolni³eœ siê ze swojej pracy, jesteœ bezrobotny.");
				    PlayerInfo[playerid][pJob] = 0;
				    PlayerInfo[playerid][pUniform] = 0;
				    PlayerInfo[playerid][pContractTime] = 0;
				}
				else
				{
				    new chours = 2 - PlayerInfo[playerid][pContractTime];
				    format(string, sizeof(string), "* Masz jeszcze %d godzin do koñca kontraktu, dopiero wtedy bedziesz móg³ siê zwolniæ.", chours / 2);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					return 1;
				}
	        }
	        else
	        {
				if(PlayerInfo[playerid][pContractTime] >= 3)
				{
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wype³ni³eœ 2.5 godzinny kontrakt wiêc mo¿esz zwolniæ siê z pracy.");
				    PlayerInfo[playerid][pJob] = 0;
				    PlayerInfo[playerid][pUniform] = 0;
				    PlayerInfo[playerid][pContractTime] = 0;
				}
				else
				{
				    new chours = 10 - PlayerInfo[playerid][pContractTime];
				    format(string, sizeof(string), "* Masz jeszcze %d godzin do koñca kontraktu, dopiero wtedy bedziesz móg³ siê zwolniæ.", chours / 2);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					return 1;
				}
			}
			
			Log(serverLog, INFO, "Gracz %s opuœci³ pracê %d.", GetPlayerLogName(playerid), job);
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie masz pracy (jeœli jesteœ we frakcji wpisz /quitfrakcja) !");
		}
	}//not connected
	return 1;
}

//end
