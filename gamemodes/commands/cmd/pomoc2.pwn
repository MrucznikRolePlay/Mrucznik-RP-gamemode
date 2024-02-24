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
    SendClientMessage(playerid, COLOR_GRAD2,"*** CMD *** /report /anuluj /akceptuj /wywal /kontrakt /tankuj /kanister /oczysc /wezwij /rodziny");
    SendClientMessage(playerid, COLOR_GRAD2,"*** CMD *** (/p)rzedmioty /naprawpojazd /wywalmaterialy /wywaldragi /ugotuj /screenshot"); 
    SendClientMessage(playerid, COLOR_GRAD3,"*** CHAT *** (/w)iadomosc (/o)oc (/k)rzyk (/s)zept (/l)ocal (/b) (/og)loszenie (/f)amily /me (/n)ewbie /sprobuj /apteczka");
    SendClientMessage(playerid, COLOR_GRAD3,"*** BLOKADY *** /togooc /togdepo /togfam /togw /togtel /toglicznik /tognewbie /togadmin");
    SendClientMessage(playerid, COLOR_GRAD4,"*** BANK *** /stan /wyplac /bank /przelew /kb(kontobankowe)");
    if(PlayerInfo[playerid][pJob] == 1) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /namierz /wanted /poddajsie /zlecenie (/m)egafon"); }
    else if(PlayerInfo[playerid][pJob] == 2) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /uwolnij /oczyscmdc /zbijwl /wanted /kuppozwolenie"); }
    else if(PlayerInfo[playerid][pJob] == 3) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /sex"); }
    else if(PlayerInfo[playerid][pJob] == 4) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /sprzedajdragi /get drugs /wezdragi"); }
    else if(PlayerInfo[playerid][pJob] == 5) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /ukradnij"); }
    else if(PlayerInfo[playerid][pMember] == 9) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** /wywiad /news [text] /reflektor /studia /glosnik /radiostacja");
    SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** P³atny numer SMS - /sms [od 100 do 150], dostajesz tyle stówek ile jest po 1 (nr. 125 to 25 * 100 = 2500$)");
    SendClientMessage(playerid,COLOR_GRAD5,"*** SAN NEWS *** /zamknijlinie /otworzlinie /linie"); }
    else if(PlayerInfo[playerid][pJob] == 7) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /napraw /tankowanie /sluzba /sprawdzneon /sprzedajzestaw"); }// /nitro /hydraulika /maluj /felga /zderzak");
    //SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /kolory /malunki /felgi /sluzba"); }
    else if(PlayerInfo[playerid][pJob] == 8) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /ochrona"); }
    else if(PlayerInfo[playerid][pJob] == 9) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /materialy /sprzedajbron"); }
    else if(PlayerInfo[playerid][pJob] == 12) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /walka /boxstats /naucz"); }
    else if(PlayerInfo[playerid][pJob] == JOB_TRUCKER) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /zlecenie - nowe zlecenia s¹ od wy¿szego skilla!"); }
    else if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10 || PlayerInfo[playerid][pJob] == 10) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /fare /businfo"); }
    else if(PlayerInfo[playerid][pJob] == 15) {
    SendClientMessage(playerid,COLOR_GRAD5,"*** PRACA *** /gazety /wezgazete /gazeta"); }
    if(PlayerInfo[playerid][pMember] == 11||PlayerInfo[playerid][pLider] == 11){
    SendClientMessage(playerid,COLOR_GRAD5,"*** DMV *** /startlekcja /stoplekcja /zaliczegz /dajlicencje /odmv /cdmv"); }
    if(PlayerInfo[playerid][pMember] == 8||PlayerInfo[playerid][pLider] == 8){
    SendClientMessage(playerid,COLOR_GRAD5,"*** Hitman Agency *** /laptop /zmienskin /reklama /namierz"); }
    if(PlayerInfo[playerid][pMember] == 7||PlayerInfo[playerid][pLider] == 7){
    SendClientMessage(playerid,COLOR_GRAD5,"*** GSA *** /wywalzdmv /radio /family"); }
    if(PlayerInfo[playerid][pMember] == 15||PlayerInfo[playerid][pLider] == 15){
    SendClientMessage(playerid,COLOR_GRAD5,"*** FDU *** /sprzedajneon /napraw /tankowanie /nitro /hydraulika /maluj /felga /zderzak");
    SendClientMessage(playerid,COLOR_GRAD5,"*** FDU *** /kolory /malunki /felgi /sluzba");
    SendClientMessage(playerid,COLOR_GRAD5,"*** WYSCIGI *** /stworzwyscig /wyscigi /wyscig /wyscig_start /wyscig_stop /cp /cp-usun /meta");         }
    if(IsAPrzestepca(playerid)){
    SendClientMessage(playerid,COLOR_GRAD5,"*** Przestêpcze *** /pobij /zwiaz /odwiaz /wepchnij /sprzedaja /maska /zabierzgps /graffiti /napad");
    SendClientMessage(playerid, COLOR_GRAD2, "*** Boombox *** /(boombox) off | /boombox on | /boombox url [URL] | /boombox znajdz");}
    if(GetPlayerOrg(playerid) == FAMILY_VINYL || GetPlayerOrg(playerid) == FAMILY_ALHAMBRA) SendClientMessage(playerid,COLOR_GRAD5,"*** Klub *** /dajbilet");
    if(GetPlayerOrg(playerid) == FAMILY_IBIZA) SendClientMessage(playerid,COLOR_GRAD5,"*** Klub *** /dajbilet /ibiza /konsola  /sprzedajalkohol /wywalibiza /zabierzbilet /glosnik");
    if (IsAPolicja(playerid))
    {
        SendClientMessage(playerid, COLOR_GRAD5, "*** Policja *** /przeszukaj /zabierz /mandat /wywaz /gps /odznaka /maska");
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
        SendClientMessage(playerid, COLOR_GRAD5, "*** Stra¿ *** /straz /megafon /ro /r /duty /czysc");
    }
    if (gTeam[playerid] == 1 || PlayerInfo[playerid][pMember] == 4 || PlayerInfo[playerid][pLider] == 4)
    {
        SendClientMessage(playerid, COLOR_GRAD5, "*** Lekarz *** (/r)adio (/d)epartment /sluzba /finfo /sprzedajapteczke /togbw /togdepo");
        SendClientMessage(playerid, COLOR_GRAD5, "*** Lekarz ***/ulecz /apteczka /zastrzyk /diagnoza /zmienplec /kuracja /maseczka");
    }
    if (PlayerInfo[playerid][pAdmin] >= 1)
    {
        SendClientMessage(playerid, COLOR_GRAD6, "*** ADMIN *** (/a)dmin (/ah)elp");
    }
    SendClientMessage(playerid, COLOR_GRAD6,"*** INNE *** /telefonpomoc /dompomoc /wynajempomoc /bizpomoc /liderpomoc /rybypomoc /ircpomoc /anim");
    SendClientMessage(playerid, COLOR_GRAD6,"*** INNE *** Pomoc od supportu: {FFFFFF}/zapytaj");
    return 1;
}
