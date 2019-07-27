//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kupskin ]------------------------------------------------//
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

// Opis
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:kupskin(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(IsAtClothShop(playerid))
        {
            new lolgf;
			if( sscanf(params, "d", lolgf))
			{
				sendTipMessage(playerid, "U¿yj /wybierzskin [id skinu] (koszt: 5000$)");
				sendTipMessage(playerid, "ID skinów znajdziesz na: http://wiki.sa-mp.com/wiki/Skins:All");
				return 1;
			}

			new dobrze = 0;
			if(kaska[playerid] < 5000)
			{
				sendErrorMessage(playerid, "Nie posiadasz wystarczaj¹co œrodków!");
				return 1;
			}
			if(lolgf > 0 && lolgf < 300)
			{
				for(new skin = 0; skin<194; skin++)
				{
					if(lolgf == Przebierz[skin][0])
					{
					    dobrze = 1;
					}
				}
				if(dobrze == 1)
				{
				    PlayerInfo[playerid][pModel] = lolgf;
					SetPlayerSkin(playerid, lolgf);
					sendTipMessageEx(playerid, COLOR_P@, "Kupi³eœ nowy skin!");
					ZabierzKase(playerid, 5000);
					GameTextForPlayer(playerid, "~r~-5000$", 2500, 1);
				}
				else
				{
				    sendTipMessage(playerid, "Tego skina nie mo¿esz wybraæ!");
				}
			}
			else if(lolgf >= 400 && lolgf <= LOADED_SKINS)
			{
				PlayerInfo[playerid][pModel] = lolgf+19601;
				SetPlayerSkin(playerid, lolgf+19601);
				sendTipMessageEx(playerid, COLOR_P@, "Kupi³eœ nowy skin!");
				ZabierzKase(playerid, 5000);
				GameTextForPlayer(playerid, "~r~-5000$", 2500, 1);
			}
			else
			{
			    sendTipMessage(playerid, "B³êdne SKIN_ID!");
			}
        }
        else
		{
		    sendErrorMessage(playerid, "Nie jesteœ w sklepie z ciuchami!");
		}
    }
	return 1;
}
