//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               zabierzbiznes                                               //
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
command_zabierzbiznes_Impl(playerid)
{
    new businessID = GetNearestBusiness(playerid); 
	if(businessID == INVALID_BIZ_ID)
	{
		sendErrorMessage(playerid, "Nie jesteœ obok biznesu!");
		return 1;
	}
    if(PlayerInfo[playerid][Admin] < 1000 && !IsAScripter(playerid))
    {
        noAccessMessage(playerid); 
        return 1;   
    }
    Log(adminLog, INFO, "%s zabral biznes %s graczowi {Player: %s[%d]}",
        GetPlayerLogName(playerid), 
        GetBusinessLogName(businessID),
        Business[businessID][b_Name_Owner],
        Business[businessID][b_ownerUID]
    );
    sendTipMessageEx(playerid, COLOR_RED, "Zabra³eœ biznes z r¹k gracza"); 
    ClearBusinessOwner(businessID); 
    return 1;
}

//end