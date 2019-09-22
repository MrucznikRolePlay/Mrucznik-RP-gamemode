//-----------------------------------------------<< Source >>------------------------------------------------//
//                                              setvregistration                                             //
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
// Data utworzenia: 22.09.2019


//

//------------------<[ Implementacja: ]>-------------------
command_setvregistration_Impl(playerid, registerText[32])
{
    if(PlayerInfo[playerid][pAdmin] > 1500 || IsAScripter(playerid))
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            new vehID = GetPlayerVehicleID(playerid);
            new string[124];
            SetVehicleNumberPlate(vehID, registerText);
            format(string, sizeof(string), "Administrator %s ustawi³ tablicê dla pojazdu %d - nowy text [%s]", GetNick(playerid), vehID, registerText);
            SendMessageToAdminEx(string, COLOR_P@, 2);
        }
        else
        {
            sendErrorMessage(playerid, "Musisz byæ w pojeŸdzie!");
        }
    }
    return 1;
}

//end