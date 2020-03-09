//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ anulujzp ]-----------------------------------------------//
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

YCMD:anulujzp(playerid, params[], help) 
{
    if(PlayerInfo[playerid][pAdmin] >= 5) 
	{
        new giveid, gracznick[MAX_PLAYER_NAME];
		
        if(sscanf(params, "k<fix>", giveid)) 
			return sendTipMessage(playerid, "U¿yj /anulujzp [czêœæ nicku/id]"); 
			
        if(PlayerInfo[giveid][pCarLic] == 0 || PlayerInfo[giveid][pCarLic] == 1) 
		{
            return sendErrorMessage(playerid, "Ten gracz nie posiada zabranego prawa jazdy!");
        }
        PlayerInfo[giveid][pPK] = 0;
        PlayerInfo[giveid][pCarLic] = 0;
        GetPlayerName(giveid, gracznick, MAX_PLAYER_NAME);
        new string[128];
        format(string, sizeof(string), "Admin %s zlikwidowa³ Twoj¹ blokadê na prawo jazdy!", GetNickEx(playerid));
        sendTipMessage(giveid, string, COLOR_LIGHTBLUE);
        format(string, sizeof(string), "Zlikwidowa³eœ %s blokadê na prawo jazdy!", gracznick);
        sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
    } 
	else 
	{
        noAccessMessage(playerid);
    }
    return 1;
}
