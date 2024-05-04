//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ placmedyk ]-----------------------------------------------//
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

YCMD:placmedyk(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

	new giveplayerid, money;
	if( sscanf(params, "k<fix>d", giveplayerid, money))
	{
		sendTipMessage(playerid, "U¿yj /placmedyk [playerid/CzêœæNicku] [cena]");
		return 1;
	}

	if(money < 100 || money > 1_000_000) { sendTipMessageEx(playerid, COLOR_GREY, "Cena od 100 do 1 000 000!"); return 1; }
	if(IsPlayerConnected(giveplayerid))
	{
	    if(giveplayerid != INVALID_PLAYER_ID)
	    {
	        if(ProxDetectorS(8.0, playerid, giveplayerid) && PlayerInfo[giveplayerid][pMember] == FRAC_ERS)
			{
			    if(giveplayerid == playerid)
			    {
			        sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz p³aciæ samemu sobie!");
			        return 1;
			    }
			    if(kaska[playerid] >= money)
		        {
                	if(Sejf_Frakcji[4] + money > 1_000_000_000)
                    {
                     	sendTipMessageEx(playerid, -1, "Sejf siê przepe³ni!");
                      	return 1;
                	}
		          	GetPlayerName(playerid, sendername, sizeof(sendername));
		          	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		           	ZabierzKase(playerid, money);
                   	Sejf_Add(4, money);

			      	new komunikat[256];
			      	format(string, sizeof(string), "* %s wyci¹ga z portfela pieni¹dze i daje je medykowi %s.", sendername ,giveplayer);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			     	format(komunikat, sizeof(komunikat), "Zap³aci³eœ %d$ medykowi.", money);
			        SendClientMessage(playerid, COLOR_P@, komunikat);
			        format(komunikat, sizeof(komunikat), "Na konto frakcji wp³ynê³o %d$ od gracza.", money);
			        SendClientMessage(giveplayerid, COLOR_P@, komunikat);
			        Log(payLog, INFO, "%s da³ medykowi %s kwotê %d$, która trafi³a do sejfu LSMC (stan: %d$)", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), money, Sejf_Frakcji[4]);
					Sejf_Save(4);
			        return 1;
				}
				else
				{
					sendTipMessageEx(playerid, COLOR_P@, "Nie masz a¿ tyle przy sobie !");
					return 1;
				}
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie ma przy tobie medyka!");
			}
		}
	}
	else
	{
	    sendErrorMessage(playerid, "Nie ma takiego gracza!");
	}
	return 1;
}
