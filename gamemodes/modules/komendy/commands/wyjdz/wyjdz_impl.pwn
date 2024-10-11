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
command_wyjdz_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0 ) return 1;
		PlayerPlaySound(playerid, 1, 0.0, 0.0, 0.0);
	
        if(GetPVarInt(playerid, "AC-izolacja") != 0) return sendTipMessageEx(playerid, COLOR_PANICRED, "Jesteœ odizolowany, nie mo¿esz u¿ywaæ tej komendy.");
		if(GetPVarInt(playerid, "Lockdown-izolacja") != 0) return sendTipMessageEx(playerid, COLOR_PANICRED, "Nie mo¿esz u¿ywaæ tej komendy w trakcie weryfikacji.");
		
		if(isNaked[playerid] == 1)
		{
			SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]); 
			isNaked[playerid] = 0;
		}
		if(SprawdzWejscia(playerid))
		{
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,648.9127, -1367.4266, 29.2878))//stare SAN - recepcja san news wyjscie
        {
			SetPlayerPos(playerid, 648.4412, -1357.3232, 13.8579);
            SetPlayerVirtualWorld(playerid,0);
            TogglePlayerControllable(playerid,0);
            Wchodzenie(playerid);
        }
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2371.5246582031, 586.56274414063, 4893.2431640625)) // Pokój przes³uchañ sro
        {
            if(IsAPolicja(playerid))
            {
                SetPlayerPos(playerid, 276.32934570313,122.20029449463,1004.1166992188); // Pokój przes³uchañ wejs 
                TogglePlayerControllable(playerid, 0);
                Wchodzenie(playerid);
                SetPlayerInterior(playerid, 10);
                SetPlayerVirtualWorld(playerid, 7110);
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "Tylko dla policjantów i wiêŸniów w kajdankach");
                return 1;
            }
        }
		else if(IsPlayerInRangeOfPoint(playerid, 4, 1213.3364,-1807.0619,70.0682)) //basen œrodek 
		{
			SetPlayerPos(playerid, 1205.45874, -1765.66833, 13.54815); // basen tsunami
			SetPlayerVirtualWorld(playerid, 43);
            Wchodzenie(playerid);
			return 1;
		}
		else if((IsPlayerInRangeOfPoint(playerid,4,1543.3915,-1643.2813,28.4881) || IsPlayerInRangeOfPoint(playerid,4,1555.1351,-1643.0166,28.4881)) && GetPlayerVirtualWorld(playerid) == 29 && !IsAPolicja(playerid) && PlayerInfo[playerid][pJailed] == 0) //miejsce do /wyjdz dla osób które nie s¹ wiêŸniami
        {
            Wchodzenie(playerid);
            SetPlayerVirtualWorld(playerid, 25);
            SetPlayerPos(playerid,1585.8722,-1685.5045,62.2363);
        }
        else if (IsPlayerInRangeOfPoint(playerid, 3.0, 566.5435,-2087.0046,2.7402))  //basen tsunami wejscie do hali
        {
            SetPlayerPos(playerid, 1221.30774, -1790.77686, 71.70520);  //basen tsunami hala
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            return 1;
        }
		else if(IsPlayerInRangeOfPoint(playerid,4,1568.6449, -1689.6379, 6.1932) && IsAPolicja(playerid)//parking LSPD
		|| IsPlayerInRangeOfPoint(playerid,4,-1645.1858, 883.1620, -45.4112)//z glownego wejscia
		|| IsPlayerInRangeOfPoint(playerid,4,-1621.7272, 834.5807, -26.1115)//sale przesluchan
		|| IsPlayerInRangeOfPoint(playerid,4,-1745.1101, 824.0737, -48.0110)//biura LSPD
		|| IsPlayerInRangeOfPoint(playerid,4,-1695.1617, 1046.9861, -65.4119)//stolowka
		|| IsPlayerInRangeOfPoint(playerid,4,1568.1061, 2205.3196, -50.9522)//treningowe miejsca
		|| IsPlayerInRangeOfPoint(playerid,4,1565.0798, -1665.6580, 28.4782) && IsAPolicja(playerid))//dach LSPD
		{
		    //ShowPlayerDialogEx(playerid,WINDA_LSPD,DIALOG_STYLE_LIST,"Winda","[Poziom -1]Parkingi\n[Poziom 0]Komisariat\n[Poziom 1]Pokoje Przes³uchañ\n[Poziom 2]Biura\n[Poziom 3]Sale Treningowe\n[Poziom 4]Dach","Jedz","");
            ShowPlayerDialogEx(playerid,WINDA_LSPD,DIALOG_STYLE_LIST,"Winda","[Poziom -1]Parking Dolny\n[Poziom 0] Parking Górny\n[Poziom 1]Komisariat\n[Poziom 2]Pokoje Przes³uchañ\n[Poziom 3]Biura\n[Poziom 4]Sale Treningowe\n[Poziom 5]Dach","Jedz","");
		}
	    else if(IsPlayerInRangeOfPoint(playerid, 5.0, 694.27490234375,-569.04272460938,-79.225189208984) || IsPlayerInRangeOfPoint(playerid, 3.0, 700.6748046875,-502.41955566406,23.515483856201) || IsPlayerInRangeOfPoint(playerid, 5.0, 707.06085205078,-508.38107299805,27.871946334839))//rada miasta dillimore (miasteczko) windy
	    {
			ShowPlayerDialogEx(playerid, 121, DIALOG_STYLE_LIST, "Wybierz pomieszczenie", "Salka Konferencyjna\nBiura\nPiwnice", "Wybierz", "WyjdŸ");
	    }
		//winda bor
		else if((IsPlayerInRangeOfPoint(playerid,3,-2089.55835, -414.24173, 36.32352)&& IsABOR(playerid))//podziemny parking
		|| IsPlayerInRangeOfPoint(playerid,3,1772.1613,-1547.9675,9.9067)
		|| IsPlayerInRangeOfPoint(playerid,3,1496.9330, -1457.8887, 64.5854)
		|| IsPlayerInRangeOfPoint(playerid,3, 1482.2319, -1531.1719, 70.0080)
		|| (IsPlayerInRangeOfPoint(playerid,3, 1795.4104,-1551.2864,22.9192)&& IsABOR(playerid)))//dach
		{
			ShowPlayerDialogEx(playerid, 696, DIALOG_STYLE_LIST, "Winda:", "[Poziom -1] Parking wewnêtrzny\n[Poziom 0] Parking zewnêtrzny\n[Poziom 1] Centrala GSA\n[Poziom 2] Sale Treningowe\n[Poziom 3] Dach", "Wybierz", "Anuluj");
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
		|| IsPlayerInRangeOfPoint(playerid,2,590.42767, -1447.62939, 80.95732)//Sale Treningowe
		|| IsPlayerInRangeOfPoint(playerid,2,605.5609, -1462.2583, 88.1674)//Sale przes³uchaniowe
		)
		{
			ShowPlayerDialogEx(playerid,19,DIALOG_STYLE_LIST,"Winda FBI","[Poziom -1]Parking podziemny \n[Poziom 0]Parking\n[Poziom 0.5] Stanowe\n[Poziom 1]Recepcja\n[Poziom 2] Szatnia\n[Poziom 3] Zbrojownia \n[Poziom 4]Biura federalne \n[Poziom 5] Dyrektorat\n[Poziom 6]CID/ERT\n[Poziom 7]Sale Treningowe\n[Poziom 8]Sale przes³uchañ \n [Poziom X] Dach","Jedz","Anuluj");
        }
		else if (PlayerToPoint(3.0, playerid,3.5040+KTAir_Offsets[0],30.7375+KTAir_Offsets[1],0.5391+100+KTAir_Offsets[2]))
		{
			if(PlayerInfo[playerid][pWlociej]==0)
			{
                new lVeh;
                for(new i=0;i<MAX_VEHICLES;i++)
                {
                    if(GetVehicleModel(i) == 577)
                    {
                        lVeh=i;
                        break;
                    }
                }
				if(VehicleToPoint(30.0, lVeh, 1937.5,-2275.8,16.9))
				{
					SetPlayerPos(playerid, 1937.5,-2275.8,16.9);
                    SetPlayerVirtualWorld(playerid, 0);
                    Wchodzenie(playerid);
					PlayerInfo[playerid][pWsamolocieLS]=0;
					osoby--;
				}
				else if(VehicleToPoint(30.0, lVeh, -1360.0999755859, -239.89999389648, 17.60000038147))
				{
					SetPlayerPos(playerid, -1360.0999755859, -239.89999389648, 17.60000038147);
                    SetPlayerVirtualWorld(playerid, 0);
                    Wchodzenie(playerid);
                    PlayerInfo[playerid][pWsamolocieLS]=0;
					osoby--;
				}
				else if(VehicleToPoint(30.0, lVeh, 1581.6999511719, 1444.5, 14.10000038147))
				{
					SetPlayerPos(playerid, 1581.6999511719, 1444.5, 14.10000038147);
                    SetPlayerVirtualWorld(playerid, 0);
                    Wchodzenie(playerid);
                    PlayerInfo[playerid][pWsamolocieLS]=0;
					osoby--;
				}
			}
        }
        else if (PlayerToPoint(3.0, playerid,-0.0320+KTAir_Offsets[0],-0.6701+KTAir_Offsets[1],0.5391+100+KTAir_Offsets[2]))
    	{
    		if(PlayerInfo[playerid][pMozeskakacAT]==1)
    		{
                new lVeh;
                for(new i=0;i<MAX_VEHICLES;i++)
                {
                    if(GetVehicleModel(i) == 577)
                    {
                        lVeh=i;
                        break;
                    }
                }
    		    new Float:X, Float:Y, Float:Z;
    			GetVehiclePos(lVeh, X, Y, Z);
    			GivePlayerWeapon(playerid, 46, 1);
    			SetPlayerPos(playerid, X, Y, Z-3);
    			GameTextForPlayer(playerid, "Powodzenia", 3000, 1);
    			PlayerInfo[playerid][pWsamolocieLS]=0;
    			PlayerInfo[playerid][pWlociej]=0;
    			PlayerInfo[playerid][pMozeskakacAT]=0;
                SetPlayerVirtualWorld(playerid, 0);
    			osoby--;
    		}
        }
		else if(IsPlayerInRangeOfPoint(playerid,5, -1674.4122,917.7183,-52.4141)) //nowe komi drzwi w celach
		{
			SetPlayerPos(playerid, -1674.5769,903.1641,-48.9141); //nowe komi wejscie prawnicze
		}
        else if (PlayerToPoint(2.0, playerid,211.7162,1811.4824,21.8594) && (PlayerInfo[playerid][pJailed] == 0)) //Wejœcie do wiêzienia stanowego
        {
            if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3)
            {
                SetPlayerPos(playerid,2730.2300,-2451.1172,17.5937);
                SetPlayerInterior(playerid, 0);
                return 1;
            }
            if(PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pLider] == 2)
            {
                SetPlayerPos(playerid,633.6562,-1490.3883,90.6158);
                SetPlayerInterior(playerid, 0);
                SetPlayerVirtualWorld(playerid, 11);
      		    TogglePlayerControllable(playerid, 0);
				Wchodzenie(playerid);
                return 1;
            }
            else
            {
                SetPlayerPos(playerid,/*216.3953,120.8046,1003.2188 old komi*/-1606.0139,818.9503,-29.4141); //Wejœcie do wiêzienia stanowego
                GameTextForPlayer(playerid, "~w~Witamy na Komisariacie.", 5000, 1);
                SetPlayerVirtualWorld(playerid,1);
       		    TogglePlayerControllable(playerid, 0);
				Wchodzenie(playerid);
				PlayerInfo[playerid][pLocal] = 210;
                return 1;
            }
        }
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1193.2720,-1774.8802,13.7282)) // basen tylko dla personelu
		{
		    if(IsAPoolBusinessOwner(playerid))
		    {
			    SetPlayerPos(playerid, 598.6794,-2204.8613,1.8190); // bar basenowy
			    TogglePlayerControllable(playerid, 10);
                Wchodzenie(playerid);
                GameTextForPlayer(playerid, "~w~Nieupowaznionym wstep wzbroniony", 5000, 1);
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ upowa¿niony do korzystania z wejœcia dla personelu");
			}
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1274.3020,-1756.0800,48.5812)) // sauna srodek
		{
		    SetPlayerPos(playerid, 1213.28540, -1790.80505, 70.25735); // sauna wejscie
    		SetPlayerVirtualWorld(playerid, 43);
		    TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
		}
		/*else if (IsPlayerInRangeOfPoint(playerid, 5.0, 575.5542,-2048.8000,16.1670)) // basen recepcja
		{
		    SetPlayerPos(playerid, 1210.552734375,-1749.1850585938,13.593885421753 ); // basen na zewnatrz
		    if(PlayerInfo[playerid][pChar] > 0) { SetPlayerSkinEx(playerid, PlayerInfo[playerid][pChar]); }
			else { SetPlayerSkinEx(playerid, PlayerInfo[playerid][pModel]); }
			SetPlayerVirtualWorld(playerid, 0);
		    TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
		}*/
		//Tory szkoleniowe
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, -653.34765625,-5448.5634765625,13.368634223938) || // wybieralka fbi Strzelnica FBI œrodek
				IsPlayerInRangeOfPoint(playerid, 5.0, 1703.9327392578,141.29598999023,30.903503417969) || // wybieralka fbi Strzelnica terenowa
				IsPlayerInRangeOfPoint(playerid, 5.0, 1581.8731689453,5490.7412109375,329.73870849609) || // wybieralka fbi spadochrin wejœcie œrodek
				IsPlayerInRangeOfPoint(playerid, 5.0, 2236.0786132813,-6891.217773475,21.423152923584) || // wybieralka fbi Porwanie w domu œrodek
				IsPlayerInRangeOfPoint(playerid, 5.0, -433.55599975586,-3812.807373046,176.7035064697) || // wybieralka fbi Terroryœci na statku
				IsPlayerInRangeOfPoint(playerid, 5.0, 1630.513671875,5232.2626953125,2.6707870960236)) // wybieralka fbi spadochrin wejœcie œrodek
		{
		    SetPlayerPos(playerid, 1271.0920,-1667.8794,19.7344); //wybieralka fbi
		    SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid,0);
		}
		//vinyl
		else if(IsPlayerInRangeOfPoint(playerid, 1.5, 816.50, -1413.75, -22.58))
		{
			Wchodzenie(playerid);
			SetPlayerVirtualWorld(playerid, 72);
			SetPlayerPos(playerid, 816.5667, -1415.4117, -22.5834);
			GameTextForPlayer(playerid, "~w~Impreza dalej trwa~n~~r~bez ciebie", 5000, 1);
			SetPlayerLocal(playerid, PLOCAL_DEFAULT); 
			return 1;
		}
        //IBIZA
		//wyjscie glowne
    	else if(PlayerToPoint(1.5, playerid, 417.3976, -1858.9402, -65.3905))
        {
			Wchodzenie(playerid);
            SetPlayerVirtualWorld(playerid, 21);
			PlayAudioStreamForPlayer(playerid, IBIZA_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
            SetPlayerPos(playerid, 395.9647, -1811.1703, 7.8789);
            GameTextForPlayer(playerid, "~w~Zapraszamy ponownie!", 5000, 1);
            return 1;
        }
		//wejscie na scene/konsole
        else if(PlayerToPoint(1.5, playerid, 434.7581, -1841.0632, -64.2206))
        {
			if(!IsAClubBusinessOwner(playerid))
            {
                return 1;
            }
            SetPlayerPos(playerid, 430.4849,-1837.2827,-65.5105);
            return 1;
        }
        //wejscia VIP
        else if(PlayerToPoint(1.5, playerid, 428.3247, -1855.9178, -65.2092) && GetPlayerVirtualWorld(playerid) == 22)
        {
            if(IbizaTicket[playerid] <= 1)
            {
                if(!IsAClubBusinessOwner(playerid))
                {
                    return 1;
                }
            }
            SetPlayerPos(playerid, 425.9001, -1854.8367, -65.5105);
            return 1;
        }
        else if(PlayerToPoint(1.5, playerid, 406.8980, -1856.6122, -65.2092) && GetPlayerVirtualWorld(playerid) == 22)
        {
            if(IbizaTicket[playerid] <= 1)
            {
                if(!IsAClubBusinessOwner(playerid))
                {
                    return 1;
                }
            }
            SetPlayerPos(playerid, 408.6968, -1855.0348, -65.5105);
            return 1;
        }
        else if(PlayerToPoint(1.5, playerid, 406.3426, -1835.0138, -65.2092) && GetPlayerVirtualWorld(playerid) == 22)
        {
            if(IbizaTicket[playerid] <= 1)
            {
                if(!IsAClubBusinessOwner(playerid))
                {
                    return 1;
                }
            }
            SetPlayerPos(playerid, 408.8490, -1835.8851, -65.5105);
            return 1;
        }
        else if(PlayerToPoint(1.5, playerid, 416.8028, -1850.4160, -61.9043) && GetPlayerVirtualWorld(playerid) == 22)
        {
            if(IbizaTicket[playerid] <= 1)
            {
                if(!IsAClubBusinessOwner(playerid))
                {
                    return 1;
                }
            }
            SetPlayerPos(playerid, 403.3954,-1843.4607,-65.5105);
            return 1;
        }
        //wejscia SUPERVIP
        else if(PlayerToPoint(1.5, playerid, 426.7242, -1834.9066, -65.2102) && GetPlayerVirtualWorld(playerid) == 22)
        {
            if(IbizaTicket[playerid] <= 2)
            {
                if(!IsAClubBusinessOwner(playerid))
                {
                    return 1;
                }
            }
            SetPlayerPos(playerid, 424.0322, -1837.0964, -65.5105);
            return 1;
        }
        else if(PlayerToPoint(1.5, playerid, 221.530426, -1546.261352, -15.997495) && GetPlayerVirtualWorld(playerid) == 25)
        {
            if(IbizaTicket[playerid] <= 2)
            {
                if(!IsAClubBusinessOwner(playerid))
                {
                    return 1;
                }
            }
			Wchodzenie(playerid);
            SetPlayerVirtualWorld(playerid, 22);
			PlayAudioStreamForPlayer(playerid, IBIZA_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
            SetPlayerPos(playerid, 422.2131, -1831.5657, -65.5105);
			return 1;
        }
    	//wyjœcie bileterki
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 397.6174,-1806.2030,7.8381) && IsAClubBusinessOwner(playerid) && GetPlayerVirtualWorld(playerid) == 0) //RANGA
    	{
    		TogglePlayerControllable(playerid, false);
    		SetPlayerPos(playerid, 1740.5719,-2471.0737,14.2266);
    		SetPlayerFacingAngle(playerid, 269.6975);
    		SetPlayerVirtualWorld(playerid, 1);
    		SetPVarInt(playerid, "IbizaWejdz", 1);
    		PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 250.0, 1);
    		if(IbizaSwiatla) WlaczSwiatlaP(playerid);
    		else WylaczSwiatlaP(playerid);
            Wchodzenie(playerid);
    		return 1;
    	}
    	//wyjœcie glowne Lewe
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1741.4761,-2469.3740,14.2266) && GetPlayerVirtualWorld(playerid) == 1)
    	{
    		SetPlayerPos(playerid, 400.8845,-1805.9010,7.8281);
    		SetPlayerFacingAngle(playerid, 0);
    		SetPlayerVirtualWorld(playerid, 0);
    		SetPVarInt(playerid, "IbizaWejdz", 0);
    		StopAudioStreamForPlayer(playerid);
    		GameTextForPlayer(playerid, "~b~Zapraszamy ponownie", 5000, 1);
    		IbizaWyjscie(playerid);
            Wchodzenie(playerid);
    		return 1;
    	}
    	//wyjœcie glowne Prawe
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1741.5828,-2473.1572,14.2266) && GetPlayerVirtualWorld(playerid) == 1)
    	{
    		SetPlayerPos(playerid, 394.2784,-1805.9104,7.8302);
    		SetPlayerFacingAngle(playerid, 0);
    		SetPlayerVirtualWorld(playerid, 0);
    		SetPVarInt(playerid, "IbizaWejdz", 0);
    		StopAudioStreamForPlayer(playerid);
    		GameTextForPlayer(playerid, "~b~Zapraszamy ponownie", 5000, 1);
    		IbizaWyjscie(playerid);
            Wchodzenie(playerid);
    		return 1;
    	}
    	// glowna SALA klubu.
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1890.3613,-2494.6675,14.2266) && GetPlayerVirtualWorld(playerid) == 1)
    	{
    		SetPlayerPos(playerid, 1761.7330,-2471.2756,19.7275);
    		SetPlayerFacingAngle(playerid, 90.0);
    		PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 250.0, 1);
            Wchodzenie(playerid);
    		return 1;
    	}
    	// BAR - wyjscie
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1900.5961,-2494.9373,13.6266) && PlayerInfo[playerid][pRank] && GetPlayerVirtualWorld(playerid) == 1 && IsAClubBusinessOwner(playerid)) //RANGA
    	{
    		SetPlayerPos(playerid, 1898.4817,-2494.8752,13.6266);
    		SetPlayerFacingAngle(playerid, 271.3850);
    		return 1;
    	}
    	// Dyrekcja - wyjscie
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1911.4484,-2466.0842,17.9850) && GetPlayerVirtualWorld(playerid) == 1)
    	{
    		if(!IbizaBiuro) return sendTipMessageEx(playerid, 0xB52E2BFF, "Biuro jest w tej chwili zamkniête");
    		SetPlayerPos(playerid, 1915.1454,-2468.3472,15.4266);
    		SetPlayerFacingAngle(playerid, 270.0);
    		PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID]);
            Wchodzenie(playerid);
    		return 1;
    	}
    	//wyjœcie boczne
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1917.3785,-2465.4368,15.4266) && GetPlayerVirtualWorld(playerid) == 1 && IsAClubBusinessOwner(playerid)) //RANGA
    	{
    		SetPlayerPos(playerid, 386.2871,-1817.9784,7.8410);
    		SetPlayerFacingAngle(playerid, 94.4268);
    		SetPlayerVirtualWorld(playerid, 0);
    		StopAudioStreamForPlayer(playerid);
    		SetPVarInt(playerid, "IbizaWejdz", 0);
    		IbizaWyjscie(playerid);
            Wchodzenie(playerid);
    		return 1;
    	}
    	//wyjœcie ubikacja Prawa
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1534.3746,-2553.6333,13.5890) && GetPlayerVirtualWorld(playerid) == 1)
    	{
    		TogglePlayerControllable(playerid, false);
            Wchodzenie(playerid);
    		SetPlayerPos(playerid, 1910.2588,-2474.8745,13.6266);
    		SetPlayerFacingAngle(playerid, 180.0);
    		DeletePVar(playerid, "IbizaKibel");
    		if(!IbizaSwiatla) WylaczSwiatlaP(playerid);
    		else WlaczSwiatlaP(playerid);
    		PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID]);
    		return 1;
    	}
    	//wyjœcie ubikacja Lewa
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1534.2446,-2550.8020,13.5890) && GetPlayerVirtualWorld(playerid) == 2)
    	{
    		TogglePlayerControllable(playerid, false);
            Wchodzenie(playerid);
    		SetPlayerPos(playerid, 1906.1383,-2474.4417,13.6266);
    		SetPlayerFacingAngle(playerid, 180.0);
    		SetPlayerVirtualWorld(playerid, 1);
    		DeletePVar(playerid, "IbizaKibel");
    		if(!IbizaSwiatla) WylaczSwiatlaP(playerid);
    		else WlaczSwiatlaP(playerid);
    		PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID]);
    		return 1;
    	}
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
        //AirTower LS
        else if (IsPlayerInRangeOfPoint(playerid,3.0,1627.3157,-2279.6157,75.0))
        {
            INT_AirTowerLS_Exit(playerid, false, true);
            SetPlayerPos(playerid,1635.3210, -2286.5698, 13.4162);
        }
        else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1763.4243, -1128.0543, 224.1499))//Wyjœcie
		{
        	SetPlayerPos(playerid, 1763.4033, -1129.7128, 24.0859);
        	SetPlayerVirtualWorld(playerid, 0);
			GameTextForPlayer(playerid, "~w~Zapraszamy ponownie!", 5000, 1);
		}
		else
		{
			Wyjdz(playerid, 738.5865, -1427.7610, 23.5927, 738.8545, -1428.7880, 13.5927, 5.0, "~w~Zapraszamy ponownie!"); //wyjœcie jetty przy ulicy
			Wyjdz(playerid, 734.0619, -1451.6720, 22.5920, 725.6371, -1440.3321, 13.5360, 5.0, "~w~Zapraszamy ponownie!"); //wyjœcie jetty pod schodami	
			Wyjdz(playerid, 1285.5999755859,-981.79998779297,32.700000762939, 1300.0999755859,-1094.5999755859,5972.2001953125, 5.0);//int z flagami
		    Wyjdz(playerid, 1302.8000488281,-988.20001220703,38.299999237061, 1301.8000488281,-1083.9000244141,5972.2001953125, 5.0);//g³ówne wejœcie
		    Wyjdz(playerid, -1716.1999511719,1018.200012207,17.60000038147, -1825.4000244141,1151.6999511719,6803.2998046875, 5.0);//WEJSCIE DO KRYJOWKI
		    Wyjdz(playerid, -1858.3000488281,1158.3000488281,6799, -1865.6999511719,1116.8000488281,6799.10009765, 2.0);//drzwi 1
			Wyjdz(playerid, -1858.5,1160.5999755859,6799, -1877.1999511719,1178,6799.2998046875, 2.0);//drzwi 2
			
			for(new i=0; i<=BusinessLoaded; i++)//
            {
               if(IsPlayerInRangeOfPoint(playerid, 4.2, Business[i][b_exX], Business[i][b_exY], Business[i][b_exZ])
                && GetPlayerVirtualWorld(playerid) == Business[i][b_vw])
                {
                    SetPlayerVirtualWorld(playerid, Business[i][b_enVw]); 
                    SetPlayerInterior(playerid, Business[i][b_enInt]); 
                    SetPlayerLocal(playerid, PLOCAL_DEFAULT); 
                    SetPlayerPos(playerid, Business[i][b_enX], Business[i][b_enY], Business[i][b_enZ]);
					return 1; 
                }
			}
			for(new i; i<=MAX_NrDOM; i++)
		    {
				if(IsPlayerInRangeOfPoint(playerid, 5.0, IntInfo[i][Int_X], IntInfo[i][Int_Y], IntInfo[i][Int_Z]))
				{
                    new deem = PlayerInfo[playerid][pDomWKJ];
			        SetPlayerPos(playerid, Dom[deem][hWej_X], Dom[deem][hWej_Y], Dom[deem][hWej_Z]);
			        SetPlayerInterior(playerid, 0);
			        SetPlayerVirtualWorld(playerid, 0);
			        PlayerInfo[playerid][pDomWKJ] = 0;
			        SetPlayerTime(playerid, PlayerInfo[playerid][pDomT], 0);
        			PlayerInfo[playerid][pDomT] = 0;
					SetServerWeatherAndTime(playerid);
			        GameTextForPlayer(playerid, "~g~Opusciles dom", 5000, 1);
			        return 1;
                }
			}
		}
		if(HireCar[playerid] >= 1 && IsPlayerInAnyVehicle(playerid))
		{
			TogglePlayerControllable(playerid, 1);
			RemovePlayerFromVehicleEx(playerid);
			HireCar[playerid] = 0;
			return 1;
		}
	}
	return 1;
}

//end
