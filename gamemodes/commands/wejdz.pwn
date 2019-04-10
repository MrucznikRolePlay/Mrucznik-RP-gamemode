//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wejdz ]-------------------------------------------------//
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

CMD:enter(playerid) return cmd_wejdz(playerid);
CMD:wejdz(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		PlayerPlaySound(playerid, 1, 0.0, 0.0, 0.0);
		
		
        if(GetPVarInt(playerid, "AC-izolacja") != 0) return sendTipMessageEx(playerid, COLOR_PANICRED, "Jesteœ odizolowany, nie mo¿esz u¿ywaæ tej komendy.");
        
        if(SprawdzWejscia(playerid))
            return 1;
        
        if(IsPlayerInRangeOfPoint(playerid, 5.0, 1143.5290527344, -1327.2391357422, 419.69830322266))//wypoczynek wejscie
        {
            SetPlayerPosEx(playerid, 1144.0762939453, -1324.9822998047, 419.69830322266);//wypoczynek srodek
            GameTextForPlayer(playerid, "~w~Witamy w ~y~Pokoju ~g~Wypoczynkowym", 5000, 1);
            Wchodzenie(playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid,5,1711.3928, -1130.0851, 24.1741)) //LSFD dach
        {
            SetPlayerPosEx(playerid,1751.6058, -1118.3661, 46.8055);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 694.27490234375,-569.04272460938,-79.225189208984) || IsPlayerInRangeOfPoint(playerid, 3.0, 700.6748046875,-502.41955566406,23.515483856201) || IsPlayerInRangeOfPoint(playerid, 5.0, 707.06085205078,-508.38107299805,27.871946334839))//rada miasta dillimore (miasteczko) windy
        {
            ShowPlayerDialogEx(playerid, 121, DIALOG_STYLE_LIST, "Wybierz pomieszczenie", "Salka Konferencyjna\nBiura\nPiwnice", "Wybierz", "WyjdŸ");
        }
        else if(
			IsPlayerInRangeOfPoint(playerid,3,1450.6615,-1819.2279,77.9613) ||  
			IsPlayerInRangeOfPoint(playerid,5,1412.3348388672, -1790.5777587891, 15.370599746704) 
			&& IsAUrzednik(playerid))
        {
            ShowPlayerDialogEx(playerid,122,DIALOG_STYLE_LIST,"Winda: Wybierz Piêtro","[Poziom 0] Zaplecze\n[Poziom 9] G³ówna sala urzêdu","Wybierz","WyjdŸ");
        }
        else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1745.8119, -1129.8972, 24.0781) || IsPlayerInRangeOfPoint(playerid, 3.0, 1746.0676, -1127.9219, 46.5746) || IsPlayerInRangeOfPoint(playerid, 3.0, 1746.2399, -1128.2211, 227.8059))
            ShowPlayerDialogEx(playerid, D_WINDA_LSFD, DIALOG_STYLE_LIST, "Winda", "Gara¿\nPierwsze piêtro\nDrugie piêtro\nDach", "Wybierz", "WyjdŸ");
        else if(IsPlayerInRangeOfPoint(playerid,4,1568.7660,-1691.4886,5.8906) && IsACop(playerid)//parking Dolny LSPD 1568.7660,-1691.4886,5.8906
        || IsPlayerInRangeOfPoint(playerid,4,-1645.1858, 883.1620, -45.4112)//z glownego wejscia
        || IsPlayerInRangeOfPoint(playerid,4,-1621.7272, 834.5807, -26.1115)//sale przesluchan
        || IsPlayerInRangeOfPoint(playerid,4,-1745.1101, 824.0737, -48.0110)//biura LSPD
        || IsPlayerInRangeOfPoint(playerid,4,-1695.1617, 1046.9861, -65.4119)//stolowka
        || IsPlayerInRangeOfPoint(playerid,4,1568.1061, 2205.3196, -50.9522)//treningowe miejsca
        || IsPlayerInRangeOfPoint(playerid,4,1565.0798, -1665.6580, 28.4782) && IsACop(playerid)//dach lspd
        || IsPlayerInRangeOfPoint(playerid,4,1570.9799,-1636.7758,13.5713) && IsACop(playerid))//gorny LSPD
        {
            ShowPlayerDialogEx(playerid,WINDA_LSPD,DIALOG_STYLE_LIST,"Winda","[Poziom -1]Parking Dolny\n[Poziom 0] Parking Górny\n[Poziom 1]Komisariat\n[Poziom 2]Pokoje Przes³uchañ\n[Poziom 3]Biura\n[Poziom 4]Sale Treningowe\n[Poziom 5]Dach","Jedz","");
        }
        //else if(IsPlayerInRangeOfPoint(playerid,3,-2089.55835, -414.24173, 36.32352)//Podziemia BOR
        else if((IsPlayerInRangeOfPoint(playerid,3,1498.9341,-1537.0797,67.3069) && IsABOR(playerid))//Podziemia BOR
        || IsPlayerInRangeOfPoint(playerid,3,1772.1613,-1547.9675,9.9067)
        || IsPlayerInRangeOfPoint(playerid,3,1496.9330, -1457.8887, 64.5854)
        || IsPlayerInRangeOfPoint(playerid,3, 1482.2319, -1531.1719, 70.0080)
        || IsPlayerInRangeOfPoint(playerid,3, 1795.4104,-1551.2864,22.9192)&& IsABOR(playerid))//dach BOR
        {
            ShowPlayerDialogEx(playerid, 696, DIALOG_STYLE_LIST, "Winda:", "[Poziom -1] Parking podziemny\n[Poziom 0] Parking zewnêtrzny\n[Poziom 1] Centrala GSA\n[Poziom 2] Sale Treningowe\n[Poziom 3] Dach", "Wybierz", "Anuluj");
        }
        //winda FBI
		else if(IsPlayerInRangeOfPoint(playerid,2,586.83704, -1473.89270, 89.30576)//przy recepcji
		|| IsPlayerInRangeOfPoint(playerid,2,592.65466, -1486.76575, 82.10487)//szatnia
		|| IsPlayerInRangeOfPoint(playerid,2,591.37579, -1482.26672, 80.43560)//zbrojownia
		|| IsPlayerInRangeOfPoint(playerid,2,596.21857, -1477.92395, 84.06664)//biura federalne
		|| IsPlayerInRangeOfPoint(playerid,2,589.23029, -1479.66357, 91.74274)//Dyrektorat
		|| IsPlayerInRangeOfPoint(playerid,2,613.4404,-1471.9745,73.8816)//DACH
		|| IsPlayerInRangeOfPoint(playerid,2,596.5255, -1489.2544, 15.3587)//Parking
		|| IsPlayerInRangeOfPoint(playerid,2,1093.0625,1530.8715,6.6905)//Parking podziemny
		|| IsPlayerInRangeOfPoint(playerid,2,585.70782, -1479.54211, 99.01273)//CID/ERT
		|| IsPlayerInRangeOfPoint(playerid,2,594.05334, -1476.27490, 81.82840)//stanowe
		|| IsPlayerInRangeOfPoint(playerid,2,590.42767, -1447.62939, 80.95732))//Sale Treningowe
		{
			ShowPlayerDialogEx(playerid,19,DIALOG_STYLE_LIST,"Winda FBI","[Poziom -1]Parking podziemny \n[Poziom 0]Parking\n[Poziom 0.5] Stanowe\n[Poziom 1]Recepcja\n[Poziom 2] Szatnia\n[Poziom 3] Zbrojownia \n[Poziom 4]Biura federalne \n[Poziom 5] Dyrektorat\n[Poziom 6]CID/ERT\n[Poziom 7]Sale Treningowe \n [Poziom X] Dach","Jedz","Anuluj");
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1142.2214355469, -1337.7125244141, 419.69830322266))//wyklady wejscie
        {
            SetPlayerPosEx(playerid, 1142.2545166016, -1339.8093261719, 419.69830322266);//wyklady srodek
            GameTextForPlayer(playerid, "~w~Witamy w ~y~Pokoju ~g~Wykladowym", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
        }
        //SAD
        else if(IsPlayerInRangeOfPoint(playerid,3,1327.6746, -1324.7770, 39.9210)
        || IsPlayerInRangeOfPoint(playerid,3,1289.0969, -1292.7489, 35.9681)
        || IsPlayerInRangeOfPoint(playerid,3,1310.3494, -1361.7319, 39.0876)
        || IsPlayerInRangeOfPoint(playerid,3,1310.0021, -1319.7189, 35.5984))
        { //WINDA
            ShowPlayerDialogEx(playerid, DIALOG_ELEVATOR_SAD, DIALOG_STYLE_LIST, "Winda:", "{660000}[1] {D2CFA6} Hol s¹du\n{660000}[2] {D2CFA6} S¹d Stanu San Andreas\n{660000}[3] {D2CFA6} Biura urzêdników s¹dowych\n{660000}[4] {D2CFA6} Dach", "Wybierz", "Anuluj");
        }
        else if(IsPlayerInRangeOfPoint(playerid,4,1310.0885, -1367.6865, 13.8504))
        { //WEJŒCIE G£OWNE
            SetPlayerPosEx(playerid,1294.6075, -1324.5051, 38.9696);
            GameTextForPlayer(playerid, "~r~Witamy w sadzie! ~n~ by abram01", 6000, 1);
            SetPlayerVirtualWorld ( playerid, 500 ) ;
			
            SetPlayerWeatherEx(playerid, 3);//Pogoda
            SetPlayerTime(playerid, 14, 0);//Czas
			
            Wchodzenie(playerid);
        }
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 2327.0959,-74.9949,39.2946))//plac manewrowy w pc
		{
			SetPlayerPosEx(playerid, 2251.5554,-89.0488,26.4844);
			SetPlayerVirtualWorld(playerid, 0);
			GameTextForPlayer(playerid, "~r~Magik z Ciebie", 6000, 1);
		}
        else if(IsPlayerInRangeOfPoint(playerid,2,1286.0413,-1329.2007,13.5515))
        { //WEJŒCIE DLA S£U¯B PORZ¥DKOWYCH!!! PODPI¥C TYLKO POD GSA PD FBI NG EW. RZ¥D
            if(GetPlayerFraction(playerid) == FRAC_BOR || IsACop(playerid) || GetPlayerOrg(playerid) == FAMILY_SAD)
            {
                SetPlayerPosEx(playerid,1305.0013, -1291.6804, 35.7221);
                GameTextForPlayer(playerid, "~r~Sala sadowa ~n~ by abram01", 6000, 1);
                SetPlayerVirtualWorld ( playerid, 501 ) ;
                Wchodzenie(playerid);
                SetPlayerWeatherEx(playerid, 3);//Pogoda
            	SetPlayerTime(playerid, 14, 0);//Czas
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid,4,1333.5448, -1308.2383, 13.7718))
        { //WEJŒCIE EWAKUACYJNE DLA GSA I RZ¥D!!!
            if(GetPlayerFraction(playerid) == FRAC_BOR || GetPlayerOrg(playerid) == FAMILY_SAD)
            {
                SetPlayerPosEx(playerid,1315.1282, -1336.4583, 39.1618);
                GameTextForPlayer(playerid, "~r~Stare przejscie jeszcze dziala! ~n~ by abram01", 6000, 1);
                SetPlayerVirtualWorld ( playerid, 502 ) ;
                Wchodzenie(playerid);
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, -2474.1194,2232.1296,5.7156))//ratusz bay side wejscie
        {
            SetPlayerPosEx(playerid, -2063.9272460938,547.01922607422,1172.2559814453);//ratusz bay side srodek
            GameTextForPlayer(playerid, "~w~Witamy w ~y~Ratuszu ~g~Bay Side", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            SetPlayerInterior(playerid,7);
            Wchodzenie(playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid,3,481.0048,-1499.3975,41.3900))//scena alh
        {
            SetPlayerPosEx(playerid,481.1781,-1493.9980,43.6700);
        }
        else if(IsPlayerInRangeOfPoint(playerid,3,495.5948,-1503.1011,41.3900))//okna alh
        {
            SetPlayerPosEx(playerid,503.4429,-1495.5690,45.6459);
        }
        else if(IsPlayerInRangeOfPoint(playerid,3,488.6343,-1520.8257,41.3900))//bar alh to ostatnie i koniec
        {
            SetPlayerPosEx(playerid,495.5581,-1520.4011,41.3900);
        }
        if(IsPlayerInRangeOfPoint(playerid,4,2447.8284,-1963.1549,13.5469))//WPS klub bonehead
        {

            GameTextForPlayer(playerid, "~w~ Witamy w~n~ ~g~ Bonehead Club", 5000, 1);
            SetPlayerVirtualWorld(playerid,1);
            SetPlayerPosEx(playerid,2455.1021,-1958.0905,120.8159);
            new muzik[128];
            GetSVarString("muzyka_bonehead", muzik, 128);
            PlayAudioStreamForPlayer(playerid,muzik,2447.8284,-1963.1549,13.5469,100,0);
            TogglePlayerControllable(playerid,0);
            Wchodzenie(playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 2324.6416,-1263.5723,22.5070))//biro tfat wejscie
        {
            SetPlayerPosEx(playerid, 2312.14,-1317.54,180.05);//biuro tfat srodek
            GameTextForPlayer(playerid, "~w~Biuro ~g~FDU", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            SetPlayerInterior(playerid,4);
            Wchodzenie(playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1201.3000488281,-1631.6999511719,-54.5))//ladowisko wejscie
        {
            SetPlayerPosEx(playerid, 613.6842,-1473.1891,73.9715);//ladowisko srodek
            GameTextForPlayer(playerid, "~w~Witamy ~y~na ~g~Ladowisku", 5000, 1);
            SetPlayerInterior(playerid,0);
            SetPlayerVirtualWorld(playerid,0);
        }
        else if(IsPlayerInRangeOfPoint(playerid,5,608.19793701172, -1458.9837646484, 14.387271881104))//fbi wejscie
        {
            SetPlayerPosEx(playerid,592.71991, -1487.62439, 89.30576);//fbi srodek
            GameTextForPlayer(playerid, "~w~Witamy w~y~ Biurach ~b~FBI~n~~r~by UbunteQ & Iwan", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            SetPlayerVirtualWorld(playerid,1);
            PlayerInfo[playerid][pLocal] = 212;
        }
		else if(IsPlayerInRangeOfPoint(playerid, 5, 592.71991, -1487.62439, 89.30576))
		{
			SetPlayerPosEx(playerid,608.19793701172, -1458.9837646484, 14.387271881104);
			TogglePlayerControllable(playerid, 0);
			Wchodzenie(playerid);
			SetPlayerVirtualWorld(playerid, 0);
			
		}
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 213.57328796387, 1811.1787109375, 21.8671875))//pkokj widzen wejscie
        {
            SetPlayerPosEx(playerid, 156.85940551758, 1829.7415771484, 17.693145751953);//pokoj widzen srodek
            GameTextForPlayer(playerid, "~w~Witamy w~y~ Pokoju ~r~Widzen", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 10.0, 197.17276000977, 1826.01171875, 17.640625))//cela smierci wejscie
        {
            SetPlayerPosEx(playerid, 41.132061004639, 1885.5982666016, 5525.8100585938);//cela smierci srodek
            GameTextForPlayer(playerid, "~w~Witamy w~y~ Sali ~r~Egzekucji", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid, 5.0, 2518.0, -2127.0, 13.5))//5.0, 2458.3215, -2116.7236, 13.5976))//biuro KT wejscie
        {
            SetPlayerPosEx(playerid, 2452.1274, -2117.2329, 32.2572);//biuro KT srodek
            GameTextForPlayer(playerid, "~w~Transport ~y~to podstawa!", 5000, 1);
            SetPlayerVirtualWorld(playerid, 3);
            Wchodzenie(playerid);
        }
        //Lotniska
        else if (PlayerToPoint(4.0, playerid,1673.3000488281, 1447.8000488281, 10.89999961853)) //Lotnisko LV do budynku glowne
        {
            SetPlayerPosEx(playerid,1673, 1447.5, 14.800000190735);
            SetPlayerVirtualWorld(playerid, 1);
            GameTextForPlayer(playerid, "Witamy na lotnisku", 3000, 1);
        }
        else if (PlayerToPoint(3.0, playerid,1597.6999511719, 1448.3000488281, 10.89999961853)) //Lotnisko LV do budynku z pasa
        {
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerPosEx(playerid,1675.8000488281, 1455.4000244141, 14.89999961853);
            GameTextForPlayer(playerid, "Witamy na lotnisku", 3000, 1);
        }
        else if (PlayerToPoint(3.0, playerid,-1421.4000244141,-287.29998779297,14.10000038147)) //Wejscie do inta SF z ulicy
        {
            SetPlayerPosEx(playerid,-1394.4000244141,-301.5,-74.6);
            GameTextForPlayer(playerid, "Witamy na lotnisku", 3000, 1);
            Wchodzenie(playerid);
        }
        else if (PlayerToPoint(3.0, playerid,-1376.3000488281,-261.10000610352,14.300000190735)) //Wejscie do inta SF z pasa
        {
            SetPlayerPosEx(playerid,-1390,-294.60000610352,-74.6);
            GameTextForPlayer(playerid, "Witamy na lotnisku", 3000, 1);
            Wchodzenie(playerid);
        }
        //Lotnisko LS budka wejœcie
        else if (PlayerToPoint(1.0, playerid,1952.8994140625,-2179.19921875,13.5))
        {
          SetPlayerPosEx(playerid,1952.9000244141,-2181,13.5);
        }
        //Lotnisko LS wejœcie lotnisko

        else if (PlayerToPoint(3.0, playerid,1585.2,-2286.6,13.7))
        {
            GameTextForPlayer(playerid, "Bezpieczne loty!", 3000, 1);
            SetPlayerPosEx(playerid,1573.5999755859,-2286.3999023438,-75);
            Wchodzenie(playerid);
        }
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
            foreach(Player, i)
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
            SetPlayerPosEx(playerid, PosX, PosY, PosZ);
            PutPlayerInVehicleEx(playerid, lVeh, seat);
            GameTextForPlayer(playerid, "Chwytaj za stery!", 2000, 5);
        }
        //Lotnisko LS wejœcie do AT400
        else if (PlayerToPoint(2.0, playerid,1937.5,-2275.8,16.9) || PlayerToPoint(2.0, playerid,-1360.0999755859, -239.89999389648, 17.60000038147) || PlayerToPoint(2.0, playerid,1581.6999511719, 1444.5, 14.10000038147))//LS
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
                        SetPlayerPosEx(playerid, 3.5040+KTAir_Offsets[0],30.7375+KTAir_Offsets[1],0.5391+100+KTAir_Offsets[2]);
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
            SetPlayerPosEx(playerid, 1605,-2282.9,-74.90);
            Wchodzenie(playerid);
        }

        //KONIEC LS
        else if(PlayerToPoint(10.0, playerid, 1462.395751,-1012.391174,26.843799))//bank LS
        {
            SetPlayerPosEx(playerid,1462.2887,-1008.2450,27.1099);//bank LS œrodek
            GameTextForPlayer(playerid, "~w~Witamy w ~y~Verte ~g~Bank ~b~Los Santos", 5000, 1);
			sendTipMessageEx(playerid, COLOR_RED, "=====Verte Bank Los Santos=====");
			sendTipMessage(playerid, "* Aby zarz¹dzaæ swoim kontem wpisz /kontobankowe (/kb)");
			sendTipMessage(playerid, "* Aby zarz¹dzaæ kontem swojej frakcji przejdŸ w zak³adkê ''Frakcyjne''");
			sendTipMessage(playerid, "* Sejf znajduje siê 10m pod ziemi¹ --> Bezpieczna lokata!");
            PlayerInfo[playerid][pLocal] = 103;
            SetPlayerVirtualWorld(playerid, 2);
            Wchodzenie(playerid);
            return 1;
        }
        else if(PlayerToPoint(10.0, playerid, 2302.7798,-15.9637,26.4844))//bank PC
        {
            SetPlayerPosEx(playerid,2305.688964,-16.088100,26.749599);//bank PC œrodek
            GameTextForPlayer(playerid, "~w~Witamy w ~y~Verte ~g~Bank ~b~Palomino Creek", 5000, 1);
            PlayerInfo[playerid][pLocal] = 103;
            SetPlayerVirtualWorld(playerid, 2);
            Wchodzenie(playerid);
			sendTipMessageEx(playerid, COLOR_RED, "=====Verte Bank Palomino Creek=====");
			sendTipMessage(playerid, "* Aby zarz¹dzaæ swoim kontem wpisz /kontobankowe (/kb)");
			sendTipMessage(playerid, "* Aby zarz¹dzaæ kontem swojej frakcji przejdŸ w zak³adkê ''Frakcyjne''");
			sendTipMessage(playerid, "* Sejf znajduje siê  6m pod ziemi¹ --> Bezpieczna lokata!");
            return 1;
        }
        /*else if(PlayerToPoint(10.0, playerid, 1310.126586,-1367.812255,13.540800))//pintball
        {
            DajKase(playerid, -1000);
            PaintballPlayers ++;
            PlayerPaintballing[playerid] = 1;
            new rand = random(sizeof(PaintballSpawns));
            SetPlayerPosEx(playerid, PaintballSpawns[rand][0], PaintballSpawns[rand][1], PaintballSpawns[rand][2]);
            TogglePlayerControllable(playerid, 0);
            return 1;
        }*/
        else if (PlayerToPoint(10.0, playerid,1479.9545,-1771.5039,15.3266))//Wejœcie do ratusza dmv srodek
        {
            if(dmv == 1 || IsAnInstructor(playerid) || IsABOR(playerid))
            {
                if(wywalzdmv[playerid] == 0)
                {
                    SetPlayerPosEx(playerid,1450.6495,-1772.9926,76.5013);//Ratusz
                    GameTextForPlayer(playerid, "~w~~b~Witamy w ratuszu~n~ By Satius", 10000, 1);
                    SetPlayerInterior(playerid,0);
                    SetPlayerVirtualWorld(playerid,50);
                    Wchodzenie(playerid);
                    PlayerInfo[playerid][pLocal] = 108;
                    SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Urz¹d Miasta w Los Santos Wita! <<<<");
                    SendClientMessage(playerid, COLOR_WHITE, "-> Cennik znajduje siê zaraz za rogiem, po prawej stronie.");
                    SendClientMessage(playerid, COLOR_WHITE, "-> Znajdujesz siê na najwy¿szym poziomie, winda znajduje siê w holu g³ównym");
                    SendClientMessage(playerid, COLOR_WHITE, "-> Okienka dla patentów znajduj¹ siê po lewej i prawej stronie w holu pierwszym");
					SendClientMessage(playerid, COLOR_WHITE, "-> [Obecny interior urzêdu powsta³ w listopadzie 2018 roku, za inicjatyw¹ Satius & Arkam & Simeone]");
                    SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> ¯yczymy przyjemnego czekania na licencje! <<<<");
                    if(PlayerInfo[playerid][pMember] == 0 && PlayerInfo[playerid][pLider] == 0 && GetPlayerOrg(playerid) == 0)
                    {
                        SendClientMessage(playerid, COLOR_PANICRED, "****Piip! Piip! Piip!*****");
                        SendClientMessage(playerid, COLOR_WHITE, "Przechodz¹c przez wykrywacz metalu s³yszysz alarm.");
                        SendClientMessage(playerid, COLOR_WHITE, "Dopiero teraz dostrzegasz czerwon¹ tabliczkê informuj¹c¹ o zakazie");
                        SendClientMessage(playerid, COLOR_WHITE, "Nie chcesz k³opotów, wiêc oddajesz swój arsena³ agentowi USSS.");
                        SendClientMessage(playerid, COLOR_PANICRED, "((Broñ otrzymasz po œmierci//ponownym zalogowaniu))");
                        SetPVarInt(playerid, "mozeUsunacBronie", 1);
                        ResetPlayerWeapons(playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Zosta³eœ wyrzucony z Urzêdu przez agentów USSS, spróbuj póŸniej.");
					SendClientMessage(playerid, COLOR_WHITE, "[Czas wyrzucenia: 10 minut]");
                }
            }
            else
            {

                    SendClientMessage(playerid,COLOR_RED,"|_________________Godziny pracy Urzêdu_________________|");
                    SendClientMessage(playerid,COLOR_WHITE,"                   {ADFF2F}§Poniedzia³ek - Pi¹tek:");
                    SendClientMessage(playerid,COLOR_WHITE,"                          Od 18:00 do 19:00");
                    SendClientMessage(playerid,COLOR_WHITE,"");
                    SendClientMessage(playerid,COLOR_RED,"             **********************************************");
                    SendClientMessage(playerid,COLOR_WHITE,"                  {DDA0DD}§Sobota- Niedziela");
                    SendClientMessage(playerid,COLOR_WHITE,"                          Od 15:00 do 16:00");
                    SendClientMessage(playerid,COLOR_WHITE,"");
                    SendClientMessage(playerid,COLOR_RED,"|____________>>> Urz¹d Miasta Los Santos <<<____________|");
            }
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid,5,2269.6848, -75.5530, 27.1525))//Urzad miasta PC by abram01
        {
            SetPlayerPosEx(playerid,2318.7566, -85.3065, 41.7866);
            SetPlayerVirtualWorld(playerid, 1);
            PlayerInfo[playerid][pLocal] = 108;
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            GameTextForPlayer(playerid, "~w~~b~Witamy w Urzedzie Miasta PC~n~ by abram01", 5000, 1);
			SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Urz¹d Miasta w Palomino Creek Wita! <<<<");
			SendClientMessage(playerid,COLOR_WHITE," ");
			SendClientMessage(playerid,COLOR_WHITE,"-> Okienka znajduj¹ siê po twojej prawej i lewej stronie");
			SendClientMessage(playerid,COLOR_WHITE,"-> Biura i przejœcie na plac znajduje siê za drzwiami na wprost od Ciebie.");
			SendClientMessage(playerid,COLOR_WHITE," ");
			SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> ¯yczymy przyjemnego czekania na licencje! <<<<");
        }
        else if (PlayerToPoint(8.0, playerid,-2111.5686,-443.9720,38.7344))//Wejœcie do drift track
        {
            GameTextForPlayer(playerid, "~w~Witamy na Dirt Track", 5000, 1);
            SetPlayerInterior(playerid,4);
            SetPlayerPosEx(playerid,-1443.0554,-581.1879,1055.0472);//drift track
            return 1;
        }
        /*  JETTY LOUNGE */

        else if (IsPlayerInRangeOfPoint(playerid,3.0,725.6371, -1440.3321, 13.5360))
        {
            if(!DoorInfo[FRAC_LCN][d_State]) return SendClientMessage(playerid, COLOR_GRAD1, "Te drzwi s¹ zamkniête.");
            SetPlayerPosEx(playerid, 734.0619, -1451.6720, 22.5920);
            SetPlayerVirtualWorld(playerid, 255);
            GameTextForPlayer(playerid, "~w~Witamy w Jetty Lounge by ~n~~h~~g~Albert ~w~& ~h~~y~Patryk", 5000, 1);
            Wchodzenie(playerid);
        }
        else if (IsPlayerInRangeOfPoint(playerid,3.0,735.2055, -1472.9760, 22.5920))
        {
            if(GetPlayerFraction(playerid) != FRAC_LCN) return SendClientMessage(playerid, COLOR_GRAD1, "Nie jestes pracownikiem!");
            SetPlayerPosEx(playerid, 736.3939, -1472.8465, 22.5920);
            SetPlayerVirtualWorld(playerid, 255);
            GameTextForPlayer(playerid, "~w~Milej pracy", 5000, 1);
            Wchodzenie(playerid);
        }
        else if (IsPlayerInRangeOfPoint(playerid,3.0,725.5906, -1450.9875, 17.7069))
        {
            if(!DoorInfo[FRAC_LCN][d_State]) return SendClientMessage(playerid, COLOR_GRAD1, "Te drzwi s¹ zamkniête.");
            SetPlayerPosEx(playerid, 722.0778, -1450.7183, 26.0396);
            SetPlayerVirtualWorld(playerid, 255);
            GameTextForPlayer(playerid, "~w~Witamy w Jetty Lounge by ~n~~h~~g~Albert ~w~& ~h~~y~Patryk", 5000, 1);
            Wchodzenie(playerid);
        }

        else if (PlayerToPoint(5.0, playerid,725.4005,-1450.4960,17.695)) //restauracja taras
        {
            if(!DoorInfo[FRAC_LCN][d_State]) return SendClientMessage(playerid, COLOR_GRAD1, "Te drzwi s¹ zamkniête.");
            SetPlayerPosEx(playerid,-794.97491455078, 489.89901733398, 1376.195312); //int restauracji
            GameTextForPlayer(playerid, "~g~Witamy w ~w~Jetty Lounge.", 5000, 1);
            SetPlayerInterior(playerid, 1);
            return 1;
        }
        else if (PlayerToPoint(5.0, playerid,725.7198,-1439.3527,13.5391)) //wejœcie do restauracji LCN na dole
        {
            if(!DoorInfo[FRAC_LCN][d_State]) return SendClientMessage(playerid, COLOR_GRAD1, "Te drzwi s¹ zamkniête.");
            //SetPlayerPosEx(playerid,-794.97491455078, 489.89901733398, 1376.1953125); //restauracja LCN na dole
            SetPlayerPosEx(playerid,-779.6347,506.1770,1371.7422);
            GameTextForPlayer(playerid, "~g~Witamy w ~w~Jetty Lounge.", 5000, 1);
            SetPlayerInterior(playerid, 1);
            return 1;
        }
        else if (PlayerToPoint(4.0, playerid,-778.3271484375,496.4326171875,1368.5303955078)) //wejœcie do gabinetu LCN
        {
            SetPlayerPosEx(playerid,726.34814453125,-1454.4940185547,22.237335205078); //gabinet LCN
            GameTextForPlayer(playerid, "~g~ Boungiorno Donie!", 5000, 1);
            SetPlayerVirtualWorld(playerid, 74);
            SetPlayerInterior(playerid, 0);
            Wchodzenie(playerid);
            return 1;
        }
        else if (PlayerToPoint(4.0, playerid,738.8545, -1428.7880, 13.5927)) //biura LCN
        {
            SetPlayerPosEx(playerid,738.5865, -1427.7610, 23.5927); //biura LCN wejœcie
            GameTextForPlayer(playerid,"~w~Witamy w biurach Jetty Lounge ~n~ ~b~ By ~r~_DywaniK_",5000,1);
            SetPlayerVirtualWorld(playerid, 2);
            Wchodzenie(playerid);
            return 1;
        }
        else if (PlayerToPoint(2.0, playerid,-2170.0593,641.1239,1052.3817)) //Zak³ad bukmaherski WEJSCIE NA GORE
        {
            SetPlayerPosEx(playerid,-2168.7502,636.2642,1052.7642); 
            GameTextForPlayer(playerid, "~w~Witamy NA GORZE", 5000, 1);
            SetPlayerInterior(playerid, 1);
            return 1;
        }
        else if (PlayerToPoint(5.0, playerid,368.3667,193.8689,1008.3828)) //wejœcie do gabinetu YKZ
        {
            SetPlayerPosEx(playerid,2967.2785644531,-1056.5300292969,4505.6782226563); //Gabinet YKZ
            GameTextForPlayer(playerid, "~w~Konichiwa Oyabunie!", 5000, 1);
            SetPlayerInterior(playerid, 13);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 371.9455,168.0409,1008.3828)) // wejscie na dach YKZ
        {
            SetPlayerPosEx(playerid, 2787.9572753906,-1085.6119384766,94.187072753906 ); // dach YKZ
            SetPlayerInterior(playerid, 0);
            return 1;
        }
        
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 371.9455,168.0409,1008.3828)) // wejscie na dach YKZ
        {
            SetPlayerPosEx(playerid, 2787.9572753906,-1085.6119384766,94.187072753906 ); // dach YKZ
            SetPlayerInterior(playerid, 0);
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid,5,648.4412, -1357.3232, 13.8579))//recepcja wejscie glowne
        {
            SetPlayerPosEx(playerid,648.9127, -1367.4266, 29.2878);
            SetPlayerVirtualWorld(playerid,20);
            TogglePlayerControllable(playerid,0);
            Wchodzenie(playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid,5,732.6443, -1343.4160, 13.5982)//parking SAN News
        || IsPlayerInRangeOfPoint(playerid,5,666.5681, -1353.2101, 29.3031)//recepcja Winda
        || IsPlayerInRangeOfPoint(playerid,5,661.8192, -1344.7736, 29.4743)/* Winda Victim*/
        || IsPlayerInRangeOfPoint(playerid,5,655.7669, -1376.8688, 28.6743)/*Drukarnia // Studio*/
        || IsPlayerInRangeOfPoint(playerid,5,737.3818, -1366.2958, 34.0796)/*Sale Konferencyjne*/
        || IsPlayerInRangeOfPoint(playerid,5,721.5345, -1381.9717, 25.7202)/*Dach*/
        || IsPlayerInRangeOfPoint(playerid,5,663.6946, -1374.4166, 27.9148)/*Biura SAN NEWS*/)
        {
            ShowPlayerDialogEx(playerid,WINDA_SAN,DIALOG_STYLE_LIST,"Winda - San News","[Pietro - 0]Parking\n[Pietro - 1]Recepcja\n[Pietro - 2]Studio Victim\n[Pietro - 3]Drukarnia & Studio Nagran\n[Pietro - 4]Sale Konferencyjne\n[Pietro - 5]Biura San News\n[Pietro - 6]Dach","Jedz","Anuluj");
        }
        else if (PlayerToPoint(5.0, playerid,2425.6000976563,117.69999694824,26.5)) //Wejœcie do komisariatu
        {
            SetPlayerPosEx(playerid,246.6659,108.0529,1003.2188); //Komisariat
            GameTextForPlayer(playerid, "~w~Witamy w Komisariacie.", 5000, 1);
            SetPlayerInterior(playerid,10);
            PlayerInfo[playerid][pInt] = 10;
            PlayerInfo[playerid][pLocal] = 210;
            return 1;
        }
        else if (PlayerToPoint(5.0, playerid,2420.9360,112.8245,29.0433)) //taras PD w PC
        {
            SetPlayerPosEx(playerid,214.9873,121.0619,999.0156); //Komisariat piwnice
            GameTextForPlayer(playerid, "~w~Witamy w Komisariacie.", 5000, 1);
            SetPlayerInterior(playerid,10);
            PlayerInfo[playerid][pInt] = 10;
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid,5,1555.0505, -1675.6409, 16.2821))//nowe komi glowne wyjscie
        {
            SetPlayerPosEx(playerid,-1693.1406,890.4065,-52.3141 );
            SetPlayerVirtualWorld(playerid,1);
            SetPlayerInterior(playerid,0);
            PlayerInfo[playerid][pLocal] = 210;
            GameTextForPlayer(playerid, "~w~Witamy na Komisariacie.", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
        }
        else if(IsPlayerInRangeOfPoint(playerid,5,-1674.5769,903.1641,-48.9141) )//nowe komi wejscie prawnicze
        {
            if(ApprovedLawyer[playerid] == 1)
                SetPlayerPosEx(playerid,-1674.4122,917.7183,-52.4141); //nowe komi drzwi w celach
            else
                SendClientMessage(playerid, COLOR_GRAD1, "Musisz mieæ pozwolenie prawnicze aby przejœæ");

        }
        else if (PlayerToPoint(5.0, playerid,315.4501953125, -1501.822265625, 13.820824623108)) //wejœcie do kancelarii prawników
        {
            SetPlayerPosEx(playerid,319.72470092773, -1548.3374023438, 13.845289230347); //Kancelaria prawnicza
            GameTextForPlayer(playerid, "~w~Witamy w Kancelarii Prawniczej.", 5000, 1);
            return 1;
        }
        else if (PlayerToPoint(5.0, playerid,292.85711669922, -1530.8516845703, 13.818398475647)) //wejœcie do biura ³owców nagród
        {
            SetPlayerPosEx(playerid,322.0553894043, 303.41961669922, 999.1484375); //Biuro £owców nagród
            GameTextForPlayer(playerid, "~w~Witamy w biurze Lowcow Nagrod.", 5000, 1);
            SetPlayerInterior(playerid,5);
            PlayerInfo[playerid][pInt] = 5;
            return 1;
        }
        else if (PlayerToPoint(5.0, playerid,330.6893,-1513.0613,35.8672)) //wejœcie do biurowca
        {
            SetPlayerPosEx(playerid,301.29656982422, -1515.7513427734, 13.809589385986); //Biurowiec
            GameTextForPlayer(playerid, "~w~Witamy w Biurowcu.", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            return 1;
        }
        else if (PlayerToPoint(5.0, playerid,2254.8652,-1334.2078,23.9922)) //wejœcie do koœcio³a
        {
            SetPlayerPosEx(playerid, 1964.1326904297, -350.83026123047, 1092.9454345703); //koœció³
            GameTextForPlayer(playerid, "~w~Szczesc boze.", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            SetPlayerInterior(playerid, 3);
            Wchodzenie(playerid);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2289.8876953125,-1206.8327636719,-18.008888244629)) // Szpitsal
        {
            SetPlayerPosEx(playerid, 1163.1424560547,-1343.5803222656,26.667037963867 ); // Dach szpital
            GameTextForPlayer(playerid, "~w~Dach.", 5000, 1);
            return 1;
        }
        //jebane miasteczko
        /*else if (IsPlayerInRangeOfPoint(playerid, 5.0, 682.03063964844,-473.62811279297,16.425407409668)) // Bar kurwa
        {
            SetPlayerPosEx(playerid, 681.5244140625,-451.8515625,-25.609762191772 ); // Bar kurwa
            GameTextForPlayer(playerid, "~w~Witamy w Barze.", 5000, 1);
            SetPlayerInterior(playerid, 1);
            return 1;
        }*/
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 695.07702636719,-499.34088134766,16.3359375)) // rada
        {
            SetPlayerPosEx(playerid, 703.78033447266,-497.16967773438,23.36548614502 ); // rada
            GameTextForPlayer(playerid, "~w~Witamy w Radzie Miasteczka Dillimore.", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            SetPlayerVirtualWorld(playerid, 35);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 648.91735839844,-520.12847900391,16.359306335449)) // bank w miasteczku wejscie
        {
            SetPlayerPosEx(playerid, 833.66455078125,7.4092292785645,1004.1796875 ); // bank w miasteczki srodek
            GameTextForPlayer(playerid, "~w~Witamy w Banku.", 5000, 1);
            SetPlayerInterior(playerid, 3);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 560.8828,-2033.8701,16.1670)) // basen wejœcie
        {
            if(Kredyty[playerid] >= 200)
            {
                SetPlayerPosEx(playerid, 566.7726,-2087.6841,2.7300); // basen œrodek
                GameTextForPlayer(playerid, "~w~Witamy na ~b~Basenie", 5000, 1);
                sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Aby siê przebraæ podejdŸ do szafek i wpisz /przebierz");
                SetPlayerVirtualWorld(playerid, 30);
                TogglePlayerControllable(playerid, 0);
                Wchodzenie(playerid);
                Kredyty[playerid] -= 200;
                return 1;
            }
            else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Nie masz wystarczaj¹cej iloœci kredytów.");
                return 1;
            }
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 570.5168,-2095.3618,2.6152)) // sauny wejœcie
        {
            if(Kredyty[playerid] >= 75)
            {
                SetPlayerPosEx(playerid, 527.8544,-2082.4460,17.2253); // sauny œrodek
                GameTextForPlayer(playerid, "~w~Witamy w ~r~Saunie", 5000, 1);
                SetPlayerVirtualWorld(playerid, 30);
                TogglePlayerControllable(playerid, 0);
                Wchodzenie(playerid);
                Kredyty[playerid] -=75;
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
            SetPlayerPosEx(playerid, 564.1958,-2029.4149,16.1670); // recepcja
            TogglePlayerControllable(playerid, 0);
            SetPlayerVirtualWorld(playerid, 30);
            Wchodzenie(playerid);
            return 1;
        }
        //BIZNES 43
        /*else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1210.552734375,-1749.1850585938,13.593885421753)) // Basen wejœcie
        {
            SetPlayerPosEx(playerid, 575.5542,-2048.8000,16.1670 ); // Basen œrodek (recepcja)
            GameTextForPlayer(playerid, "~w~Witamy w kasach ~g~Basenu Tsunami.", 5000, 1);
            SetPlayerVirtualWorld(playerid, 30);
            SetActorVirtualWorld(PaniJanina, 30);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            return 1;
        }*/
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 578.6193,-2195.7708,1.6288)) // trampolina wejœcie
        {
            ShowPlayerDialogEx(playerid, 325, DIALOG_STYLE_LIST, "Na któr¹ trampolinê chcesz wejœæ?", "Trampolina zwyk³a\nTrampolina wyczynowa", "Wybierz", "Anuluj");
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1271.0920,-1667.8794,19.7344)) // strzelnica wejœcie
        {
            if(GUIExit[playerid] == 0)
            {
                ShowPlayerDialogEx(playerid, 324, DIALOG_STYLE_LIST, "Tory szkoleniowe", "Strzelnica w budynku\nStrzelnica w terenie\nSkoki spadochronowe\nTor szkoleniowy ' Porwanie w domu '\nTor szkoleniowy ' Terroryœci na statku '", "Wybierz", "Anuluj");
                return 1;
            }
        }
        //rodzinne gówna
        else if (PlayerToPoint(5.0, playerid, 693.9794,-1645.8259,4.0938)) // Full wejœcie
        {
            SetPlayerPosEx(playerid, 2317.8201,-1024.7500,1050.2109); // Full baza
            SetPlayerInterior(playerid, 0);
            return 1;
        }
        // dynamiczne interiory
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2495.576171875,-1689.9849853516,14.765625)) // Dom na Grove Street
        {
            SetPlayerPosEx(playerid, 2495.9689941406,-1692.6496582031,1014.7421875); // Dom na Grove Street
            SetPlayerInterior(playerid, 3);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2165.9409179688,-1671.8609619141,15.074726104736)) // Melina
        {
            SetPlayerPosEx(playerid, 318.75366210938,1115.3836669922,1083.8828125); // Melina
            SetPlayerInterior(playerid, 5);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2229.2248535156,-1721.9586181641,13.567801475525)) // Si³ownia
        {
            SetPlayerPosEx(playerid, 772.41839599609,-4.6863260269165,1000.7291259766); // Si³ownia
            SetPlayerInterior(playerid, 5);
            return 1;
        }
        /*else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2104.4970703125,-1806.3927001953,13.5546875)) // Pizzeria
        {
            SetPlayerPosEx(playerid, 372.16430664063,-132.97666931152,1001.4921875); // Pizzeria
            SetPlayerInterior(playerid, 5);
            SetPlayerShopName(playerid,"FDPIZA");
            return 1;
        }*/
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2351.8894042969,-1169.4614257813,28.001684188843)) // Dom na Las Collinas
        {
            SetPlayerPosEx(playerid, 2352.0139160156,-1180.8870849609,1027.9765625); // Dom na Las Collinas
            SetPlayerInterior(playerid, 5);
            return 1;
        }
        else if(PlayerToPoint(10.0, playerid, 931.09,919.29,42.59))//jizzy club
        {
            SetPlayerInterior(playerid,3);
            SetPlayerPosEx(playerid,-2637.69,1404.24,906.46 );
            GameTextForPlayer(playerid, "~w~Exclusive w ~r~Fun", 5000, 1);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1698.8944091797,-1667.6840820313,20.194225311279)) // Muzeum sztuki wspó³czesnej
        {
            SetPlayerPosEx(playerid, 1701.4025878906,-1667.9442138672,20.21875); // Muzeum sztuki wspó³czesnej
            SetPlayerInterior(playerid, 18);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1727.1125488281,-1635.5847167969,20.216684341431)) // Muzeum sztuki wspó³czesnej 2
        {
            SetPlayerPosEx(playerid, 1727.076171875,-1638.8159179688,20.223419189453); // Muzeum sztuki wspó³czesnej 2
            SetPlayerInterior(playerid, 18);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 2.0, -2065.5505,575.6121,1173.0511)) // wejscie na balkon
        {
            SetPlayerPosEx(playerid, -2473.8140,2231.9236,8.9133); // balkon bay side
            SetPlayerInterior(playerid, 0);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 2.0, 1972.0,-1285.0,29.0)) // bar by K.Monari wejœcie
        {
            SetPlayerPosEx(playerid, 1985.9202,-1292.6693,5619); // œrodek
            SetPlayerInterior(playerid, 19);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            return 1;
        }
        //baza bor by abram01
        else if(IsPlayerInRangeOfPoint(playerid,3,1481.3147, -1534.9988, 69.8184))
        {
            SetPlayerPosEx(playerid,1448.5902, -1556.4595, 67.4875);
            SetPlayerVirtualWorld (playerid, 80);
            Wchodzenie(playerid);
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid,3,1478.0399, -1535.3342, 69.8184))
        {
            SetPlayerPosEx(playerid,1503.9996, -1557.6985, 67.4117);
            SetPlayerVirtualWorld (playerid, 80);
            Wchodzenie(playerid);
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid,3,1475.4584, -1535.0698, 69.8184))
        {
            SetPlayerPosEx(playerid,1535.8995, -1553.6477, 67.2323);
            SetPlayerVirtualWorld (playerid, 80);
            Wchodzenie(playerid);
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid,3,1518.8984, -1452.5093, 14.4603))
        {
            SetPlayerPosEx(playerid,1498.5720, -1450.9031, 64.7241);
            SetPlayerVirtualWorld (playerid, 80);
            Wchodzenie(playerid);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1517.80004,-1480.5,9.5)) // TUNEL - BOR
        {
            if(IsABOR(playerid))
            {
            SetPlayerPosEx(playerid, 1509.3000488281,-1752.9000244141,13.5); // TUNEL - DMV
            GameTextForPlayer(playerid, "~b~Tajemnicza Budka", 5000, 1);
            return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "Tylko dla agentów GSA");
                return 1;
            }
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1442.0717,-1811.6309,77.9453)) // Plac manewrowy wejscie
        {
            if(TakingLesson[playerid] == 1 || IsAnInstructor(playerid))
            {
                SetPlayerPosEx(playerid, 1412.6382,-1800.7056,15.4356); // Plac manewrowy œrodek
                SetPlayerVirtualWorld(playerid, 0);
                SetPlayerInterior(playerid, 0);
                PlayerInfo[playerid][pLocal] = 255;
                GameTextForPlayer(playerid, "~w~Powodzenia", 5000, 1);
                return 1;
            }
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2292.3088,-1723.3538,13.5469)) //  studio tatuaz new wejscie
        {
            SetPlayerPosEx(playerid, -204.0638885498,-9.17,1002.2734); //  tatuaz new srdek
            SetPlayerInterior(playerid, 17);
            GameTextForPlayer(playerid, "Witamy", 5000, 1);
            return 1;
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 276.32934570313,122.20029449463,1004.1166992188)) // Pokój przes³uchañ wejs
        {
            if(IsACop(playerid))
            {
                SetPlayerPosEx(playerid, 2371.5246582031, 586.56274414063, 4893.2431640625); // Pokój przes³uchañ sro
                TogglePlayerControllable(playerid, 0);
                Wchodzenie(playerid);
                SetPlayerInterior(playerid, 10);
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "Tylko dla policjantów i wiêŸniów w kajdankach");
                return 1;
            }
        }
        else if(IsPlayerInRangeOfPoint(playerid,4,2785.7568,-2456.2998,13.6342))//baza NG by Dywan
        {
            SetPlayerPosEx(playerid,1549.6279, 1113.2629, 124.6937);
            TogglePlayerControllable(playerid,0);
            Wchodzenie(playerid);
            SetPlayerVirtualWorld(playerid,5);
        }
        else if(IsPlayerInRangeOfPoint(playerid,2.0, 1144.4740, -1333.2556, 13.8348) ||
        IsPlayerInRangeOfPoint(playerid,2.0, -2805.0967,2596.0566,-98.0829) ||
        IsPlayerInRangeOfPoint(playerid,2.0,1134.0449,-1320.7128,68.3750)||
        IsPlayerInRangeOfPoint(playerid,2.0,1183.3129,-1333.5684,88.1627)||
        IsPlayerInRangeOfPoint(playerid,2.0,1168.2112,-1340.6785,100.3780)||
        IsPlayerInRangeOfPoint(playerid,2.0,1158.6868,-1339.4423,120.2738)||
        IsPlayerInRangeOfPoint(playerid,2.0,1167.7832,-1332.2727,134.7856)||
        IsPlayerInRangeOfPoint(playerid,2.0,1177.4791,-1320.7749,178.0699)||
        IsPlayerInRangeOfPoint(playerid,2.0,1178.2081,-1330.6317,191.5315)||
        IsPlayerInRangeOfPoint(playerid,2.0, 1161.8228, -1337.0521, 31.6112))
        {
            ShowPlayerDialogEx(playerid, D_ELEVATOR_LSMC, DIALOG_STYLE_LIST, "Winda szpitalna:", "{660000}[-1] {D2CFA6}Kostnica i laboratorium\n{660000}[0] {D2CFA6}Parking wewnêtrzny\n{660000}[1] {D2CFA6}Izba przyjêæ\n{660000}[2] {D2CFA6}Strefa pracownika\n{660000}[3] {D2CFA6}Sale operacyjne\n{660000}[4] {D2CFA6}Sale pooperacyjne\n{660000}[5] {D2CFA6}Sale specjalistyczne\n{660000}[6] {D2CFA6}Akademia medyczna\n{660000}[7] {D2CFA6}Gabinety ordynatorów\n{660000}[8] {D2CFA6}Dach szpitala", "Wybierz", "Anuluj");
        }
        else if(IsPlayerInRangeOfPoint(playerid,5,1172.6564, -1323.4110, 15.6034))
        {
            SetPlayerPosEx(playerid,1171.9703, -1322.4764, 31.6913);
            SetPlayerVirtualWorld ( playerid, 90 ) ;
        }
        //IBIZA
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 397.6700,-1811.8844,14.7359) && GetPlayerVirtualWorld(playerid) == 0)
        {
            if(!IbizaDach) return sendTipMessageEx(playerid, 0xB52E2BFF, "Wyjœcie na dach jest zamkniête");
            Wchodzenie(playerid);
            SetPlayerPosEx(playerid, 1892.9077,-2451.8071,21.6559);
            SetPlayerFacingAngle(playerid, 178.8724);
            SetPlayerVirtualWorld(playerid, 1);
            SetPVarInt(playerid, "IbizaWejdz", 1);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 50.0, 1);
            if(IbizaSwiatla) WlaczSwiatlaP(playerid);
            else WylaczSwiatlaP(playerid);
            return 1;

        }
        //wejœcie do bileterki
        else if(IsPlayerInRangeOfPoint(playerid, 12.0, 1740.8485,-2471.0625,14.2266) && GetPlayerOrg(playerid) == FAMILY_IBIZA && GetPlayerVirtualWorld(playerid) == 1) //RANGA
        {
            SetPlayerPosEx(playerid, 397.6122,-1806.0079,7.8381);
            SetPlayerFacingAngle(playerid, 0.8024);
            SetPlayerVirtualWorld(playerid, 0);
            SetPVarInt(playerid, "IbizaWejdz", 0);
            StopAudioStreamForPlayer(playerid);
            IbizaWyjscie(playerid);
            return 1;
        }
        //BIZNES IBIZA
        //Weejscie glowne lewe
        /*else if(IsPlayerInRangeOfPoint(playerid, 2.0, 400.8845,-1805.9010,7.8281) && GetPlayerVirtualWorld(playerid) == 0 )
        {
            if(IbizaZamek) return sendTipMessageEx(playerid, 0xB52E2BFF, "Klub jest w tej chwili zamkniêty");
            if(!GetPVarInt(playerid, "IbizaBilet") && GetPlayerOrg(playerid) != FAMILY_IBIZA) return sendTipMessageEx(playerid, 0xB52E2BFF, "Nie posiadasz biletu, kup go w kasie"); //RANGA
            TogglePlayerControllable(playerid, false);
            Wchodzenie(playerid);
            SetPlayerPosEx(playerid, 1741.4761,-2469.3740,14.2266);
            SetPlayerFacingAngle(playerid, 271.0109);
            SetPlayerVirtualWorld(playerid, 1);
            SetPVarInt(playerid, "IbizaWejdz", 1);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 250.0, 1);
            if(IbizaSwiatla) WlaczSwiatlaP(playerid);
            else WylaczSwiatlaP(playerid);
            SendClientMessage(playerid, -1, "=====Witamy w {00FF00}I{FFFFFF}biza {DE00FF}C{FFFFFF}lub=====");
            SendClientMessage(playerid, 0x88aa62FF, "((UWAGA! W naszym klubie czêsto mo¿na siê spotkaæ z wiadomoœciami typu: Audio stream.. aby wy³¹czyæ ten komunikat wpisz /audiomsg))");
            GameTextForPlayer(playerid, "~y~Projekt by Macias & Sonix", 5000, 1);
            return 1;
        }*/
        //Wejscie gflowne prawe
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 394.2784,-1805.9104,7.8302) && GetPlayerVirtualWorld(playerid) == 0 )
        {
            if(IbizaZamek) return sendTipMessageEx(playerid, 0xB52E2BFF, "Klub jest w tej chwili zamkniêty");
            if(!GetPVarInt(playerid, "IbizaBilet") && GetPlayerOrg(playerid) != FAMILY_IBIZA) return sendTipMessageEx(playerid, 0xB52E2BFF, "Nie posiadasz biletu, kup go w kasie"); //RANGA
            TogglePlayerControllable(playerid, false);
            Wchodzenie(playerid);
            SetPlayerPosEx(playerid, 1741.5828,-2473.1572,14.2266);
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
            SetPlayerPosEx(playerid, 1890.3613,-2494.6675,14.2266);
            SetPlayerFacingAngle(playerid, 268.8783);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID]);
            Wchodzenie(playerid);
            return 1;
        }
        // BAR - wejscie
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1898.4817,-2494.8752,13.6266) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerOrg(playerid) == FAMILY_IBIZA) //RANGA
        {
            SetPlayerPosEx(playerid, 1900.5961,-2494.9373,13.6266);
            SetPlayerFacingAngle(playerid, 271.5300);
            return 1;
        }
        // Dyrekcja - wejscie
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1915.1454,-2468.3472,15.4266) && GetPlayerVirtualWorld(playerid) == 1)
        {
            if(!IbizaBiuro) return sendTipMessageEx(playerid, 0xB52E2BFF, "Biuro jest w tej chwili zamkniête");
            SetPlayerPosEx(playerid, 1911.5500,-2466.1172,17.9850);
            SetPlayerFacingAngle(playerid, 181.9157);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 50.0, 1);
            return 1;
        }
        //wejscie od Zaplecza
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 386.2871,-1817.9784,7.8410) && GetPlayerVirtualWorld(playerid) == 0)
        {
            if(IbizaZamek) return sendTipMessageEx(playerid, 0xB52E2BFF, "Klub jest w tej chwili zamkniêty");
            if(GetPlayerOrg(playerid) != FAMILY_IBIZA) return sendTipMessageEx(playerid, 0xB52E2BFF, "Nie mo¿esz têdy przejœæ, nie jesteœ z Ibiza Club!"); //RANGA
            TogglePlayerControllable(playerid, false);
            SetPlayerPosEx(playerid, 1917.3785,-2465.4368,15.4266);
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
            SetPlayerPosEx(playerid, 1534.3746,-2553.6333,13.5890);
            SetPlayerFacingAngle(playerid, 268.5209);
            SetPVarInt(playerid, "IbizaKibel", 1);
            WlaczSwiatlaP(playerid);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 500.0, 1);
            return 1;
        }
        //wejscie ubikacja lewa
        else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1906.1383,-2474.4417,13.6266) && GetPlayerVirtualWorld(playerid) == 1)
        {
            SetPlayerPosEx(playerid, 1534.2446,-2550.8020,13.5890);
            SetPlayerFacingAngle(playerid ,268.5209);
            SetPlayerVirtualWorld(playerid, 2);
            SetPVarInt(playerid, "IbizaKibel", 1);
            WlaczSwiatlaP(playerid);
            PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 500.0, 1);
            return 1;
        }
        //VINYL wejdz
        else if (IsPlayerInRangeOfPoint(playerid,3.0,816.0470, -1386.3253, 13.6114))
        {
            SetPlayerPosEx(playerid, 808.3142, -1381.9436, 23.6518);
            SetPlayerVirtualWorld(playerid, 255);
            GameTextForPlayer(playerid, "~w~Witamy w Klubie by~n~  ~h~~g~Albert ~w~& ~h~~y~Patryk", 5000, 1);
            Wchodzenie(playerid);
        }
        else if (IsPlayerInRangeOfPoint(playerid,3.0,815.4965, -1377.1671, 23.6518))
        {
            if(GetPVarInt(playerid, "Vinyl-bilet") || GetPlayerOrg(playerid) == FAMILY_VINYL)
            {
                SetPlayerPosEx(playerid, 816.4282, -1376.2659, 23.6518);
                SetPlayerVirtualWorld(playerid, 255);
                GameTextForPlayer(playerid, "~w~Udanej Zabawy", 5000, 1);
                Wchodzenie(playerid);
            }
            else GameTextForPlayer(playerid, "~w~Brak biletu", 5000, 1);
        }
        else if (IsPlayerInRangeOfPoint(playerid,2.0,830.4240, -1376.2208, 27.8467))
        {
            if(GetPVarInt(playerid, "Vinyl-bilet") == 2 || GetPlayerOrg(playerid) == FAMILY_VINYL)
            {
                SetPlayerPosEx(playerid, 830.5424, -1375.1467, 27.8467);
                SetPlayerVirtualWorld(playerid, 255);
                GameTextForPlayer(playerid, "~w~Strefa VIP", 5000, 1);
                Wchodzenie(playerid);
            }
            else GameTextForPlayer(playerid, "~w~Tylko VIP", 5000, 1);
        }
        else if (IsPlayerInRangeOfPoint(playerid,3.0,813.2293, -1349.5438, 23.6597) && GetPlayerOrg(playerid) == FAMILY_VINYL)
        {
            SetPlayerPosEx(playerid, 823.3508, -1349.5614, 24.7971);
            SetPlayerVirtualWorld(playerid, 255);
            GameTextForPlayer(playerid, "~w~Scena DJ", 5000, 1);
            Wchodzenie(playerid);
        }
        //AirTower LS
        else if(IsPlayerInRangeOfPoint(playerid,3.0,1635.3210, -2286.5698, 13.4162) && IsPlayerInFraction(playerid, FRAC_KT, 5000))
        {
            INT_AirTowerLS_Init(playerid);
            SetPlayerPosEx(playerid, 1627.3157,-2279.6157,75.0);
            GameTextForPlayer(playerid, "~w~/wieza", 2000, 1);
            Wchodzenie(playerid);
        }
        else if (PlayerToPoint(5, playerid,1524.4829,-1677.7080,6.2188))//Wejœcie tajne LSPD
        {
            SetPlayerPos(playerid,1617.4417,-1789.3824,13.4900);
            SetPlayerFacingAngle(playerid, 177.2512);
            Wchodzenie(playerid);
        }
        else if (PlayerToPoint(5, playerid,1617.4417,-1789.3824,13.4900))//Wejœcie tajne LSPD
        {
            SetPlayerPos(playerid,1524.4829,-1677.7080,6.2188);
            SetPlayerFacingAngle(playerid, 270.2512);
            Wchodzenie(playerid);
        }
        else if (PlayerToPoint(3, playerid,1763.4033,-1129.7128,24.0859))//Wejœcie
        {
            SetPlayerPosEx(playerid,1763.4243,-1128.0543,224.1499);
            SetPlayerVirtualWorld(playerid, 22);
            GameTextForPlayer(playerid, "~w~Witamy w remizie!", 5000, 1);
            Wchodzenie(playerid);
        }
        else
        {
            Wejdz(playerid, 1285.5999755859,-981.79998779297,32.700000762939, 1300.0999755859,-1094.5999755859,5972.2001953125, 5.0);//int z flagami
            Wejdz(playerid, 1302.8000488281,-988.20001220703,38.299999237061, 1301.8000488281,-1083.9000244141,5972.2001953125, 5.0);//g³ówne wejœcie
            Wejdz(playerid, -1716.1999511719,1018.200012207,17.60000038147, -1825.4000244141,1151.6999511719,6803.2998046875, 5.0);//WEJSCIE DO KRYJOWKI
            Wejdz(playerid, -1858.3000488281,1158.3000488281,6799, -1865.6999511719,1116.8000488281,6799.10009765, 2.0);//drzwi 1
            Wejdz(playerid, -1858.5,1160.5999755859,6799, -1877.1999511719,1178,6799.2998046875, 2.0);//drzwi 2
            
            //BIZNESY
            for(new i=0;i<MAX_BIZNES;i++)
			{
            	WejdzInt(playerid, BizData[i][eBizWejX],BizData[i][eBizWejY],BizData[i][eBizWejZ], BizData[i][eBizWyjX],BizData[i][eBizWyjY],BizData[i][eBizWyjZ], 3.0, BizData[i][eBizInt], BizData[i][eBizVw]);
            	//WejdzInt(playerid, BizData[2][eBizWejX],BizData[2][eBizWejY],BizData[2][eBizWejZ], BizData[2][eBizWyjX],BizData[2][eBizWyjY],BizData[2][eBizWyjZ], 3.0, BizData[2][eBizInt]);//biz 1
			}
			//BIZNESY END

            for(new i; i<=dini_Int("Domy/NRD.ini", "NrDomow"); i++)
            {
                if(IsPlayerInRangeOfPoint(playerid, 3.0, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z]))
                {
                    if(PlayerInfo[playerid][pDom] == i)
                    {
                        new deem = Dom[i][hDomNr];
                        new h, m;
                        GetPlayerTime(playerid, h, m);
                        SetPlayerPosEx(playerid, IntInfo[deem][Int_X], IntInfo[deem][Int_Y], IntInfo[deem][Int_Z]);
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
						SetPlayerPosEx(playerid, IntInfo[deem][Int_X], IntInfo[deem][Int_Y], IntInfo[deem][Int_Z]);
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
						SetPlayerPosEx(playerid, IntInfo[deem][Int_X], IntInfo[deem][Int_Y], IntInfo[deem][Int_Z]);
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

