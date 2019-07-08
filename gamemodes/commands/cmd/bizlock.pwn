//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ bizlock ]------------------------------------------------//
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

YCMD:bizlock(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pBusinessOwner] == -1 && PlayerInfo[playerid][pBusinessMember] == -1)
		{
			sendErrorMessage(playerid, "Nie masz w³asnego biznesu"); 
			return 1;
		}
		new ID_BUSINESS, string[124]; 
		if(PlayerInfo[playerid][pBusinessOwner] != -1)
		{
			ID_BUSINESS = PlayerInfo[playerid][pBusinessOwner]; 
		}
		else if(PlayerInfo[playerid][pBusinessMember] != -1)
		{
			ID_BUSINESS = PlayerInfo[playerid][pBusinessMember]; 
		}
		if(CheckIfPlayerInBiznesPoint(playerid) == 0)
		{
			sendErrorMessage(playerid, "Nie jesteœ obok biznesu!"); 
			return 1;
		}
		if(ID_BUSINESS != GetPVarInt(playerid, "JestObokBiz"))
		{
			sendErrorMessage(playerid, "To nie jest twój biznes!"); 
			return 1;
		}
		if(BizOpenStatus[ID_BUSINESS] == 0)
		{
			BizOpenStatus[ID_BUSINESS] = 1;
			format(string, sizeof(string), "%s zamyka drzwi od %s", GetNick(playerid), Business[ID_BUSINESS][b_Name]);
		}
		else if(BizOpenStatus[ID_BUSINESS] == 1)
		{
			BizOpenStatus[ID_BUSINESS] = 0;
			format(string, sizeof(string), "%s otwiera drzwi  %s", GetNick(playerid), Business[ID_BUSINESS][b_Name]); 
		}
		ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	return 1;
}
