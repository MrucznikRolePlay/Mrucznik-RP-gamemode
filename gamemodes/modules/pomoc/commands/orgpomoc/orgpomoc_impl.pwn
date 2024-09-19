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
    if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9) 
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** /wywiad /news [text] /reflektor /studia /glosnik /radiostacja");
        SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** P³atny numer SMS - /sms [od 100 do 150], dostajesz tyle stówek ile jest po 1 (nr. 125 to 25 * 100 = 2500$)");
        SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** /zamknijlinie /otworzlinie /linie"); 
    }
    else if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10) 
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /kurs /duty /businfo /trasa /zakoncztrase /zd ");
    }
    if(PlayerInfo[playerid][pMember] == 11||PlayerInfo[playerid][pLider] == 11)
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** DMV *** /startlekcja /stoplekcja /zaliczegz /dajlicencje /odmv /cdmv"); 
    }
    if(PlayerInfo[playerid][pMember] == 8||PlayerInfo[playerid][pLider] == 8)
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** Hitman Agency *** /laptop /zmienskin /reklama /namierz"); 
    }
    if(PlayerInfo[playerid][pMember] == 7||PlayerInfo[playerid][pLider] == 7)
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** GSA *** /wywalzdmv /radio /family"); 
    }
    if(PlayerInfo[playerid][pMember] == 15||PlayerInfo[playerid][pLider] == 15)
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** FDU *** /sprzedajneon /napraw /tankowanie /nitro /hydraulika /maluj /felga /zderzaki");
        SendClientMessage(playerid,COLOR_GRAD5,"*** FDU *** /kolory /malunki /felgi /sluzba");
        SendClientMessage(playerid,COLOR_GRAD5,"*** WYSCIGI *** /stworzwyscig /wyscigi /wyscig /wyscig_start /wyscig_stop /cp /cp-usun /meta");         
    }
    if(IsAPrzestepca(playerid))
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** Przestêpcze *** /pobij /zwiaz /odwiaz /wepchnij /sprzedaja /maska /zabierzgps /graffiti /napad");
        SendClientMessage(playerid, COLOR_GRAD2, "*** Boombox *** /(boombox) off | /boombox on | /boombox url [URL] | /boombox znajdz");
    }
    if(IsAClubBusinessOwner(playerid)) 
    {
        SendClientMessage(playerid,COLOR_GRAD5,"*** Klub *** /dajbilet /ibiza /konsola  /sprzedajalkohol /wywalibiza /zabierzbilet /glosnik");
    }
    if (IsAPolicja(playerid))
    {
        SendClientMessage(playerid, COLOR_GRAD5, "*** Policja *** /przeszukaj /zabierz /mandat /wywaz /gps /odznaka /maska /podszyj");
        SendClientMessage(playerid, COLOR_GRAD5, "*** Policja *** /barierka /kajdanki /rozkuj /mdc /aresztuj /sluzba /poszukiwani /dutycd");
        SendClientMessage(playerid, COLOR_GRAD5, "*** Policja *** (/r)adio (/d)epartment /ro(radiooc) /depo(departamentooc) (/m)egafon (/su)spect");
        SendClientMessage(playerid, COLOR_GRAD5, "*** Policja *** /togcrime /pozwolenie /finfo /red /c /tablet /togro /fed /togglepozwo");
    }
    if (PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pLider] == 2)
    {
        SendClientMessage(playerid, COLOR_GRAD5, "*** FBI *** /zmienskin /namierz /(fed)eralne /fbidrzwi");
    }
    if (PlayerInfo[playerid][pMember] == 17 || PlayerInfo[playerid][pLider] == 17)
    {
        SendClientMessage(playerid, COLOR_GRAD5, "*** Stra¿ *** /straz /megafon /ro /r /duty /czysc /wez gasnice /wez mundur");
    }
    if (PlayerInfo[playerid][pMember] == FRAC_ERS || PlayerInfo[playerid][pLider] == FRAC_ERS)
    {
        SendClientMessage(playerid, COLOR_GRAD5, "*** Lekarz *** (/r)adio (/d)epartment /sluzba /finfo /sprzedajapteczke /togbw /togdepo");
        SendClientMessage(playerid, COLOR_GRAD5, "*** Lekarz ***/ulecz /apteczka /zastrzyk /diagnoza /zmienplec /kuracja /maseczka");
    }
    if (IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_GUNSHOP))
    {
        if(IsPlayerOrgLeader(playerid))
            SendClientMessage(playerid, COLOR_GRAD5, "*** GUNSHOP *** /sprzedajmatsbot /gspanel");
        else
            SendClientMessage(playerid, COLOR_GRAD5, "*** GUNSHOP *** /sprzedajmatsbot");
    }
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________________________");
    return 1;
}

//end