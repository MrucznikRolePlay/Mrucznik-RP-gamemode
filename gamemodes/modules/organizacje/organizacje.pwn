//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                organizacje                                                //
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
// Autor: Mrucznik
// Data utworzenia: 15.05.2019
//Opis:
/*
	System organizacji przestêpczych.
*/

//
//-----------------<[ Funkcje: ]>-------------------
organizacje_clearCache(playerid)
{
	SektaKey[playerid] = 0;
	SektaUwieziony[playerid] = 0;
}

organizacje_toggleSektaKey(playerid, giveplayerid)
{
	new var[128];
	if(SektaKey[giveplayerid] == 0)
    {
        format(var, sizeof(var), "Da³eœ klucz do wrot %s", GetNick(giveplayerid));
        sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
        sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, "Otrzyma³eœ klucz do wrot.");
        SektaKey[giveplayerid] = 1;
    }
    else
    {
        format(var, sizeof(var), "Zabra³eœ klucz do wrot %s", GetNick(giveplayerid));
        sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
        sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, "Zabrano ci klucz do wrot.");
        SektaKey[giveplayerid] = 0;
    }
	return 1;
}

organizacje_wepchnijSekta(playerid, giveplayerid)
{
	new var[128];
	if((PlayerToPoint(1.5, playerid, 844.8696,-1074.8522,24.3056) && GetPlayerVirtualWorld(playerid) == 0) || PlayerToPoint(4, playerid, 867.2818,-1107.7255,5.7544))
    {
        if(GetDistanceBetweenPlayers(playerid,giveplayerid) > 3) return sendErrorMessage(playerid, "Gracz nie jest w pobli¿u.");
		if(SektaUwieziony[giveplayerid] == 1) return sendErrorMessage(playerid, "Gracz jest ju¿ uwiêziony.");
        format(var, sizeof(var), "* %s og³uszy³(a) i wrzuci³(a) do celi %s.", GetNick(playerid) ,GetNick(giveplayerid));
        ProxDetector(20.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SektaUwieziony[giveplayerid] = 1;
        Wchodzenie(giveplayerid);
        SetPlayerPos(giveplayerid, 867.1572, -1111.2548, 5.8253);
        SetPlayerVirtualWorld(giveplayerid, 20);
    }
    else
    {
        sendTipMessage(playerid, "Nie jesteœ przy celi/wrotach");
    }
	return 1;
}

organizacje_wypuscSekta(playerid, giveplayerid)
{
	new var[128];
	if(PlayerToPoint(4, playerid, 867.2818,-1107.7255,5.7544))
    {
        if(SektaUwieziony[giveplayerid] == 0) return sendErrorMessage(playerid, "Gracz nie jest uwiêziony.");
        SetPlayerPos(giveplayerid, 867.2818,-1107.7255,5.7544);
        format(var, sizeof(var), "* %s wypuœci³ z celi %s.", GetNick(playerid) ,GetNick(giveplayerid));
        ProxDetector(20.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SektaUwieziony[giveplayerid] = 0;
    }
    else
    {
        sendTipMessage(playerid, "Nie jesteœ przy celi/wrotach");
    }
	return 1;
}
//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end