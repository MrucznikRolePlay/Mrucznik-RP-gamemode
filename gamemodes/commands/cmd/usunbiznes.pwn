//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ stworzbiznes ]----------------------------------------------//
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

YCMD:usunbiznes(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
   	{
       if(PlayerInfo[playerid][pAdmin] == 5000 || IsAScripter(playerid))
	   {
		   if(CheckIfPlayerInBiznesPoint(playerid))
		   {
				new idBIZ = GetPVarInt(playerid, "JestObokBiz"); 
				if(Business[idBIZ][b_ownerUID] != 0)
				{
					sendErrorMessage(playerid, "Ten biznes ma w³aœciciela! Nie mo¿esz go usun¹æ.");
					sendTipMessage(playerid, "Aby zdj¹æ biznes dla gracza (niezale¿nie od jego statusu) wpisz /zabierzbiz"); 
					return 1;
				}
				Log(businessLog, INFO, "%s [UID: %d] usun¹³ biznes {%s  [ID: %d] }",
				GetPlayerLogName(playerid),
				PlayerInfo[playerid][pUID], 
				Business[idBIZ][b_Name], 
				idBIZ); 
				DeleteBusiness(idBIZ);
				UnLoadBusiness(idBIZ); 
				sendTipMessage(playerid, "Usun¹³eœ biznes - wpis w logach zosta³ dodany!"); 
		   }
		   else
		   {
			   sendErrorMessage(playerid, "Nie jesteœ obok ¿adnego biznesu!"); 
		   }
		  
	   }
	   else 
	   {
		   return noAccessMessage(playerid); 
	   }
	}
	return 1;
}
