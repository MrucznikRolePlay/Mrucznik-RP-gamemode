//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 dajbiznes                                                 //
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
command_dajbiznes_Impl(playerid, giveplayerid, valueBiz)
{
    if(valueBiz <= 0 || valueBiz > BusinessLoaded || valueBiz == INVALID_BIZ_ID)
    {
        sendErrorMessage(playerid, "Nie ma takiego biznesu!"); 
        return 1;
    }
    if(PlayerInfo[giveplayerid][pBusinessOwner] != INVALID_BIZ_ID)
    {
        sendErrorMessage(playerid, "Ten gracz ma ju� biznes"); 
        return 1;
    }
    if(Business[valueBiz][b_ownerUID] > 0)
    {
        sendErrorMessage(playerid, "Ten biznes ju� do kogo� nale�y!"); 
        return 1;
    }
    if(PlayerInfo[playerid][pAdmin] < 1000 && !IsAScripter(playerid))
    {
        sendErrorMessage(playerid, "Nie masz uprawnie�.");
        return 1;
    }
    PlayerInfo[playerid][pBusinessOwner] = valueBiz; 
    Business[valueBiz][b_ownerUID] = PlayerInfo[giveplayerid][pUID]; 
	Business[valueBiz][b_Name_Owner] = GetNick(giveplayerid); 

    Log(adminLog, INFO, "Admin %s da� biznes %s graczowi %s",
        GetPlayerLogName(playerid), 
        GetBusinessLogName(valueBiz),
        GetPlayerLogName(giveplayerid)
    );
    return 1;
}

//end