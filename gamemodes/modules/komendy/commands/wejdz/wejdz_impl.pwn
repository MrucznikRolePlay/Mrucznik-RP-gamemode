//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_wejdz_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0 ) return 1;
        if(PlayerInfo[playerid][pJailed] == 1 || PlayerInfo[playerid][pJailed] == 3) return 1;
        if(GetPVarInt(playerid, "Lockdown-izolacja") != 0) return sendTipMessageEx(playerid, COLOR_PANICRED, "Nie mo¿esz u¿ywaæ tej komendy w trakcie weryfikacji.");
		PlayerPlaySound(playerid, 1, 0.0, 0.0, 0.0);

//======================================================================
//=================[Przeniesione - na nowy system]======================
//======================================================================
		

		WejdzInt(playerid, 725.6371, -1440.3321, 13.5360, 734.0619, -1451.6720, 22.5920, 3.0, 0, 255, "Dania, alkohole, fortuna!", PLOCAL_DEFAULT, "~w~Witamy w Jetty Lounge by ~n~~h~~g~Albert ~w~& ~h~~y~Patryk");//Jetty
		
//======================================================================
//=================[Wczytanie - nowego systemu]=====================
//======================================================================
        if(GetPVarInt(playerid, "AC-izolacja") != 0) return sendTipMessageEx(playerid, COLOR_PANICRED, "Jesteœ odizolowany, nie mo¿esz u¿ywaæ tej komendy.");
        if(SprawdzWejscia(playerid))
        {
            if(GetPlayerVirtualWorld(playerid) != 0 && GetPlayerInterior(playerid) != 0)
            {
                SetInteriorTimeAndWeather(playerid); 
            }
            else
            {
                SetServerWeatherAndTime(playerid);
            }
            return 1;
        }
        
//======================================================================
//==================[Windy pod /wejdz]==================================
//======================================================================
		
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 694.27490234375,-569.04272460938,-79.225189208984) 
            || IsPlayerInRangeOfPoint(playerid, 3.0, 700.6748046875,-502.41955566406,23.515483856201) 
            || IsPlayerInRangeOfPoint(playerid, 5.0, 707.06085205078,-508.38107299805,27.871946334839))//rada miasta dillimore (miasteczko) windy
        {
            ShowPlayerDialogEx(playerid, 121, DIALOG_STYLE_LIST, "Wybierz pomieszczenie", "Salka Konferencyjna\nBiura\nPiwnice", "Wybierz", "WyjdŸ");
        }
        else if(IsPlayerInRangeOfPoint(playerid,3,1450.6615,-1819.2279,77.9613) 
			||  (IsPlayerInRangeOfPoint(playerid,5,1412.3348388672, -1790.5777587891, 15.370599746704) && IsAUrzednik(playerid))
            ||  IsPlayerInRangeOfPoint(playerid,3,1481.5200,-1821.0967,58.1563))
        {
            ShowPlayerDialogEx(playerid,122,DIALOG_STYLE_LIST,"Winda: Wybierz Piêtro","[Poziom 0] Zaplecze\n[Poziom 9] G³ówna sala urzêdu\n[Poziom 10] Kancelaria burmistrza","Wybierz","WyjdŸ");
        }
        else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1745.8119, -1129.8972, 24.0781) 
            || IsPlayerInRangeOfPoint(playerid, 3.0, 1746.0676, -1127.9219, 46.5746) 
            || IsPlayerInRangeOfPoint(playerid, 3.0, 1746.2399, -1128.2211, 227.8059))
		{
            ShowPlayerDialogEx(playerid, D_WINDA_LSFD, DIALOG_STYLE_LIST, "Winda", "Gara¿\nPierwsze piêtro\nDrugie piêtro\nDach", "Wybierz", "WyjdŸ");
		}
        else if((IsPlayerInRangeOfPoint(playerid,4,1568.7660,-1691.4886,5.8906) && IsAPolicja(playerid) && GetPlayerVirtualWorld(playerid) == 2)//parking Dolny LSPD 1568.7660,-1691.4886,5.8906
            || (IsPlayerInRangeOfPoint(playerid,3,1585.8722,-1685.5045,62.2363) && GetPlayerVirtualWorld(playerid) == 25)//z glownego wejscia
            || (IsPlayerInRangeOfPoint(playerid,2.5,1585.8090,-1685.1177,65.8762) && GetPlayerVirtualWorld(playerid) == 25)//biuro komendanta
            || (IsPlayerInRangeOfPoint(playerid,4,1551.5720,-1701.7196,28.4807) && GetPlayerVirtualWorld(playerid) == 26)//biura LSPD
            || (IsPlayerInRangeOfPoint(playerid,4,1562.7128,-1639.0281,28.5040) && GetPlayerVirtualWorld(playerid) == 27)//konferencyjna
            || (IsPlayerInRangeOfPoint(playerid,4,1564.9027,-1665.8291,28.4815) && GetPlayerVirtualWorld(playerid) == 28)//Sala przes³uchañ
            || (IsPlayerInRangeOfPoint(playerid,4,1543.3915,-1643.2813,28.4881) && IsAPolicja(playerid) && GetPlayerVirtualWorld(playerid) == 29)//wiêzienie
            || (IsPlayerInRangeOfPoint(playerid,4,1565.0798, -1665.6580, 28.4782) && IsAPolicja(playerid) && GetPlayerVirtualWorld(playerid) == 0)//dach lspd
            || (IsPlayerInRangeOfPoint(playerid,4,1570.9799,-1636.7758,13.5713) && IsAPolicja(playerid) && GetPlayerVirtualWorld(playerid) == 0))//gorny LSPD
        {
            ShowPlayerDialogEx(playerid,WINDA_LSPD,DIALOG_STYLE_LIST,"Winda","[Poziom -2]Wiêzienie\n[Poziom -1]Parking Dolny\n[Poziom 0] Parking Górny\n[Poziom 1]Recepcja\n[Poziom 2]Biuro komendanta\n[Poziom 3]Biura\n[Poziom 4]Konferencyjne\n[Poziom 5]Sale przes³uchañ\n[Poziom 6]Dach","Jedz","");
        }
		else if(IsPlayerInRangeOfPoint(playerid,5,288.0914,-1609.7465,17.9994)//parking SAN News
            || IsPlayerInRangeOfPoint(playerid, 3, 287.7476,-1609.9395,33.0723)//PARTER
            || IsPlayerInRangeOfPoint(playerid,3,292.0818,-1610.0715,124.7512)//recepcja Winda
            || IsPlayerInRangeOfPoint(playerid,3,296.9033,-1598.3610,117.0619)/* Studia */
            || IsPlayerInRangeOfPoint(playerid,3,295.1328,-1609.4705,115.6818)/*Akademia */
            || IsPlayerInRangeOfPoint(playerid,3,285.8397,-1596.4153,114.5687)/*Dach*/
            || IsPlayerInRangeOfPoint(playerid,3,290.7577,-1604.3273,134.6113)/*Biura SAN NEWS*/)
        {
            ShowPlayerDialogEx(playerid,WINDA_SAN,DIALOG_STYLE_LIST,"Winda - San News","[Pietro - 0] Parking\n[Pietro 1] Wejscie do budynku\n[Pietro - 2] Recepcja\n[Pietro - 3] Studia\n[Pietro - 4] Akademia\n[Pietro - 5]Biura San News\n[Pietro - 6]Dach","Jedz","Anuluj");
        }
        //winda FBI
		else if((IsPlayerInRangeOfPoint(playerid,2,586.83704, -1473.89270, 89.30576)//przy recepcji
            || IsPlayerInRangeOfPoint(playerid,2,592.65466, -1486.76575, 82.10487)//szatnia
            || IsPlayerInRangeOfPoint(playerid,2,591.37579, -1482.26672, 80.43560)//zbrojownia
            || IsPlayerInRangeOfPoint(playerid,2,596.21857, -1477.92395, 84.06664)//biura federalne
            || IsPlayerInRangeOfPoint(playerid,2,589.23029, -1479.66357, 91.74274)//Dyrektorat
            || IsPlayerInRangeOfPoint(playerid,2,613.4404,-1471.9745,73.8816)//DACH
            || IsPlayerInRangeOfPoint(playerid,2,596.5255, -1489.2544, 15.3587)//Parking
            || IsPlayerInRangeOfPoint(playerid,2,1093.0625,1530.8715,6.6905)//Parking podziemny
            || IsPlayerInRangeOfPoint(playerid,2,585.70782, -1479.54211, 99.01273)//CID/ERT
            || IsPlayerInRangeOfPoint(playerid,2,594.05334, -1476.27490, 81.82840)//stanowe
            || IsPlayerInRangeOfPoint(playerid,2,590.42767, -1447.62939, 80.95732)//Sale Treningowe
            || IsPlayerInRangeOfPoint(playerid,2,605.5609, -1462.2583, 88.1674))//Sale przes³uchaniowe
            && (doorFBIStatus == 1 || GetPlayerFraction(playerid) == FRAC_FBI)
		)
		{
			ShowPlayerDialogEx(playerid,19,DIALOG_STYLE_LIST,"Winda FBI","[Poziom -1] Parking podziemny \n[Poziom 0] Parking\n[Poziom 0.5] Areszt federalny\n[Poziom 1] Recepcja\n[Poziom 2] Szatnia\n[Poziom 3] Zbrojownia \n[Poziom 4] Biura federalne \n[Poziom 5] Dyrektorat\n[Poziom 6] CID/ERT\n[Poziom 7] Sale Treningowe\n[Poziom 8] Sale przes³uchañ \nDach","Jedz","Anuluj");
        }
        else if((IsPlayerInRangeOfPoint(playerid,2,586.83704, -1473.89270, 89.30576)//przy recepcji
            || IsPlayerInRangeOfPoint(playerid,2,592.65466, -1486.76575, 82.10487)//szatnia
            || IsPlayerInRangeOfPoint(playerid,2,591.37579, -1482.26672, 80.43560)//zbrojownia
            || IsPlayerInRangeOfPoint(playerid,2,596.21857, -1477.92395, 84.06664)//biura federalne
            || IsPlayerInRangeOfPoint(playerid,2,589.23029, -1479.66357, 91.74274)//Dyrektorat
            || IsPlayerInRangeOfPoint(playerid,2,613.4404,-1471.9745,73.8816)//DACH
            || IsPlayerInRangeOfPoint(playerid,2,596.5255, -1489.2544, 15.3587)//Parking
            || IsPlayerInRangeOfPoint(playerid,2,1093.0625,1530.8715,6.6905)//Parking podziemny
            || IsPlayerInRangeOfPoint(playerid,2,585.70782, -1479.54211, 99.01273)//CID/ERT
            || IsPlayerInRangeOfPoint(playerid,2,594.05334, -1476.27490, 81.82840)//stanowe
            || IsPlayerInRangeOfPoint(playerid,2,590.42767, -1447.62939, 80.95732)//Sale Treningowe
            || IsPlayerInRangeOfPoint(playerid,2,605.5609, -1462.2583, 88.1674))//Sale przes³uchaniowe
            && (doorFBIStatus == 0 && !GetPlayerFraction(playerid) == FRAC_FBI))
                sendTipMessage(playerid, "Ta winda jest zamkniêta.");
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1271.0920,-1667.8794,19.7344)) // strzelnica wejœcie
        {
            if(GUIExit[playerid] == 0)
            {
                ShowPlayerDialogEx(playerid, 324, DIALOG_STYLE_LIST, "Tory szkoleniowe", "Strzelnica w budynku\nStrzelnica w terenie\nSkoki spadochronowe\nTor szkoleniowy ' Porwanie w domu '\nTor szkoleniowy ' Terroryœci na statku '", "Wybierz", "Anuluj");
                return 1;
            }
        }
        //SAD
        else if(IsPlayerInRangeOfPoint(playerid,3,1311.5483,-1361.2096,62.8567)
            || IsPlayerInRangeOfPoint(playerid,3,1305.9991,-1326.1344,52.5659)
            || IsPlayerInRangeOfPoint(playerid,3,1309.9982,-1364.2216,59.6271)
            || IsPlayerInRangeOfPoint(playerid,3,1310.1989,-1328.8876,82.5859)
            || IsPlayerInRangeOfPoint(playerid,3,1310.2946,-1321.2517,74.6955)
            || IsPlayerInRangeOfPoint(playerid,3,1310.3961,-1319.0530,35.6587))
        { //WINDA
            ShowPlayerDialogEx(playerid, DIALOG_ELEVATOR_SAD, DIALOG_STYLE_LIST, "Winda:", "{660000}[-1] {D2CFA6} Archiwum\n{660000}[0] {D2CFA6} Recepcja\n{660000}[1] {D2CFA6} Sale Rozpraw\n{660000}[2] {D2CFA6} Biura\n{660000}[3] {D2CFA6} Pomieszczenia Socjalne\n{660000}[4] {D2CFA6} Dach", "Wybierz", "Anuluj");
        }
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 1144.4740, -1333.2556, 13.8348) || 
            IsPlayerInRangeOfPoint(playerid,2.0,1134.0449,-1320.7128,68.3750)||
            IsPlayerInRangeOfPoint(playerid,2.0,1183.3129,-1333.5684,88.1627)|| 
            IsPlayerInRangeOfPoint(playerid,2.0, -2805.0967,2596.0566,-98.0829) ||
            IsPlayerInRangeOfPoint(playerid,2.0,1168.2112,-1340.6785,100.3780)||
            IsPlayerInRangeOfPoint(playerid,2.0,1158.6868,-1339.4423,120.2738)|| 
            IsPlayerInRangeOfPoint(playerid,2.0,1167.7832,-1332.2727,134.7856)||
            IsPlayerInRangeOfPoint(playerid,2.0,1177.4791,-1320.7749,178.0699)||
            IsPlayerInRangeOfPoint(playerid,2.0,1178.2081,-1330.6317,191.5315)||
            IsPlayerInRangeOfPoint(playerid,2.0, 1161.8228, -1337.0521, 31.6112))
        {
            ShowPlayerDialogEx(playerid, D_ELEVATOR_LSMC, DIALOG_STYLE_LIST, "Winda szpitalna:", "{660000}[-1] {D2CFA6}Kostnica i laboratorium\n{660000}[0] {D2CFA6}Parking wewnêtrzny\n{660000}[1] {D2CFA6}Izba przyjêæ\n{660000}[2] {D2CFA6}Strefa pracownika\n{660000}[3] {D2CFA6}Sale operacyjne\n{660000}[4] {D2CFA6}Sale pooperacyjne\n{660000}[5] {D2CFA6}Sale specjalistyczne\n{660000}[6] {D2CFA6}Akademia medyczna\n{660000}[7] {D2CFA6}Gabinety ordynatorów\n{660000}[8] {D2CFA6}Dach szpitala", "Wybierz", "Anuluj");
        }
        else if(IsPlayerInRangeOfPoint(playerid,2.0, 1538.7106,-1474.8816,9.5000) || //Parking
            IsPlayerInRangeOfPoint(playerid,2.0, 1529.2543,-1489.3378,16.5134)|| //Recepcja
            IsPlayerInRangeOfPoint(playerid,2.0, 1549.7249,-1462.1644,3.3250)|| //Strefa Pracownika
            IsPlayerInRangeOfPoint(playerid,2.0, 1526.7426,-1469.4413,23.0778) || //Sala treningowa
            IsPlayerInRangeOfPoint(playerid,2.0, 1541.2571,-1464.1281,21.8429)|| //Biura
            IsPlayerInRangeOfPoint(playerid,2.0, 1544.1202,-1466.9008,42.8386) || //Akademia 
            IsPlayerInRangeOfPoint(playerid,2.0, 1542.1123,-1467.8416,63.8593)) //Dach
        {
            ShowPlayerDialogEx(playerid, D_ELEVATOR_USSS, DIALOG_STYLE_LIST, "Winda:", "{660000}[-1] {D2CFA6}Parking\n{660000}[0] {D2CFA6}Recepcja\n{660000}[1] {D2CFA6}Sala treningowa\n{660000}[2] {D2CFA6}Strefa pracownika\n{660000}[3] {D2CFA6}Biura\n{660000}[4] {D2CFA6}Akademia\n{660000}[5] {D2CFA6}Dach", "Wybierz", "Anuluj");
        }
		
//======================================================================
//=================[SAMOLOT DLA KORPORACJI TRANSP.]=====================
//======================================================================

        //Wejscie do kokpitu at400
        else if (PlayerToPoint(2.0, playerid,0.1389+KTAir_Offsets[0],33.2975+KTAir_Offsets[1],0.5391+100+KTAir_Offsets[2]))
        {
            if(!IsPlayerInFraction(playerid, FRAC_KT, 5000)) return GameTextForPlayer(playerid, "Tylko piloci!", 2000, 3);
            new seat, lVeh;
            for(new i=0;i<MAX_VEHICLES;i++)
            {
                if(GetVehicleModel(i) == 577)
                {
                    lVeh = i;
                    break;
                }
            }
            foreach(new i : Player)
            {
                if(GetPlayerVehicleID(i) == lVeh)
                {
                    seat++;
                }
            }
            if(seat > 1) return GameTextForPlayer(playerid, "Brak miejsc", 2000, 3);
            new Float:PosX,Float:PosY,Float:PosZ;

            GetVehiclePos(lVeh,PosX,PosY,PosZ);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerPos(playerid, PosX, PosY, PosZ);
            PutPlayerInVehicleEx(playerid, lVeh, seat);
            GameTextForPlayer(playerid, "Chwytaj za stery!", 2000, 5);
        }
        //Lotnisko LS wejœcie do AT400
        else if (PlayerToPoint(2.0, playerid,1937.5,-2275.8,16.9) 
            || PlayerToPoint(2.0, playerid,-1360.0999755859, -239.89999389648, 17.60000038147) 
            || PlayerToPoint(2.0, playerid,1581.6999511719, 1444.5, 14.10000038147))//LS
        {
            new Float:PosX,Float:PosY,Float:PosZ;
            for(new i=0;i<MAX_VEHICLES;i++)
            {
                if(GetVehicleModel(i) == 577)
                {
                    GetVehiclePos(i,PosX,PosY,PosZ);
                    break;
                }
            }
            if(IsPlayerInRangeOfPoint(playerid, 25, PosX,PosY,PosZ))
            {
                if(planeisstopped == 1 || IsPlayerInFraction(playerid, FRAC_KT, 5000))
                {
                    if(PlayerInfo[playerid][pBiletsamolotowy]==1 || IsPlayerInFraction(playerid, FRAC_KT, 5000))
                    {
                        GameTextForPlayer(playerid, "Witamy w samolocie! ZnajdŸ swoje miejsce", 4000, 3);
                        SetPlayerPos(playerid, 3.5040+KTAir_Offsets[0],30.7375+KTAir_Offsets[1],0.5391+100+KTAir_Offsets[2]);
                        SetPlayerVirtualWorld(playerid, 2);
                        //PlayerInfo[playerid][pBiletsamolotowy]=0;
                        PlayerInfo[playerid][pWsamolocieLS]=1;
                        osoby++;
                        Wchodzenie(playerid);
                    }
                    else
                    {
                        GameTextForPlayer(playerid, "~r~Nie masz biletu", 5000, 1);
                    }
                }
                else
                {
                    sendTipMessageEx(playerid, COLOR_GREY, "Drzwi samolotu s¹ zamkniête !");
                }
            }
            else
            {
                 sendTipMessageEx(playerid, COLOR_GREY, "Nie ma w pobli¿u samolotu !");
            }
        }
        //Wejcie do srodka int z biletem
        else if (PlayerToPoint(3.0, playerid,1886.1,-2286.4,14))
        {
            SetPlayerPos(playerid, 1605,-2282.9,-74.90);
            Wchodzenie(playerid);
        }
//====================================[SAMOLOT END]=================================================
        
        
//======================================================================
//=================[Nieznane - nieokreœlone - nieprzeniesione]==========
//======================================================================

        
       //wejscie do vinyl
        else if(PlayerToPoint(1.5, playerid, 816.5667, -1415.4117, -22.5834))
        {
            if(vinylStatus == 0 && !IsFrontBusinnesOwnedByPlayerOrg(playerid, 40))
            {
                sendTipMessage(playerid, "Vinyl jest aktualnie zamkniêty! Skontaktuj siê z w³aœcicielem klubu."); 
                return 1;
            }
            if(GetPVarInt(playerid, "Vinyl-bilet") < 1 && !IsFrontBusinnesOwnedByPlayerOrg(playerid, 40))
            {
                sendErrorMessage(playerid, "Nie posiadasz biletu do Vinyla!"); 
                return 1;
            }
            SetPlayerLocal(playerid, PLOCAL_ORG_SN); 
            SetPlayerVirtualWorld(playerid, 71);
            SetPlayerPos(playerid, 816.4222, -1413.7644, -22.5834);
            GameTextForPlayer(playerid, "~w~Witamy w klubie", 5000, 1);
            Wchodzenie(playerid);
            return 1;
        }
        //IBIZA =======================
        //wejscie glowne, na bilet.
        else if(PlayerToPoint(1.5, playerid, 395.9647, -1811.1703, 7.8789) && GetPlayerVirtualWorld(playerid) == 21)
        {
            if(IbizaTicket[playerid] == 0)
            {
                if(!IsFrontBusinnesOwnedByPlayerOrg(playerid, 39))
                {
                    sendErrorMessage(playerid, "Nie posiadasz biletu do Ibizy!"); 
                    return 1;
                }
            }
            if  (!IsAPolicja(playerid)
			&&  PlayerInfo[playerid][pLider] == 0 
			&&  GetPlayerOrg(playerid) == 0)
			{
                new weapon[12], ammo[12], bool:wyrzuc=false;
                for(new i=0;i<12;i++)
                {
                    GetPlayerWeaponData(playerid, i, weapon[i], ammo[i]);
                    if(weapon[i] > 0)
                    {
                        wyrzuc = true;
                        break;
                    }
                }
                if(wyrzuc)
                {
                    SendClientMessage(playerid, COLOR_PANICRED, "****Piip! Piip! Piip!*****");
                    SendClientMessage(playerid, COLOR_WHITE, "Przechodz¹c przez wykrywacz metalu s³yszysz alarm.");
                    SendClientMessage(playerid, COLOR_WHITE, "Dopiero teraz dostrzegasz czerwon¹ tabliczkê informuj¹c¹ o zakazie");
                    SendClientMessage(playerid, COLOR_WHITE, "Nie chcesz k³opotów, wiêc oddajesz swój arsena³ ochroniarzowi Ibizy.");
                    SendClientMessage(playerid, COLOR_PANICRED, "((Broñ otrzymasz po œmierci//ponownym zalogowaniu))");
                    SetTimerEx("AntySB", 5000, 0, "d", playerid);
				    AntySpawnBroni[playerid] = 5;
                    SetPVarInt(playerid, "mozeUsunacBronie", 1);
                    RemovePlayerWeaponsTemporarity(playerid);
                }
			}
            Wchodzenie(playerid);
            SetPlayerVirtualWorld(playerid, 22);
            SetPlayerPos(playerid, 417.3976, -1858.9402, -65.3905);
            GameTextForPlayer(playerid, "~w~Witamy w klubie", 5000, 1);
            PlayAudioStreamForPlayer(playerid, IBIZA_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
            return 1;
        }
        else if(PlayerToPoint(1.5, playerid, 408.6968, -1855.0348, -65.5105) && GetPlayerVirtualWorld(playerid) == 22)
        {
            if(IbizaTicket[playerid] <= 1)
            {
                if(!IsFrontBusinnesOwnedByPlayerOrg(playerid, 39))
                {
                    GameTextForPlayer(playerid, "~r~Brak dostepu", 5000, 1);
                    return 1;
                }
            }
            SetPlayerPos(playerid, 406.8980, -1856.6122, -65.2092);
            GameTextForPlayer(playerid, "~w~Witamy w strefie VIP", 5000, 1);
            return 1;
        }
        else if(PlayerToPoint(1.5, playerid, 408.8490, -1835.8851, -65.5105) && GetPlayerVirtualWorld(playerid) == 22)
        {
            if(IbizaTicket[playerid] <= 1)
            {
                if(!IsFrontBusinnesOwnedByPlayerOrg(playerid, 39))
                {
                    GameTextForPlayer(playerid, "~r~Brak dostepu", 5000, 1);
                    return 1;
                }
            }
            SetPlayerPos(playerid, 406.3426, -1835.0138, -65.2092);
            GameTextForPlayer(playerid, "~w~Witamy w strefie VIP", 5000, 1);
            return 1;
        }
        else if(PlayerToPoint(1.5, playerid, 403.3954,-1843.4607,-65.5105) && GetPlayerVirtualWorld(playerid) == 22)
        {
            if(IbizaTicket[playerid] <= 1)
            {
                if(!IsFrontBusinnesOwnedByPlayerOrg(playerid, 39))
                {
                    GameTextForPlayer(playerid, "~r~Brak dostepu", 5000, 1);
                    return 1;
                }
            }
            SetPlayerPos(playerid, 416.8028, -1850.4160, -61.9043);
            GameTextForPlayer(playerid, "~w~Witamy w strefie VIP", 5000, 1);
            return 1;
        }
        //wejscia SUPERVIP
        else if(PlayerToPoint(1.5, playerid, 424.0322, -1837.0964, -65.5105) && GetPlayerVirtualWorld(playerid) == 22)
        {
            if(IbizaTicket[playerid] <= 2)
            {
                if(!IsFrontBusinnesOwnedByPlayerOrg(playerid, 39))
                {
                    GameTextForPlayer(playerid, "~r~Brak dostepu", 5000, 1);
                    return 1;
                }
            }
            SetPlayerPos(playerid, 426.7242, -1834.9066, -65.2102);
            GameTextForPlayer(playerid, "~w~Witamy w strefie SUPERVIP", 5000, 1);
            return 1;
        }
        else if(PlayerToPoint(1.5, playerid, 422.2131, -1831.5657, -65.5105) && GetPlayerVirtualWorld(playerid) == 22)
        {
            if(IbizaTicket[playerid] <= 2)
            {
                if(!IsFrontBusinnesOwnedByPlayerOrg(playerid, 39))
                {
                    GameTextForPlayer(playerid, "~r~Brak dostepu", 5000, 1);
                    return 1;
                }
            }
            Wchodzenie(playerid);
            SetPlayerVirtualWorld(playerid, 25);
            SetPlayerPos(playerid, 221.530426, -1546.261352, -15.997495);
            PlayAudioStreamForPlayer(playerid, IBIZA_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
            GameTextForPlayer(playerid, "~w~Witamy w strefie SUPERVIP", 5000, 1);
            return 1;
        }
        //san news biura
        else if(PlayerToPoint(1.0, playerid, 286.0645,-1602.0117,134.4274) && posDrzwiSN[playerid] == 0)
        {
            sendTipMessageEx(playerid, COLOR_RED, "Witaj w biurze dyrektorki!"); 
            SetPlayerPos(playerid, 285.8782,-1604.2446,134.4756); 
            posDrzwiSN[playerid] = 1; 
            return 1;
        }
        else if(PlayerToPoint(1.0, playerid, 285.8782,-1604.2446,134.4756) && posDrzwiSN[playerid] == 1)
        {
            SetPlayerPos(playerid, 286.0645,-1602.0117,134.4274); 
            posDrzwiSN[playerid] = 0; 
            return 1;
        }
        else if(PlayerToPoint(1.0, playerid, 298.0779,-1603.7250,134.4482) && posDrzwiSN[playerid] == 0)
        {
            sendTipMessageEx(playerid, COLOR_RED, "Witaj w biurze v-dyrektora!"); 
            SetPlayerPos(playerid, 297.9890,-1605.9541,134.4645); 
            posDrzwiSN[playerid] = 1; 
            return 1;
        }
        else if(PlayerToPoint(1.0, playerid, 297.9890,-1605.9541,134.4645) && posDrzwiSN[playerid] == 1)
        {
            SetPlayerPos(playerid, 298.0779,-1603.7250,134.4482); 
            posDrzwiSN[playerid] = 0; 
            return 1;
        }
       //reszta
        else if (PlayerToPoint(4.0, playerid,738.8545, -1428.7880, 13.5927)) //biura LCN
        {
            SetPlayerPos(playerid,738.5865, -1427.7610, 23.5927); //biura LCN wejœcie
            GameTextForPlayer(playerid,"~w~Witamy w biurach Jetty Lounge ~n~ ~b~ By ~r~_DywaniK_",5000,1);
            SetPlayerVirtualWorld(playerid, 2);
            Wchodzenie(playerid);
            return 1;
        }
        else if (PlayerToPoint(2.0, playerid,-2170.0593,641.1239,1052.3817)) //Zak³ad bukmaherski WEJSCIE NA GORE
        {
            SetPlayerPos(playerid,-2168.7502,636.2642,1052.7642); 
            GameTextForPlayer(playerid, "~w~Witamy NA GORZE", 5000, 1);
            SetPlayerInterior(playerid, 1);
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid,5,-1674.5769,903.1641,-48.9141) )//nowe komi wejscie prawnicze
        {
            if(ApprovedLawyer[playerid] == 1 || PlayerInfo[playerid][pMember] == FRAC_FBI)
                SetPlayerPos(playerid,-1674.4122,917.7183,-52.4141); //nowe komi drzwi w celach
            else
                SendClientMessage(playerid, COLOR_GRAD1, "Musisz mieæ pozwolenie prawnicze aby przejœæ");

        }
		else if (IsPlayerInRangeOfPoint(playerid, 2.0, -2065.5505,575.6121,1173.0511)) // wejscie na balkon
        {
            SetPlayerPos(playerid, -2473.8140,2231.9236,8.9133); // balkon bay side
            SetPlayerInterior(playerid, 0);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 276.32934570313,122.20029449463,1004.1166992188)) // Pokój przes³uchañ wejs
        {
            if(IsAPolicja(playerid))
            {
                SetPlayerPos(playerid, 2371.5246582031, 586.56274414063, 4893.2431640625); // Pokój przes³uchañ sro
                TogglePlayerControllable(playerid, 0);
                Wchodzenie(playerid);
                SetPlayerInterior(playerid, 10);
                SetPlayerVirtualWorld(playerid, 0);
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "Tylko dla policjantów i wiêŸniów w kajdankach");
                return 1;
            }
        }
		//AirTower LS
        else if(IsPlayerInRangeOfPoint(playerid,3.0,1635.3210, -2286.5698, 13.4162) && IsPlayerInFraction(playerid, FRAC_KT, 5000))
        {
            INT_AirTowerLS_Init(playerid);
            SetPlayerPos(playerid, 1627.3157,-2279.6157,75.0);
            GameTextForPlayer(playerid, "~w~/wieza", 2000, 1);
            Wchodzenie(playerid);
        }
       
//======================================================================
//=================[BASEN TSUNAMI WEJŒCIA]==============================
//======================================================================
        else if (IsPlayerInRangeOfPoint(playerid, 5.0,  1205.45874, -1765.66833, 13.54815)) // basen wejœcie
        {
			if(poolStatus == 1)
			{
				if(Kredyty[playerid] >= 200)
				{
					SetPlayerPos(playerid, 1213.3364,-1807.0619,70.0682); // basen œrodek
					GameTextForPlayer(playerid, "~w~Szatnie~n~ ~r~by Simeone & Sergio", 5000, 1);
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Aby siê przebraæ podejdŸ do szafek i wpisz /przebierz");
					SetPlayerVirtualWorld(playerid, 43);
					TogglePlayerControllable(playerid, 0);
					Wchodzenie(playerid);
					Kredyty[playerid] -= 200;
					ResetPlayerWeapons(playerid);
					SetPVarInt(playerid, "mozeUsunacBronie", 1);
					
					new string[128];
					format(string, sizeof(string), "Pozosta³o Ci %d kredytów", Kredyty[playerid]);
					sendTipMessage(playerid, string);
					poolStats = poolStats+1;
					return 1;
				}
				else
				{
					sendTipMessageEx(playerid, COLOR_GREY, "Nie masz wystarczaj¹cej iloœci kredytów.");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, -1, "Pani Janina mówi: Przykro mi! Szef jeszcze nie otworzy³, przyjdŸ póŸniej.");
				return 1;
			}
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1213.28540, -1790.80505, 70.25735)) // sauny wejœcie
        {
            if(Kredyty[playerid] >= 75)
            {
                SetPlayerPos(playerid, 1274.3020,-1756.0800,48.5812); // sauny œrodek
                GameTextForPlayer(playerid, "~w~Wypoc swoje ~r~Problemy", 5000, 1);
                SetPlayerVirtualWorld(playerid, 43);
                TogglePlayerControllable(playerid, 0);
                Wchodzenie(playerid);
                Kredyty[playerid] -=75;
				
				new string[128];
				format(string, sizeof(string), "Pozosta³o Ci %d kredytów", Kredyty[playerid]);
				sendTipMessage(playerid, string);
				poolSaunaStats = poolSaunaStats+1;
                return 1;
            }
            else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Nie masz wystarczaj¹cej iloœci kredytów.");
                return 1;
            }
        }
        else if (IsPlayerInRangeOfPoint(playerid, 3.0, 598.6794,-2204.8613,1.8190)) // tylko dla personelu bar
        {
            SetPlayerPos(playerid, 1193.2720,-1774.8802,13.7282); // recepcja
            TogglePlayerControllable(playerid, 0);
            SetPlayerVirtualWorld(playerid, 43);
            Wchodzenie(playerid);
            return 1;
        } 
        else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1221.30774, -1790.77686, 71.70520))  //basen tsunami wejscie do hali
        {
            SetPlayerPos(playerid, 566.5435,-2087.0046,2.7402);  //basen tsunami hala
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            return 1;
        }

        
//======================================================================
//=================[IBIZA WEJSÆIA I SKRYPT==============================
//======================================================================
        //IBIZA
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 397.6700,-1811.8844,14.7359) && GetPlayerVirtualWorld(playerid) == 0)
        {
            if(!IbizaDach) return sendTipMessageEx(playerid, 0xB52E2BFF, "Wyjœcie na dach jest zamkniête");
            Wchodzenie(playerid);
            SetPlayerPos(playerid, 1892.9077,-2451.8071,21.6559);
            SetPlayerFacingAngle(playerid, 178.8724);
            SetPlayerVirtualWorld(playerid, 1);
            SetPVarInt(playerid, "IbizaWejdz", 1);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 50.0, 1);
            if(IbizaSwiatla) WlaczSwiatlaP(playerid);
            else WylaczSwiatlaP(playerid);
            return 1;

        }
        //wejœcie do bileterki
        else if(IsPlayerInRangeOfPoint(playerid, 12.0, 1740.8485,-2471.0625,14.2266) && IsFrontBusinnesOwnedByPlayerOrg(playerid, 39) && GetPlayerVirtualWorld(playerid) == 1) //RANGA
        {
            SetPlayerPos(playerid, 397.6122,-1806.0079,7.8381);
            SetPlayerFacingAngle(playerid, 0.8024);
            SetPlayerVirtualWorld(playerid, 0);
            SetPVarInt(playerid, "IbizaWejdz", 0);
            StopAudioStreamForPlayer(playerid);
            IbizaWyjscie(playerid);
            return 1;
        }

        //Wejscie gflowne prawe
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 394.2784,-1805.9104,7.8302) && GetPlayerVirtualWorld(playerid) == 0 )
        {
            if(IbizaZamek) return sendTipMessageEx(playerid, 0xB52E2BFF, "Klub jest w tej chwili zamkniêty");
            if(!GetPVarInt(playerid, "IbizaBilet") && !IsAClubBusinessOwner(playerid)) return sendTipMessageEx(playerid, 0xB52E2BFF, "Nie posiadasz biletu, kup go w kasie"); //RANGA
            TogglePlayerControllable(playerid, false);
            Wchodzenie(playerid);
            SetPlayerPos(playerid, 1741.5828,-2473.1572,14.2266);
            SetPlayerFacingAngle(playerid, 271.2026);
            SetPlayerVirtualWorld(playerid, 1);
            SetPVarInt(playerid, "IbizaWejdz", 1);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 250.0, 1);
            if(IbizaSwiatla) WlaczSwiatlaP(playerid);
            else WylaczSwiatlaP(playerid);
            SendClientMessage(playerid, -1, "=====Witamy w {00FF00}I{FFFFFF}biza {DE00FF}C{FFFFFF}lub=====");
            SendClientMessage(playerid, 0x88aa62FF, "((UWAGA! W naszym klubie czêsto mo¿na siê spotkaæ z wiadomoœciami typu: Audio stream.. aby wy³¹czyæ ten komunikat wpisz /audiomsg))");
            GameTextForPlayer(playerid, "~y~Projekt by Macias & Sonix", 5000, 1);
            return 1;
        }
        // Wejscie do glownej sali klubu
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1761.7330,-2471.2756,19.7275) && GetPlayerVirtualWorld(playerid) == 1 )
        {
            TogglePlayerControllable(playerid, false);
            SetPlayerPos(playerid, 1890.3613,-2494.6675,14.2266);
            SetPlayerFacingAngle(playerid, 268.8783);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID]);
            Wchodzenie(playerid);
            return 1;
        }
        // BAR - wejscie
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1898.4817,-2494.8752,13.6266) && GetPlayerVirtualWorld(playerid) == 1 && IsAClubBusinessOwner(playerid)) //RANGA
        {
            SetPlayerPos(playerid, 1900.5961,-2494.9373,13.6266);
            SetPlayerFacingAngle(playerid, 271.5300);
            return 1;
        }
        // Dyrekcja - wejscie
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1915.1454,-2468.3472,15.4266) && GetPlayerVirtualWorld(playerid) == 1)
        {
            if(!IbizaBiuro) return sendTipMessageEx(playerid, 0xB52E2BFF, "Biuro jest w tej chwili zamkniête");
            SetPlayerPos(playerid, 1911.5500,-2466.1172,17.9850);
            SetPlayerFacingAngle(playerid, 181.9157);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 50.0, 1);
            return 1;
        }
        //wejscie od Zaplecza
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 386.2871,-1817.9784,7.8410) && GetPlayerVirtualWorld(playerid) == 0)
        {
            if(IbizaZamek) return sendTipMessageEx(playerid, 0xB52E2BFF, "Klub jest w tej chwili zamkniêty");
            if(!IsAClubBusinessOwner(playerid)) return sendTipMessageEx(playerid, 0xB52E2BFF, "Nie mo¿esz têdy przejœæ, nie jesteœ z Ibiza Club!"); //RANGA
            TogglePlayerControllable(playerid, false);
            SetPlayerPos(playerid, 1917.3785,-2465.4368,15.4266);
            SetPlayerFacingAngle(playerid, 180.7695);
            SetPlayerVirtualWorld(playerid, 1);
            SetPVarInt(playerid, "IbizaWejdz", 1);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID]);
            if(IbizaSwiatla) WlaczSwiatlaP(playerid);
            else WylaczSwiatlaP(playerid);
            Wchodzenie(playerid);
            return 1;
        }
        //wejscie ubikacja prawa
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1910.2588,-2474.8745,13.6266) && GetPlayerVirtualWorld(playerid) == 1)
        {
            SetPlayerPos(playerid, 1534.3746,-2553.6333,13.5890);
            SetPlayerFacingAngle(playerid, 268.5209);
            SetPVarInt(playerid, "IbizaKibel", 1);
            WlaczSwiatlaP(playerid);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 500.0, 1);
            return 1;
        }
        //wejscie ubikacja lewa
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1906.1383,-2474.4417,13.6266) && GetPlayerVirtualWorld(playerid) == 1)
        {
            SetPlayerPos(playerid, 1534.2446,-2550.8020,13.5890);
            SetPlayerFacingAngle(playerid ,268.5209);
            SetPlayerVirtualWorld(playerid, 2);
            SetPVarInt(playerid, "IbizaKibel", 1);
            WlaczSwiatlaP(playerid);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 500.0, 1);
            return 1;
        }
        else
        {
		
//======================================================================
//=================[Biznesy, domy i inny syf]===========================
//======================================================================
            Wejdz(playerid, 1285.5999755859,-981.79998779297,32.700000762939, 1300.0999755859,-1094.5999755859,5972.2001953125, 5.0);//int z flagami
            Wejdz(playerid, 1302.8000488281,-988.20001220703,38.299999237061, 1301.8000488281,-1083.9000244141,5972.2001953125, 5.0);//g³ówne wejœcie
            Wejdz(playerid, -1716.1999511719,1018.200012207,17.60000038147, -1825.4000244141,1151.6999511719,6803.2998046875, 5.0);//WEJSCIE DO KRYJOWKI
            Wejdz(playerid, -1858.3000488281,1158.3000488281,6799, -1865.6999511719,1116.8000488281,6799.10009765, 2.0);//drzwi 1
            Wejdz(playerid, -1858.5,1160.5999755859,6799, -1877.1999511719,1178,6799.2998046875, 2.0);//drzwi 2
            
			//BIZNESY
            for(new i=0; i<=BusinessLoaded; i++)
            {
                if(IsPlayerInRangeOfPoint(playerid, 4.2, Business[i][b_enX], Business[i][b_enY], Business[i][b_enZ])
                && GetPlayerVirtualWorld(playerid) == Business[i][b_enVw] && GetPlayerInterior(playerid) == Business[i][b_enInt])
                {
                    if(BizOpenStatus[i] == 1 
                    && PlayerInfo[playerid][pBusinessOwner] != i
                    && PlayerInfo[playerid][pBusinessMember] != i)
                    {
                        sendErrorMessage(playerid, "Ten biznes jest zamkniêty!"); 
                        return 1;
                    }
                    if(Business[i][b_vw] == 0 && Business[i][b_enX] == Business[i][b_exX])
                    {
                        sendTipMessage(playerid, "Ten biznes nie ma wnêtrza!"); 
                        return 1;
                    }
                    if (Business[i][b_vw] == 55 && Business[i][b_int] == 3) // Bymber Casino 
                    {
                        if(PlayerInfo[playerid][pLevel] < 3) return sendTipMessageEx(playerid, COLOR_GRAD1, "Tylko gracze z conajmniej 3 lvl mog¹ graæ w kasynie!");
                        
                        SendClientMessage(playerid, COLOR_GREEN, "Witamy w Bymber Casino.");
                        SendClientMessage(playerid, COLOR_WHITE, "W naszym kasynie obowi¹zuj¹ nastêpuj¹ce stawki za rozpoczêcie gry:");
                        SendClientMessage(playerid, COLOR_GREEN, "Kostki - (0.5 proc. podatku) za rzut /kostka || Black Jack - 100$ za kartê /oczko");
                        SendClientMessage(playerid, COLOR_GREEN, "Ko³o fortuny - 5 000$ za obrót /kf || Ruletka - 10 000$ za zakrêcenie /ruletka");

                        SendClientMessage(playerid, COLOR_PANICRED, "****Piip! Piip! Piip!*****");
                        SendClientMessage(playerid, COLOR_WHITE, "Przechodz¹c przez wykrywacz metalu s³yszysz alarm.");
                        SendClientMessage(playerid, COLOR_WHITE, "Nie chcesz k³opotów, wiêc oddajesz swój arsena³ ochronie.");
                        SendClientMessage(playerid, COLOR_PANICRED, "((broñ zostanie przywrócona po œmierci lub ponownym zalogowaniu))");
                        
                        SetPVarInt(playerid, "mozeUsunacBronie", 1);
                        RemovePlayerWeaponsTemporarity(playerid); // bug?
                    }
                    SetPlayerVirtualWorld(playerid, Business[i][b_vw]); 
                    SetPlayerInterior(playerid, Business[i][b_int]); 
                    SetPlayerLocal(playerid, Business[i][b_pLocal]); 
                    SetPlayerPos(playerid, Business[i][b_exX], Business[i][b_exY], Business[i][b_exZ]);
                    Wchodzenie(playerid);
                    return 1;  
                }
            }

            for(new i; i<=dini_Int("Domy/NRD.ini", "NrDomow"); i++)
            {
                if(IsPlayerInRangeOfPoint(playerid, 3.0, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z]))
                {
                    if(PlayerInfo[playerid][pDom] == i)
                    {
                        new deem = Dom[i][hDomNr];
                        new h, m;
                        GetPlayerTime(playerid, h, m);
                        SetPlayerPos(playerid, IntInfo[deem][Int_X], IntInfo[deem][Int_Y], IntInfo[deem][Int_Z]);
                        SetPlayerInterior(playerid, IntInfo[deem][Int]);
                        SetPlayerVirtualWorld(playerid, Dom[i][hVW]);
                        SetPlayerTime(playerid, Dom[i][hSwiatlo], 0);
                        PlayerInfo[playerid][pDomT] = h;
                        PlayerInfo[playerid][pDomWKJ] = i;
                        GameTextForPlayer(playerid, "~g~Witamy w domu", 5000, 1);
                    }
                    else if(Dom[i][hZamek] == 1)
					{
						new deem = Dom[i][hDomNr];
						new h, m;
						GetPlayerTime(playerid, h, m);
						SetPlayerPos(playerid, IntInfo[deem][Int_X], IntInfo[deem][Int_Y], IntInfo[deem][Int_Z]);
						SetPlayerInterior(playerid, IntInfo[deem][Int]);
						SetPlayerVirtualWorld(playerid, Dom[i][hVW]);
						SetPlayerTime(playerid, Dom[i][hSwiatlo], 0);
						PlayerInfo[playerid][pDomT] = h;
						PlayerInfo[playerid][pDomWKJ] = i;
						GameTextForPlayer(playerid, "~g~Witamy w domu", 5000, 1);
					}
					else if(PlayerInfo[playerid][pAdmin] >= 1000)
					{
						new deem = Dom[i][hDomNr];
						new h, m;
						GetPlayerTime(playerid, h, m);
						SetPlayerPos(playerid, IntInfo[deem][Int_X], IntInfo[deem][Int_Y], IntInfo[deem][Int_Z]);
						SetPlayerInterior(playerid, IntInfo[deem][Int]);
						SetPlayerVirtualWorld(playerid, Dom[i][hVW]);
						SetPlayerTime(playerid, Dom[i][hSwiatlo], 0);
						PlayerInfo[playerid][pDomT] = h;
						PlayerInfo[playerid][pDomWKJ] = i;
						GameTextForPlayer(playerid, "~g~Witamy w domu", 5000, 1);
					}
					else
					{
						sendErrorMessage(playerid, "Drzwi s¹ zamkniête.");
						GameTextForPlayer(playerid, "~r~Zamkniete", 5000, 1);
						return 1;
					}
					
					if(Dom[i][hVW] == 2001)
						Wchodzenie(playerid);
					return 1;
                }
            }
        }
    }
    return 1;
}

//end
