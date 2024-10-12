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
command_forceskin_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /forceskin [playerid/CzêœæNicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
			        if(PlayerInfo[para1][pMember] < 1)
			        {
			            sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest we frakcji !");
			            return 1;
			        }
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "* Zosta³eœ wybrany do zmiany skinu przez Administratora %s.", GetNickEx(playerid));
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Wymusi³eœ zmiane skinu na %s.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					NowaWybieralka_Setup(para1);
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
