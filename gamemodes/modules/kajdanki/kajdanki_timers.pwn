//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                  kajdanki                                                 //
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
// Autor: NikodemBanan
// Data utworzenia: 01.03.2024
//Opis:
/*
	Uporz¹dkowany system kajdanek.
*/

//

//-----------------<[ Timery: ]>-------------------
public CuffedAction(playerid, cuffedid)
{
	new message_s[64];

	format(message_s, sizeof(message_s), "Sku³eœ %s.", GetNick(cuffedid));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, message_s);

	GameTextForPlayer(cuffedid, "~r~SKUTY", 2500, 3);

	ClearAnimations(cuffedid);
	SetPlayerSpecialAction(cuffedid, SPECIAL_ACTION_CUFFED);
	SetPlayerAttachedObject(cuffedid, CUFF_ATTACH_OBJ_IDX, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977,-81.700035, 0.891999, 1.000000, 1.168000);
	
	isPlayerCuffed[cuffedid] = true;
	isPlayerUsingCuffs[playerid] = true;
	whoIsCuffing[cuffedid] = playerid;
	whoIsCuffedBy[playerid] = cuffedid;

	return 1;
}

//end