//-----------------------------------------------<< Source >>------------------------------------------------//
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

//-----------------<[ Funkcje: ]>-------------------

CuffAutoSuccess(playerid, cuffedplayerid)
{
	new cuffingDescription[128];
	new reasonForAutoSuccess[128];
	new message_s[128];

	if(PlayerInfo[cuffedplayerid][pBW] >= 1 || PlayerInfo[cuffedplayerid][pInjury] >= 1)
    {
		ZdejmijBW(cuffedplayerid, 2000);

		format(cuffingDescription, sizeof(cuffingDescription), "* %s docisn¹³ do ziemi nieprzytomnego %s i sku³ go.", GetNick(playerid), GetNick(cuffedplayerid));
		format(reasonForAutoSuccess, sizeof(reasonForAutoSuccess), "Jesteœ nieprzytomny");
	}
	else //if(GetPlayerSpecialAction(cuffedplayerid) == SPECIAL_ACTION_DUCK)
	{
		format(cuffingDescription, sizeof(cuffingDescription), "* %s docisn¹³ do ziemi %s, a nastêpnie zaku³ go w kajdanki.", GetNick(playerid), GetNick(cuffedplayerid));
		format(reasonForAutoSuccess, sizeof(reasonForAutoSuccess), "Le¿a³eœ na ziemi");
	}

	ProxDetector(30.0, playerid, cuffingDescription, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

	format(message_s, sizeof(message_s), "Dziêki szybkiej interwencji uda³o Ci siê skuæ %s.", GetNick(cuffedplayerid));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, message_s);

	format(message_s, sizeof(message_s), "%s - policjant sku³ ciê bez wiêkszego wysi³ku.", reasonForAutoSuccess);
	sendTipMessageEx(cuffedplayerid, COLOR_BLUE, message_s);

	CuffedAction(playerid, cuffedplayerid);
	TogglePlayerControllable(cuffedplayerid, 1);
}


UncuffPlayer(playerid)
{
	if(playerid == INVALID_PLAYER_ID)
	{
		return;
	}

	new cuffingPlayerID = whoIsCuffing[playerid]; // id skuwaj¹cego (np. policjanta)

	if(cuffingPlayerID != INVALID_PLAYER_ID)
	{
		whoIsCuffedBy[cuffingPlayerID] = INVALID_PLAYER_ID;
		isPlayerUsingCuffs[cuffingPlayerID] = false;
		whoIsCuffing[playerid] = INVALID_PLAYER_ID;
	}

	isPlayerCuffed[playerid] = false;
	
	ClearAnimations(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    RemovePlayerAttachedObject(playerid, CUFF_ATTACH_OBJ_IDX);
    TogglePlayerControllable(playerid, true);
}


UncuffPlayerCuffedBy(playerid)
{
	if(playerid == INVALID_PLAYER_ID)
	{
		return;
	}

	new cuffedPlayerID = whoIsCuffedBy[playerid];

	if(cuffedPlayerID != INVALID_PLAYER_ID)
	{
		whoIsCuffing[cuffedPlayerID] = INVALID_PLAYER_ID;
		isPlayerCuffed[cuffedPlayerID] = false;
		whoIsCuffedBy[playerid] = INVALID_PLAYER_ID;
		
		ClearAnimations(cuffedPlayerID);
		SetPlayerSpecialAction(cuffedPlayerID, SPECIAL_ACTION_NONE);
        RemovePlayerAttachedObject(cuffedPlayerID, CUFF_ATTACH_OBJ_IDX);
        TogglePlayerControllable(cuffedPlayerID, true);
	}

	isPlayerUsingCuffs[playerid] = false;
}


TransferCuffs(cuffedplayerid, newcopid)
{
    new oldcopid = whoIsCuffing[cuffedplayerid];
    new message_s[128];

    format(message_s, sizeof(message_s), "* %s przejmuje skutego %s od %s", GetNick(newcopid), GetNick(cuffedplayerid), GetNick(oldcopid));
    ProxDetector(30.0, cuffedplayerid, message_s, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

    format(message_s, sizeof(message_s), "Przej¹³eœ skutego %s od %s.", GetNick(cuffedplayerid), GetNick(oldcopid));
    SendClientMessage(newcopid, COLOR_LIGHTBLUE, message_s);

    format(message_s, sizeof(message_s), "%s przej¹³ od ciebie skutego %s.", GetNick(newcopid), GetNick(cuffedplayerid));
    SendClientMessage(oldcopid, COLOR_LIGHTBLUE, message_s);

    whoIsCuffing[cuffedplayerid] = newcopid;
    isPlayerUsingCuffs[oldcopid] = false;
    whoIsCuffedBy[oldcopid] = INVALID_PLAYER_ID;
    isPlayerUsingCuffs[newcopid] = true;
    whoIsCuffedBy[newcopid] = cuffedplayerid;
}


JednaSekundaTimer_Kajdanki(i)
{
	new Float:x, Float:y, Float:z;
    if(isPlayerCuffed[i])
    {
        new cop = whoIsCuffing[i];

        if(cop == INVALID_PLAYER_ID || !IsPlayerConnected(cop) || (!IsAPolicja(cop) && !IsABOR(cop)))
        {
            UncuffPlayer(i);
            UncuffPlayerCuffedBy(cop);
        }

        new copState = GetPlayerState(cop);
        new copVirtualWorld = GetPlayerVirtualWorld(cop);
        new copInterior = GetPlayerInterior(cop);

        if(copVirtualWorld != GetPlayerVirtualWorld(i))
        {
            SetPlayerVirtualWorld(i, copVirtualWorld);
        }
        if(copInterior != GetPlayerInterior(i))
        {
            SetPlayerInterior(i, copInterior);
        }

        new cuffedInVehicle = false;

        if(copState == PLAYER_STATE_DRIVER || copState == PLAYER_STATE_PASSENGER)
        {
            cuffedInVehicle = true;
            new veh = GetPlayerVehicleID(cop);
            new veh_zakuty = GetPlayerVehicleID(i);
            if(veh != veh_zakuty) 
            {
                new seat = GetFreeVehicleSeat(veh);
                if(seat > 1)
                {
                    PutPlayerInVehicleEx(i, veh, seat);
                    TogglePlayerControllable(i, 0);
                }
                else
                {
                    cuffedInVehicle = false;
                }
            }
        }

        if(!cuffedInVehicle && !ProxDetectorS(3.5, cop, i))
        {
            GetPlayerPos(cop, x, y, z);
            SetPlayerPos(i, x-0.5, y-0.5, z);
            SetPlayerSpecialAction(i, SPECIAL_ACTION_CUFFED);
            TogglePlayerControllable(i, 0);
            if(PlayerInfo[i][pBW] == 0)
            {
                SetTimerEx("FreezePlayer", 2000, false, "i", i);
            }
        }
    }
}


IsKajdankiInvalid(playerid, cuffedplayerid)
{
	if(!IsPlayerConnected(playerid))
    {
        return 1;
    }
    if(!IsAPolicja(playerid) && !(IsABOR(playerid) && PlayerInfo[playerid][pRank] >= 2))
    {
        sendTipMessage(playerid, "Nie posiadasz kajdanek");
        return 1;
    }
    if(!IsPlayerConnected(cuffedplayerid))
    {
        sendTipMessage(playerid, "Nie ma takiego gracza");
        return 1;
    }
    if(IsAPolicja(playerid) && OnDuty[playerid] == 0)
    {
        sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie!");
        return 1;
    }
    if(!ProxDetectorS(8.0, playerid, cuffedplayerid))
    {
        sendTipMessage(playerid, "Jesteœ zbyt daleko od gracza");
        return 1;
    }
    if(GetPlayerAdminDutyStatus(cuffedplayerid) == 1)
    {
        sendTipMessage(playerid, "Nie mo¿esz skuæ administratora!");
        return 1;
    }
    if(PlayerInfo[playerid][pMember] != FRAC_FBI && (PlayerInfo[cuffedplayerid][pMember] == FRAC_LSPD && OnDuty[cuffedplayerid]))
    {
        sendTipMessage(playerid, "Tylko FBI mo¿e skuæ policjanta na s³u¿bie.");
        return 1;
    }
    if(PlayerInfo[playerid][pMember] == FRAC_FBI && PlayerInfo[cuffedplayerid][pMember] == FRAC_FBI)
    {
        sendTipMessage(playerid, "Nie mo¿esz skuwaæ agentów!");
        return 1;
    }
    if(GetPlayerState(playerid) != 1 || GetPlayerState(cuffedplayerid) != 1)
    {
        sendErrorMessage(playerid, "¯aden z was nie mo¿e byæ w wozie!");
        return 1;
    }
    if(AntySpam[playerid] == 1)
    {
        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 10 sekund");
        return 1;
    }

    CheckAndFixBuggedCuffs(playerid, cuffedplayerid);
    
    if((!isPlayerCuffed[cuffedplayerid] && isPlayerUsingCuffs[playerid])
        || (isPlayerCuffed[cuffedplayerid] && isPlayerUsingCuffs[playerid] && whoIsCuffing[cuffedplayerid] != playerid))
    {
        sendTipMessage(playerid, "U¿ywasz ju¿ swoich kajdanek!");
        return 1;
    }
    if(!isPlayerCuffed[cuffedplayerid] && whoIsCuffing[cuffedplayerid] != INVALID_PLAYER_ID)
    {
        sendTipMessage(playerid, "Ten gracz jest obecnie w trakcie bycia skuwanym przez kogoœ innego!");
        return 1;
    }

    return 0;
}


IsRozkujInvalid(playerid, uncuffedplayerid)
{
    if(!IsPlayerConnected(playerid))
    {
        return 1;
    }
	if(!(IsAPolicja(playerid) || IsABOR(playerid) || PlayerInfo[playerid][pAdmin] >= 1))
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz kluczy do kajdanek!");
	}
	if(uncuffedplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(uncuffedplayerid))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza!");
		return 1;
	}
	if(!ProxDetectorS(8.0, playerid, uncuffedplayerid))
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie!");
	}
	if(uncuffedplayerid == playerid && !PlayerInfo[playerid][pAdmin] >= 1) 
	{ 
		sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz odkuæ samego siebie!"); 
		return 1; 
	}
	if(!isPlayerCuffed[uncuffedplayerid] && !PlayerTied[uncuffedplayerid])
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest skuty!");
		return 1;
	}
	if(isPlayerCuffed[uncuffedplayerid] && whoIsCuffing[uncuffedplayerid] != playerid)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz jest skuty przez kogoœ innego. U¿yj /kajdanki [id skutego], by go przej¹æ.");
		return 1;
	}

    return 0;
}


FixBuggedCuffs(playerid, cuffedid)
{
    UncuffPlayer(cuffedid);
    UncuffPlayerCuffedBy(cuffedid);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Naprawiono ci zbugowane kajdanki.");
    SendClientMessage(cuffedid, COLOR_LIGHTBLUE, "Naprawiono ci zbugowane kajdanki.");
}


CheckAndFixBuggedCuffs(playerid, cuffedid)
{
    if((whoIsCuffing[cuffedid] == playerid && whoIsCuffedBy[playerid] != cuffedid)
        || (whoIsCuffing[cuffedid] != playerid && whoIsCuffedBy[playerid] == cuffedid))
    {
        FixBuggedCuffs(playerid, cuffedid);
        return 1;
    }

    if(isPlayerUsingCuffs[playerid] && whoIsCuffedBy[playerid] == INVALID_PLAYER_ID
        || !isPlayerUsingCuffs[playerid] && whoIsCuffedBy[playerid] != INVALID_PLAYER_ID)
    {
        FixBuggedCuffs(playerid, cuffedid);
        return 1;
    }

    if(whoIsCuffing[cuffedid] != INVALID_PLAYER_ID && whoIsCuffing[cuffedid] != playerid)
    {
        return 0;
    }

    if(isPlayerCuffed[cuffedid] && whoIsCuffing[cuffedid] == INVALID_PLAYER_ID)
    {
        FixBuggedCuffs(playerid, cuffedid);      
        return 1;
    }

    if(whoIsCuffing[cuffedid] == playerid && (isPlayerCuffed[cuffedid] != isPlayerUsingCuffs[playerid]))
    {
        FixBuggedCuffs(playerid, cuffedid);      
        return 1;
    }

    return 0;
}


ZerujZmienne_Kajdanki(playerid)
{
	isPlayerCuffed[playerid] = false;
	isPlayerUsingCuffs[playerid] = false;

	return ZerujZmienne(playerid);
}
#if defined _ALS_ZerujZmienne
    #undef ZerujZmienne
#else
    #define _ALS_ZerujZmienne
#endif
#define ZerujZmienne ZerujZmienne_Kajdanki

//end