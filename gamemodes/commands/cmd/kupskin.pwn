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
            new skinID;
			if( sscanf(params, "d", skinID))
			{
				sendTipMessage(playerid, "U¿yj /wybierzskin [id skinu] (koszt: 5000$)");
				sendTipMessage(playerid, "ID skinów znajdziesz na: http://wiki.sa-mp.com/wiki/Skins:All");
				sendTipMessage(playerid, "ID skinów [+400] znajdziesz na: http://mrucznik-rp.pl");
				return 1;
			}
			if(kaska[playerid] < 5000)
			{
				sendErrorMessage(playerid, "Nie posiadasz wystarczaj¹co œrodków!");
				return 1;
			}
			if(skinID == 0 
			|| skinID > 299 && skinID < 400)
			{
				sendTipMessage(playerid, "Tego skina nie mo¿esz wybraæ!"); 
				return 1;
			}
			if(skinID > 400 && skinID <= LOADED_SKINS)
			{
				if(SprawdzSkin(1, skinID))
				{
					sendTipMessage(playerid, "Zakupi³eœ nowego skina!"); 
					SetPlayerSkinEx(playerid, skinID); 
				}
				return 1;
			}
			new dobrze = 0; 
			for(new skin = 0; skin<194; skin++)
			{
				if(skinID == Przebierz[skin][0])
				{
					dobrze = 1;
				}
			}
			if(dobrze == 1)
			{
				sendTipMessage(playerid, "Zakupi³eœ nowego skina!"); 
				SetPlayerSkinEx(playerid, skinID); 
			}
			else
			{
				sendTipMessage(playerid, "Tego skina nie mo¿esz wybraæ!"); 
				return 1;
			}
        }
        else
		{
		    sendErrorMessage(playerid, "Nie jesteœ w sklepie z ciuchami!");
		}
    }
	return 1;
}
