//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  bizlock                                                  //
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
// Autor: Simeone
// Data utworzenia: 19.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_bizlock_Impl(playerid)
{
    if(PlayerInfo[playerid][pBusinessOwner] == INVALID_BIZ_ID && PlayerInfo[playerid][pBusinessMember] == INVALID_BIZ_ID)
	{
		sendErrorMessage(playerid, "Nie masz w³asnego biznesu"); 
		return 1;
	}
	new businessID, string[124]; 
	if(PlayerInfo[playerid][pBusinessOwner] != INVALID_BIZ_ID)
	{
		businessID = PlayerInfo[playerid][pBusinessOwner]; 
	}
	else if(PlayerInfo[playerid][pBusinessMember] != INVALID_BIZ_ID)
	{
		businessID = PlayerInfo[playerid][pBusinessMember]; 
	}
	new businessIDE = GetNearestBusiness(playerid); 
	if(businessIDE == INVALID_BIZ_ID)
	{
		sendErrorMessage(playerid, "Nie jesteœ obok biznesu!");
		return 1;
	}
	if(businessID != businessIDE)
	{
		sendErrorMessage(playerid, "To nie jest twój biznes!"); 
		return 1;
	}
	if(BizOpenStatus[businessID] == 0)
	{
		BizOpenStatus[businessID] = 1;
		format(string, sizeof(string), "%s zamyka drzwi od %s", GetNick(playerid), Business[businessID][b_Name]);
	}
	else if(BizOpenStatus[businessID] == 1)
	{
		BizOpenStatus[businessID] = 0;
		format(string, sizeof(string), "%s otwiera drzwi  %s", GetNick(playerid), Business[businessID][b_Name]); 
	}
	ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    return 1;
}

//end