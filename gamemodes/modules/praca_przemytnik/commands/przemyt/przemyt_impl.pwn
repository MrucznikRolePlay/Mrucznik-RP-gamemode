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
        MruMessageFail(playerid, "Nie jesteœ przemytnikiem.");
        return 1;
    }

    if(!IsAPrzestepca(playerid))
    {
        MruMessageFail(playerid, "Nie jesteœ w organizacji przestêpczej, tylko organizacje przestêpcze mog¹ organizowaæ przemyt.");
        return 1;
    }

    if(IsPlayerSmuggling(playerid))
    {
        new actionID = GetPlayerSmugglingActionID(playerid);
        if(actionID == -1)
        {
            MruMessageError(playerid, "Nie uda³o siê pobraæ ID akcji przemytniczej. Zg³oœ b³¹d adminom.");
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
                MruMessageInfo(playerid, "Musisz teraz dolecieæ do punktu kontrolnego nad Prawn Island, Vice City");
            }
            case SMUGGLING_STAGE_DROP:
            {
                MruMessageInfo(playerid, "Musisz teraz zrzuciæ 5 paczek kontrabandy, a nastêpnie Twoi partnerzy lub Ty powinni dostarczyæ je do punktu odbioru.");
            }
            case SMUGGLING_STAGE_GATHER:
            {
                MruMessageInfo(playerid, "Wszystkie paczki zosta³y zrzucione, teraz musisz dostarczyæ je do punktu odbioru.");
            }
            case SMUGGLING_STAGE_END:
            {
                przemyt_StageEnd(playerid, actionID);
            }
            default:
            {
                MruMessageError(playerid, "B³¹d - zg³oœ go Mrucznikowi.");
            }
        }
        return 1;
    }

    ChatMe(playerid, "wyci¹ga telefon i dzwoni umówiæ akcjê przemytnicz¹");

    new hour,minute,second;
    gettime(hour, minute, second);
    if(hour < 18 || hour > 23)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Nie ma dostêpnych przemytów w tym momencie. Zadzwoñ miêdzy 18 a 23.");
        SendClientMessage(playerid, COLOR_GRAD2, "Marcepan_Marks roz³¹czy³ siê.");
        return 1;
    }

    if(SmugglingActionsCount >= SMUGGLING_ACTIONS_PER_DAY)
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Przemyciliœmy ju¿ zbyt du¿o dzisiejszego dnia. Musimy przystopowaæ, by nikt siê nie po³apa³.");
        SendClientMessage(playerid, COLOR_GRAD2, "Marcepan_Marks roz³¹czy³ siê.");
        return 1;
    }

    if(!(IsPlayerAtViceCityMainland(playerid) && GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Twój telefon mo¿e znajdowaæ siê na pods³uchu!");
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Zadzwoñ ustaliæ szczegó³y gdy bêdziesz na wyspie Mainland w Vice City!");
        SendClientMessage(playerid, COLOR_GRAD2, "Marcepan_Marks roz³¹czy³ siê.");
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
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Niestety, ma³y ruch w interesie, nie ma z kim organizowaæ akcji przemytniczych.");
        SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Zadzwoñ, gdy w mieœcie bêdzie wiêcej ruchu. ((minimum 3 graczy z prac¹ ³owcy/przemytnika/policjanta na serwerze))");
        SendClientMessage(playerid, COLOR_GRAD2, "Marcepan_Marks roz³¹czy³ siê.");
        return 1;
    }

    SetPVarInt(playerid, "smuggling", 1);
    MruMessageInfo(playerid, "Rozpocz¹³eœ umawianie akcji przemytniczej, aby z niej zrezygnowaæ, wpisz: /z");
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);

    SendClientMessage(playerid, COLOR_YELLOW, "Telefon (Marcepan_Marks): Dobrze, ¿e dzwonisz. W³aœnie zmierzamy z kontraband¹ do Vice City.");
    SendClientMessage(playerid, COLOR_YELLOW, sprintf("Telefon (Marcepan_Marks): Sprzedajemy j¹ za %d$. Zainteresowany zorganizowaniem akcji przemytniczej?", SMUGGLING_COST));
    MruMessageInfo(playerid, "Wpisz 'tak' aby kontynuowaæ.");
    return 1;
}


przemyt_StagePickup(playerid, actionID)
{
    if(GetPlayerSmugglingRole(playerid) != SMUGGLING_ROLE_INITIATOR)
    {
        MruMessageFail(playerid, "Tylko inicjator akcji przemytniczej mo¿e odebraæ kontrabandê z punktu odbioru.");
        return 1;
    }

    if(!IsPlayerInRangeOfPoint(playerid, 15.0, SmugglingAction[actionID][s_pickupPointX], SmugglingAction[actionID][s_pickupPointY], SmugglingAction[actionID][s_pickupPointZ]))
    {
        MruMessageFail(playerid, "Nie jesteœ przy punkcie odbioru kontrabandy.");
        return 1;
    }

    new vehicleID = GetPlayerVehicleID(playerid);
    if(!IsPlayerInAnyVehicle(playerid) || !IsAWodolot(vehicleID))
    {
        MruMessageFail(playerid, "Musisz znajdowaæ siê w wodolocie by odebraæ kontrabandê.");
        return 1;
    }

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        MruMessageFail(playerid, "Musisz byæ pasa¿erem wodolotu. Twój kierowca powinien nim kierowaæ.");
        return 1;
    }

    new driverid = GetVehicleDriverID(vehicleID);
    if(GetPlayerSmugglingRole(driverid) != SMUGGLING_ROLE_DRIVER || PlayerInfo[driverid][pUID] != SmugglingAction[actionID][s_driverUID])
    {
        MruMessageFail(playerid, "Gracz który jest kierowc¹ wodolotu nie zosta³ wybrany jako kierowca w tej akcji przemytniczej.");
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
        MruMessageFail(playerid, "Tylko inicjator akcji przemytniczej mo¿e odebraæ kontrabandê z punktu zboru.");
        return 1;
    }

    if(!IsPlayerInRangeOfPoint(playerid, 15.0, SmugglingAction[actionID][s_gatherPointX], SmugglingAction[actionID][s_gatherPointY], SmugglingAction[actionID][s_gatherPointZ]))
    {
        MruMessageFail(playerid, "Nie jesteœ przy punkcie zboru.");
        return 1;
    }

    ChatMe(playerid, "zabiera paczki kontrabandy z punktu zboru.");

    MruMessageGoodInfo(playerid, "Gratulacje! Uda³o Ci siê zakoñczyæ akcjê przemytnicz¹.");
    MruMessageGoodInfoF(playerid, "Uda³o Ci siê zdobyæ %d paczek kontrabandy.", SmugglingAction[actionID][s_contrabandGathered]);
    SendSmugglingCrewMessage(actionID, TEAM_AZTECAS_COLOR, sprintf("%s zgarn¹³ %d paczek kontrabandy.", GetNick(playerid), SmugglingAction[actionID][s_contrabandGathered]));

    GiveContraband(playerid, SmugglingAction[actionID][s_contrabandGathered]);

    EndSmuggling(actionID);
    return 1;
}

//end