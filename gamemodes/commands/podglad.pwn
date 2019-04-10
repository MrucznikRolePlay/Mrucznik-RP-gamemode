//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ podglad ]------------------------------------------------//
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

CMD:podglad(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /podglad [playerid/CzêœæNicku]");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
		            GetPlayerName(para1, giveplayer, sizeof(giveplayer));
		            if(PlayerInfo[para1][pPodPW] == 0)
					{
                        SendCommandLogMessage(sprintf("Admin %s [%d] w³¹czy³ podgl¹d dla %s [%d]", GetNick(playerid), playerid, GetNick(para1), para1));

						PlayerInfo[para1][pPodPW] = 1;

                        format(string, sizeof(string), "AdmCmd: %s wlaczyl podglad PW %s",GetNick(playerid) ,giveplayer);
                        CMDLog(string);
					}
					else
					{
                        SendCommandLogMessage(sprintf("Admin %s [%d] wy³¹czy³ podgl¹d dla %s [%d]", GetNick(playerid), playerid, GetNick(para1), para1));
						PlayerInfo[para1][pPodPW] = 0;
					}
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
