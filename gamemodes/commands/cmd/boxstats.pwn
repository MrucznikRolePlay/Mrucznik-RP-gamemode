//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ boksstats ]-----------------------------------------------//
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

YCMD:boxstats(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pJob] != 12)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ bokserem !");
            return 1;
        }
        new ttext[20];//Title
        new clevel = PlayerInfo[playerid][pBoxSkill];
		if(clevel >= 0 && clevel <= 50) { ttext = "Cienias"; }
		else if(clevel >= 51 && clevel <= 200) { ttext = "Amator"; }
		else if(clevel >= 201 && clevel <= 400) { ttext = "Profesionalista"; }
		else if(clevel >= 401 && clevel <= 800) { ttext = "Hardkorowiec"; }
		else if(clevel >= 801 && clevel <= 999) { ttext = "Czempion"; }
        new ntext[20];//NickName
        new level = PlayerInfo[playerid][pWins];
        if(level > 0 && PlayerInfo[playerid][pLoses] == 0)
        {
            ntext = "Niepokonany";
        }
        else
        {
            if(level >= 0 && level <= 10) { ntext = "Noobek"; }
            else if(level >= 11 && level <= 20) { ntext = "Koks"; }
            else if(level >= 21 && level <= 30) { ntext = "Twardziel"; }
            else if(level >= 31 && level <= 40) { ntext = "Nakurwiator"; }
            else if(level >= 41 && level <= 50) { ntext = "£amiczaha"; }
            else if(level >= 51 && level <= 60) { ntext = "Hardcorowy Koksu"; }
            else if(level >= 61 && level <= 70) { ntext = "Kox przez X"; }
            else if(level >= 71) { ntext = "Rambo"; }
        }
        SendClientMessage(playerid, COLOR_WHITE, "|__________________ Rekord boksu __________________|");
        format(string, sizeof(string), "| Obecny mistrz: %s, [%d] Wygrane [%d] Przegrane.", Titel[TitelName],Titel[TitelWins],Titel[TitelLoses]);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "| Obecny tytu³: %s.", ttext);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "| Obecne pseudonim: %s.", ntext);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "| Wszystkich wygranych: %d.", PlayerInfo[playerid][pWins]);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "| Wszystkich przegranych: %d.", PlayerInfo[playerid][pLoses]);
		SendClientMessage(playerid, COLOR_GREY, string);
        SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________________|");
	}
	return 1;
}
