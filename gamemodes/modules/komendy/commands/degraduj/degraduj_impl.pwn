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
command_degraduj_Impl(playerid, params[256])
{
    new para1;
	if(sscanf(params, "k<fix>", para1))
	{
		sendTipMessage(playerid, "U¿yj /degraduj [playerid/CzêœæNicku]");
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
					if(PlayerInfo[para1][pRank] == 0)
					{
                        if(PlayerInfo[para1][pLider] != 0) return sendErrorMessage(playerid, "Nie mo¿esz wyrzuciæ lidera.");

                        SendClientMessage(para1, COLOR_RED, sprintf("%s zdegradowa³ Ciê. Masz ju¿ rangê 0 - zostajesz zwolniony z frakcji", GetNickEx(playerid)));

                        new str[32];
                        valstr(str, para1);
                        RunCommand(playerid, "/zwolnij",  str);
					}
					else
					{
						PlayerInfo[para1][pRank] -= 1;
						new level = PlayerInfo[para1][pRank];

                        SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Zdegradowa³eœ %s na rangê %s", GetNickEx(para1), FracRang[GetPlayerFraction(para1)][level]));
                        if(playerid != para1)
                            SendClientMessage(para1, COLOR_LIGHTBLUE, sprintf("Zosta³eœ zdegradowany na rangê %s przez %s", FracRang[GetPlayerFraction(para1)][level],  GetNickEx(playerid)));

                        MruMySQL_SetAccInt("Rank", GetNick(para1), PlayerInfo[para1][pRank]);
					}
				}
				else
				{
					sendErrorMessage(playerid, "Ten gracz nie jest w twojej frakcji!");
				}
			}
		}
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}

//end
