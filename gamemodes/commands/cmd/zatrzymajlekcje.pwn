//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------[ zatrzymajlekcje ]--------------------------------------------//
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

YCMD:zatrzymajlekcje(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new Float:px, Float:py, Float:pz;

    if(IsPlayerConnected(playerid))
    {
        if(IsAnInstructor(playerid))
        {
            new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
			    sendTipMessage(playerid, "U¿yj /stoplekcja [playerid/CzêœæNicku]");
			    return 1;
			}

			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(TakingLesson[giveplayerid] != 1)
			        {
			            sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie zacz¹³ lekcji !");
			            return 1;
			        }
			        GetPlayerName(playerid, sendername, sizeof(sendername));
			        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			        format(string, sizeof(string), "* Zakonczy³eœ egzamin z %s.",giveplayer);
			        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			        format(string, sizeof(string), "* Urzêdnik %s zakoñczy³ z tob¹ egzamin.",sendername);
			        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
			        TakingLesson[giveplayerid] = 0;
			        PlayerInfo[giveplayerid][pCarLic] = 2;
					GetPlayerPos(giveplayerid, px, py, pz); 
					SetPlayerPos(giveplayerid, px, py, pz+3);
			    }
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			    return 1;
			}
        }
        else
        {
            sendErrorMessage(playerid, "Nie jesteœ instruktorem !");
            return 1;
        }
    }
    return 1;
}
