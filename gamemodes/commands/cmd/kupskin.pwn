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
				sendTipMessage(playerid, "ID skinów [+20.000] znajdziesz na: http://mrucznik-rp.pl");
				return 1;
			}
			if(kaska[playerid] >= 5000){
				
				if(skinID > 299 && skinID < 400)
				{
					sendErrorMessage(playerid, "B³êdne ID skina - brak przedzia³u od 300-399"); 
					return 1;
				}
				else if(skinIsLegally(skinID))
				{
					sendTipMessage(playerid, "Kupi³eœ nowego skina!"); 
					ZabierzKase(playerid, 5000); 
					return 1;
				}	
				else if(skinID > 20000 && skinID <= 20100)//SKINY EVENTOWE
				{
					if(eventForSkin[skinID] != 1)
					{
						sendTipMessage(playerid, "Event dla tego skina jest wy³¹czony!"); 
						return 1;
					}
					SetPlayerSkin(playerid, skinID); 
					sendTipMessage(playerid, "Kupi³eœ nowego skina!"); 
					ZabierzKase(playerid, 5000); 
					return 1;
				}
				else if(skinID > 20100 && skinID <= 20300)//Skiny dla frakcji
				{
					sendTipMessage(playerid, "Ten skin jest tylko i wy³¹cznie dla frakcji! U¿yj /uniform"); 
					return 1;
				}
				else if(skinID > 20300 && skinID <= 20400)
				{
					sendErrorMessage(playerid, "Ten skin jest do kupienia za MC"); 
					return 1;
				}
				else if(skinID > 20400 && skinID < LOADED_SKINS)//Normalne skiny dla ka¿dego
				{
					SetPlayerSkin(playerid, skinID); 
					sendTipMessage(playerid, "Kupi³eœ nowego skina!"); 
					ZabierzKase(playerid, 5000); 
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie posiadasz odpowiedniej iloœci gotówki!");
				return 1;
			}
		}
	}
	return 1;
}
/*
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
			if(skinID > )
			for(new i; i<=2; i++)
			{
				if(skinID == PedsEvent[i][0])
				{
					if(eventForSkin[i] != 1)
					{
						sendErrorMessage(playerid, "Event dla tego skina zosta³ zakoñczony!"); 
						return 1;
					}
					
					sendTipMessage(playerid, "Zakupi³eœ nowego skina [Tymczasowego]!"); 
					ZabierzKase(playerid, 5000); 
					SetPlayerSkinEx(playerid, skinID); 
					return 1;
				}
			}
			for(new skin = 0; skin<=222; skin++)
			{
				if(skinID == Przebierz[skin][0])
				{
					sendTipMessage(playerid, "Zakupi³eœ nowego skina!"); 
					ZabierzKase(playerid, 5000); 
					SetPlayerSkinEx(playerid, skinID); 
					PlayerInfo[playerid][pSkin] = skinID; 
					return 1;
				}
			}
			sendTipMessage(playerid, "Tego skina nie mo¿esz wybraæ!"); 	
        }
        else
		{
		    sendErrorMessage(playerid, "Nie jesteœ w sklepie z ciuchami!");
		}
    }
	return 1;
}
*/