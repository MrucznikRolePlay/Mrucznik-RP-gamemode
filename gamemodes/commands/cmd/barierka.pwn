//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ barierka ]-----------------------------------------------//
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

YCMD:barierka(playerid, params[], help)
{
    if(!(IsAPolicja(playerid) || GetPlayerFraction(playerid) == FRAC_BOR || GetPlayerFraction(playerid) == FRAC_ERS))
	{
		sendErrorMessage(playerid, "Nie masz uprawnieñ do u¿ycia tej komendy.");
		return 1;
	}
	
	if(PlayerInfo[playerid][pJailed] != 0)
	{
		sendErrorMessage(playerid, "Nie mo¿esz stawiaæ barierek w wiêzieniu.");
		return 1;
	}

    if(isnull(params))
    {
        DestroySelectionMenu(playerid);
    	SetPVarInt(playerid, "gatechose_active", 1);
    	CreateSelectionMenu(playerid);
    	SelectTextDraw(playerid, 0xACCBF1FF);
        sendTipMessage(playerid, "U¿yj /barierka usuñ [ID] aby usun¹æ!");
    }
    else
    {
        new var[32], id;
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
        if(sscanf(params, "s[32]d", var, id)) return sendTipMessage(playerid, "U¿yj /barierka usuñ [ID]");
        if(strcmp(var, "usuñ", true) == 0 ||  strcmp(var, "usun", true) == 0)
        {
            if(GetPVarInt(playerid, "gatechose_active") == 1)//Zabezpieczenie przed edycj¹ obiektów mapy
            {
                DestroySelectionMenu(playerid);
                SetPVarInt(playerid, "gatechose_active", 0);
                return 1;
            }
            if(id < 0 || id > 9) return 1;
            new frac = GetPlayerFraction(playerid);
            if(!BarierState[frac][id]) return 1;

            BARIERKA_Remove(frac, id);

            SendClientMessage(playerid, -1, "Usuniêto barierkê");
        }
    }
    return 1;
}
