//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  przemyt                                                  //
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
// Data utworzenia: 31.03.2024


//

//------------------<[ Implementacja: ]>-------------------
command_przemyt_Impl(playerid)
{
    if(GetPlayerJob(playerid) != JOB_SMUGGLER)
    {
        MruMessageFail(playerid, "Nie jeste� przemytnikiem.");
        return 1;
    }

    if(!IsAPrzestepca(playerid))
    {
        MruMessageFail(playerid, "Nie jeste� w organizacji przest�pczej - tylko organizacje przest�pcze mog� organizowa� przemyt.");
        return 1;
    }

    if(IsPlayerSmuggling(playerid))
    {
        new actionID = GetPlayerSmugglingActionID(playerid);
        if(actionID == -1)
        {
            MruMessageError(playerid, "Nie uda�o si� pobra� ID akcji przemytniczej. Zg�o� b��d adminom. Tw�j udzia� w akcji zosta� anulowany.");
            RedisDelete(sprintf("player:%d:smuggling", PlayerInfo[playerid][pUID]));
            RedisDelete(sprintf("player:%d:smuggling:role", PlayerInfo[playerid][pUID]));
            return 1;
        }

        switch(SmugglingAction[actionID][s_stage])
        {
            case SMUGGLING_STAGE_PICKUP:
            {
                przemyt_StagePickup(playerid, actionID);
            }
            case SMUGGLING_STAGE_FLY:
            {
                MruMessageInfo(playerid, "Musisz teraz dolecie� do punktu kontrolnego nad Prawn Island, Vice City");
            }
            case SMUGGLING_STAGE_DROP:
            {
                MruMessageInfo(playerid, "Musisz teraz zrzuci� 5 paczek kontrabandy, a nast�pnie Twoi partnerzy lub Ty powinni dostarczy� je do punktu odbioru.");
            }
            case SMUGGLING_STAGE_GATHER:
            {
                MruMessageInfo(playerid, "Wszystkie paczki zosta�y zrzucione, teraz musisz dostarczy� je do punktu odbioru.");
            }
            case SMUGGLING_STAGE_END:
            {
                przemyt_StageEnd(playerid, actionID);
            }
            default:
            {
                MruMessageError(playerid, "B��d - zg�o� go Mrucznikowi.");
            }
        }
        return 1;
    }

    ChatMe(playerid, "wyci�ga telefon i dzwoni um�wi� akcj� przemytnicz�");

    new hour,minute,second;
    gettime(hour, minute, second);
    if(hour < 18 || hour > 23)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie ma dost�pnych przemyt�w w tym momencie. Zadzwo� mi�dzy 18 a 23.");
        SendClientMessage(playerid, COLOR_GRAD2, "Marcepan_Marks roz��czy� si�.");
        return 1;
    }

    if(SmugglingActionsCount >= SMUGGLING_ACTIONS_PER_DAY)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Przemycili�my ju� zbyt du�o dzisiejszego dnia. Musimy przystopowa�, by nikt si� nie po�apa�.");
        SendClientMessage(playerid, COLOR_GRAD2, "Marcepan_Marks roz��czy� si�.");
        return 1;
    }

    if(!(IsPlayerAtViceCityMainland(playerid) && GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Tw�j telefon mo�e znajdowa� si� na pods�uchu!");
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Zadzwo� ustali� szczeg�y gdy b�dziesz na wyspie Mainland w Vice City!");
        SendClientMessage(playerid, COLOR_GRAD2, "Marcepan_Marks roz��czy� si�.");
        return 1;
    }

    new players;
    foreach(new i : Player)
    {
        if(IsAPolicja(i) || GetPlayerJob(i) == JOB_SMUGGLER || GetPlayerJob(i) == JOB_LOWCA)
        {
            players++;
        }
    }
    if(players < 3)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Niestety, ma�y ruch w interesie, nie ma z kim organizowa� akcji przemytniczych.");
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Zadzwo�, gdy w mie�cie b�dzie wi�cej ruchu. ((minimum 3 graczy z prac� �owcy/przemytnika/policjanta na serwerze))");
        SendClientMessage(playerid, COLOR_GRAD2, "Marcepan_Marks roz��czy� si�.");
        return 1;
    }

    SetPVarInt(playerid, "smuggling", 1);
    MruMessageInfo(playerid, "Rozpocz��e� umawianie akcji przemytniczej, aby z niej zrezygnowa�, wpisz: /z");
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);

    SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Dobrze, �e dzwonisz. W�a�nie zmierzamy z kontraband� do Vice City.");
    SendClientMessage(playerid, COLOR_YELLOW, sprintf("Telefon (Marcepan_Marks): Sprzedajemy j� za %d$. Zainteresowany zorganizowaniem akcji przemytniczej?", SMUGGLING_COST));
    MruMessageInfo(playerid, "Wpisz 'tak' aby kontynuowa�.");
    return 1;
}


przemyt_StagePickup(playerid, actionID)
{
    if(GetPlayerSmugglingRole(playerid) != SMUGGLING_ROLE_INITIATOR)
    {
        MruMessageFail(playerid, "Tylko inicjator akcji przemytniczej mo�e odebra� kontraband� z punktu odbioru.");
        return 1;
    }

    if(!IsPlayerInRangeOfPoint(playerid, 15.0, SmugglingAction[actionID][s_pickupPointX], SmugglingAction[actionID][s_pickupPointY], SmugglingAction[actionID][s_pickupPointZ]))
    {
        MruMessageFail(playerid, "Nie jeste� przy punkcie odbioru kontrabandy.");
        return 1;
    }

    new vehicleID = GetPlayerVehicleID(playerid);
    if(!IsPlayerInAnyVehicle(playerid) || !IsAWodolot(vehicleID))
    {
        MruMessageFail(playerid, "Musisz znajdowa� si� w wodolocie by odebra� kontraband�.");
        return 1;
    }

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        MruMessageFail(playerid, "Musisz by� pasa�erem wodolotu. Tw�j kierowca powinien nim kierowa�.");
        return 1;
    }

    new driverid = GetVehicleDriverID(vehicleID);
    if(driverid == INVALID_PLAYER_ID)
    {
        MruMessageFail(playerid, "W wodolocie nie ma kierowcy. Tw�j kierowca powinien nim kierowa�.");
        return 1;
    }

    if(GetPlayerSmugglingRole(driverid) != SMUGGLING_ROLE_DRIVER || PlayerInfo[driverid][pUID] != SmugglingAction[actionID][s_driverUID])
    {
        MruMessageFail(playerid, "Gracz kt�ry jest kierowc� wodolotu nie zosta� wybrany jako kierowca w tej akcji przemytniczej.");
        return 1;
    }

    DisablePlayerCheckpoint(playerid);
    DisablePlayerCheckpoint(driverid);

    StartSmugglingDrop(playerid, driverid, actionID);
    return 1;
}

przemyt_StageEnd(playerid, actionID)
{
    if(GetPlayerSmugglingRole(playerid) != SMUGGLING_ROLE_INITIATOR)
    {
        MruMessageFail(playerid, "Tylko inicjator akcji przemytniczej mo�e odebra� kontraband� z punktu zboru.");
        return 1;
    }

    if(!IsPlayerInRangeOfPoint(playerid, 15.0, SmugglingAction[actionID][s_gatherPointX], SmugglingAction[actionID][s_gatherPointY], SmugglingAction[actionID][s_gatherPointZ]))
    {
        MruMessageFail(playerid, "Nie jeste� przy punkcie zboru.");
        return 1;
    }

    new contraband = SmugglingAction[actionID][s_contrabandGathered];
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_BOAT))
    {
        contraband = floatround(contraband * 1.2); // +20%
    }

    ChatMe(playerid, "zabiera paczki kontrabandy z punktu zboru.");

    MruMessageGoodInfo(playerid, "Gratulacje! Uda�o Ci si� zako�czy� akcj� przemytnicz�.");
    MruMessageGoodInfoF(playerid, "Uda�o Ci si� zdoby� %d paczek kontrabandy.", contraband);
    SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, sprintf("%s zgarn�� %d paczek kontrabandy.", GetNick(playerid), contraband));

    GiveContraband(playerid, contraband);
    Log(payLog, INFO, "Gracz %s odebral %d kontrabandy z akcji przemytniczej.", GetPlayerLogName(playerid));

    EndSmuggling(actionID);
    return 1;
}

//end