//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ zlomujbiznes ]----------------------------------------------//
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

YCMD:zlomujbiznes(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		if(GetPlayerBusiness(playerid) == INVALID_BIZ_ID)
		{
			sendTipMessage(playerid, "Nie posiadasz w³asnego biznesu!");
			return 1; 
		}
		if(!CheckIfPlayerInBiznesPoint(playerid))
		{
			sendTipMessage(playerid, "Nie jesteœ w miejscu biznesu!"); 
			return 1;
		}
		new ID_Business = GetPVarInt(playerid, "JestObokBiz");
		new valueMoneyB = (Business[ID_Business][b_cost]/2); 
		if(ID_Business != PlayerInfo[playerid][pBusinessOwner])
		{
			sendErrorMessage(playerid, "Nie jesteœ w³aœcicielem tego biznesu"); 
			return 1;
		}
		if(GetPVarInt(playerid, "Wpisal_zlomujbiznes") == 0)
		{
			sendTipMessage(playerid, "Uwaga! Stracisz swój biznes, dostaniesz po³owê jego ceny jako zwrot!"); 
			sendTipMessage(playerid, "Je¿eli akceptujesz powy¿sze warunki wpisz ponownie /zlomujbiznes"); 
			SetPVarInt(playerid, "Wpisal_zlomujbiznes", 1);
			return 1;
		}
		else if(GetPVarInt(playerid, "Wpisal_zlomujbiznes") == 1)
		{
			Business[ID_Business][b_ownerUID] = 0;  
			format(stringName, sizeof(stringName), "Brak - na sprzeda¿");
			Business[ID_Business][b_Name_Owner] = stringName; 
			PlayerInfo[playerid][pBusinessOwner] = INVALID_BIZ_ID; 
			format(string, sizeof(string), "%s zez³omowa³ biznes %d za $%d", GetNick(playerid), ID_Business, valueMoneyB); 
			SendMessageToAdmin(string, COLOR_RED); 

			Log(businessLog, INFO, "%s [UID: %d] zez³omowa³ biznes %s [%d] za $%d",
			GetPlayerLogName(playerid),
			PlayerInfo[playerid][pUID], 
			Business[ID_Business][b_Name], 
			ID_Business,
			valueMoneyB);
			DajKase(playerid, valueMoneyB); 
			SetPVarInt(playerid, "Wpisal_zlomujbiznes", 0);
			sendTipMessage(playerid, "Pomyœlnie zez³omowa³eœ swój biznes!"); 
		}
	}
	return 1;
}



