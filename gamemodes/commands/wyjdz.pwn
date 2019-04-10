//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wyjdz ]-------------------------------------------------//
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

CMD:exit(playerid) return cmd_wyjdz(playerid);
CMD:wyjdz(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
	
        if(GetPVarInt(playerid, "AC-izolacja") != 0) return sendTipMessageEx(playerid, COLOR_PANICRED, "Jesteœ odizolowany, nie mo¿esz u¿ywaæ tej komendy.");
		
		if(SprawdzWejscia(playerid))
			return 1;
		
		else if(IsPlayerInRangeOfPoint(playerid,4,1568.6449, -1689.6379, 6.1932) && IsACop(playerid)//parking LSPD
		|| IsPlayerInRangeOfPoint(playerid,4,-1645.1858, 883.1620, -45.4112)//z glownego wejscia
		|| IsPlayerInRangeOfPoint(playerid,4,-1621.7272, 834.5807, -26.1115)//sale przesluchan
		|| IsPlayerInRangeOfPoint(playerid,4,-1745.1101, 824.0737, -48.0110)//biura LSPD
		|| IsPlayerInRangeOfPoint(playerid,4,-1695.1617, 1046.9861, -65.4119)//stolowka
		|| IsPlayerInRangeOfPoint(playerid,4,1568.1061, 2205.3196, -50.9522)//treningowe miejsca
		|| IsPlayerInRangeOfPoint(playerid,4,1565.0798, -1665.6580, 28.4782) && IsACop(playerid))//dach LSPD
		{
		    //ShowPlayerDialogEx(playerid,WINDA_LSPD,DIALOG_STYLE_LIST,"Winda","[Poziom -1]Parkingi\n[Poziom 0]Komisariat\n[Poziom 1]Pokoje Przes³uchañ\n[Poziom 2]Biura\n[Poziom 3]Sale Treningowe\n[Poziom 4]Dach","Jedz","");
            ShowPlayerDialogEx(playerid,WINDA_LSPD,DIALOG_STYLE_LIST,"Winda","[Poziom -1]Parking Dolny\n[Poziom 0] Parking Górny\n[Poziom 1]Komisariat\n[Poziom 2]Pokoje Przes³uchañ\n[Poziom 3]Biura\n[Poziom 4]Sale Treningowe\n[Poziom 5]Dach","Jedz","");
		}
		//w     szpital na zewnatrz
        else if(IsPlayerInRangeOfPoint(playerid,5,1171.9703, -1322.4764, 31.6913))
    	{
    		SetPlayerPosEx(playerid,1172.6564, -1323.4110, 15.6034);
    		SetPlayerVirtualWorld ( playerid, 0 ) ;
    	}
        //SAD
        else if(IsPlayerInRangeOfPoint(playerid,4,1294.6930, -1324.6571, 39.1802))
    	{ //WYJŒCIE G£OWNE
    		SetPlayerPosEx(playerid,1309.9658, -1367.2878, 13.7324);
    		GameTextForPlayer(playerid, "~r~Milego dnia! ~n~ by abram01", 6000, 1);
    		SetPlayerVirtualWorld ( playerid, 0 ) ;
    		SetPlayerWeatherEx(playerid, ServerWeather);
    		SetPlayerTime(playerid, ServerTime, 0);
    	}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 592.71991, -1487.62439, 89.30576))
		{
			SetPlayerPosEx(playerid,608.19793701172, -1458.9837646484, 14.387271881104);
			TogglePlayerControllable(playerid, 0);
			Wchodzenie(playerid);
			SetPlayerVirtualWorld(playerid, 0);
			
		}
    	else if(IsPlayerInRangeOfPoint(playerid,4,1315.1282, -1336.4583, 39.1618))
    	{ //WYJŒCIE EWAKUACYJNE DLA GSA I RZ¥D!!!
            if(GetPlayerFraction(playerid) == FRAC_BOR || GetPlayerOrg(playerid) == FAMILY_SAD)
            {
        		SetPlayerPosEx(playerid,1333.5448, -1308.2383, 13.7718);
        		GameTextForPlayer(playerid, "~r~Stare przejscie jeszcze dziala! ~n~ by abram01", 6000, 1);
        		SetPlayerVirtualWorld ( playerid, 0 ) ;
        		SetPlayerWeatherEx(playerid, ServerWeather);
    			SetPlayerTime(playerid, ServerTime, 0);
            }
    	}
        else if(IsPlayerInRangeOfPoint(playerid,2,1305.0013, -1291.6804, 35.7221))
    	{ //WEJŒCIE DLA S£U¯B PORZ¥DKOWYCH!!! PODPI¥C TYLKO POD GSA PD FBI NG EW. RZ¥D
            if(GetPlayerFraction(playerid) == FRAC_BOR || IsACop(playerid) || GetPlayerOrg(playerid) == FAMILY_SAD)
            {
        		SetPlayerPosEx(playerid,1286.0413,-1329.2007,13.5515);
        		SetPlayerVirtualWorld ( playerid, 0 ) ;
        		SetPlayerWeatherEx(playerid, ServerWeather);
    			SetPlayerTime(playerid, ServerTime, 0);
            }
    	}
        else if(IsPlayerInRangeOfPoint(playerid,5,1751.6058, -1118.3661, 46.8055))   //Dach LSFD
        {
    		SetPlayerPosEx(playerid,1711.3928, -1130.0851, 24.1741);
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
		|| IsPlayerInRangeOfPoint(playerid,2,590.42767, -1447.62939, 80.95732))//Sale Treningowe
		{
			ShowPlayerDialogEx(playerid,19,DIALOG_STYLE_LIST,"Winda FBI","[Poziom -1]Parking podziemny \n[Poziom 0]Parking\n[Poziom 0.5] Stanowe\n[Poziom 1]Recepcja\n[Poziom 2] Szatnia\n[Poziom 3] Zbrojownia \n[Poziom 4]Biura federalne \n[Poziom 5] Dyrektorat\n[Poziom 6]CID/ERT\n[Poziom 7]Sale Treningowe \n [Poziom X] Dach","Jedz","Anuluj");
        }
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1144.0762939453, -1324.9822998047, 419.69830322266))//wypoczynek srodek
		{
		    SetPlayerPosEx(playerid, 1143.5290527344, -1327.2391357422, 419.69830322266);//wypoczynek wejscie
		    GameTextForPlayer(playerid, "~w~Witamy w ~r~Szpitalu", 5000, 1);
		    TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1142.2545166016, -1339.8093261719, 419.69830322266))//wyklady srodek
		{
		    SetPlayerPosEx(playerid, 1142.2214355469, -1337.7125244141, 419.69830322266);//wyklady wejscie
		    GameTextForPlayer(playerid, "~w~Witamy w ~r~Szpitalu", 5000, 1);
		    TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 156.85940551758, 1829.7415771484, 17.693145751953))//pokoj widzen fbi srodek
		{
		    SetPlayerPosEx(playerid, 213.57328796387, 1811.1787109375, 21.8671875);//pokoj widzen fbi wejscie
		    GameTextForPlayer(playerid, "~w~Zegnamy", 5000, 1);
			PlayerInfo[playerid][pLocal] = 255;
		}
		else if(IsPlayerInRangeOfPoint(playerid,3,481.1781,-1493.9980,43.6700))//scena
		{
			SetPlayerPosEx(playerid,481.0048,-1499.3975,41.3900);
		}
	 	else if(IsPlayerInRangeOfPoint(playerid,3,503.4429,-1495.5690,45.6459))//okna
		{
			SetPlayerPosEx(playerid,495.5948,-1503.1011,41.3900);
		}
		if(IsPlayerInRangeOfPoint(playerid,4,2455.1021,-1958.0905,120.8159))//WPS klub bonehead
	    {
	        SetPlayerVirtualWorld(playerid,0);
	        SetPlayerPosEx(playerid,2447.8284,-1963.1549,13.5469);
	        StopAudioStreamForPlayer(playerid);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 41.132061004639, 1885.5982666016, 5525.8100585938))//cela smierci srodek
		{
		    SetPlayerPosEx(playerid, 197.17276000977, 1826.01171875, 17.640625);//cela smierci wejscie
		    GameTextForPlayer(playerid, "~w~Niech zabity spoczywa w spokoju", 5000, 1);
		    TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 627.1783, -1470.2279, 90.7054) && GetPlayerVirtualWorld(playerid) == 10)//biura fbi srodek
		{
		    SetPlayerPosEx(playerid, 608.19793701172, -1458.9837646484, 14.387271881104);//biura fbi wejscie
		    GameTextForPlayer(playerid, "~w~Zegnamy", 5000, 1);
		    TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid,0);
		}
	    else if(IsPlayerInRangeOfPoint(playerid, 5.0, 2312.14,-1317.54,180.05))//biro tfat srodek
	    {
	        SetPlayerPosEx(playerid, 2324.6416,-1263.5723,22.5070 );//biuro tfat wejscie
	        GameTextForPlayer(playerid, "~y~Wyscigowego ~b~dnia", 5000, 1);
	        SetPlayerInterior(playerid,0);
	    }
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, 2452.1274, -2117.2329, 32.2572))//biuro KT srodek
	    {
	        SetPlayerPosEx(playerid, 2518.0, -2127.0, 13.5);//2458.3215, -2116.7236, 13.5976);//biuro KT exit
	        GameTextForPlayer(playerid, "~w~Jestesmy najszybsi w miescie!", 3000, 1);
	        SetPlayerVirtualWorld(playerid, 0);
	    }
        else if (PlayerToPoint(4.0, playerid,1673, 1447.5, 14.800000190735)) //Lotnisko LV przed budynek
		{
			SetPlayerPosEx(playerid,1673.3000488281, 1447.8000488281, 10.89999961853);
			GameTextForPlayer(playerid, "Zegnamy", 3000, 1);
			SetPlayerVirtualWorld(playerid, 0);
		}
		else if (PlayerToPoint(3.0, playerid,1675.8000488281, 1455.4000244141, 14.89999961853)) //Lotnisko LV na pas
		{
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerPosEx(playerid,1597.6999511719, 1448.3000488281, 10.89999961853);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "LSBD: Wchodzisz na pas lotniska Las Venturas!");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "LSBD: Kieruj siê na schody samolotu.");
		}
		else if (PlayerToPoint(2.0, playerid,-1390,-294.60000610352,-74.6)) //Wyjscie z inta na pas SF
		{
			SetPlayerPosEx(playerid,-1376.3000488281,-261.10000610352,14.300000190735);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "LSBD: Wchodzisz na pas lotniska San Fierro !");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "LSBD: Kieruj siê na schody samolotu.");
		}
		else if (PlayerToPoint(2.0, playerid,-1394.4000244141,-301.5,-74.6)) //Wyjscie z inta na droge SF
		{
			SetPlayerPosEx(playerid,-1421.4000244141,-287.29998779297,14.10000038147);
		}
		//Lotnisko LS budka wyjscie
		else if (PlayerToPoint(1.0, playerid,1952.9000244141,-2181,13.5))
		{
			SetPlayerPosEx(playerid,1952.8994140625,-2179.19921875,13.5);
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
					SetPlayerPosEx(playerid, 1937.5,-2275.8,16.9);
                    SetPlayerVirtualWorld(playerid, 0);
                    Wchodzenie(playerid);
					PlayerInfo[playerid][pWsamolocieLS]=0;
					osoby--;
				}
				else if(VehicleToPoint(30.0, lVeh, -1360.0999755859, -239.89999389648, 17.60000038147))
				{
					SetPlayerPosEx(playerid, -1360.0999755859, -239.89999389648, 17.60000038147);
                    SetPlayerVirtualWorld(playerid, 0);
                    Wchodzenie(playerid);
                    PlayerInfo[playerid][pWsamolocieLS]=0;
					osoby--;
				}
				else if(VehicleToPoint(30.0, lVeh, 1581.6999511719, 1444.5, 14.10000038147))
				{
					SetPlayerPosEx(playerid, 1581.6999511719, 1444.5, 14.10000038147);
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
    			SetPlayerPosEx(playerid, X, Y, Z-3);
    			GameTextForPlayer(playerid, "Powodzenia", 3000, 1);
    			PlayerInfo[playerid][pWsamolocieLS]=0;
    			PlayerInfo[playerid][pWlociej]=0;
    			PlayerInfo[playerid][pMozeskakacAT]=0;
                SetPlayerVirtualWorld(playerid, 0);
    			osoby--;
    		}
        }
        //Int lotniska wyjscie
		else if (PlayerToPoint(3.0, playerid,1573.5999755859,-2286.3999023438,-75))
		{
			SetPlayerPosEx(playerid,1585.2,-2286.6,13.7);
		}
        //Wyjœcie z biletem na pas LS
		else if (PlayerToPoint(3.0, playerid,1605,-2282.9,-74.90))
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "LSBD: Wchodzisz na pas lotniska Los Santos!");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "LSBD: Kieruj siê na schody samolotu.");
			SetPlayerPosEx(playerid, 1886.1,-2286.4,14);
		}


		//KONIEC LS
		/*else if (PlayerToPoint(3.0, playerid,387.7978,173.8582,1008.3828))
		{
		    SetPlayerInterior(playerid,0);
			SetPlayerPosEx(playerid,-2162.2554,-2385.9541,30.6250);
			PlayerInfo[playerid][pInt] = 0;
			PlayerInfo[playerid][pLocal] = 255;
		}*/
		else if (PlayerToPoint(8.0, playerid,-1443.0554,-581.1879,1055.0472))
		{
		    SetPlayerInterior(playerid,0);
			SetPlayerPosEx(playerid,-2111.5686,-443.9720,38.7344);
		}
		else if (PlayerToPoint(8.0, playerid,-1464.7732,1557.5533,1052.5313))
		{
		    SetPlayerInterior(playerid,0);
			SetPlayerPosEx(playerid,-2080.3079,-406.0309,38.7344);
		}
		else if(PlayerToPoint(10.0, playerid, 1462.2887,-1008.2450,27.1099))//bank LS œrodek
	    {
	        SetPlayerPosEx(playerid,1462.395751,-1012.391174,26.843799);//bank LS wejscie
	        GameTextForPlayer(playerid, "~w~Zapraszamy ~g~ponownie", 5000, 1);
	        PlayerInfo[playerid][pLocal] = 255;
            SetPlayerVirtualWorld(playerid, 0);
	    }
		else if(PlayerToPoint(10.0, playerid, 2305.688964,-16.088100,26.749599))//bank PC œrodek
	    {
	        SetPlayerPosEx(playerid,2302.7798,-15.9637,26.4844);//bank PC wejscie
	        GameTextForPlayer(playerid, "~w~Zapraszamy ~g~ponownie", 5000, 1);
	        PlayerInfo[playerid][pLocal] = 255;
            SetPlayerVirtualWorld(playerid, 0);
	    }
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, -2063.9272460938,547.01922607422,1172.2559814453))//ratusz bay side srodek
		{
		    SetPlayerPosEx(playerid, -2474.1194,2232.1296,5.7156);//ratusz bay side wejscie
		    GameTextForPlayer(playerid, "~w~Zapraszamy ponownie", 5000, 1);
		    SetPlayerInterior(playerid,0);
		}
		else if (PlayerToPoint(10.0, playerid,1450.6495,-1772.9926,76.5013))//ratusz
		{
		    SetPlayerInterior(playerid,0);
			SetPlayerPosEx(playerid,1481.1531,-1770.0277,18.7958);//wejscie do ratusza
			PlayerInfo[playerid][pInt] = 0;
			PlayerInfo[playerid][pLocal] = 255;
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid,0);
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,2318.7566, -85.3065, 39.7866))
		{
		    SetPlayerPosEx(playerid,2269.6848, -75.5530, 27.1525);
		    SetPlayerVirtualWorld(playerid, 0);
			PlayerInfo[playerid][pLocal] = 255;
		}
		else if (PlayerToPoint(8.0, playerid,-1443.0554,-581.1879,1055.0472))//drift track
		{
		    SetPlayerInterior(playerid,0);
			SetPlayerPosEx(playerid,-2111.5686,-443.9720,38.7344);//wejscie do drift track
			return 1;
		}
        /* JETTY LOUNGE */

        else if (IsPlayerInRangeOfPoint(playerid,3.0,734.0619, -1451.6720, 22.5920))
        {
            SetPlayerPosEx(playerid, 725.6371, -1440.3321, 13.5360 );
            SetPlayerVirtualWorld(playerid, 0);
            GameTextForPlayer(playerid, "~w~Zapraszamy ponownie", 5000, 1);
        }
        else if (IsPlayerInRangeOfPoint(playerid,3.0,736.3939, -1472.8465, 22.5920))
        {
            if(GetPlayerFraction(playerid) != FRAC_LCN) return SendClientMessage(playerid, COLOR_GRAD1, "Tylko pracownicy!");
            SetPlayerPosEx(playerid, 735.2055, -1472.9760, 22.5920);
            SetPlayerVirtualWorld(playerid, 255);
        }
        else if (IsPlayerInRangeOfPoint(playerid,3.0,722.0778, -1450.7183, 26.0396))
        {
            SetPlayerPosEx(playerid,725.5906, -1450.9875, 17.7069);
            SetPlayerVirtualWorld(playerid, 0);
            GameTextForPlayer(playerid,  "~w~Witamy na tarasie", 5000, 1);
        }

        else if (PlayerToPoint(5.0, playerid,-794.97491455078, 489.89901733398, 1376.1953125)) //restauracja na gorze
        {
            SetPlayerPosEx(playerid,725.4005,-1450.4960,17.6953); //taras restauracji
            GameTextForPlayer(playerid, "~g~Witamy~w~ na ~r~tarasie.", 5000, 1);
            SetPlayerInterior(playerid, 0);
            return 1;
        }
        else if (PlayerToPoint(5.0, playerid,-778.74987792969, 506.79095458984, 1371.7421875)) //restauracja na dole
        {
            SetPlayerPosEx(playerid,725.7198,-1439.3527,13.5391); //restauracja na zewnatrz na dole
            GameTextForPlayer(playerid, "~g~Goraco ~w~Zapraszamy ~r~Ponownie.", 5000, 1);
            SetPlayerInterior(playerid, 0);
            return 1;
        }

        else if (PlayerToPoint(4.0, playerid,726.34814453125,-1454.4940185547,22.237335205078)) //gabinet LCN
        {
            SetPlayerPosEx(playerid,-778.3271484375,496.4326171875,1368.5303955078); //wejscie do gabinetu LCN
            GameTextForPlayer(playerid, "~g~ Arivederci", 5000, 1);
            SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 1);
            return 1;
        }
		else if (PlayerToPoint(4.0, playerid,738.5865, -1427.7610, 23.5927)) //biura LCN
        {
            SetPlayerPosEx(playerid,738.8545, -1428.7880, 13.5927); //biura LCN wejœcie
            GameTextForPlayer(playerid, "~g~ Arivederci", 5000, 1);
            SetPlayerVirtualWorld(playerid, 0);
            return 1;
        }
		else if (PlayerToPoint(5.0, playerid,2967.2785644531,-1056.5300292969,4505.6782226563)) //gabinet  YKZ
        {
            SetPlayerPosEx(playerid,368.3667,193.8689,1008.3828); //wejœcie YKZ
            GameTextForPlayer(playerid, "~w~Shitsurei Shimasu", 5000, 1);
            SetPlayerInterior(playerid, 3);
            return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2787.9572753906,-1085.6119384766,94.187072753906)) // dach YKZ
		{
		    SetPlayerPosEx(playerid, 371.9455,168.0409,1008.3828 ); // wejscie na dach YKZ
		    SetPlayerInterior(playerid, 3);
		}
        else if (PlayerToPoint(3.5, playerid,-2170.2500,638.5538,1052.3750)) //Zak³ad bukmaherski ZEJSCIE Z GORY
        {
            SetPlayerPosEx(playerid,-2170.0593,641.1239,1052.3817); 
            GameTextForPlayer(playerid, "~w~Witamy NA DOLE", 5000, 1);
            SetPlayerInterior(playerid, 1);
            return 1;
        }
		//stare komi (old komi)
		else if (PlayerToPoint(4.0, playerid,246.6659,108.0529,1003.2188)) //Komisariat wyjscie
        {
		    SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerPosEx(playerid,2425.6000976563,117.69999694824,26.53); //Komisariatna zewn¹trz
            GameTextForPlayer(playerid, "~w~Milego dnia", 5000, 1);
            PlayerInfo[playerid][pInt] = 0;
			PlayerInfo[playerid][pLocal] = 255;
            return 1;
        }
		else if (PlayerToPoint(5.0, playerid, 214.9873,121.0619,999.0156)) //grara¿ PD
        {
            SetPlayerPosEx(playerid,2420.9360,112.8245,29.0433); //taras PD w PC
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            GameTextForPlayer(playerid, "~w~Witamy w garazu", 5000, 1);
            return 1;
        }
		if(IsPlayerInRangeOfPoint(playerid,5,-1693.1406,890.4065,-52.3141))//glowne wyjscie KOMI
		{
			SetPlayerPosEx(playerid,1555.0505, -1675.6409, 16.2821);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
			PlayerInfo[playerid][pLocal] = 255;
		}
		else if (PlayerToPoint(4.0, playerid,246.6659,108.0529,1003.2188)) //Komisariat nowy wyjscie nowe komi
        {
		    SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerPosEx(playerid,2425.6000976563,117.69999694824,26.53); //Komisariat na zewn¹trz (LS)
            GameTextForPlayer(playerid, "~w~Milego dnia", 5000, 1);
            PlayerInfo[playerid][pInt] = 0;
			PlayerInfo[playerid][pLocal] = 255;
            return 1;
        }
		if(IsPlayerInRangeOfPoint(playerid,4,1549.6279, 1113.2629, 124.1937))//baza NG by Dywan
		{
			SetPlayerPosEx(playerid,2785.7568,-2456.2998,13.6342);
			SetPlayerVirtualWorld(playerid,0);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5, -1674.4122,917.7183,-52.4141)) //nowe komi drzwi w celach
		{
			SetPlayerPosEx(playerid, -1674.5769,903.1641,-48.9141); //nowe komi wejscie prawnicze
		}
        else if (PlayerToPoint(2.0, playerid,211.7162,1811.4824,21.8594) && (PlayerInfo[playerid][pJailed] == 0)) //Wejœcie do wiêzienia stanowego
        {
            if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3)
            {
                SetPlayerPosEx(playerid,2730.2300,-2451.1172,17.5937);
                SetPlayerInterior(playerid, 0);
                return 1;
            }
            if(PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pLider] == 2)
            {
                SetPlayerPosEx(playerid,633.6562,-1490.3883,90.6158);
                SetPlayerInterior(playerid, 0);
                SetPlayerVirtualWorld(playerid, 11);
      		    TogglePlayerControllable(playerid, 0);
				Wchodzenie(playerid);
                return 1;
            }
            else
            {
                SetPlayerPosEx(playerid,/*216.3953,120.8046,1003.2188 old komi*/-1606.0139,818.9503,-29.4141); //Wejœcie do wiêzienia stanowego
                GameTextForPlayer(playerid, "~w~Witamy na Komisariacie.", 5000, 1);
                SetPlayerVirtualWorld(playerid,1);
       		    TogglePlayerControllable(playerid, 0);
				Wchodzenie(playerid);
				PlayerInfo[playerid][pLocal] = 210;
                return 1;
            }
        }
        else if (PlayerToPoint(5.0, playerid,319.72470092773, -1548.3374023438, 13.845289230347)) //œrodek kancelarii prawników
        {
            SetPlayerPosEx(playerid,315.4501953125, -1501.822265625, 13.820824623108); //wejœcie Kancelaria prawnicza
            GameTextForPlayer(playerid, "~w~Milego dnia.", 5000, 1);
            return 1;
		}

		//forelli
		else if (PlayerToPoint(5.0, playerid,322.0553894043, 303.41961669922, 999.1484375)) //œrodek biura £owców nagród
        {
            SetPlayerPosEx(playerid,292.85711669922, -1530.8516845703, 13.818398475647); //wejœcie biura £owców nagród
            GameTextForPlayer(playerid, "~w~Milego dnia.", 5000, 1);
            TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            SetPlayerInterior(playerid,0);
            return 1;
		}
		else if (PlayerToPoint(5.0, playerid,301.29656982422, -1515.7513427734, 13.809589385986)) //Biurowiec
        {
            SetPlayerPosEx(playerid,330.6893,-1513.0613,35.8672); //wejœcie do biurowca
            GameTextForPlayer(playerid, "~w~Milego dnia.", 5000, 1);
            return 1;
		}
		else if (PlayerToPoint(5.0, playerid,1964.1326904297, -350.83026123047, 1092.9454345703)) //œrodek kosciol
        {
            SetPlayerPosEx(playerid,2254.8652,-1334.2078,23.9922); //koœció³
            GameTextForPlayer(playerid, "~w~Bog zaplac.", 5000, 1);//wyjscie kosciol
            SetPlayerInterior(playerid,0);
			return 1;
		}
		else if (PlayerToPoint(5.0, playerid, 1526,-1451,64)) // baza bor srodek
		{
		    SetPlayerPosEx(playerid, 1797.99829, -1578.78772, 14.01125); // baza bor wejscie
		    SetPlayerVirtualWorld(playerid, 0);
		    GameTextForPlayer(playerid, "~w~Milego dnia.", 5000, 1);
		    return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1563,-1434,65)) // baza bor dyrekcja srodek
		{
		    SetPlayerPosEx(playerid,1523.0439,-1466.9510,64.7786); // baza dyrekcja wejscie
		    TogglePlayerControllable(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 32);
            Wchodzenie(playerid);
		    return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1163.1424560547,-1343.5803222656,26.667037963867)) // Szpitsal
		{
		    SetPlayerPosEx(playerid, 2289.8876953125,-1206.8327636719,-18.008888244629 ); // Dach szpital
		    TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
            SetPlayerInterior(playerid, 0);
			return 1;
		}
		//SAN NEWS WYBIERALKA
        else if(IsPlayerInRangeOfPoint(playerid,5,648.9127, -1367.4266, 29.2878))//wysjcie z recepcji na zewnatrz
    	{
    	    SetPlayerPosEx(playerid,648.4412, -1357.3232, 13.8579);
    	    SetPlayerVirtualWorld(playerid,0);
    	}
        //miasteczko
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 681.5244140625,-451.8515625,-25.609762191772)) // Bar
		{
		    SetPlayerPosEx(playerid, 682.03063964844,-473.62811279297,16.425407409668); // Bar
		    SetPlayerInterior(playerid, 0);
		}
		else if (IsPlayerInRangeOfPoint(playerid, 3.0, 703.78033447266,-497.16967773438,23.36548614502)) // rada
		{
		    SetPlayerPosEx(playerid, 695.0287,-499.5582,16.3359); // rada srodek
		    SetPlayerVirtualWorld(playerid, 0);
		}
        else if (IsPlayerInRangeOfPoint(playerid, 5.0, 833.66455078125,7.4092292785645,1004.1796875)) //  bank na œrodku miasteczko
		{
		    SetPlayerPosEx(playerid, 648.91735839844,-520.12847900391,16.359306335449 ); // bank na œrodku miasteczko
		    SetPlayerInterior(playerid, 0);
		}
		//micha³owe syfy
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 566.7726,-2087.6841,2.7300)) // basen (g³ówny )wyjœcie
		{
		    SetPlayerPosEx(playerid, 560.6104,-2033.9307,16.1670); // basen (g³ówny )recepcja
		    TogglePlayerControllable(playerid, 10);
            Wchodzenie(playerid);
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 562.2107,-2029.9917,16.167)) // basen tylko dla personelu
		{
		    if(GetPlayerOrg(playerid) == 19)
		    {
			    SetPlayerPosEx(playerid, 598.6794,-2204.8613,1.8190); // bar basenowy
			    TogglePlayerControllable(playerid, 10);
                Wchodzenie(playerid);
                GameTextForPlayer(playerid, "~w~Nieupowaznionym wstep wzbroniony", 5000, 1);
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ upowa¿niony do korzystania z wejœcia dla personelu");
			}
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 528.8655,-2082.5376,17.2253)) // sauna srodek
		{
		    SetPlayerPosEx(playerid, 570.5168,-2095.3618,2.6152 ); // sauna wejscie
    		SetPlayerVirtualWorld(playerid, 30);
		    TogglePlayerControllable(playerid, 0);
            Wchodzenie(playerid);
		}
		/*else if (IsPlayerInRangeOfPoint(playerid, 5.0, 575.5542,-2048.8000,16.1670)) // basen recepcja
		{
		    SetPlayerPosEx(playerid, 1210.552734375,-1749.1850585938,13.593885421753 ); // basen na zewnatrz
		    if(PlayerInfo[playerid][pChar] > 0) { SetPlayerSkin(playerid, PlayerInfo[playerid][pChar]); }
			else { SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]); }
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
		    SetPlayerPosEx(playerid, 1271.0920,-1667.8794,19.7344); //wybieralka fbi
		    SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid,0);
		}
		//wybiera³a san
		//rodzinne gówna
		else if (PlayerToPoint(5.0, playerid, 2317.8201,-1024.7500,1050.2109)) // Full baza
		{
		    SetPlayerPosEx(playerid, 693.9794,-1645.8259,4.0938); // Full wejœcie
		    SetPlayerInterior(playerid, 0);
		    return 1;
		}
		//dynamiczne interiory
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2495.9689941406,-1692.6496582031,1014.7421875)) // Dom na Grove Street
		{
		    SetPlayerPosEx(playerid, 2495.576171875,-1689.9849853516,14.765625); // Dom na Grove Street
		    SetPlayerInterior(playerid, 0);
		    return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 318.75366210938,1115.3836669922,1083.8828125)) //Melina
		{
		    SetPlayerPosEx(playerid, 2165.9409179688,-1671.8609619141,15.074726104736); // Melina
		    SetPlayerInterior(playerid, 0);
		    return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 772.41839599609,-4.6863260269165,1000.7291259766)) // Si³ownia
		{
		    SetPlayerPosEx(playerid, 2229.2248535156,-1721.9586181641,13.567801475525); // Si³ownia
		    SetPlayerInterior(playerid, 0);
		    return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 372.16430664063,-132.97666931152,1001.4921875)) // Pizzeria
		{
		    SetPlayerPosEx(playerid, 2104.4970703125,-1806.3927001953,13.5546875); // Pizzeria
		    SetPlayerInterior(playerid, 0);
		    return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2352.0139160156,-1180.8870849609,1027.9765625)) // Dom na Las Collinas
		{
		    SetPlayerPosEx(playerid, 2351.8894042969,-1169.4614257813,28.001684188843); // Dom na Las Collinas
		    SetPlayerInterior(playerid, 0);
		    return 1;
		}
		else if(PlayerToPoint(10.0, playerid, -2637.69,1404.24,906.46))
	    {
	        SetPlayerInterior(playerid,0);
	        SetPlayerPosEx(playerid, 931.09,919.29,42.59);
	        GameTextForPlayer(playerid, "~w~Wroc do nas!", 5000, 1);
	        return 1;
	    }
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1701.4025878906,-1667.9442138672,20.21875)) // Muzeum sztuki wspó³czesnej
		{
		    SetPlayerPosEx(playerid, 1698.8944091797,-1667.6840820313,20.194225311279); // Muzeum sztuki wspó³czesnej
		    SetPlayerInterior(playerid, 0);
		    return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1727.076171875,-1638.8159179688,20.223419189453)) // Muzeum sztuki wspó³czesnej 2
		{
		    SetPlayerPosEx(playerid, 1727.1125488281,-1635.5847167969,20.216684341431); // Muzeum sztuki wspó³czesnej  2
		    SetPlayerInterior(playerid, 0);
		    return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, -204.0638885498,-9.17,1002.2734)) //  tatuaz new sro
		{
		    SetPlayerPosEx(playerid,2292.3088,-1723.3538,13.5469); //  tatuaz new wej
		    SetPlayerInterior(playerid, 0);
		    GameTextForPlayer(playerid, "Zapraszamy ponownie", 5000, 1);
		    return 1;
		}
		//baza bor by abram01
		else if(IsPlayerInRangeOfPoint(playerid,3,1448.5902, -1556.4595, 67.4875))
		{
			SetPlayerPosEx(playerid,1481.3147, -1534.9988, 69.8184);
			SetPlayerVirtualWorld ( playerid, 80);
        	return 1;
		}
	    else if(IsPlayerInRangeOfPoint(playerid,3,1503.9996, -1557.6985, 67.4117))
		{
			SetPlayerPosEx(playerid,1478.0399, -1535.3342, 69.8184);
			SetPlayerVirtualWorld ( playerid, 80);
        	return 1;
		}
	    else if(IsPlayerInRangeOfPoint(playerid,3,1535.8995, -1553.6477, 67.2323))
		{
			SetPlayerPosEx(playerid,1475.4584, -1535.0698, 69.8184);
			SetPlayerVirtualWorld ( playerid, 80);
        	return 1;
		}
  	 	else if(IsPlayerInRangeOfPoint(playerid,3,1498.5720, -1450.9031, 64.7241))
		{
			SetPlayerPosEx(playerid,1518.8984, -1452.5093, 14.4603);
			SetPlayerVirtualWorld ( playerid, 0);
        	return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1509.3000488281,-1752.9000244141,13.5)) // TUNEL - dmv
		{
		    SetPlayerPosEx(playerid, 1517.80004,-1480.5,9.5); // TUNEL - bor
		    GameTextForPlayer(playerid, "~b~Tajemnicza Budka", 5000, 1);
		    return 1;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 1412.6382,-1800.7056,15.43560)) // Plac manewrowy srodek
		{
		    SetPlayerPosEx(playerid, 1442.0717,-1811.6309,77.9453); // Plac manewrowy wyjscie
			GameTextForPlayer(playerid, "~w~Witamy po egzaminie!", 5000, 1);
			PlayerInfo[playerid][pLocal] = 108;
			TogglePlayerControllable(playerid, 0);
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid,50);
            Wchodzenie(playerid);
		    return 1;
		}
		/*else if(IsPlayerInRangeOfPoint(playerid, 5, 819.4210, -1382.6415, 26.1157))
		{
			SetPlayerPosEx(playerid,561.7242,-1506.8630,14.5496);
			GameTextForPlayer(playerid, "~w~Jesteœ pijany?~n~~y~/wezwij taxi", 5000, 1);
			new Hour,Minutes,Seconds;
			gettime(Hour,Minutes,Seconds);
			SetPlayerTime(playerid,Hour,Minutes);
			new weather = GetServerVarAsInt("weather");
			SetPlayerWeather(playerid,weather);
			StopAudioStreamForPlayer(playerid);
			SetPlayerVirtualWorld(playerid,0);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 817.4785, -1383.6086, 35.9391))
		{
			SetPlayerPosEx(playerid, 819.5079, -1376.9327, 26.1157);
			SetPlayerWeather(playerid,2);
			SetPlayerTime(playerid,14,0);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 829.9050, -1364.0845, 26.2828))
		{
			SetPlayerPosEx(playerid, 825.1359, -1373.6002, 36.5962);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 828.1592, -1374.5605, 26.0091)) //Do biura
		{
			SetPlayerPosEx(playerid, 821.9205, -1345.3864, 37.5569);
			SetPlayerVirtualWorld(playerid,3);
			TogglePlayerControllable(playerid,0);
            Wchodzenie(playerid);
		}*/
		else if (IsPlayerInRangeOfPoint(playerid, 5.0, 2371.5246582031, 586.56274414063, 4893.2431640625)) // Pokój przes³uchañ sro
		{
		    if(IsACop(playerid))
		    {
			    SetPlayerPosEx(playerid, 276.32934570313,122.20029449463,1004.1166992188); // Pokój przes³uchañ wejs
			    return 1;
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Tylko dla policjantów i zakutych wiêŸniów. Chyba nie chcesz uciec PD?");
			}
		}
        //IBIZA
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1892.9077,-2451.8071,21.6559) && GetPlayerVirtualWorld(playerid) == 1)
    	{
    		if(!IbizaDach) return sendTipMessageEx(playerid, 0xB52E2BFF, "Wyjœcie na dach jest zamkniête");
    		SetPlayerPosEx(playerid, 397.6700,-1811.8844,14.7359);
    		SetPlayerFacingAngle(playerid, 182.1396);
    		SetPlayerVirtualWorld(playerid, 0);
    		SetPVarInt(playerid, "IbizaWejdz", 0);
    		StopAudioStreamForPlayer(playerid);
    		IbizaWyjscie(playerid);
    		return 1;

    	}
    	//wyjœcie bileterki
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 397.6174,-1806.2030,7.8381) && GetPlayerOrg(playerid) == FAMILY_IBIZA && GetPlayerVirtualWorld(playerid) == 0) //RANGA
    	{
    		TogglePlayerControllable(playerid, false);
    		SetPlayerPosEx(playerid, 1740.5719,-2471.0737,14.2266);
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
    		SetPlayerPosEx(playerid, 400.8845,-1805.9010,7.8281);
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
    		SetPlayerPosEx(playerid, 394.2784,-1805.9104,7.8302);
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
    		SetPlayerPosEx(playerid, 1761.7330,-2471.2756,19.7275);
    		SetPlayerFacingAngle(playerid, 90.0);
    		PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID], 1942.0912,-2468.7349,15.5266, 250.0, 1);
            Wchodzenie(playerid);
    		return 1;
    	}
    	// BAR - wyjscie
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1900.5961,-2494.9373,13.6266) && PlayerInfo[playerid][pRank] && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerOrg(playerid) == FAMILY_IBIZA) //RANGA
    	{
    		SetPlayerPosEx(playerid, 1898.4817,-2494.8752,13.6266);
    		SetPlayerFacingAngle(playerid, 271.3850);
    		return 1;
    	}
    	// Dyrekcja - wyjscie
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1911.4484,-2466.0842,17.9850) && GetPlayerVirtualWorld(playerid) == 1)
    	{
    		if(!IbizaBiuro) return sendTipMessageEx(playerid, 0xB52E2BFF, "Biuro jest w tej chwili zamkniête");
    		SetPlayerPosEx(playerid, 1915.1454,-2468.3472,15.4266);
    		SetPlayerFacingAngle(playerid, 270.0);
    		PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID]);
            Wchodzenie(playerid);
    		return 1;
    	}
    	//wyjœcie boczne
    	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1917.3785,-2465.4368,15.4266) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerOrg(playerid) == FAMILY_IBIZA) //RANGA
    	{
    		SetPlayerPosEx(playerid, 386.2871,-1817.9784,7.8410);
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
    		SetPlayerPosEx(playerid, 1910.2588,-2474.8745,13.6266);
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
    		SetPlayerPosEx(playerid, 1906.1383,-2474.4417,13.6266);
    		SetPlayerFacingAngle(playerid, 180.0);
    		SetPlayerVirtualWorld(playerid, 1);
    		DeletePVar(playerid, "IbizaKibel");
    		if(!IbizaSwiatla) WylaczSwiatlaP(playerid);
    		else WlaczSwiatlaP(playerid);
    		PlayAudioStreamForPlayer(playerid, IbizaStream[IbizaStreamID]);
    		return 1;
    	}
        //VINYL wyjdz
        else if (IsPlayerInRangeOfPoint(playerid,3.0,808.3142, -1381.9436, 23.6518))
        {
            DeletePVar(playerid, "Vinyl-bilet");
            DeletePVar(playerid, "Vinyl-VIP");
            SetPlayerPosEx(playerid, 816.0470, -1386.3253, 13.6114 );
            SetPlayerVirtualWorld(playerid, 0);
            GameTextForPlayer(playerid, "~w~Pijany? Wezwij taryfe", 5000, 1);
            SetPVarInt(playerid, "VINYL-stream", 0);
            StopAudioStreamForPlayer(playerid);
        }
        else if (IsPlayerInRangeOfPoint(playerid,3.0,816.4282, -1376.2659, 23.6518))
        {
            SetPlayerPosEx(playerid, 815.4965, -1377.1671, 23.6518);
            SetPlayerVirtualWorld(playerid, 255);
            GameTextForPlayer(playerid, "~w~Zapraszamy ponownie", 5000, 1);
            Wchodzenie(playerid);
        }
        else if (IsPlayerInRangeOfPoint(playerid,2.0,830.5424, -1375.1467, 27.8467))
        {
            SetPlayerPosEx(playerid,830.4240, -1376.2208, 27.8467);
            SetPlayerVirtualWorld(playerid, 255);
            GameTextForPlayer(playerid, "~w~Zacny Pan wyszedl", 5000, 1);
            Wchodzenie(playerid);
        }
        else if (IsPlayerInRangeOfPoint(playerid,3.0,823.3508, -1349.5614, 24.7971) && GetPlayerOrg(playerid) == FAMILY_VINYL)
        {
            SetPlayerPosEx(playerid,813.2293, -1349.5438, 23.6597);
            SetPlayerVirtualWorld(playerid, 255);
            GameTextForPlayer(playerid, "~w~Koniec Imprezy", 5000, 1);
            Wchodzenie(playerid);
        }
        //AirTower LS
        else if (IsPlayerInRangeOfPoint(playerid,3.0,1627.3157,-2279.6157,75.0))
        {
            INT_AirTowerLS_Exit(playerid, false, true);
            SetPlayerPosEx(playerid,1635.3210, -2286.5698, 13.4162);
        }
        else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1763.4243, -1128.0543, 224.1499))//Wyjœcie
		{
        	SetPlayerPosEx(playerid, 1763.4033, -1129.7128, 24.0859);
        	SetPlayerVirtualWorld(playerid, 0);
			GameTextForPlayer(playerid, "~w~Zapraszamy ponownie!", 5000, 1);
		}
		else
		{
		    Wyjdz(playerid, 1285.5999755859,-981.79998779297,32.700000762939, 1300.0999755859,-1094.5999755859,5972.2001953125, 5.0);//int z flagami
		    Wyjdz(playerid, 1302.8000488281,-988.20001220703,38.299999237061, 1301.8000488281,-1083.9000244141,5972.2001953125, 5.0);//g³ówne wejœcie
		    Wyjdz(playerid, -1716.1999511719,1018.200012207,17.60000038147, -1825.4000244141,1151.6999511719,6803.2998046875, 5.0);//WEJSCIE DO KRYJOWKI
		    Wyjdz(playerid, -1858.3000488281,1158.3000488281,6799, -1865.6999511719,1116.8000488281,6799.10009765, 2.0);//drzwi 1
			Wyjdz(playerid, -1858.5,1160.5999755859,6799, -1877.1999511719,1178,6799.2998046875, 2.0);//drzwi 2
			
			//BIZNESY
            for(new i=0;i<MAX_BIZNES;i++)
			{
				WyjdzInt(playerid, BizData[i][eBizWyjX],BizData[i][eBizWyjY],BizData[i][eBizWyjZ], BizData[i][eBizWejX],BizData[i][eBizWejY],BizData[i][eBizWejZ], 3.0, BizData[i][eBizInt], BizData[i][eBizVw]);//biz 1
			}
            //BIZNESY END

			for(new i; i<=MAX_NrDOM; i++)
		    {
				if(IsPlayerInRangeOfPoint(playerid, 5.0, IntInfo[i][Int_X], IntInfo[i][Int_Y], IntInfo[i][Int_Z]))
				{
                    new deem = PlayerInfo[playerid][pDomWKJ];
			        SetPlayerPosEx(playerid, Dom[deem][hWej_X], Dom[deem][hWej_Y], Dom[deem][hWej_Z]);
			        SetPlayerInterior(playerid, 0);
			        SetPlayerVirtualWorld(playerid, 0);
			        PlayerInfo[playerid][pDomWKJ] = 0;
			        SetPlayerTime(playerid, PlayerInfo[playerid][pDomT], 0);
        			PlayerInfo[playerid][pDomT] = 0;
			        GameTextForPlayer(playerid, "~g~Opusciles dom", 5000, 1);
			        return 1;
                }
			}
		}
		if(KradniecieWozu[playerid] >= 1 && IsPlayerInAnyVehicle(playerid) && PlayerCuffed[playerid] == 0)
		{
			TogglePlayerControllable(playerid, 1);
			RemovePlayerFromVehicleEx(playerid);
			KradniecieWozu[playerid] = 0;
			return 1;
		}
        else if(HireCar[playerid] >= 1 && IsPlayerInAnyVehicle(playerid) && PlayerCuffed[playerid] == 0)
		{
			TogglePlayerControllable(playerid, 1);
			RemovePlayerFromVehicleEx(playerid);
			HireCar[playerid] = 0;
			return 1;
		}
	}
	return 1;
}

