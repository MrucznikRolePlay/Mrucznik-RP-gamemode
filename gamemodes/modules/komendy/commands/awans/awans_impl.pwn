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
command_awans_Impl(playerid, params[256])
{
    new para1;
	if(sscanf(params, "k<fix>", para1))
	{
		sendTipMessage(playerid, "U¿yj /awans [playerid/CzêœæNicku]");
		return 1;
	}
	if (PlayerInfo[playerid][pLider] >= 1)
	{
		if(IsPlayerConnected(para1))
		{
			if(para1 != INVALID_PLAYER_ID)
			{
				if(PlayerInfo[playerid][pLider] == PlayerInfo[para1][pMember] || PlayerInfo[playerid][pLider] == PlayerInfo[para1][pLider])
				{
                    new rang = PlayerInfo[para1][pRank];
                    if(rang == 9) return 1;
                    if(strlen(FracRang[GetPlayerFraction(playerid)][rang+1]) < 1) return SendClientMessage(playerid, COLOR_LIGHTBLUE, "Ta ranga nie jest stworzona!");

					PlayerInfo[para1][pRank] += 1;
					new level = PlayerInfo[para1][pRank];

                    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Awansowa³eœ %s na rangê %s", GetNickEx(para1), FracRang[GetPlayerFraction(para1)][level]));
                    if(playerid != para1)
                        SendClientMessage(para1, COLOR_LIGHTBLUE, sprintf("Gratulacje! Otrzyma³eœ awans na rangê %s od %s", FracRang[GetPlayerFraction(para1)][level],  GetNickEx(playerid)));

                    MruMySQL_SetAccInt("Rank", GetNick(para1), PlayerInfo[para1][pRank]);
				}
				else
				{
					sendErrorMessage(playerid, "Ten gracz nie jest w twojej frakcji!");
				}
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza!");
		}
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}

//end
