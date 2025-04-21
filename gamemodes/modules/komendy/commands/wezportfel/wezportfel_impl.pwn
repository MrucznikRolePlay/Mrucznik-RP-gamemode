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
command_wezportfel_Impl(playerid, params[256])
{
    if(!IsAPrzestepca(playerid))
	{
		sendErrorMessage(playerid, "Nie jeste� cz�onkiem organizacji!");
		return 1;
	}
	if(PlayerInfo[playerid][pRank] < 2)
	{
		sendTipMessage(playerid, "Potrzebujesz rangi 2 lub wy�szej, �eby m�c zabiera� pieni�dze!");
		return 1;
	}

	new giveplayerid;
	if(sscanf(params, "k<fix>", giveplayerid))
	{
		sendTipMessage(playerid, "U�yj /wezportfel [id/nick]");
		return 1;
	}

	if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza!");
		return 1;
	}
	if(!(PlayerTied[giveplayerid] || PlayerInfo[giveplayerid][pBW] > 0 || PlayerInfo[giveplayerid][pInjury] > 0))
	{
		sendTipMessage(playerid, "Ta osoba nie jest zwi�zana lub nie ma BW/nie jest ranna!");
		return 1;
	}
	if(!PlayerTied[giveplayerid])
	{
		sendTipMessage(playerid, "Gracz musi by� zwi�zany.");
		return 1;
	}
	if(!ProxDetectorS(8.0, playerid, giveplayerid))
	{
		sendErrorMessage(playerid, "Ten gracz nie jest w pobli�u Ciebie !");
		return 1;
	}
	if(isPlayerCuffed[playerid] || PlayerTied[playerid] ||  PlayerInfo[playerid][pBW] || PlayerInfo[playerid][pInjury])
	{
		sendTipMessage(playerid, "Jeste� zakuty, ranny lub pobity, nie mo�esz okrada� w tym stanie.");
		return 1;
	}
	if(!IsAPrzestepca(giveplayerid))
	{
		sendTipMessage(playerid, "Nie mo�esz okrada� cywili.");
		return 1;
	}
	if(giveplayerid == playerid) 
	{
		sendErrorMessage(playerid, "Nie mo�esz okra�� sam siebie!"); 
		return 1; 
	}
	if(okradziony[giveplayerid])
	{
		sendErrorMessage(playerid, "Ta osoba nie ma portfela, ju� jej kto� zabra�!");
		return 1;
	}
	if(kaska[giveplayerid] <= 0)
	{
		sendErrorMessage(playerid, "Ten gracz nie ma przy sobie �adnych pieni�dzy!");
		return 1;
	}
	if(PlayerInfo[giveplayerid][pConnectTime] < 2)
	{
		sendErrorMessage(playerid, "Ten gracz za kr�tko gra !");
		return 1;
	}
	
	new string[128];
	new pieniadze = 1000000;
	if(kaska[giveplayerid] < pieniadze)
	{
		pieniadze = kaska[giveplayerid];
	}

	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("%s zabra� Ci portfel z $%d w �rodku", GetNick(playerid), pieniadze));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Zabra�e� portfel %s, w �rodku jest $%d", GetNick(giveplayerid), pieniadze));
	format(string, sizeof(string), "* %s zabiera portfel %s razem z %d$", GetNick(playerid), GetNick(giveplayerid), pieniadze);
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	Log(payLog, INFO, "%s zabra� portfel %s razem z %d$", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), pieniadze);

	DajKase(playerid, pieniadze);
	ZabierzKase(giveplayerid, pieniadze);
	okradziony[giveplayerid] = true;
	PoziomPoszukiwania[playerid] += 3;
	SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Porwanie + kradzie�");

	return 1;
}

//end
