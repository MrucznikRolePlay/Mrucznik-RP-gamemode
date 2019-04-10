//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zmienwl ]------------------------------------------------//
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

CMD:setwl(playerid, params[]) return cmd_zmienwl(playerid, params);
CMD:zmienwl(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /setwl [playerid/CzêœæNicku] [iloœæ wl]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 100)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(level > 10 || level < 0)
				{
					sendTipMessage(playerid, "Numer WL od 0 do 10!"); return 1;
				}
		        if(para1 != INVALID_PLAYER_ID)
		        {
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PoziomPoszukiwania[para1] = level;
					printf("AdmCmd: %s zmieni³ wanted level gracza %s na wartoœæ %d.", sendername, giveplayer, level);
					format(string, sizeof(string), "   Twój Poziom Poszukiwania zosta³ zmieniony na %d przez admina %s", level, sendername);
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "   Zmieni³eœ poziom poszukiwania %s na %d.", giveplayer,level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
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
