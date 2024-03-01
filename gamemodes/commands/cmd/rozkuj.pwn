//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ rozkuj ]------------------------------------------------//
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

YCMD:rozkuj(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
    {
		return 1;
	}
	if(!(IsAPolicja(playerid) || IsABOR(playerid) || PlayerInfo[playerid][pAdmin] >= 1))
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz kluczy do kajdanek!");
	}

	new giveplayerid;
	if( sscanf(params, "k<fix>", giveplayerid))
	{
		sendTipMessage(playerid, "U¿yj /rozkuj [playerid/CzêœæNicku]");
		return 1;
	}

	if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza !");
		return 1;
	}
	if(!ProxDetectorS(8.0, playerid, giveplayerid))
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
	}
	if(giveplayerid == playerid && !PlayerInfo[playerid][pAdmin] >= 1) 
	{ 
		sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz odkuæ samego siebie!"); 
		return 1; 
	}

	if(!isPlayerCuffed[giveplayerid] && !PlayerTied[giveplayerid])
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest skuty !");
		return 1;
	}

	new string[128];
	format(string, sizeof(string), "* Zosta³eœ rozkuty przez %s.", GetNick(playerid));
	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "* Rozku³eœ %s.", GetNick(giveplayerid));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	GameTextForPlayer(giveplayerid, "~g~Rozkuty", 2500, 3);

	TogglePlayerControllable(giveplayerid, 1);
	PlayerTied[giveplayerid] = false;
	PlayerTiedTime[giveplayerid] = 0;
	isPlayerCuffed[giveplayerid] = 0;
	whoIsCuffedBy[giveplayerid] = 0;
	isPlayerUsingCuffs[giveplayerid] = 0;
	isPlayerUsingCuffs[playerid] = 0;
	whoIsCuffing[playerid] = 0;
	whoIsCuffing[giveplayerid]=0;
	PlayerInfo[giveplayerid][pMuted] = 0;
	ClearAnimations(giveplayerid);
	SetPlayerSpecialAction(giveplayerid,SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(giveplayerid, 5);

	return 1;
}
