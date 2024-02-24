//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  akceptuj                                                 //
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
// Autor: Mrucznik
// Data utworzenia: 07.02.2020


//
//TODO: przerobiæ ca³kowicie
//------------------<[ Implementacja: ]>-------------------
command_akceptuj_Impl(playerid, x_job[32])
{
    new string[256];
    new giveplayer[MAX_PLAYER_NAME];
    new sendername[MAX_PLAYER_NAME];
    if(strcmp(x_job, "biznes", false) == 0)
    {
        Business_AkceptujBiznes(playerid);
    }
    else if(strcmp(x_job,"wizytowka",true) == 0 || strcmp(x_job,"wizytowke",true) == 0 || strcmp(x_job,"wizytówka",true) == 0 || strcmp(x_job,"wizytówkê",true) == 0 || strcmp(x_job,"wizytówke",true) == 0)
    {
        new dawacz = GetPVarInt(playerid, "wizytowka");
        new nazwa[32];
        if(dawacz == -1)
        {
            sendErrorMessage(playerid, "Nikt nie oferowa³ Ci wizytówki.");
            return 1;
        }
        
        if(!IsPlayerConnected(dawacz))
        {
            sendErrorMessage(playerid, "Gracz, który oferowa³ Ci wizytówkê wyszed³.");
            return 1;
        }
        
        if(!CzyMaWolnySlotNaKontakt(playerid))
        {
            sendErrorMessage(playerid, "Osi¹gn¹³eœ maksymaln¹ liczbê kontaktów.");
            return 1;
        }
        
        if(CzyKontaktIstnieje(playerid, PlayerInfo[dawacz][pPnumber]))
        {
            sendErrorMessage(playerid, "Ten numer ju¿ istnieje w Twoich kontaktach.");
            return 1;
        }
        
        if(!ProxDetectorS(10.0, playerid, dawacz))
        {
            sendErrorMessage(playerid, "Jesteœ za daleko od gracza, który oferowa³ Ci wizytówkê.");
            return 1;
        }
        
        format(string, sizeof(string), "* Akceptowa³eœ wizytówkê od %s, dodano nowy kontakt.", GetNick(dawacz));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
        format(string, sizeof(string), "* %s przyj¹³ Twoj¹ wizytówkê.", GetNick(playerid));
        
        format(string, sizeof(string), "* %s wrêcza z uœmiechem wizytówkê %s, który chowa j¹ do kieszeni.", GetNick(dawacz), GetNick(playerid));
        ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
        
        GetPVarString(playerid, "wizytowka-nazwa", nazwa, sizeof(nazwa));
        format(string, sizeof(string), "dodaj %d %s", PlayerInfo[dawacz][pPnumber], nazwa);
        SetPVarInt(playerid, "wizytowka", -1);
        RunCommand(playerid, "/kontakty",  string);
    }
    else if(strcmp(x_job,"neon",true) == 0 || strcmp(x_job,"neony",true) == 0)
    {
        new dawacz = GraczDajacyNeon[playerid];
        if(dawacz < 999)
        {
            if(IsPlayerConnected(dawacz))
            {
                if(kaska[playerid] > 3000000 && kaska[playerid] >= 1)
                {
                    new pojazd;
                    if((pojazd = GetPlayerVehicleID(playerid)) != 0 && IsCarOwner(playerid, GetPlayerVehicleID(playerid)))
                    {
                        if(IsANoA(dawacz))
                        {
                            if(IsABoat(pojazd) || IsAPlane(pojazd) || IsABike(pojazd))
                            {
                                GraczDajacyNeon[playerid] = 999;
                                SendClientMessage(playerid, COLOR_GREY, "W helikopterze/samolocie/³odzi/motorze nie mo¿na zamontowaæ neonów.");
                                return  1;
                            }
                            if(ProxDetectorS(10.0, playerid, dawacz))
                            {
                                GetPlayerName(dawacz, giveplayer, sizeof(giveplayer));
                                GetPlayerName(playerid, sendername, sizeof(sendername));
                                format(string, sizeof(string), "* Kupi³eœ neony od %s za 3 000 000$. Wybierz kolor neonów!", giveplayer);
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                format(string, sizeof(string), "* %s akceptowa³ sprzeda¿ neonów, zarabiasz 25 000$.", sendername);
                                SendClientMessage(dawacz, COLOR_LIGHTBLUE, string);
                                Log(payLog, INFO, "%s kupi³ od %s neony do auta %s za 3000000$", GetPlayerLogName(playerid), GetPlayerLogName(dawacz), GetVehicleLogName(pojazd));
                                ZabierzKase(playerid, 3000000);
                                DajKase(dawacz, 75000);
                                Sejf_Add(FRAC_NOA, 50000);//wplacanie kasy
                                IloscAut[playerid] = VehicleUID[pojazd][vUID];
                                if(IsPlayerPremiumOld(playerid))
                                {
                                    ShowPlayerDialogEx(playerid, 1402, DIALOG_STYLE_LIST, "Wybierz kolor neonu", "{FFFFFF}Bia³y\n{DAA520}¯ó³ty\n{9ACD32}Zielony\n{0000FF}Niebieski\n{FF0000}Czerwony\n{C2A2DA}Ró¿owy", "Wybierz", "");
                                }
                                else
                                {
                                    ShowPlayerDialogEx(playerid, 1402, DIALOG_STYLE_LIST, "Wybierz kolor neonu", "{FFFFFF}Bia³y", "Wybierz", "");
                                }
                                GraczDajacyNeon[playerid] = 999;
                            }
                            else
                            {
                                SendClientMessage(playerid, COLOR_GREY, "   Jesteœcie za daleko od siebie !");
                                return 1;
                            }
                        }
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_GREY, "   Nie jesteœ w wozie/wóz nie jest twój !");
                        return 1;
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Nie staæ ciê !");
                    return 1;
                }
            }
        }
    }
    if(strcmp(x_job,"pojazd",true) == 0 || strcmp(x_job,"auto",true) == 0)
    {
        if(GraczDajacy[playerid] < 999)
        {
            if(IsPlayerConnected(GraczDajacy[playerid]))
            {
                if(kaska[playerid] > CenaDawanegoAuta[playerid] && CenaDawanegoAuta[playerid] > 0 && kaska[playerid] >= 1)
                {
                    new vehicle = GetPlayerVehicleID(GraczDajacy[playerid]);
                    if(vehicle == CarData[IDAuta[playerid]][c_ID])
                    {
                        if(CarData[IDAuta[playerid]][c_Owner] != PlayerInfo[GraczDajacy[playerid]][pUID])
                        {
                            GraczDajacy[playerid] = 0;
                            CenaDawanegoAuta[playerid] = 0;
                            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa³ ci sprzeda¿y !");
                            return 1;
                        }
                        GetPlayerName(playerid, sendername, sizeof(sendername));

                        if(CountPlayerCars(playerid) >= PlayerInfo[playerid][pCarSlots])
                        {
                            SendClientMessage(GraczDajacy[playerid], COLOR_GREY, " Gracz nie posiada wolnego slota.");
                            GraczDajacy[playerid] = 0;
                            CenaDawanegoAuta[playerid] = 0;
                            SendClientMessage(playerid, COLOR_GREY, " Nie posiadasz wolnego slota.");
                            return 1;
                        }
            
                        foreach(new i : Player)
                        {
                           if(PlayerInfo[i][pKluczeAuta] == IDAuta[playerid])
                            {
                                PlayerInfo[i][pKluczeAuta] = 0;
                            }
                        }
                        Car_MakePlayerOwner(playerid, IDAuta[playerid]);
                        Car_RemovePlayerOwner(GraczDajacy[playerid], IDAuta[playerid]);

                        new cena = CenaDawanegoAuta[playerid];
                        GetPlayerName(GraczDajacy[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* Akceptowa³eœ sprzeda¿ %s od %s za %d. Wpisz /autopomoc aby zobaczyæ nowe komendy!", VehicleNames[GetVehicleModel(vehicle)-400], giveplayer, cena);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        format(string, sizeof(string), "* %s akceptowa³ sprzeda¿ twojego %s, zarabiasz %d.", sendername, VehicleNames[GetVehicleModel(vehicle)-400], cena);
                        SendClientMessage(GraczDajacy[playerid], COLOR_LIGHTBLUE, string);
                        Log(payLog, INFO, "%s kupi³ od %s auto %s za %d$", GetPlayerLogName(playerid), GetPlayerLogName(GraczDajacy[playerid]), GetVehicleLogName(vehicle), cena);
                        
                        ZabierzKase(playerid, cena);
                        DajKase(GraczDajacy[playerid], cena);
                        RemovePlayerFromVehicleEx(GraczDajacy[playerid]);
                        GraczDajacy[playerid] = 999;
                        CenaDawanegoAuta[playerid] = 0;
                        return 1;
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zaoferowa³ ci auta!");
                        return 1;
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Nie staæ ciê!");
                    return 1;
                }
            }
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa³ ci sprzeda¿y!");
            return 1;
        }
    }
    if(strcmp(x_job,"wymiana",true) == 0)
    {
        if(GraczWymieniajacy[playerid] < 999)
        {
            if(IsPlayerConnected(GraczWymieniajacy[playerid]))
            {
                if(kaska[playerid] > CenaWymienianegoAuta[playerid] && CenaWymienianegoAuta[playerid] > 0 && kaska[playerid] >= 1)
                {
                    if(GetPlayerVehicleID(GraczWymieniajacy[playerid]) == CarData[IDAuta[playerid]][c_ID])
                    {
                        if(CarData[IDAuta[playerid]][c_Owner] != PlayerInfo[GraczWymieniajacy[playerid]][pUID])
                        {
                            GraczWymieniajacy[playerid] = 0;
                            CenaWymienianegoAuta[playerid] = 0;
                            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa³ ci wymiany !");
                            return 1;
                        }
                        GetPlayerName(playerid, sendername, sizeof(sendername));

                        
                        if(!ProxDetectorS(10.0, playerid, GraczWymieniajacy[playerid])) return SendClientMessage(playerid, 0xFFC0CB, "Ten gracz jest za daleko !");
                        if(!IsPlayerInAnyVehicle(playerid))
                        {
                            SendClientMessage(playerid, COLOR_GREY, " Musisz byæ w pojeŸdzie.");
                            return 1;
                        }
                        if(IDWymienianegoAuta[playerid] == 0)
                        {
                            SendClientMessage(playerid, COLOR_GREY, " Wyszed³eœ z auta wymienianego.");
                            GraczWymieniajacy[playerid] = 999;
                            CenaWymienianegoAuta[playerid] = 0;
                            return 1;
                        }
                        
                        Car_RemovePlayerOwner(GraczWymieniajacy[playerid], IDAuta[playerid]);
                        Car_RemovePlayerOwner(playerid, VehicleUID[GetPlayerVehicleID(playerid)][vUID]);
                        
                        Car_MakePlayerOwner(playerid, IDAuta[playerid]);
                        Car_MakePlayerOwner(GraczWymieniajacy[playerid], VehicleUID[GetPlayerVehicleID(playerid)][vUID]);

                        GetPlayerName(GraczWymieniajacy[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* Akceptowa³eœ wymianê %s od %s za %d. Wpisz /autopomoc aby zobaczyæ nowe komendy!", VehicleNames[GetVehicleModel(GetPlayerVehicleID(GraczWymieniajacy[playerid]))-400], giveplayer, CenaWymienianegoAuta[playerid]);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        format(string, sizeof(string), "* %s akceptowa³ wymianê twojego %s, zarabiasz %d.", sendername, VehicleNames[GetVehicleModel(GetPlayerVehicleID(GraczWymieniajacy[playerid]))-400], CenaWymienianegoAuta[playerid]);
                        SendClientMessage(GraczWymieniajacy[playerid], COLOR_LIGHTBLUE, string);

                        Log(payLog, INFO, "%s auto %s wymiana aut z %s auto %s z dop³at¹ %d$", \
                            GetPlayerLogName(playerid), GetVehicleLogName(GetPlayerVehicleID(playerid)), \
                            GetPlayerLogName(GraczWymieniajacy[playerid]), GetVehicleLogName(GetPlayerVehicleID(GraczWymieniajacy[playerid])), \
                            CenaWymienianegoAuta[playerid]
                        );
                        ZabierzKase(playerid, CenaWymienianegoAuta[playerid]);
                        DajKase(GraczWymieniajacy[playerid], CenaWymienianegoAuta[playerid]);
                        RemovePlayerFromVehicleEx(GraczWymieniajacy[playerid]);
                        RemovePlayerFromVehicleEx(playerid);
                        GraczWymieniajacy[playerid] = 999;
                        CenaWymienianegoAuta[playerid] = 0;
                        return 1;
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zaoferowa³ ci wymiany !");
                        return 1;
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Nie staæ ciê na wymianê !");
                    return 1;
                }
            }
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa³ ci wymiany !");
            return 1;
        }
    }
    else if(strcmp(x_job,"rozwod",true) == 0)
    {
        if(DivorceOffer[playerid] < 999)
        {
            if(IsPlayerConnected(DivorceOffer[playerid]))
            {
                if(ProxDetectorS(10.0, playerid, DivorceOffer[playerid]))
                {
                    GetPlayerName(DivorceOffer[playerid], giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    format(string, sizeof(string), "* Akceptowa³eœ wniosek %s do rozwodu.", giveplayer);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "* %s akceptowa³ twój wniosek o rozwód.", sendername);
                    SendClientMessage(DivorceOffer[playerid], COLOR_LIGHTBLUE, string);
                    ClearMarriage(playerid);
                    ClearMarriage(DivorceOffer[playerid]);
                    PlayerInfo[playerid][pPbiskey] = 255;
                    return 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Gracz który wys³a³ ci papiery rozwodowe nie jest blisko ciebie !");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie wys³a³ ci papierów rozwodowych !");
            return 1;
        }
    }
    else if(strcmp(x_job,"swiadek",true) == 0)
    {
        if(MarryWitnessOffer[playerid] < 999)
        {
            if(IsPlayerConnected(MarryWitnessOffer[playerid]))
            {
                if(ProxDetectorS(10.0, playerid, MarryWitnessOffer[playerid]))
                {
                    GetPlayerName(MarryWitnessOffer[playerid], giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    format(string, sizeof(string), "* Akceptowa³eœ proœbê %s aby byæ œwiadkiem.", giveplayer);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "* %s zaakceptowa³ twoj¹ proœbê aby by³ œwiadkiem.", sendername);
                    SendClientMessage(MarryWitnessOffer[playerid], COLOR_LIGHTBLUE, string);
                    MarryWitness[MarryWitnessOffer[playerid]] = playerid;
                    MarryWitnessOffer[playerid] = 999;
                    return 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Gracz który prosi ciê o bycie œwiadkiem jest za daleko !");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie poprosi³ ciê o bycie œwiadkiem !");
            return 1;
        }
    }
    else if(strcmp(x_job,"slub",true) == 0)
    {
        if(ProposeOffer[playerid] < 999)
        {
            if(!PlayerToPoint(10.0, playerid, 1964.2332,-369.1353,1093.7289) && !PlayerToPoint(10.0, playerid, -2482.6416,2406.8088,17.1094) && !PlayerToPoint(10.0, playerid, 2256.8000488281,-43.900001525879,26.5))
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie jesteœ w kosciele LS / Bay Side / Palomino Creek!");
                return 1;
            }
            if(IsPlayerConnected(ProposeOffer[playerid]))
            {
                if(ProxDetectorS(10.0, playerid, ProposeOffer[playerid]))
                {
                    if(MarryWitness[ProposeOffer[playerid]] == 999)
                    {
                        SendClientMessage(playerid, COLOR_GREY, "   Do œlubu potrzebny jest œwiadek !");
                        return 1;
                    }
                    if(IsPlayerConnected(MarryWitness[ProposeOffer[playerid]]))
                    {
                        if(ProxDetectorS(12.0, ProposeOffer[playerid], MarryWitness[ProposeOffer[playerid]]))
                        {
                            GetPlayerName(ProposeOffer[playerid], giveplayer, sizeof(giveplayer));
                            GetPlayerName(playerid, sendername, sizeof(sendername));
                            format(string, sizeof(string), "* Akceptowa³eœ œlub z %s.", giveplayer);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                            format(string, sizeof(string), "* %s Akceptowa³a œlub z tob¹.", sendername);
                            SendClientMessage(ProposeOffer[playerid], COLOR_LIGHTBLUE, string);
                            format(string, sizeof(string), "Ksi¹dz: %s czy chcesz aby %s zosta³ twoim mê¿em? (wpisz 'tak', cokolwiek innego anuluje œlub)", sendername, giveplayer);
                            SendClientMessage(playerid, COLOR_WHITE, string);
                            MarriageCeremoney[playerid] = 1;
                            ProposedTo[ProposeOffer[playerid]] = playerid;
                            GotProposedBy[playerid] = ProposeOffer[playerid];
                            MarryWitness[ProposeOffer[playerid]] = 999;
                            ProposeOffer[playerid] = 999;
                            return 1;
                        }
                        else
                        {
                            SendClientMessage(playerid, COLOR_GREY, "   Œwiadek jest za daleko !");
                            return 1;
                        }
                    }
                    return 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Gracz z którym bierzesz œlub jest za daleko !");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie chce siê z tob¹ o¿eniæ !");
            return 1;
        }
    }
    else if(strcmp(x_job,"ticket",true) == 0 || strcmp(x_job,"mandat",true) == 0)
    {
        if(TicketOffer[playerid] < 999)
        {
            if(IsPlayerConnected(TicketOffer[playerid]))
            {
                if (ProxDetectorS(5.0, playerid, TicketOffer[playerid]))
                {
                    if(TicketMoney[playerid] < kaska[playerid] && TicketMoney[playerid] > 0)
                    {
                        GetPlayerName(TicketOffer[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        new karne = GetPVarInt(playerid, "mandat_punkty");
                        format(string, sizeof(string), "* Zap³aci³eœ mandat w wysokoœci $%d Policjantowi %s.", TicketMoney[playerid], giveplayer);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        if(karne>0) {
                            format(string, sizeof(string), "* Dosta³eœ te¿ %d PK", karne);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                            PlayerInfo[playerid][pPK] += karne;
                            if(PlayerInfo[playerid][pPK] > 24) 
                            {
                                format(string, sizeof(string), "* Przekroczy³eœ limit 24 PK. Tracisz prawo jazdy");
                                SendClientMessage(playerid, COLOR_RED, string);
                                //86400 - jeden dzien
                                PlayerInfo[playerid][pPK] = 0;
                                PlayerInfo[playerid][pCarLic] = 0;
                                format(string, sizeof(string), "* %s straci³ prawo jazdy z powodu przekroczenia limitu 24 PK", sendername);
                                SendClientMessage(TicketOffer[playerid], COLOR_RED, string);
                            }
                        }

                        //format(string, sizeof(string), "* %s zap³aci³ mandat $%d. Otrzymujesz po³owê tej kwoty.", sendername, TicketMoney[playerid]);
                        SetPVarInt(playerid, "mandat_punkty", 0);
                        ZabierzKase(playerid, TicketMoney[playerid]);
                        //DajKase(playerid, TicketMoney[playerid]);
                        new depo2 = floatround(((TicketMoney[playerid]/100) * 80), floatround_round); //sejf
                        new depo3 = floatround(((TicketMoney[playerid]/100) * 20), floatround_round); //pd
                        format(string, sizeof(string), "* %s zap³aci³ mandat $%d. Otrzymujesz $%d", sendername, TicketMoney[playerid], depo3);
                        SendClientMessage(TicketOffer[playerid], COLOR_LIGHTBLUE, string);
                        DajKase(TicketOffer[playerid], depo3);
                        new ktodal = TicketOffer[playerid];
                        new sejf = PlayerInfo[ktodal][pMember] ? PlayerInfo[ktodal][pMember] : PlayerInfo[ktodal][pLider];
                        if(sejf)
                            Sejf_Add(sejf, depo2);
                        TicketOffer[playerid] = 999;
                        TicketMoney[playerid] = 0;
                        return 1;
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Nie staæ ciê!");
                        return 1;
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Policjant nie jest przy tobie !");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie da³ ci mandatu !");
            return 1;
        }
    }
    else if(strcmp(x_job,"boxing",true) == 0 || strcmp(x_job,"box",true) == 0 || strcmp(x_job,"boks",true) == 0)
    {
        if(BoxOffer[playerid] < 999)
        {
            if(IsPlayerConnected(BoxOffer[playerid]))
            {
                new points;
                new mypoints;
                GetPlayerName(BoxOffer[playerid], giveplayer, sizeof(giveplayer));
                GetPlayerName(playerid, sendername, sizeof(sendername));
                new level = PlayerInfo[BoxOffer[playerid]][pBoxSkill];
                if(level >= 0 && level <= 50) { points = 40; }
                else if(level >= 51 && level <= 100) { points = 50; }
                else if(level >= 101 && level <= 200) { points = 60; }
                else if(level >= 201 && level <= 400) { points = 70; }
                else if(level >= 401) { points = 80; }
                if(PlayerInfo[playerid][pJob] == 12)
                {
                    new clevel = PlayerInfo[playerid][pBoxSkill];
                    if(clevel >= 0 && clevel <= 50) { mypoints = 40; }
                    else if(clevel >= 51 && clevel <= 100) { mypoints = 50; }
                    else if(clevel >= 101 && clevel <= 200) { mypoints = 60; }
                    else if(clevel >= 201 && clevel <= 400) { mypoints = 70; }
                    else if(clevel >= 401) { mypoints = 80; }
                }
                else
                {
                    mypoints = 30;
                }
                format(string, sizeof(string), "* Akceptowa³eœ walkê boksersk¹ z %s, zaczynasz z %d Punktami ¯ycia.",giveplayer,mypoints);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "* %s akceptowa³ walkê boksersk¹ z tob¹, zaczynasz z %d Punktami ¯ycia.",sendername,points);
                SendClientMessage(BoxOffer[playerid], COLOR_LIGHTBLUE, string);
                SetPlayerHealth(playerid, mypoints);
                SetPlayerHealth(BoxOffer[playerid], points);
                SetPlayerInterior(playerid, 5); SetPlayerInterior(BoxOffer[playerid], 5);
                SetPlayerPos(playerid, 762.9852,2.4439,1001.5942); SetPlayerFacingAngle(playerid, 131.8632);
                SetPlayerPos(BoxOffer[playerid], 758.7064,-1.8038,1001.5942); SetPlayerFacingAngle(BoxOffer[playerid], 313.1165);
                TogglePlayerControllable(playerid, 0); TogglePlayerControllable(BoxOffer[playerid], 0);
                GameTextForPlayer(playerid, "~r~Czekaj", 3000, 1); GameTextForPlayer(BoxOffer[playerid], "~r~Czekaj", 3000, 1);
                new name[MAX_PLAYER_NAME];
                new dstring[MAX_PLAYER_NAME];
                new wstring[MAX_PLAYER_NAME];
                GetPlayerName(playerid, name, sizeof(name));
                format(dstring, sizeof(dstring), "%s", name);
                strmid(wstring, dstring, 0, strlen(dstring), 255);
                if(strcmp(Titel[TitelName] ,wstring, true ) == 0 )
                {
                    format(string, sizeof(string), "Boks News: Mistrz Bokserski %s walczy z %s, za 60 sekund (w Si³owni Grove Street).",  sendername, giveplayer);
                    OOCOff(COLOR_WHITE,string);
                    TBoxer = playerid;
                    BoxDelay = 60;
                }
                GetPlayerName(BoxOffer[playerid], name, sizeof(name));
                format(dstring, sizeof(dstring), "%s", name);
                strmid(wstring, dstring, 0, strlen(dstring), 255);
                if(strcmp(Titel[TitelName] ,wstring, true ) == 0 )
                {
                    format(string, sizeof(string), "Boks News: Mistrz Bokserski %s walczy z %s, za 60 sekund (w Si³owni Grove Street).",  giveplayer, sendername);
                    OOCOff(COLOR_WHITE,string);
                    TBoxer = BoxOffer[playerid];
                    BoxDelay = 60;
                }
                BoxWaitTime[playerid] = 1; BoxWaitTime[BoxOffer[playerid]] = 1;
                if(BoxDelay < 1) { BoxDelay = 20; }
                InRing = 1;
                Boxer1 = BoxOffer[playerid];
                Boxer2 = playerid;
                PlayerBoxing[playerid] = 1;
                PlayerBoxing[BoxOffer[playerid]] = 1;
                BoxOffer[playerid] = 999;
                return 1;
            }
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferuje ci walki bokserskiej !");
            return 1;
        }
    }
    else if(strcmp(x_job,"taxi",true) == 0)
    {
        if(TransportDuty[playerid] != 1)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie jesteœ taksówkrzem !");
            return 1;
        }
        if(TaxiCallTime[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Masz ju¿ zlecenie !");
            return 1;
        }
        if(PlayerOnMission[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Jesteœ na misji, nie mo¿esz u¿ywaæ tej komendy !");
            return 1;
        }
        if(TaxiCall < 999)
        {
            if(IsPlayerConnected(TaxiCall))
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                GetPlayerName(TaxiCall, giveplayer, sizeof(giveplayer));
                format(string, sizeof(string), "* Akceptowa³eœ zlecenie od %s, jedŸ do czerwonego markera.",giveplayer);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "* Taksówkarz %s akceptowa³ twoje zlecenie, czekaj na niego i nie ruszaj siê z miejsca.",sendername);
                SendClientMessage(TaxiCall, COLOR_LIGHTBLUE, string);
                GameTextForPlayer(playerid, "~w~Jedz do~n~~r~czerwonego punktu", 5000, 1);
                TaxiCallTime[playerid] = 1;
                TaxiAccepted[playerid] = TaxiCall;
                TaxiCall = 999;
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zamawia³ taksówki !");
            return 1;
        }
    }
    else if(strcmp(x_job,"heli",true) == 0)
    {
        if(TransportDuty[playerid] != 1)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie jesteœ pilotem !");
            return 1;
        }
        new newcar = GetPlayerVehicleID(playerid);
        if(!IsAPlane(newcar))
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie pilotujesz helikoptera !");
            return 1;
        }
        if(TaxiCallTime[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Masz ju¿ zlecenie !");
            return 1;
        }
        if(PlayerOnMission[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Jesteœ na misji, nie mo¿esz u¿ywaæ tej komendy !");
            return 1;
        }
        if(HeliCall < 999)
        {
            if(IsPlayerConnected(HeliCall))
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                GetPlayerName(HeliCall, giveplayer, sizeof(giveplayer));
                format(string, sizeof(string), "* Akceptowa³eœ zlecenie od %s, leæ do czerwonego markera.",giveplayer);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "* Pilot %s akceptowa³ twoje zlecenie, czekaj na niego i nie ruszaj siê z miejsca.",sendername);
                SendClientMessage(HeliCall, COLOR_LIGHTBLUE, string);
                GameTextForPlayer(playerid, "~w~Lec do~n~~r~czerwonego punktu", 5000, 1);
                TaxiCallTime[playerid] = 1;
                TaxiAccepted[playerid] = HeliCall;
                HeliCall = 999;
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zamawia³ helikoptera !");
            return 1;
        }
    }
    else if(strcmp(x_job,"bus",true) == 0)
    {
        if(TransportDuty[playerid] != 2)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie jesteœ kierowc¹ autobusu na s³u¿bie !");
            return 1;
        }
        if(BusCallTime[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Masz ju¿ zlecenie !");
            return 1;
        }
        if(PlayerOnMission[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Jesteœ na misji, nie mo¿esz u¿ywaæ tej komendy !");
            return 1;
        }
        if(PlayerInfo[playerid][pJob] == 10 && PlayerInfo[playerid][pCarSkill] < 400)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Potrzebujesz 5 skilla kierowcy autobusu aby móc odbieraæ wezwania !");
            return 1;
        }
        if(BusCall < 999)
        {
            if(IsPlayerConnected(BusCall))
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                GetPlayerName(BusCall, giveplayer, sizeof(giveplayer));
                format(string, sizeof(string), "* Akceptowa³eœ zlecenie od %s, jedŸ do czerwonego markera.",giveplayer);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "* Kierowca Autobusu %s akceptowa³ twoje wezwanie, czekaj na niego i nie ruszaj siê z miejsca.",sendername);
                SendClientMessage(BusCall, COLOR_LIGHTBLUE, string);
                new Float:X,Float:Y,Float:Z;
                GetPlayerPos(BusCall, X, Y, Z);
                SetPlayerCheckpoint(playerid, X, Y, Z, 5);
                GameTextForPlayer(playerid, "~w~Jedz do~n~~r~czerwonego punktu", 5000, 1);
                BusCallTime[playerid] = 1;
                BusAccepted[playerid] = BusCall;
                BusCall = 999;
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie dzwoni³ po autobus !");
            return 1;
        }
    }
    else if(strcmp(x_job,"medic",true) == 0 || strcmp(x_job,"medyk",true) == 0)
    {
        if(PlayerInfo[playerid][pMember] == 4 || PlayerInfo[playerid][pLider] == 4)
        {
            if(MedicCallTime[playerid] > 0)
            {
                SendClientMessage(playerid, COLOR_GREY, "   Masz ju¿ zlecenie !");
                return 1;
            }
            if(PlayerOnMission[playerid] > 0)
            {
                SendClientMessage(playerid, COLOR_GREY, "   Jesteœ na misji, nie mo¿esz u¿ywaæ tej koemndy !");
                return 1;
            }
            if(MedicCall < 999)
            {
                if(IsPlayerConnected(MedicCall))
                {
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    GetPlayerName(MedicCall, giveplayer, sizeof(giveplayer));
                    format(string, sizeof(string), "* Akceptowa³eœ zlecenie od %s, masz 30 sekund na dojechanie tam.",giveplayer);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Po 30 sekundach marker zniknie.");
                    format(string, sizeof(string), "* Medyk %s akceptowa³ twoje zlecenie, NIE RUSZAJ SIÊ z miejsca.",sendername);
                    SendClientMessage(MedicCall, COLOR_LIGHTBLUE, string);
                    new Float:X,Float:Y,Float:Z;
                    GetPlayerPos(MedicCall, X, Y, Z);
                    SetPlayerCheckpoint(playerid, X, Y, Z, 5);
                    GameTextForPlayer(playerid, "~w~Medyku~n~~r~Jedz do celu", 5000, 1);
                    MedicCallTime[playerid] = 1;
                    MedicCall = 999;
                    return 1;
                }
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nikt nie potrzebuje medyka !");
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie jesteœ lekarzem !");
            return 1;
        }
    }
    else if(strcmp(x_job,"mechanic",true) == 0 || strcmp(x_job,"mechanik",true) == 0)
    {
        if(PlayerInfo[playerid][pJob] != 7)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie jesteœ mechanikiem !");
            return 1;
        }
        if(MechanicCallTime[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Masz ju¿ zlecenie !");
            return 1;
        }
        if(PlayerOnMission[playerid] > 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Jesteœ na misji, nie mo¿esz u¿ywaæ tej komendy !");
            return 1;
        }
        if(MechanicCall < 999)
        {
            if(IsPlayerConnected(MechanicCall))
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                GetPlayerName(MechanicCall, giveplayer, sizeof(giveplayer));
                format(string, sizeof(string), "* Akceptowa³eœ zlecenie od %s, masz 60 sekund aby tam dojechaæ.",giveplayer);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Po 60 sekundach marker zniknie.");
                format(string, sizeof(string), "* Mechanik %s akceptowa³ twoje zlecenie, czekaj i nie ruszaj siê z miejsca.",sendername);
                SendClientMessage(MechanicCall, COLOR_LIGHTBLUE, string);
                new Float:X,Float:Y,Float:Z;
                GetPlayerPos(MechanicCall, X, Y, Z);
                SetPlayerCheckpoint(playerid, X, Y, Z, 5);
                GameTextForPlayer(playerid, "~w~Jedz do~n~~r~czerownego markera", 5000, 1);
                MechanicCallTime[playerid] = 1;
                MechanicCall = 999;
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zadzwoni³ po mechanika !");
            return 1;
        }
    }
    else if(strcmp(x_job,"job",true) == 0 || strcmp(x_job,"praca",true) == 0)//prace dorywcze
    {
        if(GettingJob[playerid] > 0)
        {
            if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || PlayerInfo[playerid][pOrg] != 0)
            {
                if(GettingJob[playerid] == 4 || GettingJob[playerid] == 5 || GettingJob[playerid] == 9)
                {//Allow the 3 jobs for Family Members
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Nie mo¿esz wzi¹æ pracy, jesteœ we frakcji !");
                    return 1;
                }
            }
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Podpisa³eœ umowe na 2,5 godziny, zaczynasz now¹ pracê.");
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Gratulujemy nowej pracy, wpisz /pomoc aby zobaczyæ nowe komendy.");
            PlayerInfo[playerid][pJob] = GettingJob[playerid];
            Log(serverLog, INFO, "Gracz %s do³¹czy³ do pracy %d.", GetPlayerLogName(playerid), PlayerInfo[playerid][pJob]);
            if(GettingJob[playerid] == 14)
            {
                PlayerInfo[playerid][pRank] = 0;

                SetPlayerInterior(playerid,0);
                new rand = random(sizeof(gInviteSpawns));
                SetPlayerPos(playerid, gInviteSpawns[rand][0], gInviteSpawns[rand][1], gInviteSpawns[rand][2]); // Warp the player
                SetPlayerFacingAngle(playerid, gInviteSpawns[rand][3]);
                SetPlayerCameraPos(playerid,gInviteSpawns[rand][0] + 3, gInviteSpawns[rand][1], gInviteSpawns[rand][2]);
                SetPlayerCameraLookAt(playerid,gInviteSpawns[rand][0], gInviteSpawns[rand][1], gInviteSpawns[rand][2]);
                TogglePlayerControllable(playerid, 0);
                SelectChar[playerid] = 255;
                SelectCharID[playerid] = PlayerInfo[playerid][pMember];
                SelectCharPlace[playerid] = 1;
                PlayerInfo[playerid][pSkin] = ChosenSkin[playerid];
                SendClientMessage(playerid, COLOR_LIGHTRED, "* U¿yj 'next' aby zobaczyæ nastêpny skin.");
                SendClientMessage(playerid, COLOR_LIGHTRED, "* Jeœli zdecydowa³eœ siê na konkretny skin wpisz 'gotowe'.");
                SendClientMessage(playerid, COLOR_LIGHTRED, "* Je¿eli nie ma tu wszytkich skinów twojej frakcji u¿yj /uniform w sklepie z ciuchami.");
            }
            GettingJob[playerid] = 0;
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   W tym miejscu nie mo¿na wzi¹æ pracy!");
            return 1;
        }
    }
    else if(strcmp(x_job,"refill",true) == 0 || strcmp(x_job,"tankowanie",true) == 0)
    {
        if(RefillOffer[playerid] < 999)
        {
            if(IsPlayerConnected(RefillOffer[playerid]) && IsPlayerInAnyVehicle(playerid))
            {
                if(kaska[playerid] > RefillPrice[playerid] && RefillPrice[playerid] > 0)
                {
                    GetPlayerName(RefillOffer[playerid], giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    new fuel;
                    new vehicleid = GetPlayerVehicleID(playerid);
                    if(RefillOffer[playerid] != playerid)
                    {
                        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
                        PlayerPlaySound(RefillOffer[playerid], 1085, 0.0, 0.0, 0.0);
                        PlayerInfo[RefillOffer[playerid]][pMechSkill] ++;
                        SendClientMessage(RefillOffer[playerid], COLOR_GREY, "Skill +1");
                        if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 50)
                        { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 2, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                        else if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 100)
                        { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 3, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                        else if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 200)
                        { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 4, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                        else if(PlayerInfo[RefillOffer[playerid]][pMechSkill] == 400)
                        { SendClientMessage(RefillOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 5, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                    }
                    new level = PlayerInfo[RefillOffer[playerid]][pMechSkill];
                    if(level >= 0 && level <= 50)
                    { fuel = 15; }
                    else if(level >= 51 && level <= 100)
                    { fuel = 40; }
                    else if(level >= 101 && level <= 200)
                    { fuel = 60; }
                    else if(level >= 201 && level <= 400)
                    { fuel = 80; }
                    else if(level >= 401)
                    { fuel = 100; }
                    format(string, sizeof(string), "* Twój pojazd zosta³ dotankowany o %d% przez mechanika %s, koszt $%d.",fuel,giveplayer,RefillPrice[playerid]);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "* Zatankowa³eœ pojazd %s o %d% paliwa, doliczono ci $%d do wyp³aty.",sendername,fuel,RefillPrice[playerid]);
                    SendClientMessage(RefillOffer[playerid], COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string),"* Mechanik %s wyci¹ga kanister i dotankowuje auto %s.",giveplayer,VehicleNames[GetVehicleModel(vehicleid)-400]);
                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    format(string, sizeof(string), "* Bak nape³niony o %d jednostek paliwa (( %s ))", fuel, giveplayer);
                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    ZabierzKase(playerid, RefillPrice[playerid]);
                    DajKase(RefillOffer[playerid], RefillPrice[playerid]);
                    if(Gas[vehicleid] < 110)
                    {
                        Gas[vehicleid] += fuel;
                    }
                    RefillOffer[playerid] = 999;
                    RefillPrice[playerid] = 0;
                    return 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Nie mo¿esz akceptowaæ tankowania !");
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa³ ci tankowania !");
            return 1;
        }
    }
    else if(strcmp(x_job,"live",true) == 0 || strcmp(x_job,"wywiad",true) == 0)
    {
        if(LiveOffer[playerid] < 999)
        {
            if(IsPlayerConnected(LiveOffer[playerid]))
            {
                if (ProxDetectorS(5.0, playerid, LiveOffer[playerid]) || (Mobile[playerid] == LiveOffer[playerid] && Callin[playerid] == CALL_PLAYER))
                {
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wywiad rozpoczêty, wszystko co teraz powiesz bêdzie na antenie.");
                    SendClientMessage(LiveOffer[playerid], COLOR_LIGHTBLUE, "* Rozpocz¹³eœ wywiad. Aby go zakoñczyæ ponownie wpisz /wywiad.");
                    TalkingLive[playerid] = LiveOffer[playerid];
                    TalkingLive[LiveOffer[playerid]] = playerid;
                    LiveOffer[playerid] = 999;
                    
                    if(Mobile[playerid] == LiveOffer[playerid] && Callin[playerid] == CALL_PLAYER)
                    {
                        Callin[Mobile[playerid]] = CALL_LIVE;
                        Callin[playerid] = CALL_LIVE;
                    }
                    return 1;
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "   Jesteœ za daleko od reportera !");
                    return 1;
                }
            }
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zaoferowa³ ci wywiadu !");
            return 1;
        }
    }
    else if(strcmp(x_job,"lawyer",true) == 0 || strcmp(x_job,"prawnik",true) == 0 || strcmp(x_job,"prawnika",true) == 0)
    {
            /* if(giveplayerid == -1)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /akceptuj prawnik");
            sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Pamiêtaj, ze pieni¹dze ($10 000) zostan¹ pobrane z Twojego portfela!");
            return 1;
        }

        if (IsAPolicja(playerid))
        {
            if(IsPlayerConnected(giveplayerid))
            {
                if(giveplayerid != INVALID_PLAYER_ID)
                {
                    if(PlayerInfo[giveplayerid][pJob] == 2)
                    {
                        if(kaska[playerid] < 20000) return sendErrorMessage(playerid, "Koszt wydania pozwolenia prawniczego to $10 000. Nie masz tyle!");
                        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* Da³eœ zgodê %s na uwolnienie wiêŸnia z celi. Tracisz $10 000 z portfela", giveplayer);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE,string);
                        format(string, sizeof(string), "* Policjant %s da³ ci zgodê na uwolnienie wiêŸnia z celi. (wpisz /uwolnij)", sendername);
                        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE,string);
                        format(string, sizeof(string), "* %s da³ zgodê na uwolnienie wiêŸnia prawnikowi %s.", sendername, giveplayer);
                        SendRadioMessage(1, COLOR_PANICRED, string);
                        SendRadioMessage(2, COLOR_PANICRED, string);
                        SendRadioMessage(3, COLOR_PANICRED, string);
                        ZabierzKase(playerid, 20000);
                        Sejf_Add(PlayerInfo[playerid][pMember], 10000);
                        ApprovedLawyer[giveplayerid] = 1;
                        return 1;
                    }
                }
            }
            return 1;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "B³¹d! (Nie jesteœ policjantem / Gracz nie jest prawnikiem / Z³e ID)");
            return 1;
        } */
    
    
    }
    else if(strcmp(x_job, "uwolnienie", true) == 0 || strcmp(x_job, "wolnosc", true) == 0)
    {
        new money = OfferPrice[playerid];
        //SetPVarInt(playerid, "idPrawnika", playerid);
        if(kaska[playerid] >= money)
        {
            if(OfferPlayer[playerid] == -1)
            {
                sendErrorMessage(playerid, "Nikt nie oferowa³ Ci uwolnienia z wiêzienia!"); 
                return 1;
            }
            format(string, sizeof(string), "* Uwolni³eœ %s z wiêzienia za kwotê %d$", GetNick(playerid), money);
            SendClientMessage(OfferPlayer[playerid], COLOR_LIGHTBLUE, string);
            
            format(string, sizeof(string), "* Zosta³eœ uwolniony przez prawnika %s za kwotê %d$", GetNick(OfferPlayer[playerid]), money);
            SendClientMessage(playerid , COLOR_LIGHTBLUE, string);
            
            //Czynnoœci
            PlayerInfo[playerid][pJailTime] = 1;
            ZabierzKase(playerid, money);
            DajKase(OfferPlayer[playerid], money);
            
            //skill
            PlayerInfo[OfferPlayer[playerid]][pLawSkill] +=2;
            SendClientMessage(OfferPlayer[playerid], COLOR_GRAD2, "Skill +2");
            if(PlayerInfo[OfferPlayer[playerid]][pLawSkill] == 50)
            { SendClientMessage(OfferPlayer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci prawnika wynosz¹ teraz 2, Mo¿esz taniej zbijaæ WL."); }
            else if(PlayerInfo[OfferPlayer[playerid]][pLawSkill] == 100)
            { SendClientMessage(OfferPlayer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci prawnika wynosz¹ teraz 3, Mo¿esz taniej zbijaæ WL."); }
            else if(PlayerInfo[OfferPlayer[playerid]][pLawSkill] == 200)
            { SendClientMessage(OfferPlayer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci prawnika wynosz¹ teraz 4, Mo¿esz taniej zbijaæ WL."); }
            else if(PlayerInfo[OfferPlayer[playerid]][pLawSkill] == 400)
            { SendClientMessage(OfferPlayer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci prawnika wynosz¹ teraz 5, Mo¿esz taniej zbijaæ WL."); }
            
            //zerowanie zmiennych 2
            ApprovedLawyer[OfferPlayer[playerid]] = 0;
            WantLawyer[playerid] = 0;
            CallLawyer[playerid] = 0;
            JailPrice[playerid] = 0;
            OfferPrice[playerid] = 0;
            LawyerOffer[playerid] = 0;
            OfferPlayer[playerid] = -1;
        }
        else
        {
            sendErrorMessage(playerid, "Nie masz takiej kwoty!"); 
            return 1;
        }
        
    }
    else if(strcmp(x_job,"bodyguard",true) == 0 || strcmp(x_job,"ochrona",true) == 0)
    {
        if(GuardOffer[playerid] < 999)
        {
            if(kaska[playerid] > GuardPrice[playerid] && GuardPrice[playerid] > 0)
            {
                if(IsPlayerConnected(GuardOffer[playerid]))
                {
                    GetPlayerName(GuardOffer[playerid], giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    format(string, sizeof(string), "* Akceptowa³eœ ochronê, zap³aci³eœ $%d ochroniarzowi %s.",GuardPrice[playerid],giveplayer);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "* %s akceptowa³ twoj¹ oferte ochrony, $%d zostanie doliczone do twojej wyp³aty.",sendername,GuardPrice[playerid]);
                    SendClientMessage(GuardOffer[playerid], COLOR_LIGHTBLUE, string);
                    PlayerInfo[GuardOffer[playerid]][pPayCheck] += GuardPrice[playerid];
                    ZabierzKase(playerid, GuardPrice[playerid]);
                    SetPlayerArmour(playerid, 90);
                    sendTipMessage(playerid, "Dosta³eœ kamizelkê kuloodporn¹ od ochroniarza.");
                    Log(payLog, INFO, "%s kupi³ kamizelkê od %s za $%d", GetPlayerLogName(playerid), GetPlayerLogName(GuardOffer[playerid]), GuardPrice[playerid]);
                    GuardOffer[playerid] = 999;
                    GuardPrice[playerid] = 0;
                    return 1;
                }
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie mo¿esz zaakceptowaæ ochrony !");
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zaoferowa³ ci ochrony !");
            return 1;
        }
    }
    else if(strcmp(x_job,"drugs",true) == 0 || strcmp(x_job,"dragi",true) == 0)
    {
        if(DrugOffer[playerid] < 999)
        {
            if(kaska[playerid] > DrugPrice[playerid] && DrugPrice[playerid] > 0)
            {
                if(PlayerInfo[playerid][pDrugs] < 7)
                {
                    if(IsPlayerConnected(DrugOffer[playerid]))
                    {
                        GetPlayerName(DrugOffer[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* Kupi³eœ %d gram za $%d od Dilera Dragów %s. Aby je wzi¹æ wpisz /wezdragi.",DrugGram[playerid],DrugPrice[playerid],giveplayer);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        format(string, sizeof(string), "* %s kupi³ od ciebie %d gram, $%d zostanie dodane do twojej wyp³aty.",sendername,DrugGram[playerid],DrugPrice[playerid]);
                        SetPVarInt(DrugOffer[playerid], "wydragowany", 60);
                        SendClientMessage(DrugOffer[playerid], COLOR_LIGHTBLUE, string);
                        //
                        format(string, sizeof(string), "%s kupi³ dragi za $%d od %s", sendername, DrugPrice[playerid], giveplayer);
                        ABroadCast(COLOR_YELLOW,string,1);
                        Log(payLog, INFO, "%s kupi³ od %s paczkê %d narkotyków za %d$", GetPlayerLogName(playerid), GetPlayerLogName(DrugOffer[playerid]), DrugGram[playerid], DrugPrice[playerid]);
                        //
                        PlayerInfo[DrugOffer[playerid]][pPayCheck] += DrugPrice[playerid];
                        PlayerInfo[DrugOffer[playerid]][pDrugsSkill] ++;
                        ZabierzKase(playerid, DrugPrice[playerid]);
                        PlayerInfo[playerid][pDrugs] += DrugGram[playerid];
                        PlayerInfo[DrugOffer[playerid]][pDrugs] -= DrugGram[playerid];
                        if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 50)
                        { SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci dilera dragów wynosz¹ teraz 2, mo¿esz kupowac wiêcej dragów w melinie."); }
                        else if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 100)
                        { SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci dilera dragów wynosz¹ teraz 3, mo¿esz kupowac wiêcej dragów w melinie."); }
                        else if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 200)
                        { SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci dilera dragów wynosz¹ teraz 4, mo¿esz kupowac wiêcej dragów w melinie."); }
                        else if(PlayerInfo[DrugOffer[playerid]][pDrugsSkill] == 400)
                        { SendClientMessage(DrugOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci dilera dragów wynosz¹ teraz 5, mo¿esz kupowac wiêcej dragów w melinie."); }
                        DrugOffer[playerid] = 999;
                        DrugPrice[playerid] = 0;
                        DrugGram[playerid] = 0;
                        return 1;
                    }
                    return 1;
                }
                else
                {
                    sendTipMessageEx(playerid, COLOR_GREY, "Masz ju¿ za du¿o narkotyków, u¿yj ich najpierw !");
                    return 1;
                }
            }
            else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz zakupiæ narkotyków !");
                return 1;
            }
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nikt nie oferowa³ ci sprzeda¿y narkotyków !");
            return 1;
        }
    }
    else if(strcmp(x_job,"sex",true) == 0)
    {
        if(SexOffer[playerid] < 999)
        {
            if(kaska[playerid] > SexPrice[playerid] && SexPrice[playerid] > 0)
            {
                if (IsPlayerConnected(SexOffer[playerid]))
                {
                    new Car = GetPlayerVehicleID(playerid);
                    if(IsPlayerInAnyVehicle(playerid) && IsPlayerInVehicle(SexOffer[playerid], Car))
                    {
                        GetPlayerName(SexOffer[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "* Uprawiasz ostry sex z dziwk¹ %s, za $%d.", giveplayer, SexPrice[playerid]);
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                        SetPVarInt(SexOffer[playerid], "wysekszony", 120);
                        format(string, sizeof(string), "* %s uprawia z tob¹ sex. $%d zostanie dodane do twojej wyp³aty.", sendername, SexPrice[playerid]);
                        SendClientMessage(SexOffer[playerid], COLOR_LIGHTBLUE, string);
                        PlayerInfo[SexOffer[playerid]][pPayCheck] += SexPrice[playerid];
                        PlayerInfo[SexOffer[playerid]][pSexSkill] ++;
                        //
                        Log(payLog, INFO, "%s uprawia³ sex z %s za $%d", GetPlayerLogName(playerid), GetPlayerLogName(SexOffer[playerid]), SexPrice[playerid]);
                        //
                        ZabierzKase(playerid, SexPrice[playerid]);
                        if(PlayerInfo[SexOffer[playerid]][pSexSkill] == 50)
                        { SendClientMessage(SexOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci prostytutki wynosz¹ teraz 2, Mo¿esz oferowaæ teraz lepszy sex (wiêcej ¿ycia) i trudniej sie zaraziæ."); }
                        else if(PlayerInfo[SexOffer[playerid]][pSexSkill] == 100)
                        { SendClientMessage(SexOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci prostytutki wynosz¹ teraz 3, Mo¿esz oferowaæ teraz lepszy sex (wiêcej ¿ycia) i trudniej sie zaraziæ."); }
                        else if(PlayerInfo[SexOffer[playerid]][pSexSkill] == 200)
                        { SendClientMessage(SexOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci prostytutki wynosz¹ teraz 4, Mo¿esz oferowaæ teraz lepszy sex (wiêcej ¿ycia) i trudniej sie zaraziæ."); }
                        else if(PlayerInfo[SexOffer[playerid]][pSexSkill] == 400)
                        { SendClientMessage(SexOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci prostytutki wynosz¹ teraz 5, Mo¿esz oferowaæ teraz lepszy sex (wiêcej ¿ycia) i trudniej sie zaraziæ."); }
                        
                        if(Condom[playerid] < 1)
                        {
                            new Float:health, Float:Ahealth
                            new hp = 0;
                            new level = PlayerInfo[SexOffer[playerid]][pSexSkill];
                            if(level >= 0 && level <= 50) hp = 20;
                            else if(level >= 51 && level <= 100) hp = 40;
                            else if(level >= 101 && level <= 200) hp = 60;
                            else if(level >= 201 && level <= 400) hp = 80;
                            else if(level >= 401)
                            {
                                hp = 100;
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Twoje umiejêtnoœci prostytutki s¹ tak wysokie ¿e dajesz wysokie HP i nie dajesz chorób.");
                                SendClientMessage(SexOffer[playerid], COLOR_LIGHTBLUE, "* Umiejêtnoœæ dziwki s¹ tak wysokie ¿e dostajesz du¿e HP i zero chorób.");
                                return 1;
                            }
                            GetPlayerHealth(playerid, health);
                            GetPlayerArmour(playerid, Ahealth);
                            new actualhp = floatround(health, floatround_tozero);
                            new actualap = floatround(Ahealth, floatround_tozero);
                            if((actualhp + hp) < 100) 
                            {
                                SetPlayerHealth(playerid, actualhp + hp); 
                            }
                            else
                            {
                                SetPlayerArmour(playerid, actualap + hp);  
                            }
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Dodano ci %d HP/Pancerza z powodu sexu.", hp));
                            if(random(20) == 1)//5% szans na zara¿enie
                            {
                                InfectOrDecreaseImmunity(playerid, HIV);
                            }

                            //TODO: przenoszenie chorób drog¹ p³ciow¹
                        }
                        else
                        {
                            SendClientMessage(SexOffer[playerid], COLOR_LIGHTBLUE, "* Ten gracz u¿ywa kondom.");
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, "* U¿y³eœ kondom.");
                            Condom[playerid] --;
                        }
                        SexOffer[playerid] = 999;
                        return 1;
                    }
                    else
                    {
                        sendTipMessageEx(playerid, COLOR_GREY, "Ty i dziwka nie jesteœcie w samochodzie !");
                        return 1;
                    }
                }//Connected or not
                return 1;
            }
            else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Nie staæ ciê !");
                return 1;
            }
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nikt nie oferowa³ ci sexu !");
            return 1;
        }
    }
    else if(strcmp(x_job,"naprawe",true) == 0 || strcmp(x_job,"naprawa",true) == 0)
    {
        if(RepairOffer[playerid] < 999)
        {
            if(kaska[playerid] > RepairPrice[playerid] && RepairPrice[playerid] > 0)
            {
                if(IsPlayerInAnyVehicle(playerid))
                {
                    if(IsPlayerConnected(RepairOffer[playerid]))
                    {
                        if(ProxDetectorS(10.5, playerid, RepairOffer[playerid]))
                        {
                            GetPlayerName(RepairOffer[playerid], giveplayer, sizeof(giveplayer));
                            GetPlayerName(playerid, sendername, sizeof(sendername));
                            RepairCar[playerid] = GetPlayerVehicleID(playerid);
                            SetVehicleHealth(RepairCar[playerid], 1000.0);
                            RepairVehicle(RepairCar[playerid]);

                            CarData[VehicleUID[RepairCar[playerid]][vUID]][c_Tires] = 0;
                            CarData[VehicleUID[RepairCar[playerid]][vUID]][c_HP] = 1000.0;

                            PlayerPlaySound(RepairCar[playerid], 1140, 0.0, 0.0, 0.0);
                            PlayerPlaySound(playerid, 1140, 0.0, 0.0, 0.0);
                            format(string, sizeof(string), "* Twój samochód zosta³ naprawiony za $%d przez mechanika %s.",RepairPrice[playerid],giveplayer);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                            format(string, sizeof(string), "* Naprawi³eœ pojazd %s, $%d zostanie dodane do twojej wyp³aty.",giveplayer,RepairPrice[playerid]);
                            SendClientMessage(RepairOffer[playerid], COLOR_LIGHTBLUE, string);
                            format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia oraz naprawia %s.",giveplayer,VehicleNames[GetVehicleModel(RepairCar[playerid])-400]);
                            ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                            format(string, sizeof(string), "* Silnik pojazdu znów dzia³a jak nale¿y (( %s ))", giveplayer);
                            ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                            PlayerInfo[RepairOffer[playerid]][pMechSkill] ++;
                            if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 50)
                            { SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 2, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                            else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 100)
                            { SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 3, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                            else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 200)
                            { SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 4, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                            else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 400)
                            { SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 5, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
                            ZabierzKase(playerid, RepairPrice[playerid]);
                            DajKase(RepairOffer[playerid], RepairPrice[playerid]);
                            RepairOffer[playerid] = 999;
                            RepairPrice[playerid] = 0;
                        }
                        else
                        {
                            sendErrorMessage(playerid, "Mechanik musi byæ obok Ciebie!");
                            return 1;
                        }
                        return 1;
                    }
                    return 1;
                }
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie staæ ciê na naprawe !");
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa³ ci naprawy !");
            return 1;
        }
    }
    else if(strcmp(x_job,"wynajem",true) == 0 || strcmp(x_job,"wynajmij",true) == 0)
    {
        if(WynajemOffer[playerid] < 999)
        {
            new dom = PlayerInfo[WynajemOffer[playerid]][pDom];
            if(kaska[playerid] > Dom[dom][hCenaWynajmu] && Dom[dom][hCenaWynajmu] > 0)
            {
                GetPlayerName(WynajemOffer[playerid], giveplayer, sizeof(giveplayer));
                sendername = GetNickEx(playerid);
                if(Dom[dom][hPW] == 0)
                {
                    Dom[dom][hL1] = sendername;
                }
                else if(Dom[dom][hPW] == 1)
                {
                    Dom[dom][hL2] = sendername;
                }
                else if(Dom[dom][hPW] == 2)
                {
                    Dom[dom][hL3] = sendername;
                }
                else if(Dom[dom][hPW] == 3)
                {
                    Dom[dom][hL4] = sendername;
                }
                else if(Dom[dom][hPW] == 4)
                {
                    Dom[dom][hL5] = sendername;
                }
                else if(Dom[dom][hPW] == 5)
                {
                    Dom[dom][hL6] = sendername;
                }
                else if(Dom[dom][hPW] == 6)
                {
                    Dom[dom][hL7] = sendername;
                }
                else if(Dom[dom][hPW] == 7)
                {
                    Dom[dom][hL8] = sendername;
                }
                else if(Dom[dom][hPW] == 8)
                {
                    Dom[dom][hL9] = sendername;
                }
                else if(Dom[dom][hPW] == 9)
                {
                    Dom[dom][hL10] = sendername;
                }
                Dom[dom][hPDW] --;
                Dom[dom][hPW] ++;
                PlayerInfo[playerid][pWynajem] = dom;
                format(string, sizeof(string), "Wynaj¹³eœ pokój w tym domu. Aby uzyskaæ wiêcej opcji i mo¿liwoœci wpisz /dom");
                SendClientMessage(playerid, COLOR_NEWS, string);
                format(string, sizeof(string), "%s wynaj¹³ pokój w twoim domu!", sendername);
                SendClientMessage(WynajemOffer[playerid], COLOR_NEWS, string);
                WynajemOffer[playerid] = 999;
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie staæ ciê na wynajem tego pokoju !");
                WynajemOffer[playerid] = 999;
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nikt nie oferowa³ ci wynajmu !");
            return 1;
        }
    }
    else if(strcmp(x_job,"dom",true) == 0 || strcmp(x_job,"house",true) == 0)
    {
        if(DomOffer[playerid] < 999)
        {
            if(kaska[playerid] > DomCena[playerid] && DomCena[playerid] > 0)
            {
                if (ProxDetectorS(10.0, playerid, DomOffer[playerid]))
                {
                    if(PlayerInfo[DomOffer[playerid]][pDom] != 0 && PlayerInfo[DomOffer[playerid]][pDom] == GetPVarInt(DomOffer[playerid], "DomOfferID"))
                    {
                        GetPlayerName(DomOffer[playerid], giveplayer, sizeof(giveplayer));
                        GetPlayerName(playerid, sendername, sizeof(sendername));
                        format(string, sizeof(string), "Sprzeda³eœ dom graczowi %s za %d$.", sendername, DomCena[playerid]);
                        SendClientMessage(DomOffer[playerid], COLOR_NEWS, string);
                        format(string, sizeof(string), "Kupi³eœ dom od %s za %d$. Aby uzyskaæ wiêcej opcji i mo¿liwoœci wpisz /dom", giveplayer, DomCena[playerid]);
                        SendClientMessage(playerid, COLOR_NEWS, string);
                        SendClientMessage(playerid, COLOR_PANICRED, "UWAGA! Pamiêtaj aby zmieniæ kod do sejfu !!!!!!");
                        Dom[PlayerInfo[DomOffer[playerid]][pDom]][hWlasciciel] = GetNickEx(playerid);
                        PlayerInfo[playerid][pDom] = PlayerInfo[DomOffer[playerid]][pDom];
                        PlayerInfo[DomOffer[playerid]][pDom] = 0;
                        ZabierzKase(playerid, DomCena[playerid]);
                        DajKase(DomOffer[playerid], DomCena[playerid]);
                        ZapiszDom(PlayerInfo[playerid][pDom]);
                        Log(payLog, INFO, "%s kupi³ od %s dom %s za %d$. ", \
                            GetPlayerLogName(playerid), \
                            GetPlayerLogName(DomOffer[playerid]), \
                            GetHouseLogName(PlayerInfo[playerid][pDom]), \
                            DomCena[playerid] \
                        );
                    }
                    else
                    {
                        format(string, sizeof(string), "Napotkano b³¹d. Dom zosta³ kupiony przez kogoœ innego.");
                        SendClientMessage(playerid, COLOR_NEWS, string);
                    }
                    DeletePVar(DomOffer[playerid], "DomOfferID");
                    DomCena[playerid] = 0;
                    DomOffer[playerid] = 999;
                    return 1;
                }
                else
                {
                    DomOffer[playerid] = 0;
                    SendClientMessage(playerid, COLOR_GREY, "   Jesteœ za daleko !");
                    return 1;
                }
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "   Nie staæ ciê na kupno tego domu !");
                return 1;
            }
        }
    }
    else if(strcmp(x_job,"kuracje",true) == 0 || strcmp(x_job,"kuracja",true) == 0)
    {
        kuracja_akceptuj(playerid);
    }
    else if(strcmp(x_job,"maseczke",true) == 0 || strcmp(x_job,"maseczka",true) == 0)
    {
        maseczka_akceptuj(playerid);
    }
    else if(strcmp(x_job,"neony",true) == 0 || strcmp(x_job,"neon",true) == 0)
    {
        sprzedajneon_akceptuj(playerid);
    }
    else if(strcmp(x_job, "zestaw", true) == 0 || strcmp(x_job, "zestawnaprawczy", true) == 0)
    {
        new id = GetPVarInt(playerid, "FixKitOffer");
        
        if(id == -1)
        {
            SendClientMessage(playerid, -1, "Nikt nie oferowa³ ci zestawu naprawczego!");
            return 1;
        }
        if(!IsPlayerConnected(id))
        {
            SetPVarInt(playerid, "FixKitOffer", -1);
            SendClientMessage(playerid, -1, "Gracz, który oferowa³ ci zestaw naprawczy wyszed³ z serwera!");
            return 1;
        }
        if(kaska[playerid] < 15000)
        {
            SendClientMessage(id, -1, "Ten gracz nie ma tyle kasy");
            SendClientMessage(playerid, -1, "Nie masz wystarczaj¹cej iloœci pieniêdzy");
            return 1;
        }
        if(!ProxDetectorS(10.5, playerid, id))
        {
            SendClientMessage(playerid, -1, "Jesteœ za daleko od mechanika, który oferowa³ ci zestaw.");
            return 1;
        }

        SendClientMessage(id, 0x0080D0FF, sprintf("%s kupi³ od Ciebie zestaw naprawczy. Otrzymujesz 15000$", GetNick(playerid)));
        SendClientMessage(playerid, 0x00FF00FF, sprintf("Kupi³eœ zestaw od mechanika %s za 15000$", GetNick(id)));
        ZabierzKase(playerid, 15000);
        DajKase(id, 15000);
        PlayerInfo[playerid][pFixKit]++;
        PlayerInfo[id][pMechSkill]++;
        if(PlayerInfo[id][pMechSkill] == 50)
        { SendClientMessage(id, COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 2, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
        else if(PlayerInfo[id][pMechSkill] == 100)
        { SendClientMessage(id, COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 3, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
        else if(PlayerInfo[id][pMechSkill] == 200)
        { SendClientMessage(id, COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 4, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
        else if(PlayerInfo[id][pMechSkill] == 400)
        { SendClientMessage(id, COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 5, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
        
        SetPVarInt(playerid, "FixKitOffer", -1);
    }
    return 1;
}

//end