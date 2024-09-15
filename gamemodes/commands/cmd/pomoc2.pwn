//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ pomoc2 ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:pomoc2(playerid, params[], help)
{
    SendClientMessage(playerid, COLOR_GRAD1,"*** KONTO *** /stats /nextlevel /ulepszenia /personalizuj");
    SendClientMessage(playerid, COLOR_GRAD2,"*** CMD *** /plac /datek /czas /kup /wyrzucbronie /dajkluczyki /id /pij /muzyka /pokazlicencje /ubranie");
    SendClientMessage(playerid, COLOR_GRAD2,"*** CMD *** /resetulepszen(100k) /lock /skill /licencje /lotto /zmienspawn /stopani /pobij /wyscigi");
    SendClientMessage(playerid, COLOR_GRAD2,"*** CMD *** /report /anuluj /akceptuj /wywal /kontrakt /tankuj /kanister /oczysc /wezwij /organizacje");
    SendClientMessage(playerid, COLOR_GRAD2,"*** CMD *** (/p)rzedmioty /naprawpojazd /wywalmaterialy /wywaldragi /ugotuj /screenshot /pancerz"); 
    SendClientMessage(playerid, COLOR_GRAD3,"*** CHAT *** (/w)iadomosc (/o)oc (/k)rzyk (/s)zept (/l)ocal (/b) (/og)loszenie (/f)amily /me (/n)ewbie /sprobuj /apteczka");
    SendClientMessage(playerid, COLOR_GRAD3,"*** BLOKADY *** /togooc /togdepo /togfam /togw /togtel /toglicznik /tognewbie /togadmin /togopis /togvopis");
    SendClientMessage(playerid, COLOR_GRAD4,"*** BANK *** /stan /wyplac /bank /przelew /kb(kontobankowe)");

    switch(GetPlayerJob(playerid))
    {
        case JOB_LOWCA: { SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /namierz /wanted /poddajsie /zlecenie (/m)egafon"); }
        case JOB_LAWYER: { SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /uwolnij /oczyscmdc /zbijwl /wanted /kuppozwolenie"); }
		case JOB_PROSTITUTE: { SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /sex"); }
		case JOB_DRUG_DEALER: { SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /sprzedajdragi /get drugs /wezdragi /diluj"); }
		case JOB_CARTHIEF: { SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /ukradnij"); }
		// case JOB_REPORTER: { }
		case JOB_MECHANIC: 
        { 
            SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /napraw /tankowanie /sluzba /sprawdzneon /sprzedajzestaw /sprzedajneon");
            SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /nitro /hydraulika /maluj /felga /zderzaki /kolory /malunki /felgi");
        }
		case JOB_SMUGGLER: { SendClientMessage(playerid, COLOR_GRAD5,"*** PRACA *** /sprzedajprzemyt /przemyt /zrzut /sprzedajkontrabande"); }
		case JOB_GUN_DEALER: { SendClientMessage(playerid, COLOR_GRAD5,"*** PRACA *** /materialy /sprzedajbron"); }
		case JOB_DRIVER: { SendClientMessage(playerid, COLOR_GRAD5,"*** PRACA *** /kurs /duty /businfo /trasa /zakoncztrase /zd "); }
		case JOB_MEDIC: { 
            SendClientMessage(playerid, COLOR_GRAD5, "*** PRACA *** /sluzba /czysc /wez gasnice /wez mundur /rezonans /zmienplec");
            SendClientMessage(playerid, COLOR_GRAD5, "*** PRACA *** /sprzedajapteczke /ulecz /apteczka /zastrzyk /diagnoza /kuracja /maseczka"); 
        }
		case JOB_BOXER: { SendClientMessage(playerid, COLOR_GRAD5,"*** PRACA *** /walka /boxstats /naucz"); }
		// case JOB_RESERVED_1: { }
		// case JOB_RESERVED_2: { }
		// case JOB_RESERVED_3: { }
		case JOB_TRUCKER: { SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /zlecenie - nowe zlecenia s¹ od wy¿szego skilla!"); }
    }
    
    if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** /wywiad /news [text] /reflektor /studia /glosnik /radiostacja");
    SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** P³atny numer SMS - /sms [od 100 do 150], dostajesz tyle stówek ile jest po 1 (nr. 125 to 25 * 100 = 2500$)");
    SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** /zamknijlinie /otworzlinie /linie"); }
    else if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10) {
        SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /kurs /duty /businfo /trasa /zakoncztrase /zd ");
    }
    if(PlayerInfo[playerid][pMember] == 11||PlayerInfo[playerid][pLider] == 11){
    SendClientMessage(playerid,COLOR_GRAD5,"*** DMV *** /startlekcja /stoplekcja /zaliczegz /dajlicencje /odmv /cdmv"); }
    if(PlayerInfo[playerid][pMember] == 8||PlayerInfo[playerid][pLider] == 8){
    SendClientMessage(playerid,COLOR_GRAD5,"*** Hitman Agency *** /laptop /zmienskin /reklama /namierz"); }
    if(PlayerInfo[playerid][pMember] == 7||PlayerInfo[playerid][pLider] == 7){
    SendClientMessage(playerid,COLOR_GRAD5,"*** GSA *** /wywalzdmv /radio /family"); }
    if(PlayerInfo[playerid][pMember] == 15||PlayerInfo[playerid][pLider] == 15){
    SendClientMessage(playerid,COLOR_GRAD5,"*** FDU *** /sprzedajneon /napraw /tankowanie /nitro /hydraulika /maluj /felga /zderzaki");
    SendClientMessage(playerid,COLOR_GRAD5,"*** FDU *** /kolory /malunki /felgi /sluzba");
    SendClientMessage(playerid,COLOR_GRAD5,"*** WYSCIGI *** /stworzwyscig /wyscigi /wyscig /wyscig_start /wyscig_stop /cp /cp-usun /meta");         }
    if(IsAPrzestepca(playerid)){
    SendClientMessage(playerid,COLOR_GRAD5,"*** Przestêpcze *** /pobij /zwiaz /odwiaz /wepchnij /sprzedaja /maska /zabierzgps /graffiti /napad");
    SendClientMessage(playerid, COLOR_GRAD2, "*** Boombox *** /(boombox) off | /boombox on | /boombox url [URL] | /boombox znajdz");}
    if(IsAClubBusinessOwner(playerid)) SendClientMessage(playerid,COLOR_GRAD5,"*** Klub *** /dajbilet /ibiza /konsola  /sprzedajalkohol /wywalibiza /zabierzbilet /glosnik");
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
    if (PlayerInfo[playerid][pAdmin] >= 1)
    {
        SendClientMessage(playerid, COLOR_GRAD6, "*** ADMIN *** (/a)dmin (/ah)elp");
    }
    SendClientMessage(playerid, COLOR_GRAD6,"*** INNE *** /telefonpomoc /dompomoc /wynajempomoc /bizpomoc /liderpomoc /rybypomoc /ircpomoc /anim");
    SendClientMessage(playerid, COLOR_GRAD6,"*** INNE *** Pomoc od supportu: {FFFFFF}/zapytaj");
    return 1;
}
