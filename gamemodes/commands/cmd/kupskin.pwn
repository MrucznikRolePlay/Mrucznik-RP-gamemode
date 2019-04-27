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

// Opis:
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
					DajKase(playerid, -5000);
					GameTextForPlayer(playerid, "~r~-5000$", 2500, 1);
				}
				else
				{
				    sendTipMessage(playerid, "Tego skina nie mo¿esz wybraæ!");
				}
			}
			else
			{
			    sendTipMessage(playerid, "Skin od 1 do 299!");
			}
        }
        else
		{
		    sendErrorMessage(playerid, "Nie jesteœ w sklepie z ciuchami!");
		}
    }
	return 1;
}

