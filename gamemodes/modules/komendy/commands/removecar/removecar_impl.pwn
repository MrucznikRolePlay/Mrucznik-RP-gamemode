//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_removecar_Impl(playerid, params[256])
{
    if(!Uprawnienia(playerid, ACCESS_EDITCAR)) return 1;
    new car;
    if(sscanf(params, "d", car)) return sendTipMessage(playerid, "U¿yj /removecar [Car UID]");

    new uid = Car_GetIDXFromUID(car);
    if(uid == -1)
    {
        sendTipMessageEx(playerid, COLOR_GRAD2, "Pojazd nie by³ wczytany do systemu, inicjalizacja ...");
        uid = Car_LoadEx(car);
        if(uid == -1) return sendTipMessageEx(playerid, COLOR_GRAD2, "... brak pojazdu w bazie.");
    }
    new str[128];
    format(str, 128, "[CAR] Usuniêto pojazd (UID: %d) przez %s", CarData[uid][c_UID], GetNickEx(playerid));
	SendClientMessage(playerid, COLOR_GRAD2, str);
    Log(adminLog, INFO, "Admin %s usun¹³ pojazd o UID %d", GetPlayerLogName(playerid), CarData[uid][c_UID]);
    Car_Destroy(uid);

    return 1;
}

//end
