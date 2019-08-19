//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ kupbiznes ]-----------------------------------------------//
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

YCMD:kupbiznes(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pLevel] < 2)
		{
			sendTipMessage(playerid, "Mo¿esz zakupiæ w³asny biznes dopiero od poziomu 2");
			return 1;
		}
		if(GetPlayerBusiness(playerid) != INVALID_BIZ_ID)
		{
			sendTipMessage(playerid, "Jesteœ w³aœcicielem b¹dŸ cz³onkiem biznesu! Nie mo¿esz kupiæ nastêpnego.");
			sendTipMessage(playerid, "Je¿eli jesteœ w³aœcicielem wpisz: /zlomujbiznes");
			sendTipMessage(playerid, "Je¿eli jesteœ cz³onkiem wpisz: /quitbiznes"); 
			return 1; 
		}
		new businessID = GetNearestBusiness(playerid); 
		if(businessID == INVALID_BIZ_ID)
		{
			sendErrorMessage(playerid, "Nie jesteœ obok biznesu!");
			return 1;
		}
		if(businessID == -1)
		{
			sendErrorMessage(playerid, "B³êdne ID biznesu"); 
			return 1;
		}
		if(Business[businessID][b_ownerUID] != 0)
		{
			sendErrorMessage(playerid, "Ten biznes nale¿y ju¿ do kogoœ!"); 
			return 1;
		}
		if(kaska[playerid] < Business[businessID][b_cost])
		{
			sendErrorMessage(playerid, "Nie staæ Ciê!"); 
			return 1;
		}
		PlayerInfo[playerid][pBusinessOwner] = businessID; 
		Business[businessID][b_ownerUID] = PlayerInfo[playerid][pUID]; 
		Business[businessID][b_Name_Owner] = GetNick(playerid); 
		new string[124]; 
		sendTipMessageEx(playerid, COLOR_GREEN, "===[Zakupi³eœ swój w³asny biznes]===");
		format(string, sizeof(string), "Nazwa biznesu: %s", Business[businessID][b_Name]);  
		sendTipMessage(playerid, string); 
		format(string, sizeof(string), "ID biznesu: %d", businessID); 
		sendTipMessage(playerid, string);
		format(string, sizeof(string), "Twoje UID: %d", PlayerInfo[playerid][pUID]); 
		sendTipMessage(playerid, string); 
		sendTipMessageEx(playerid, COLOR_GREEN, "===[WYKONAJ ZRZUT EKRANU]==="); 

		Log(businessLog, INFO, "%s [UID: %d] kupi³ biznes %s [%d] za %d$",
        GetPlayerLogName(playerid),
		PlayerInfo[playerid][pUID], 
		Business[businessID][b_Name], 
    	businessID,
        Business[businessID][b_cost]);
		ZabierzKase(playerid, Business[businessID][b_cost]); 
		ResetBizOffer(playerid);
	}
	return 1;
}
