//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------[ personalizuj ]-----------------------------------------------//
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

YCMD:personalizuj(playerid, params[], help) 
{
	if(IsPlayerConnected(playerid))
	{
		new string[256]; 
		new persona_A[64]; 
		if(PlayerPersonalization[playerid][PERS_KB] == 1)
		{
			format(persona_A, sizeof(persona_A), "Konto Bankowe\t{FF6A6A}OFF");
		}
		else if(PlayerPersonalization[playerid][PERS_KB] == 0)
		{
			format(persona_A, sizeof(persona_A), "Konto Bankowe\t{80FF00}ON");
		}
		new persona_B[64];
		if(PlayerPersonalization[playerid][PERS_CB] == 1)
		{
			format(persona_A, sizeof(persona_A), "CB-RADIO\t{FF6A6A}OFF");
		}
		else if(PlayerPersonalization[playerid][PERS_KB] == 0)
		{
			format(persona_A, sizeof(persona_A), "CB-RADIO\t{80FF00}ON");
		}
		format(string, sizeof(string), "%s\n\%s", persona_A, persona_B);
		ShowPlayerDialogEx(playerid, D_PERSONALIZE, DIALOG_STYLE_TABLIST, "Mrucznik Role Play", string, "Akceptuj", "Wyjdz");
	}
	return 1;
}