//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   konwoj                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 20.10.2019


//

//------------------<[ Implementacja: ]>-------------------
command_konwoj_Impl(playerid)
{
    new hour, minute, second;
    gettime(hour, minute, second);

    if(!IsPlayerInSecuriCar(playerid))
    {
        sendErrorMessage(playerid, "Musisz byæ w pojeŸdzie konwojowym (securicar) aby rozpocz¹æ konwój.");
        return 1;
    }

    if(PlayerInfo[playerid][pAdmin] < 1) 
    {
        if(!IsAConvoyTeamLeader(playerid))
        {
            sendErrorMessage(playerid, "Nie masz wystarczaj¹cych uprawnieñ aby zorganizowaæ konwój.");
            return 1;
        }

        if(hour < 12 || hour > 21)
        {
            sendErrorMessage(playerid, "Konwój mo¿na wystartowaæ tylko od godziny 12:00 do 22:00.");
            return 1;
        }

        if(convoyDelayed)
        {
            sendErrorMessage(playerid, "Nastêpny konwój mo¿na wystartowaæ dopiero po 3 godzinach od ukoñczenia ostatniego.");
            return 1;
        }

        if(kaska[playerid] < CONVOY_PRICE)
        {
            sendErrorMessage(playerid, "Zorganizowanie konwoju kosztuje "#CONVOY_PRICE"$ a Ty tyle nie masz.");
            return 1;
        }
    }

    if(ConvoyStarted)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Konwój stop");
        StopConvoy(CONVOY_STOP_ADMIN);
        return 1;
    }

    StartConvoy(playerid, GetPlayerVehicleID(playerid));
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wystartowa³eœ konwój. Po dojechaniu do celu otrzymasz nagrodê.");
    ZabierzKase(playerid, CONVOY_PRICE);

    Log(adminLog, INFO, "Admin %s wystartowa³ konwój", 
        GetPlayerLogName(playerid)
    );
    return 1;
}

//end