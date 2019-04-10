//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ zdejmijkevlar ]---------------------------------------------//
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

CMD:wyrzuckami(playerid) return cmd_zdejmijkevlar(playerid);
CMD:zdejmijkami(playerid) return cmd_zdejmijkevlar(playerid);
CMD:zdejmijkevlar(playerid)
{
    if(IsPlayerConnected(playerid))
    {
            new string[64], sendername[MAX_PLAYER_NAME];
            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string),"%s zdejmuje kevlar i rzuca go na ziemie", sendername);
            ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            RemovePlayerAttachedObject(playerid, 7);
            SetPlayerArmour(playerid, 0);
    }
    return 1;
}

