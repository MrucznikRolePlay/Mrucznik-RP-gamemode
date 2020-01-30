//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ dajbilet ]-----------------------------------------------//
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

YCMD:dajbilet(playerid, params[], help)
{
	if(GetPlayerOrg(playerid) == FAMILY_ALHAMBRA && PlayerInfo[playerid][pRank] >= 1)
	{
		if(kaska[playerid] >= 20000)
		{
			new giveplayerid, string[128];
			if(sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /dajbilet [playerid/CzêœæNicku]");
				return 1;
			}
			if(!IsPlayerConnected(giveplayerid))
			{
				sendErrorMessage(playerid, "Ten gracz jest offline!");
				return 1;
			}
			//
			format(string, sizeof(string), "Da³eœ bilet graczowi %s. Koszt wydania biletu: 20 000$", GetNick(giveplayerid, true));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "Otrzyma³eœ bilet do klubu Alhmabra od %s", GetNick(playerid, true));
			SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
            ZabierzKase(playerid, 20000);
            SejfR_Add(FAMILY_ALHAMBRA, 20000);
			BiletAlhambra[giveplayerid] = 1;
		}
		else
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Koszt wydania biletu: 20 000$, a ty tyle nie masz");
		}
	}
    else if(GetPlayerOrg(playerid) == FAMILY_VINYL && PlayerInfo[playerid][pRank] >= 1)
    {
        if(kaska[playerid] >= 20000)
		{
			if(IsPlayerConnected(playerid))
			{
				sendTipMessage(playerid, "U¿yj /panelvinyl");
				return 1;
			}
			new giveplayerid, typ, string[128];
			if(sscanf(params, "k<fix>D(1)", giveplayerid, typ))
			{
				sendTipMessage(playerid, "U¿yj /dajbilet [playerid/CzêœæNicku]");
                return 1;
            }
            if(!IsPlayerConnected(giveplayerid))
            {
                sendErrorMessage(playerid, "Ten gracz jest offline!");
				return 1;
			}
            if(typ > 2 || typ < 1) return 1;
			//
			format(string, sizeof(string), "Da³eœ bilet graczowi %s. Koszt wydania biletu: 20 000$", GetNick(giveplayerid, true));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "Otrzyma³eœ bilet do klubu Vinyl od %s", GetNick(playerid, true));
			SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);

            if(typ == 1)
		    {
                ZabierzKase(playerid, 20000);
                SejfR_Add(FAMILY_VINYL, 20000);
		    	format(string,sizeof(string),"*%s da³ bilet %s",GetNick(playerid, true),GetNick(giveplayerid, true));
		    }
		    else if(typ == 2)
		    {
                ZabierzKase(playerid, 50000);
                SejfR_Add(FAMILY_VINYL, 50000);
		    	format(string,sizeof(string),"*%s da³ bilet VIP %s",GetNick(playerid, true),GetNick(giveplayerid, true));
		    }
		    ProxDetector(10, playerid, string,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);


            SetPVarInt(giveplayerid, "Vinyl-bilet", typ);
		}
		else
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Koszt wydania biletu: 20 000$, a Ty tyle nie masz");
		}
    }
	else if(GetPlayerOrg(playerid) == FAMILY_IBIZA && PlayerInfo[playerid][pRank] >= 6)
    {
		new giveplayerid;
		if(sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /dajbilet [playerid/CzêœæNicku]");
            return 1;
        }
		if(!IsPlayerConnected(giveplayerid))
        {
            sendErrorMessage(playerid, "Ten gracz jest offline!");
			return 1;
		}
		PlayerInfo[giveplayerid][pIbizaBilet] = 3;
		format(string, sizeof(string), "Da³eœ bilet SUPERVIP graczowi %s.", GetNick(giveplayerid, true));
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "Otrzyma³eœ bilet SUPERVIP do klubu Ibiza od %s", GetNick(playerid, true));
		SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
	}
	return 1;
}
