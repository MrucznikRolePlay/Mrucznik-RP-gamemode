//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_rozwiaz_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(!IsPlayerConnected(playerid))
    {
		return 1;
	}
	if(PlayerInfo[playerid][pAdmin] < 1)
	{
		if(!IsAKidnapper(playerid))
		{
			noAccessMessage(playerid);
			return 1;
		}
		if(PlayerInfo[playerid][pRank] < 2)
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Musisz mie� 2 lub wy�sz� rang�, aby kogo� rozwi�za� !");
			return 1;
		}
	}

	new giveplayerid;
	if( sscanf(params, "k<fix>", giveplayerid))
	{
		sendTipMessage(playerid, "U�yj /odwiaz [playerid/Cz��Nicku]");
		return 1;
	}

	if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza!");
		return 1;
	}
	if (!ProxDetectorS(8.0, playerid, giveplayerid))
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
		return 1;
	}
	if(!PlayerTied[giveplayerid])
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest zwi�zany !");
		return 1;
	}
	if(giveplayerid == playerid && !PlayerInfo[playerid][pAdmin] >= 1) 
	{ 
		sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz rozwi�za� sam siebie!"); 
		return 1; 
	}

	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
	GetPlayerName(playerid, sendername, sizeof(sendername));

	format(string, sizeof(string), "* Zosta�e� odwi�zany przez %s.", sendername);
	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "* Odwi�za�e� %s.", giveplayer);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	GameTextForPlayer(giveplayerid, "~g~Wolnosc", 2500, 3);
	
	TogglePlayerControllable(giveplayerid, 1);

	PlayerTied[giveplayerid] = false;
	isBeatenUp[giveplayerid] = false;
	PlayerTiedTime[giveplayerid] = 0;

	return 1;
}

//end
