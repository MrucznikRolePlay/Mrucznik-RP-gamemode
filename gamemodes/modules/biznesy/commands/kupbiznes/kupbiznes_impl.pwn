//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 kupbiznes                                                 //
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
command_kupbiznes_Impl(playerid)
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
	if(Business[businessID][b_cost] <= 0)
	{
		sendErrorMessage(playerid, "Ten biznes mo¿na zakupiæ tylko w trakcie licytacji."); 
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

	Log(payLog, INFO, "%s kupi³ biznes %s za %d$",
		GetPlayerLogName(playerid),
		GetBusinessLogName(businessID),
		Business[businessID][b_cost]
	);
	ZabierzKase(playerid, Business[businessID][b_cost]); 
	ResetBizOffer(playerid);
    return 1;
}

//end