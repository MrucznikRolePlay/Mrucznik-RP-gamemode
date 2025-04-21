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
command_zwiaz_Impl(playerid, params[256])
{
    new string[128];
	new giveplayername[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(!IsPlayerConnected(playerid))
    {
		return 1;
	}
	if(!IsAKidnapper(playerid))
	{
		noAccessMessage(playerid);
		return 1;
	}
	if(PlayerInfo[playerid][pRank] < 2)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 2 rangi aby zwi�zywa� ludzi !");
		return 1;
	}
	if(GetPlayerJob(playerid) == JOB_DRIVER && TransportDuty[playerid] == 1)
	{
		MruMessageFail(playerid, "Nie mo�esz zwi�zywa� ludzi b�d�c taks�wkarzem!");
		return 1;
	}

	new giveplayerid;
	if( sscanf(params, "k<fix>", giveplayerid))
	{
		sendTipMessage(playerid, "U�yj /zwiaz [playerid/Cz��Nicku]");
		return 1;
	}

	if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza!");
		return 1;
	}
	if(PlayerTied[giveplayerid])
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz jest ju� zwi�zany !");
		return 1;
	}
	if (!ProxDetectorS(8.0, playerid, giveplayerid))
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
		return 1;
	}
	if(giveplayerid == playerid)
	{ 
		sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz zwi�za� samego siebie!"); 
		return 1; 
	}
	new car = GetPlayerVehicleID(playerid);
	if(!(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == 2 && IsPlayerInVehicle(giveplayerid, car)))
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Gracz nie jest w twoim wozie / nie jeste� kierowc� !");
		return 1;
	}

	GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
	GetPlayerName(playerid, sendername, sizeof(sendername));

	format(string, sizeof(string), "* Zosta�e� zwi�zany przez %s.", sendername);
	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "* Zwi�za�e� %s tak aby nie m�g� si� rozwi�za�.", giveplayername);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "* %s wyci�ga lin� i zwi�zuje %s aby nigdzie nie uciek�.", sendername, giveplayername);
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	GameTextForPlayer(giveplayerid, "~r~Zwiazany", 2500, 3);

	TogglePlayerControllable(giveplayerid, 0);
	PlayerTied[giveplayerid] = true;
	PlayerTiedTime[giveplayerid] = 5*60;
	isBeatenUp[giveplayerid] = false;

	return 1;
}

//end
