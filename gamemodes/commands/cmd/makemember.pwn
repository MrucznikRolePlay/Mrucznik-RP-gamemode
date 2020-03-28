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
		if (PlayerInfo[playerid][Admin] >= 1000 || Uprawnienia(playerid, ACCESS_MAKELEADER) || IsAScripter(playerid))
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
            		Log(adminLog, INFO, "Admin %s da³ graczowi %s cz³onka frakcji %d", GetPlayerLogName(playerid), GetPlayerLogName(para1), level);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
					
					if(level == 0) { PlayerInfo[para1][pUniform] = 0; }
					else if(level == 1) { PlayerInfo[para1][pUniform] = 280; } //Police Force
					else if(level == 2) { PlayerInfo[para1][pUniform] = 285; } //FBI/ATF
					else if(level == 3) { PlayerInfo[para1][pUniform] = 287; } //National Guard
					else if(level == 4) { PlayerInfo[para1][pUniform] = 70; } //Fire/Ambulance
					else if(level == 5) { PlayerInfo[para1][pUniform] = 258; } //La Cosa Nostra
					else if(level == 6) { PlayerInfo[para1][pUniform] = 120; } //Yakuza
					else if(level == 7) { PlayerInfo[para1][pUniform] = 240; } //Mayor
					else if(level == 8) { PlayerInfo[para1][pUniform] = 127; } //Hitman Agency
					else if(level == 9) { PlayerInfo[para1][pUniform] = 148; } //News Reporters
					else if(level == 10) { PlayerInfo[para1][pUniform] = 255; } //Taxi Cab Company
					else if(level == 11) { PlayerInfo[para1][pUniform] = 59; } //Driving/Flying School
					else if(level == 12) { PlayerInfo[para1][pUniform] = 270; } //Grove Street
					else if(level == 13) { PlayerInfo[para1][pUniform] = 103; } //Ballas
					else if(level == 14) { PlayerInfo[para1][pUniform] = 108; } //Vagos
					else if(level == 15) { PlayerInfo[para1][pUniform] = 8; } //NoA
                    else if(level == 17) PlayerInfo[para1][pUniform] = 277; //NoA
				    gTeam[para1] = 19;
				    PlayerInfo[para1][pTeam] = 19;

                    MruMySQL_SetAccInt("Member", giveplayer, level);
                    MruMySQL_SetAccInt("Rank", giveplayer, 0);

                    PlayerInfo[para1][Rank] = 0;
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
