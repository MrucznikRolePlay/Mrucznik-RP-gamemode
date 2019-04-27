//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ gotowane ]-----------------------------------------------//
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



CMD:gotowane(playerid)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
        SendClientMessage(playerid, COLOR_WHITE, "|__________________ Gotowanie __________________|");
        format(string, sizeof(string), "** (1) Potrawa: %s.   Waga: %d.", Cooking[playerid][pCook1], Cooking[playerid][pCWeight1]);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "** (2) Potrawa: %s.   Waga: %d.", Cooking[playerid][pCook2], Cooking[playerid][pCWeight2]);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "** (3) Potrawa: %s.   Waga: %d.", Cooking[playerid][pCook3], Cooking[playerid][pCWeight3]);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "** (4) Potrawa: %s.   Waga: %d.", Cooking[playerid][pCook4], Cooking[playerid][pCWeight4]);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "** (5) Potrawa: %s.   Waga: %d.", Cooking[playerid][pCook5], Cooking[playerid][pCWeight5]);
		SendClientMessage(playerid, COLOR_GREY, string);
		SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________|");
	}
    return 1;
}

