//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   zrzut                                                   //
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
// Data utworzenia: 04.05.2024


//

//------------------<[ Implementacja: ]>-------------------
command_zrzut_Impl(playerid)
{
    new vehicleID = GetPlayerVehicleID(playerid);
    if(!IsAWodolot(vehicleID))
    {
        MruMessageFail(playerid, "Musisz znajdowaæ siê w wodolocie by zrzuciæ kontrabandê.");
        return 1;
    }

    new actionID = GetPlayerSmugglingActionID(playerid);
    if(actionID == -1)
    {
        MruMessageFail(playerid, "Nie organizujesz akcji przemytniczej.");
        return 1;
    }

    new role = GetPlayerSmugglingRole(playerid);
    if(role != SMUGGLING_ROLE_INITIATOR)
    {
        MruMessageFail(playerid, "Nie jesteœ inicjatorem akcji przemytniczej - nie mo¿esz zrzucaæ paczek z kontraband¹");
        return 1;
    }

    if(SmugglingAction[actionID][s_enableContrabandDrop] < 1)
    {
        MruMessageFail(playerid, "Musisz przelecieæ przez "#CHECKPOINT_PER_DROP" checkpointy by móc zrzuciæ 1 paczkê kontrabandy.");
        return 1;
    }

    new driverid = GetVehicleDriverID(vehicleID);
    if(GetPlayerSmugglingRole(driverid) != SMUGGLING_ROLE_DRIVER || PlayerInfo[driverid][pUID] != SmugglingAction[actionID][s_driverUID])
    {
        MruMessageFail(playerid, "Gracz który jest kierowc¹ wodolotu nie zosta³ wybrany jako kierowca w tej akcji przemytniczej.");
        return 1;
    }

    if(!IsAtViceCityMainland(playerid))
    {
        MruMessageFail(playerid, "Zrzucaæ paczki mo¿esz tylko w Vice City Beach.");
        return 1;
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if(z <= 20.0)
    {
        MruMessageFail(playerid, "Jesteœ za nisko, powiec kierowcy by wzlecia³ wy¿ej.");
        return 1;
    }

    if(z >= 60.0)
    {
        MruMessageFail(playerid, "Jesteœ za wysoko, powiedz kierowcy by zni¿y³ lot");
        return 1;
    }

    ChatMe(playerid, "wyrzuca z wodolotu paczkê z kontraband¹");
    SmugglingAction[actionID][s_enableContrabandDrop] = 0;
    SmugglingAction[actionID][s_packagesToDrop]--;

    GetPosBehindVehicle(vehicleID, x, y, z, 1.0);
    CreateContrabandDrop(actionID, x, y, z, SmugglingAction[actionID][s_packagesToDrop]);
    PlayerPlaySound(playerid, 1039, 0, 0, 0);

    if(SmugglingAction[actionID][s_packagesToDrop] == 0)
    {
        // last package dropped, start gather stage
        SmugglingAction[actionID][s_stage] = SMUGGLING_STAGE_GATHER;
        MruMessageGoodInfo(playerid, "To by³a ostatnia paczka kontrabandy, teraz udaj siê do punktu zboru i czekaj a¿ Twoi wspólnicy zbior¹ wszystkie paczki.");
        SendSmugglingCrewMessage(playerid, TEAM_AZTECAS_COLOR, sprintf("%s zrzuci³ ostatni¹ paczkê z kontraband¹.", GetNick(playerid)));
    }
    else 
    {
        MruMessageGoodInfo(playerid, "Zrzuci³eœ paczkê kontrabandy!");
        SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, sprintf("%s zrzuci³ paczkê z kontraband¹.", GetNick(playerid)));
        ShowSmugglingCheckpoint(playerid, actionID);
        foreach(new i : Player)
        {
            if(PlayerInfo[i][pUID] == SmugglingAction[actionID][s_driverUID])
            {
                ShowSmugglingCheckpoint(i, actionID);
            }
        }
    }
    return 1;
}

//end