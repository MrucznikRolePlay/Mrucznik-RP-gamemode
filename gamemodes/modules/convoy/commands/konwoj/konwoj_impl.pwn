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

    if( !(IsACop(playerid) && PlayerInfo[playerid][pRank] >= 8))
    {
        sendErrorMessage(playerid, "Musisz byæ w organizacji porz¹dkowej i mieæ conajmniej 8 rangê aby rozpocz¹æ konwój.");
        return 1;
    }
    
    if(!IsPlayerInSecuriCar(playerid))
    {
        sendErrorMessage(playerid, "Musisz byæ w pojeŸdzie konwojowym (securicar) aby rozpocz¹æ konwój.");
        return 1;
    }

    if(hour < 15 || hour > 22)
    {
        sendErrorMessage(playerid, "Konwój mo¿na wystartowaæ tylko od godziny 15:00 do 23:00.");
        return 1;
    }

    if(ConvoyStarted)
    {
        sendErrorMessage(playerid, "Konwój ju¿ jest aktywny, nie mo¿esz go wystartowaæ ponownie.");
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

    StartConvoy(playerid, GetPlayerVehicleID(playerid));
    SendClientMessage(playerid, -1, "Wystartowa³eœ konwój. Po dojechaniu do celu otrzymasz");
    return 1;
}

//end