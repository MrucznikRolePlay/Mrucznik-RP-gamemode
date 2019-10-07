//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   napraw                                                  //
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
// Data utworzenia: 07.10.2019


//

//------------------<[ Implementacja: ]>-------------------
command_napraw_Impl(playerid, giveplayerid, valueCost)
{
    new string[124];
    if(GetPlayerJobID(playerid) != JOB_MECHAZORD)
    {
        sendErrorMessage(playerid, "Nie jesteœ mechanikiem!");
        sendTipMessage(playerid, "Mo¿esz do³¹czyæ do pracy mechanika wpisuj¹c /dolacz w odpowiednim punkcie!"); 
        return 1;
    }
    if(valueCost > 6000)
    {
        sendErrorMessage(playerid, "Kwota nie mo¿e przekraczaæ 6 tysiêcy!"); 
        return 1;
    }
    if(valueCost < 0)
    {
        sendErrorMessage(playerid, "Nie mo¿esz oferowaæ naprawy za minusowe kwoty!"); 
        return 1;
    }
    if(!IsPlayerInAnyVehicle(giveplayerid))
    {
        sendErrorMessage(playerid, "Gracz, któremu oferujesz naprawê nie znajduje siê w ¿adnym pojeŸdzie!"); 
        return 1;
    }
    if(!ProxDetectorS(8.0, playerid, giveplayerid) || Spectate[giveplayerid] != INVALID_PLAYER_ID)
    {
        sendErrorMessage(playerid, "Ten gracz nie jest przy Tobie!"); 
        return 1;
    }
    if(SpamujeMechanik[playerid] == 0)
    {
        if(playerid == giveplayerid)
        {
            sendErrorMessage(playerid, "Nie mo¿esz naprawiæ pojazdu samemu sobie!"); 
            return 1;
        }
        format(string, sizeof(string), "Mechanik %s oferuje naprawê twojego pojazdu za %d$ - aby siê zgodziæ wpisz /akceptuj naprawe", GetNick(playerid), valueCost);
        sendTipMessageEx(giveplayerid, COLOR_P@, string); 
        format(string, sizeof(string), "Zaoferowa³eœ naprawê dla %s za %d$ - odczekaj chwilê, a¿ gracz akceptuje twoj¹ ofertê!", GetNick(giveplayerid), valueCost); 
        sendTipMessageEx(playerid, COLOR_P@, string); 
        RepairOffer[giveplayerid] = playerid;
        RepairPrice[giveplayerid] = valueCost;
        SpamujeMechanik[playerid] = 1;
        SetTimerEx("AntySpamMechanik",30000,0,"d",playerid);
    }
    else
    {
        sendErrorMessage(playerid, "Odczekaj 30 sekund!"); 
    }
    return 1;
}

//end