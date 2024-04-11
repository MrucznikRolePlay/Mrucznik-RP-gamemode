//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ makemember ]----------------------------------------------//
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

YCMD:makemember(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /makemember [ID gracza] [Numer (1-17)]");
			return 1;
		}

		if(level > 17 || level < 0) { SendClientMessage(playerid, COLOR_GREY, "Od 0 do 17 !"); return 1; }
		if (PlayerInfo[playerid][pAdmin] >= 1 || Uprawnienia(playerid, ACCESS_MAKELEADER) || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
		            if(GetPlayerFraction(para1) > 0 || GetPlayerOrg(para1) != 0)
		            {
		                sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz ma ju¿ prace !");
		                return 1;
		            }
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					PlayerInfo[para1][pMember] = level;
					format(string, sizeof(string), "Zosta³eœ mianowany pracownikiem frakcji numer %d przez Administratora: %s", level,GetNickEx(playerid));
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "Da³eœ membera graczowi %s nad frakcj¹ numer %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					
					//logi
            		Log(adminLog, INFO, "Admin %s da³ graczowi %s cz³onka frakcji %s", GetPlayerLogName(playerid), GetPlayerLogName(para1), GetFractionLogName(level));
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
					
					SetDefaultUniform(para1);

                    MruMySQL_SetAccInt("Member", giveplayer, level);
                    MruMySQL_SetAccInt("Rank", giveplayer, 0);

                    PlayerInfo[para1][pRank] = 0;
				}
			}//not connected
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
