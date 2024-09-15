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
command_wrzuc_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(!IsAPrzestepca(playerid))
    {
        return sendErrorMessage(playerid, "Nie mo¿esz tego zrobiæ!");
	}
	
	new person, seat4;
	if(sscanf(params, "k<fix>d", person, seat4) || seat4 < 1 || seat4 > 3)
	{
		return sendTipMessage(playerid, "U¿yj /wepchnij [ID Gracza] [miejsce 1-3]");
	}

	if(!IsPlayerConnected(person))
	{
		return sendErrorMessage(playerid, "Nie ma takiego gracza.");
	}
	if (GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
	{
		return sendTipMessage(playerid, "Musisz byæ w pojeŸdzie.");
	}
	if (IsPlayerInAnyVehicle(person))
	{
		return sendTipMessage(playerid, "Gracz nie mo¿e znajdowaæ siê w pojeŸdzie.");
	}
	if (!ProxDetectorS(5.0, playerid, person))
	{
		return sendErrorMessage(playerid, "Gracz nie jest w pobli¿u.");
	}
	if(!isBeatenUp[person] && PlayerInfo[person][pBW] == 0 && PlayerInfo[person][pInjury] == 0)
	{
		return sendTipMessage(playerid, "Gracz nie jest pobity ani ranny!");
	}

	GetPlayerName(person, giveplayer, sizeof(giveplayer));
	GetPlayerName(playerid, sendername, sizeof(sendername));

	format(string, sizeof(string), "* Zosta³eœ wrzucony do pojazdu przez %s.", sendername);
	SendClientMessage(person, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "* Wrzuci³eœ do pojazdu %s.", giveplayer);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "* %s zwi¹za³ i wrzuci³ do pojazdu %s.", sendername ,giveplayer);
	ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	sendTipMessage(playerid, "Po trzech minutach osoba zostanie rozwi¹zana!");
	sendTipMessage(person, "Po trzech minutach zostaniesz rozwi¹zany!");
	SetPlayerChatBubble(person, " ", 0xFF0000FF, 70.0, 1000);
	GameTextForPlayer(person, "~r~Wrzucony do wozu", 2500, 3);

	ZdejmijBW(person);
	TogglePlayerControllable(person, 1);
	PutPlayerInVehicleEx(person, GetPlayerVehicleID(playerid), seat4);
	TogglePlayerControllable(person, 0);
	PlayerTied[person] = true;
	PlayerTiedTime[person] = 180;
	isBeatenUp[person] = false;
	
	return 1;
}

//end
