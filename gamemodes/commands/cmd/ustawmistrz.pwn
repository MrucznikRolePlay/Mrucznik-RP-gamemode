//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ ustawmistrz ]----------------------------------------------//
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

YCMD:ustawmistrz(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 50)
        {
            new  giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /ustawmistrz [playerid/CzêœæNicku]");
				return 1;
			}


	        if(IsPlayerConnected(giveplayerid))
	        {
	            if(giveplayerid != INVALID_PLAYER_ID)
	            {
	                GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	                new nstring[MAX_PLAYER_NAME];
					format(nstring, sizeof(nstring), "%s", giveplayer);
					strmid(Titel[TitelName], nstring, 0, strlen(nstring));
					Titel[TitelWins] = PlayerInfo[giveplayerid][pWins];
					Titel[TitelLoses] = PlayerInfo[giveplayerid][pLoses];
					SaveBoxer();
					format(string, sizeof(string), "* Mianowa³eœ %s nowym mistrzem bokserskim.", giveplayer);
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string);
	            }
	        }
	        else
	        {
	            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma takiego gracza !");
	            return 1;
	        }
        }
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
