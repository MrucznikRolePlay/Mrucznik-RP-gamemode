//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 pracapomoc                                                //
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
command_pracapomoc_Impl(playerid)
{
    if(GetPlayerJob(playerid) == 0)
    {
        MruMessageFail(playerid, "Nie masz ¿adnej pracy.");
        return 1;
    }

    if(IsPlayerCarryingBox(playerid))
    SendClientMessage(playerid, COLOR_GREEN, "______________________PRACA POMOC______________________");
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
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________________________");
    return 1;
}

//end