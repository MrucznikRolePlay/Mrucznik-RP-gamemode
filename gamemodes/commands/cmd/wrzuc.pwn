//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wrzuc ]-------------------------------------------------//
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

YCMD:wrzuc(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
    new frac = GetPlayerFraction(playerid), fam = GetPlayerOrgType(playerid);
    if(frac == FRAC_LCN || frac == FRAC_YKZ || frac == FRAC_HA || (frac >= 12 && frac <= 16) || fam == ORG_TYPE_GANG || fam == ORG_TYPE_MAFIA)
    {
    	new person, seat4;
    	if( sscanf(params, "k<fix>d", person, seat4))
    	return sendTipMessage(playerid, "U¿yj /wepchnij [ID Gracza] [miejsce 2-4]");

    	if (GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
    	return sendTipMessage(playerid, "Musisz byæ w pojeŸdzie.");

    	if (IsPlayerInAnyVehicle(person))
    	return sendTipMessage(playerid, "Gracz nie mo¿e znajdowaæ siê w pojeŸdzie.");

    	if(pobity[person] >= 1 || PlayerInfo[person][pBW] > 0)
        {
    		if (GetDistanceBetweenPlayers(playerid,person) > 5) return sendErrorMessage(playerid, "Gracz nie jest w pobli¿u.");

            TogglePlayerControllable(person, 1);
    		new Float:pos[6];
    		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    		GetPlayerPos(playerid, pos[3], pos[4], pos[5]);
    		if (floatcmp(floatabs(floatsub(pos[0], pos[3])), 10.0) != -1 &&
    		floatcmp(floatabs(floatsub(pos[1], pos[4])), 10.0) != -1 &&
    		floatcmp(floatabs(floatsub(pos[2], pos[5])), 10.0) != -1) return false;
            PutPlayerInVehicleEx(person, GetPlayerVehicleID(playerid), seat4);
    		TogglePlayerControllable(person, 0);
    		PlayerCuffed[person] = 2;
    		PlayerCuffedTime[person] = 180;
    		GameTextForPlayer(person, "~r~Wrzucony do wozu", 2500, 3);
    		pobity[person] = 0;
    		GetPlayerName(person, giveplayer, sizeof(giveplayer));
    		GetPlayerName(playerid, sendername, sizeof(sendername));
    		format(string, sizeof(string), "* Zosta³eœ wrzucony do pojazdu przez %s.", sendername);
    		SendClientMessage(person, COLOR_LIGHTBLUE, string);
    		format(string, sizeof(string), "* Wrzuci³eœ do pojazdu %s.", giveplayer);
    		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    		format(string, sizeof(string), "* %s wrzuci³ do pojazdu i unieruchomi³ %s.", sendername ,giveplayer);
    		ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            sendTipMessage(playerid, "Po trzech minutach osoba zostanie rozwi¹zana!");
            sendTipMessage(person, "Po trzech minutach zostaniesz rozwi¹zany!");
    		return 1;
    	}
    	else
    	{
    	    sendTipMessage(playerid, "Gracz nie jest pobity!");
    	}
    } else {
        sendErrorMessage(playerid, "Nie mo¿esz tego zrobiæ!");
        return 1;
    }
    return 1;
}
