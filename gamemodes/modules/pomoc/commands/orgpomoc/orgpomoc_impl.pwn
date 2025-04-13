//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  orgpomoc                                                 //
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
// Data utworzenia: 17.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_orgpomoc_Impl(playerid)
{
    if(GetPlayerOrg(playerid) == 0 && GetPlayerFraction(playerid) == 0)
    {
        MruMessageFail(playerid, "Nie jesteœ we frakcji/organizacji.");
        return 1;
    }

    SendClientMessage(playerid, COLOR_GREEN, "______________________ORG POMOC______________________");

    // --- Frakcje ---
    new member;
    if(PlayerInfo[playerid][pLider] > 0) member = PlayerInfo[playerid][pLider];
    else if(PlayerInfo[playerid][pMember] > 0) member = PlayerInfo[playerid][pMember];

    if(IsAPolicja(playerid))
    {
        SendClientMessage(playerid, COLOR_GRAD5, "*** Policja *** /przeszukaj /zabierz /mandat /wywaz /gps /odznaka /maska /podszyj");
        SendClientMessage(playerid, COLOR_GRAD5, "*** Policja *** /barierka /kajdanki /rozkuj /mdc /aresztuj /sluzba /poszukiwani /dutycd");
        SendClientMessage(playerid, COLOR_GRAD5, "*** Policja *** (/r)adio (/d)epartment /ro(radiooc) /depo(departamentooc) (/m)egafon (/su)spect");
        SendClientMessage(playerid, COLOR_GRAD5, "*** Policja *** /togcrime /pozwolenie /finfo /red /c /tablet /togro /fed /togglepozwo");
    }
    if(member == FRAC_FBI)
    {
        SendClientMessage(playerid, COLOR_GRAD5, "*** FBI *** /zmienskin /namierz /(fed)eralne /fbidrzwi");
    }
    else if(member == FRAC_ERS)
    {
        SendClientMessage(playerid, COLOR_GRAD5, "*** Lekarz *** (/r)adio (/d)epartment /sluzba /finfo /sprzedajapteczke /togbw /togdepo");
        SendClientMessage(playerid, COLOR_GRAD5, "*** Lekarz ***/ulecz /apteczka /zastrzyk /diagnoza /zmienplec /kuracja /maseczka");
        SendClientMessage(playerid, COLOR_GRAD5, "*** Stra¿ *** /straz /megafon /duty /czysc /wez gasnice /wez mundur");
    }
    else if(member == FRAC_BOR)
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** BOR *** /wywalzdmv /radio /family"); 
    }
    else if(member == FRAC_HA)
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** Hitman Agency *** /laptop /zmienskin /reklama /namierz"); 
    }
    else if(member == FRAC_SN) 
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** /wywiad /news [text] /reflektor /studia /glosnik /radiostacja");
        SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** P³atny numer SMS - /sms [od 100 do 150], dostajesz tyle stówek ile jest po 1 (nr. 125 to 25 * 100 = 2500$)");
        SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** /zamknijlinie /otworzlinie /linie"); 
    }
    else if(member == FRAC_KT) 
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** Korporacja Transportowa *** /kurs /duty /businfo /trasa /zakoncztrase /zd ");
    }
    else if(member == FRAC_GOV)
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** DMV *** /startlekcja /stoplekcja /zaliczegz /dajlicencje /odmv /cdmv"); 
    }

    // --- Organizacje ---
    if(IsAPrzestepca(playerid))
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** Przestêpcze *** /pobij /zwiaz /odwiaz /wepchnij /sprzedaja /maska /zabierzgps /graffiti /napad");
        SendClientMessage(playerid, COLOR_GRAD2, "*** Boombox *** /(boombox) off | /boombox on | /boombox url [URL] | /boombox znajdz");
    }
    if(IsAClubBusinessOwner(playerid)) 
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** Klub *** /sprzedajalkohol /glosnik");
        if (IsFrontBusinnesOwnedByPlayerOrg(playerid, 39))
            SendClientMessage(playerid,COLOR_GRAD5,"*** IBIZA *** /dajbilet /ibiza /konsola /wywalklub /zabierzbilet /cennik /polej");
        if (IsFrontBusinnesOwnedByPlayerOrg(playerid, 40))
            SendClientMessage(playerid,COLOR_GRAD5,"*** VINYL *** /dajbilet /vinyl /konsola /wywalklub /zabierzbilet /cennik /polej");
    }
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RESTAURANT))
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** Restauracja *** /sprzedajalkohol /sprzedajryby");         
    }
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RACE))
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** Tor wyœcigowy *** /stworzwyscig /wyscigi /wyscig /wyscig_start /wyscig_stop /cp /cp-usun /meta");         
    }
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_SPRAY))
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** Pay'N'Spray *** /sprzedajneon ");
    }
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_GUNSHOP))
    {
        if(IsPlayerOrgLeader(playerid))
            SendClientMessage(playerid, COLOR_GRAD5, "*** Gunshop *** /sprzedajmatsbot /gunshop");
        else
            SendClientMessage(playerid, COLOR_GRAD5, "*** Gunshop *** /sprzedajmatsbot");
    }

    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________________________");
    return 1;
}

//end