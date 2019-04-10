//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ dajpomocnika ]---------------------------------------------//
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

CMD:dajpomocnika(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

	new para1, level;
	if( sscanf(params, "k<fix>d", para1, level))
	{
		sendTipMessage(playerid, "U¿yj /dajpomocnika [playerid/CzêœæNicku] [level(1-3)]");
		return 1;
	}

	GetPlayerName(para1, giveplayer, sizeof(giveplayer));
	GetPlayerName(playerid, sendername, sizeof(sendername));
    if(!Uprawnienia(playerid, ACCESS_GIVEHALF)) return noAccessMessage(playerid);
    if(IsPlayerConnected(para1))
    {
        if(para1 != INVALID_PLAYER_ID)
        {
            if(level == 0 || level == 1 || level == 2 || level == 3 || level == 4)
            {

				PlayerInfo[para1][pNewAP] = level;
				format(string, sizeof(string), "AdmCmd: %s mianowal %s na %d level poladmina.", sendername, giveplayer, level);
				CKLog(string);
				format(string, sizeof(string), "Zosta³eœ mianowany na %d level pó³admina przez %s", level, sendername);
				SendClientMessage(para1, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "Da³eœ %s pó³admina o levelu %d.", giveplayer,level);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            }
			else
			{
				sendTipMessageEx(playerid, COLOR_NEWS, "Level od 1 do 4!");
			}
		}
	}
	return 1;
}
