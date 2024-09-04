//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ brama ]-------------------------------------------------//
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

YCMD:brama(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(SprawdzBramy(playerid))
			return 1;
        if(IsPlayerInFraction(playerid, FRAC_ERS, 5000)) //bramy LSFD
        {
            if (IsPlayerInRangeOfPoint(playerid, 9.0, 1712.68005, -1141.50000, 24.27000))
            {
    			switch(bramyfd[0])
    			{
    			    case 0: //otwieranie
    		 		{
						MoveDynamicObject(bramafd[0], 1712.68005, -1141.50000, 27.41000, 1.77, 0.00000, 77.00000, 90.00000);//Otwieranie szybsze ze wzgl?du na wyjazd na akcje
						bramyfd[0] = true;
    				}
    				case 1: //zamykanie
    				{
						MoveDynamicObject(bramafd[0], 1712.68005, -1141.50000, 25.27000, 0.71, 0.00000, 0.00000, 90.00000);//Zamykanie wolniejsze ze wzgl?du na mo?liwe zaklinowanie si? pojazdu
						bramyfd[0] = false;
    				}
    			}
    		}

    		else if (IsPlayerInRangeOfPoint(playerid, 9.0, 1729.71997, -1141.50000, 25.27000))
    		    switch(bramyfd[1])
    			{
    			    case 0:
    		 		{
						MoveDynamicObject(bramafd[1], 1729.71997, -1141.50000, 27.41000, 1.77, 0.00000, 77.00000, 90.00000);
						bramyfd[1] = true;
    				}
    				case 1:
    				{
						MoveDynamicObject(bramafd[1], 1729.71997, -1141.50000, 25.27000, 0.71, 0.00000, 0.00000, 90.00000);
						bramyfd[1] = false;
    				}
    			}
    		else if (IsPlayerInRangeOfPoint(playerid, 9.0, 1746.76001, -1141.50000, 25.27000))
			{
    		    switch(bramyfd[2])
    		    {
    		        case 0:
    		    	{
						MoveDynamicObject(bramafd[2], 1746.76001, -1141.50000, 27.41000, 1.77, 0.00000, 77.00000, 90.00000);
						bramyfd[2] = true;
    				}
    				case 1:
    				{
						MoveDynamicObject(bramafd[2], 1746.76001, -1141.50000, 25.27000, 0.71, 0.00000, 0.00000, 90.00000);
						bramyfd[2] = false;
    			    }
    			}
			}
    		else if (IsPlayerInRangeOfPoint(playerid, 3.0, 1703.37000, -1131.09998, 23.06920))
			{
    		    switch(bramyfd[3])
    		    {
    		        case 0:
    		    	{
						MoveDynamicObject(bramafd[3], 1703.37000, -1131.09998, 23.06920, 1.77, 0.00000, 0.00000, 187.00000);
						bramyfd[3] = true;
    				}
    				case 1:
    				{
						MoveDynamicObject(bramafd[3], 1703.37000, -1131.09998, 23.06920, 0.71, 0.00000, 0.00000, 270.00000);
						bramyfd[3] = false;
    			    }
    			}
			}
            else if (IsPlayerInRangeOfPoint(playerid, 1.0, 1763.46000, -1116.97290, 224.47000))
			{
    		    switch(bramyfd[4])
    		    {
    		        case 0:
    		    	{
    			    MoveDynamicObject(bramafd[4], 1764.19995, -1116.97290, 224.47000, 0.71, 0.00000, 0.00000, 97.00000);
    			    bramyfd[4] = true;
    				}
    				case 1:
    				{
    			    MoveDynamicObject(bramafd[4], 1764.19995, -1116.97290, 224.47000, 0.71, 0.00000, 0.00000, 180.00000);
    			    bramyfd[4] = false;
    			    }
    			}
			}
    		else if (IsPlayerInRangeOfPoint(playerid, 1.0, 1764.33105, -1118.37000, 224.47000))
    		    switch(bramyfd[5])
    		    {
    		        case 0:
    		    	{
    			    MoveDynamicObject(bramafd[5], 1764.33105, -1117.38000, 224.47000, 0.71, 0.00000, 0.00000, 317.00000);
    			    bramyfd[5] = true;
    				}
    				case 1:
    				{
    			    MoveDynamicObject(bramafd[5], 1764.33105, -1117.38000, 224.47000, 0.71, 0.00000, 0.00000, 270.00000);
    			    bramyfd[5] = false;
    			    }
    			}
        }
        //S?D bramy
        if(IsPlayerInFraction(playerid, FRAC_BOR, 5000))
        {

			if(IsPlayerInRangeOfPoint(playerid,9,1310.15649, -1384.96997, 13.20500))
        	{
         		if(GATE_SAD[39] == 0)
        		{
          			MoveDynamicObject(GATE_SAD[19], 1310.18359, -1384.99634, 12.1610, 1,  0.0000, 0.00000, 0.00000);
          			MoveDynamicObject(GATE_SAD[20], 1311.99561, -1384.99634, 12.1610, 1,  0.0000, 0.00000, 0.00000);
          			MoveDynamicObject(GATE_SAD[21], 1308.37158, -1384.99634, 12.1610, 1,  0.0000, 0.00000, 0.00000);
          			GATE_SAD[39] = 1;
        		}
        		else
        		{
        			MoveDynamicObject(GATE_SAD[19], 1310.18359, -1384.99634, 13.27060, 1,  0.0000, 0.00000, 0.00000);
          			MoveDynamicObject(GATE_SAD[20], 1311.99561, -1384.99634, 13.27060, 1,  0.0000, 0.00000, 0.00000);
          			MoveDynamicObject(GATE_SAD[21], 1308.37158, -1384.99634, 13.27060, 1,  0.0000, 0.00000, 0.00000);
          			GATE_SAD[39] = 0;
        		}
        		return 1;
        	}
  
            else if(IsPlayerInRangeOfPoint(playerid,7.0,1270.69995, -1344.80005, 13.10000))
        	{
         		if(GATE_ORGSAD_S[0])
        		{
          			MoveDynamicObject(GATE_ORGSAD[0], 1270.69995, -1344.80005, 13.10000, 0.01,  0.00000, 90.00000, 90.00000);
                    GATE_ORGSAD_S[0] = false;
        		}
        		else
        		{
          			MoveDynamicObject(GATE_ORGSAD[0], 1270.69995, -1344.80005, 13.11000, 0.01,  0.0000, 15.0, 90.0000);
                    GATE_ORGSAD_S[0] = true;
        		}
        	}
            if(IsPlayerInRangeOfPoint(playerid,7.0,1270.69995, -1330.50000, 13.10000))
        	{
         		if(GATE_ORGSAD_S[1])
        		{
          			MoveDynamicObject(GATE_ORGSAD[1], 1270.69995, -1330.50000, 13.10000, 0.01, 0.00000, 90.00000, 270.00000);
                    GATE_ORGSAD_S[1] = false;
        		}
        		else
        		{
          			MoveDynamicObject(GATE_ORGSAD[1], 1270.69995, -1330.50000, 13.11000, 0.01, 0.0000, 15.0000, 270.0000);
                    GATE_ORGSAD_S[1] = true;
        		}
        		return 1;
        	}
        }
        //Bramy FDU
        if(IsAMechazordWarsztatowy(playerid))
        {
            if(IsPlayerInRangeOfPoint(playerid,10,1074.1450, -1205.0692, 18.6206))
        	{
         		if(Brama_FDU_Move[0] == 0)
        		{
          			MoveDynamicObject(Brama_FDU[0], 1074.1450, -1198.1892, 18.6206, 2,  0.0000, 0.00000, 90.00000);
          			Brama_FDU_Move[0] = 1;
        		}
        		else
        		{
          			MoveDynamicObject(Brama_FDU[0], 1074.1450, -1205.0692, 18.6206, 2,  0.00000, 0.00000, 90.00000);
          			Brama_FDU_Move[0]  = 0;
        		}
        		return 1;
        	}
        	if(IsPlayerInRangeOfPoint(playerid,10,1121.4536, -1159.7131, 25.5400))
        	{
         		if(Brama_FDU_Move[1] == 0)
        		{
          			MoveDynamicObject(Brama_FDU[1], 1127.7115, -1159.7131, 25.5400, 2,  0.0000, 0.00000, 0.00000);
          			Brama_FDU_Move[1] = 1;
        		}
        		else
        		{
          			MoveDynamicObject(Brama_FDU[1], 1121.4536, -1159.7131, 25.5400, 2,  0.00000, 0.00000, 0.00000);
          			Brama_FDU_Move[1]  = 0;
        		}
        		return 1;
        	}
        	if(IsPlayerInRangeOfPoint(playerid,10,1111.9348, -1236.7568, 17.7250))
        	{
         		if(Brama_FDU_Move[2] == 0)
        		{
          			MoveDynamicObject(Brama_FDU[2], 1109.9968, -1236.7568, 20.4540, 2,  0.0000, 270.00000, 0.00000);
          			Brama_FDU_Move[2] = 1;
        		}
        		else
        		{
          			MoveDynamicObject(Brama_FDU[2], 1111.9348, -1236.7568, 17.7250, 2,  0.00000, 0.00000, 0.00000);
          			Brama_FDU_Move[2]  = 0;
        		}
        		return 1;
        	}
        }
        //Bramy HA
        if(IsPlayerInFraction(playerid, FRAC_HA, 5000))
        {
            if(IsPlayerInRangeOfPoint(playerid,15.0, -75.8421, -347.3001, 3.1407))
        	{
         		if(Brama_Move_HA == 0)
        		{
        	     	MoveDynamicObject(Brama_HA, -75.8421, -340.4661, 3.1407, 2,  0.0000, 0.00000, 90.00000);
        	     	MoveDynamicObject(Brama_HA1, -75.8332, -365.2261, 3.1407, 2,  0.0000, 0.00000, 270.00000);
        			Brama_Move_HA = 1;
        		}
        		else
        		{
          			MoveDynamicObject(Brama_HA, -75.8421, -347.3001, 3.1407, 2,  0.00000, 0.00000, 90.00000);
          			MoveDynamicObject(Brama_HA1, -75.8332, -358.8341, 3.1407, 2,  0.0000, 0.00000, 270.00000);
        			Brama_Move_HA  = 0;
        		}
        		return 1;
        	}
        	if(IsPlayerInRangeOfPoint(playerid,5.0, -60.3850000,-227.3999900,5.7300000))
        	{
         		if(Brama_Move_HA1 == 0)
        		{
        	     	SetDynamicObjectRot(Brama_HA2,0,0,90);
        			Brama_Move_HA1 = 1;
        		}
        		else
        		{
          			SetDynamicObjectRot(Brama_HA2,0,0,0);
        			Brama_Move_HA1  = 0;
        		}
        		return 1;
        	}
        }
		if(PlayerInfo[playerid][pLider] == 16 || PlayerInfo[playerid][pMember] == 16)//WPS klub bonehead bramy
		{
			if(IsPlayerInRangeOfPoint(playerid,3,2433.3701, -1944.1500, 119.7100))
			{
				if(SkinBramaMove[0] == 0)
				{
					SetDynamicObjectRot(SkinBrama[0],0,0,0);
					SkinBramaMove[0] = 1;
				}
				else
				{
					SetDynamicObjectRot(SkinBrama[0],0,0,270);
					SkinBramaMove[0] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,2449.4910, -1953.6609, 119.7700))
			{
				if(SkinBramaMove[1] == 0)
				{
					SetDynamicObjectRot(SkinBrama[1],0,0,90);
					SkinBramaMove[1] = 1;
				}
				else
				{
					SetDynamicObjectRot(SkinBrama[1],0,0,0);
					SkinBramaMove[1] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,2442.8127, -1981.5231, 123.4490))
			{
				if(SkinBramaMove[2] == 0)
				{
					SetDynamicObjectRot(SkinBrama[2],0,0,90);
					SkinBramaMove[2] = 1;
				}
				else
				{
					SetDynamicObjectRot(SkinBrama[2],0,0,0);
					SkinBramaMove[2] = 0;
				}
			}
		}
		if(PlayerInfo[playerid][pLider] == 5 || PlayerInfo[playerid][pMember] == 5 || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(PlayerToPoint(10.0, playerid, -792.44158935547, 495.30035400391, 1370.7421875))
			{
				if(BramaLCN2 == 1)
				{
				  MoveDynamicObject(BramaLCN, -792.44158935547, 495.30035400391, 1370.7521874, 2.5, 0, 0, 90);
			      SetDynamicObjectRot(BramaLCN, 0, 0, 90);
			      BramaLCN2 = 0;
				  PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
				}
				else
				{
				  MoveDynamicObject(BramaLCN, -792.44158935547, 495.30035400391, 1370.7421875, 2.5, 0, 0, 0);
                  SetDynamicObjectRot(BramaLCN, 0, 0, 0);
				  BramaLCN2 = 1;
				  PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
				}
			}
		}
		if (PlayerInfo[playerid][pAdmin] >= 1000 || GetPlayerOrg(playerid) == 16)//warsztat niebieski
		{
			if(IsPlayerInRangeOfPoint(playerid, 20, 2313.5000000,-1217.6999512,24.7000008) || IsPlayerInRangeOfPoint(playerid, 12, 2313.5000000,-1217.6999512,24.7000008))
			{
				if(bramadom1State == 0)
				{
					MoveDynamicObject(bramadom1, 2315.8184, -1217.8220, 25.6250, 2,  0.0000, 84.0000, 180.0000);
					bramadom1State = 1;
					ApplyAnimation(playerid,"PED","bomber",4.1,0,0,0,0,0);
				}
				else
				{
					MoveDynamicObject(bramadom1, 2313.5461, -1218.0405, 23.9090, 2,  0.00000, 00.00000, 180.00000);
					bramadom1State  = 0;
					ApplyAnimation(playerid,"PED","bomber",4.1,0,0,0,0,0);
				}
			}
		}
        if(PlayerInfo[playerid][pLider] == 9 || PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pAdmin] >= 3000)
		{
            if(IsPlayerInRangeOfPoint(playerid,3,657.5705, -1353.2709, 29.1975))//recepcja
        	{
        	    if(SanMove1 == 0)
        	    {
        	        MoveDynamicObject(SanDrzwi1,657.5705, -1353.2709, 29.1975+0.01,0.01,0,0,90);
        	        SanMove1 = 1;
        	    }
        	    else
        	    {
        	        MoveDynamicObject(SanDrzwi1,657.5705, -1353.2709, 29.1975-0.01,0.01,0,0,0);
        	        SanMove1 = 0;
        	    }
        	}
        	if(IsPlayerInRangeOfPoint(playerid,3, 664.42480, -1341.17322, 28.37660))//victim studio
        	{
        	    if(SanMove2 == 0)
        	    {
        	        MoveDynamicObject(SanDrzwi2,664.42480, -1341.17322, 28.37660+0.01,0.01,0,0,0);
        	        MoveDynamicObject(SanDrzwi3,664.42480, -1338.17200, 28.37660+0.01,0.01,0,0,0);
        	        SanMove2 = 1;
        	    }
        	    else
        	    {
        	        MoveDynamicObject(SanDrzwi2,664.42480, -1341.17322, 28.37660-0.01,0.01,0,0,90);
        	        MoveDynamicObject(SanDrzwi3,664.42480, -1338.17200, 28.37660-0.01,0.01,0,0,270);
        	        SanMove2 = 0;
        	    }
        	}
        	if(IsPlayerInRangeOfPoint(playerid,3, 737.24872, -1373.13220, 33.96040))//sale konf
        	{
        	    if(SanMove3 == 0)
        	    {
        	        MoveDynamicObject(SanDrzwi4,737.24872, -1373.13220, 33.96040+0.01,0.01,0,0,90);
        	        SanMove3 = 1;
        	    }
        	    else
        	    {
        	        MoveDynamicObject(SanDrzwi4,737.24872, -1373.13220, 33.96040-0.01,0.01,0,0,0);
        	        SanMove3 = 0;
        	    }
        	}
        	if(IsPlayerInRangeOfPoint(playerid,3, 741.80212, -1368.57654, 33.96040))//sale konf
        	{
        	    if(SanMove4 == 0)
        	    {
        	        MoveDynamicObject(SanDrzwi5,741.80212, -1368.57654, 33.96040+0.01,0.01,0,0,180);
        	        SanMove4 = 1;
        	    }
        	    else
        	    {
        	        MoveDynamicObject(SanDrzwi5,741.80212, -1368.57654, 33.96040-0.01,0.01,0,0,270);
        	        SanMove4 = 0;
        	    }
        	}
        }
		if(PlayerInfo[playerid][pLider] == 7 || PlayerInfo[playerid][pMember] == 7)
		{
			if(IsPlayerInRangeOfPoint(playerid,3,1501.6648, -1452.1390, 63.3306))
			{
				if(bormove == 0)
				{
					MoveDynamicObject(bor, 1501.6646, -1450.7420, 63.3306, 1,  0.00000, 00.00000, 270.00000);
					bormove = 1;
				}
				else
				{
					MoveDynamicObject(bor, 1501.6648, -1452.1390, 63.3306, 1,  0.00000, 0.00000, 270.00000);
					bormove  = 0;
				}
				return 1;
			}
			if(IsPlayerInRangeOfPoint(playerid,3,1513.57556, -1468.74573, 66.82270))
			{
				if(bormove1 == 0)
				{
					MoveDynamicObject(bor1, 1513.5756, -1469.6897, 66.8227, 1,  0.00000, 00.00000, 90.00000);
					bormove1 = 1;
				}
				else
				{
					MoveDynamicObject(bor1, 1513.57556, -1468.74573, 66.82270, 1,  0.00000, 0.00000, 90.00000);
					bormove1  = 0;
				}
				return 1;
			}
		}
		//brama do konfesjona?u
     	if(IsPlayerInRangeOfPoint(playerid,3,1957.14050, -361.36722, 1092.92456))//KO?CI?!
 		{
	        if(kosmove == 0)
	        {
	            MoveDynamicObject(kos, 1957.1405, -361.3672, 1090.5646, 1,  0.00000, 0.00000, 90.00000);
	            kosmove = 1;
			}
			else
			{
			    MoveDynamicObject(kos, 1957.14050, -361.36722, 1092.92456, 1,  0.00000, 0.00000, 90.00000);
			    kosmove  = 0;
			}
			return 1;
    	}
     	else if(IsPlayerInRangeOfPoint(playerid,3,1970.5963, -361.2964, 1092.9246))
 		{
	        if(kos2move == 0)
	        {
	            MoveDynamicObject(kos2, 1970.5963, -361.2964, 1090.5646, 1,  0.00000, 0.00000, 90.00000);
	            kos2move = 1;
			}
			else
			{
			    MoveDynamicObject(kos2, 1970.5963, -361.2964, 1092.9246, 1,  0.00000, 0.00000, 90.00000);
			    kos2move  = 0;
			}
			return 1;
    	}//koniec bramy do konfesjona?u
		/*if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1 || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(PlayerToPoint(20.0, playerid, 1544.6816, -1630.8596, 12.9796))
			{
				if(SzlabanPolicjaState == 1)
				{
					MoveDynamicObject(SzlabanPolicja, 1544.6816, -1630.8596, 12.9796, 2, 0, 3.4377, 89.3814);
					SzlabanPolicjaState = 0;
					PlayerPlaySound(playerid, 1039, 0.0, 0.0, 0.0);
				}
				else
				{
					MoveDynamicObject(SzlabanPolicja, 1544.6816, -1630.8596, 12.9796, 2, 0, 87.6625, 89.3814);
					SzlabanPolicjaState = 1;
					PlayerPlaySound(playerid, 1039, 0.0, 0.0, 0.0);
				}
			}
		}
		if(IsAPolicja(playerid) || IsAHA(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(PlayerToPoint(25.0, playerid, 1595.4099, -1638.2567, 14.0207) || PlayerToPoint(10.0, playerid, 1588.5547, -1638.2567, 14.0207))
			{
				if(BramaPolicjaState == 1)
				{
					MoveDynamicObject(BramaPolicja, 1597.4099, -1638.2567, 14.4305, 2.5);
					BramaPolicjaState = 0;
					//PlayerPlaySound(playerid, 1153, 0.0, 0.0, 0.0);
					//SetTimerEx("StopBrama",3500,0,"d",playerid);
				}
				else
				{
					MoveDynamicObject(BramaPolicja, 1589.0277099609, -1638.2808837891, 14.430500030518, 2.5);
					BramaPolicjaState = 1;
					//PlayerPlaySound(playerid, 1153, 0.0, 0.0, 0.0);
					//SetTimerEx("StopBrama",3500,0,"d",playerid);
				}
			}
		}*/
		//stary komisariat (old komi)
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(PlayerToPoint(5.0, playerid, 253.18164062,108.04980469,1002.21875000))
			{
				if(DrzwiPDKomiS == 1)
				{
					MoveDynamicObject(DrzwiPDKomi, 253.18164062,106.97,1002.21875000, 2.5);
					DrzwiPDKomiS = 0;
				}
				else
				{
					MoveDynamicObject(DrzwiPDKomi, 253.18164062,108.04980469,1002.21875000, 2.5);
					DrzwiPDKomiS = 1;
				}
			}
		}
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(PlayerToPoint(5.0, playerid, 253.22167969,124.16796875,1002.21875000))
			{
				if(DrzwiPDKomi2S == 1)
				{
					MoveDynamicObject(DrzwiPDKomi2, 253.22167969,123.12,1002.21875000, 2.5);
					DrzwiPDKomi2S = 0;
				}
				else
				{
					MoveDynamicObject(DrzwiPDKomi2, 253.22167969,124.16796875,1002.21875000, 2.5);
					DrzwiPDKomi2S = 1;
				}
			}
		}
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(PlayerToPoint(5.0, playerid, 238.32324219,119.16503906,1002.21875000))
			{
				if(DrzwiPDKomi3S == 1)
				{
  					SetDynamicObjectRot(DrzwiPDKomi3, 0, 0, 90);
					DrzwiPDKomi3S = 0;
				}
				else
				{
  					SetDynamicObjectRot(DrzwiPDKomi3, 0, 0, 180);
					DrzwiPDKomi3S = 1;
				}
			}
		}
		if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(PlayerToPoint(5.0, playerid, 220.67187500,118.53125000,1010.50921631))
			{
				if(DrzwiPDKomi4S == 1)
				{
  					SetDynamicObjectRot(DrzwiPDKomi4, 0, 0, 0);
					DrzwiPDKomi4S = 0;
				}
				else
				{
  					SetDynamicObjectRot(DrzwiPDKomi4, 0, 0, 270);
					DrzwiPDKomi4S = 1;
				}
			}
		}
		//nowe komi bramy
		// if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1 || PlayerInfo[playerid][pAdmin] >= 5000)
		// {
		// 	if(IsPlayerInRangeOfPoint(playerid,3,-1670.9452,915.7548,-52.4141))
		// 	{
		// 		if(lspdmove13 == 0)
		// 		{
		// 			MoveDynamicObject(bramalspd13,-1671.5000, 922.4590, -49.8000,3,0,0,90);
		// 			lspdmove13 = 1;
		// 		}
		// 		else
		// 		{
		// 			MoveDynamicObject(bramalspd13, -1671.50, 918.00, -49.80,3,0,0,90);
		// 			lspdmove13 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,2.0,-1673.90, 876.96, -49.90))
		// 	{
		// 		if(lspdmove1 == 0)
		// 		{
		// 			new Float:xy,Float:yy;
		// 			SetDynamicObjectRot(bramalspd1,xy,yy,0);
		// 			lspdmove1 = 1;
		// 		}
		// 		else
		// 		{
		// 		new Float:xy,Float:yy;
		// 		SetDynamicObjectRot(bramalspd1,xy,yy,90);
		// 		lspdmove1 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,2,-1673.90, 902.57, -49.90))
		// 	{
		// 		if(lspdmove2 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd2,xy,yy,0);
		// 			lspdmove2 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd2,xy,yy,90);
		// 			lspdmove2 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,2,-1670.67, 904.90, -49.90))
		// 	{
		// 		if(lspdmove3 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd3,xy,yy,90);
		// 			lspdmove3 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd3,xy,yy,0);
		// 			lspdmove3 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,2,-1670.57, 876.07, -49.90))
		// 	{
		// 		if(lspdmove4 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd4,xy,yy,90);
		// 			lspdmove4 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd4,xy,yy,0);
		// 			lspdmove4 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,3,-1673.90, 891.26, -48.60))
		// 	{
		// 		if(lspdmove5 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd5,xy,yy,0);
		// 			lspdmove5 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd5,xy,yy,270);
		// 			lspdmove5 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,3,-1616.80, 829.67, -25.80))
		// 	{
		// 		if(lspdmove6 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd6,xy,yy,0);
		// 			lspdmove6 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd6,xy,yy,90);
		// 			lspdmove6 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,3,-1626.40, 829.67, -25.80))
		// 	{
		// 		if(lspdmove7 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd7,xy,yy,0);
		// 			lspdmove7 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd7,xy,yy,90);
		// 			lspdmove7 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,3,-1626.40, 823.28, -25.80))
		// 	{
		// 		if(lspdmove8 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd8,xy,yy,0);
		// 			lspdmove8 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd8,xy,yy,90);
		// 			lspdmove8 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,3,-1616.80, 823.28, -25.80))
		// 	{
		// 		if(lspdmove9 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd9,xy,yy,0);
		// 			lspdmove9 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd9,xy,yy,90);
		// 			lspdmove9 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,3,-1745.86, 784.40, -44.20))
		// 	{
		// 		if(lspdmove10 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd10,xy,yy,90);
		// 			lspdmove10 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd10,xy,yy,0);
		// 			lspdmove10 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,3,-1606.47, 817.80, -30.50))
		// 	{
		// 		if(lspdmove11 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd11,xy,yy,90);
		// 			lspdmove11 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd11,xy,yy,0);
		// 			lspdmove11 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,3, -1745.87, 805.20, -45.50))
		// 	{
		// 		if(lspdmove12 == 0)
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd12,xy,yy,90);
		// 			lspdmove12 = 1;
		// 		}
		// 		else
		// 		{
		// 			new Float:xy,Float:yy;

		// 			SetDynamicObjectRot(bramalspd12,xy,yy,0);
		// 			lspdmove12 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,2,-1682.7000, 923.1000, -52.2000))
		// 	{
		// 		if(lspdmove14 == 0)
		// 		{
		// 			MoveDynamicObject(celalspd1,-1682.7000, 921.5530, -52.2000,3,0,0,90);
		// 			lspdmove14 = 1;
		// 		}
		// 		else
		// 		{
		// 			MoveDynamicObject(celalspd1,-1682.7000, 923.1000, -52.2000,3,0,0,90);
		// 			lspdmove14 = 0;
		// 		}
		// 	}
		// 	if(IsPlayerInRangeOfPoint(playerid,2,-1682.7000, 926.3000, -52.2000))
		// 	{
		// 		if(lspdmove15 == 0)
		// 		{
		// 			MoveDynamicObject(celalspd2,-1682.7000, 924.7530, -52.2000,3,0,0,90);
		// 			lspdmove15 = 1;
		// 		}
		// 		else
		// 		{
		// 			MoveDynamicObject(celalspd2,-1682.7000, 926.3000, -52.2000,3,0,0,90);
		// 			lspdmove15 = 0;
		// 		}
		// 	}
		// }
		//nowe komi bray koniec
		//==========================[NOWE BRAMY URZÊDU MIASTA!]=============================
		//[23-12-2018] Dual Gate DMV
		//if(IsAUrzednik(playerid) || IsABOR(playerid))
		//{
	
			/*if(IsPlayerInRangeOfPoint(playerid, 3.5, 1450.117919, -1784.158203, 78.235244))
			{
				if(PlayerInfo[playerid][pRank] >= 1)
				{
					if(urzadnewm == 0)
					{
						MoveDynamicObject(dualgdmv1, 1450.117919, -1784.158203, 78.235244, 5, 0.000000, 0.000000, -87.95994);
						MoveDynamicObject(dualgdmv2, 1453.097045, -1784.160522, 78.235260, 5, 0.000000, 0.000000, -92.16000);
						urzadnewm = 1;
					}
					else
					{
						MoveDynamicObject(dualgdmv1, 1450.117919, -1784.158203, 78.235244, 5, 0.000000, 0.000000, 0.000000);
						MoveDynamicObject(dualgdmv2, 1453.097045, -1784.160522, 78.235260, 5, 0.000000, 0.000000, -180.000000);
						urzadnewm = 0;
					}
					
					return 1;
				}
				else
				{
					sendErrorMessage(playerid, "Nie posiadasz odpowiedniego stopnia identyfikatora aby to otworzyæ!");
				}
				
			}*/
			/*else if(IsPlayerInRangeOfPoint(playerid, 3.5, 1450.3826,-1844.5345,81.4612))
			{
				if(PlayerInfo[playerid][pLider] == 11)//Tylko dla dyrektorow
				{
					if(urzadnewm2 == 0)
					{
						MoveDynamicObject(bramadyrektora1, 1452.035400, -1842.966674, 81.605247, 5, 0.000000, 0.000000, 265.9202);
						MoveDynamicObject(bramadyrektora2, 1449.049804, -1842.941528, 81.605247, 5, -0.100000, 0.000000, -82.2801);
						urzadnewm2 = 1;
					}
					else
					{
						MoveDynamicObject(bramadyrektora1, 1452.035400, -1842.966674, 81.605247, 5, 0.000000, 0.000000, 180.000000);
						MoveDynamicObject(bramadyrektora2, 1449.049804, -1842.941528, 81.605247, 5, -0.100000, 0.000000, -0.800033);
						urzadnewm2 = 0;
					}
					return 1;
				}
				else
				{
					sendErrorMessage(playerid, "Nie posiadasz odpowiedniego stopnia identyfikatora aby to otworzyæ!");
				}
				
			}
		
		}*/ 
		//==============================[KONIEC]====================================================
		//..
		if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9  || strcmp(GetNick(playerid),"Gonzalo_DiNorscio", false) == 0 || PlayerInfo[playerid][pAdmin] >= 1)
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, -1113.25769043,-1008.68634033,128.90229797))
			{
			    if(BramaZuzS == 1)
			    {
			        SetDynamicObjectRot(BramaZuz, 0, 0, 249);
    				BramaZuzS = 0;
			    }
			    else
				{
				    SetDynamicObjectRot(BramaZuz, 90, 60, 249);
    				BramaZuzS = 1;
    			}
			}

		}
		if(IsAPolicja(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(PlayerToPoint(7.5, playerid, 266.57534790039, 112.58443450928, 1006.2540283203))
			{
				if(IzbaState == 1)
				{
					MoveDynamicObject(Izba, 264.57534790039, 112.58443450928, 1006.2540283203, 2.5);
					IzbaState = 0;
					PlayerPlaySound(playerid, 1039, 0.0, 0.0, 0.0);
				}
				else
				{
					MoveDynamicObject(Izba, 266.57534790039, 112.58443450928, 1006.2540283203,  2.5);
					IzbaState = 1;
					PlayerPlaySound(playerid, 1039, 0.0, 0.0, 0.0);
				}
			}
		}
		if(IsAHA(playerid) || PlayerInfo[playerid][pAdmin] >= 5000)
		{
			if(PlayerToPoint(10.0, playerid, -1.39941406,-267.09960938,7.19999981))
			{
				if(BramaHAS == 1)
				{
					MoveDynamicObject(BramaHA, -1.39941406,-267.09960938,13.39, 2.5);
					BramaHAS = 0;
				}
				else
				{
					MoveDynamicObject(BramaHA, -1.39941406,-267.09960938,7.19999981, 2.5);
					BramaHAS = 1;
				}
			}
		}
		if(GetPlayerOrg(playerid) != 0 || PlayerInfo[playerid][pAdmin] >= 5000)
		{
			if(PlayerToPoint(7.5, playerid, 1240.9154052734, -767.32855224609, 91.052940368652))
			{
				if(BramaCortezS == 1)
				{
					MoveDynamicObject(BramaCortez, 1240.9154052734, -767.32855224609, 80.052940368652, 1.5);
					BramaCortezS = 0;
				}
				else
				{
				    MoveDynamicObject(BramaCortez, 1240.9154052734, -767.32855224609, 91.052940368652, 1.5);
					BramaCortezS = 1;
				}
			}
		}
		if(GetPlayerOrg(playerid) != 0 || PlayerInfo[playerid][pAdmin] >= 5000)
		{
			if(PlayerToPoint(10.0, playerid, 1285.09960938,-1006.29980469,29.89999962))
			{
				if(BrFS[0] == 1)
				{
					MoveDynamicObject(BrF[0], 1285.09960938,-1006.29980469,29.89999962, 1.5);
					BrFS[0] = 0;
				}
				else
				{
				    MoveDynamicObject(BrF[0], 1290.80004883,-1006.29998779,29.89999962, 1.5);
					BrFS[0] = 1;
				}
			}
		}
		if(GetPlayerOrg(playerid) != 0 || PlayerInfo[playerid][pAdmin] >= 5000)
		{
			if(PlayerToPoint(10.0, playerid, 1285.09997559,-966.40002441,33.59999847))
			{
				if(BrFS[1] == 1)
				{
					MoveDynamicObject(BrF[1], 1285.09997559,-966.40002441,33.59999847, 1.5);
					BrFS[1] = 0;
				}
				else
				{
				    MoveDynamicObject(BrF[1], 1290.80004883,-966.40002441,33.59999847, 1.5);
					BrFS[1] = 1;
				}
			}
		}
		if(GetPlayerOrg(playerid) != 0 || PlayerInfo[playerid][pAdmin] >= 5000)
		{
			if(PlayerToPoint(3.0, playerid, 1289.59960938,-1080.09960938,5972.39990234))
			{
				if(BrFS[2] == 1)
				{
					SetDynamicObjectRot(BrF[2],0,0,180 );
					SetDynamicObjectRot(BrF[3],0,0,0 );
					BrFS[2] = 0;
				}
				else
				{
					SetDynamicObjectRot(BrF[2], 0,0,0);
					SetDynamicObjectRot(BrF[3],0,0,180 );
					BrFS[2] = 1;
				}
			}
		}
		if(GetPlayerOrg(playerid) != 0 || PlayerInfo[playerid][pAdmin] >= 5000)
		{
			if(PlayerToPoint(3.0, playerid, 1288.21972656,-1086.67968750,5971.18017578))
			{
				if(BrFS[4] == 1)
				{
					SetDynamicObjectRot(BrF[4], 0,0,0);
					BrFS[4] = 0;
				}
				else
				{
				    SetDynamicObjectRot(BrF[4], 0,0,180);
					BrFS[4] = 1;
				}
			}
		}
		if(GetPlayerOrg(playerid) != 0 || PlayerInfo[playerid][pAdmin] >= 5000)
		{
			if(PlayerToPoint(3.0, playerid, 1276.29980469,-1084.68652344,5971.10009766))
			{
				if(BrFS[5] == 1)
				{
					SetDynamicObjectRot(BrF[5], 0,0,89);
					BrFS[5] = 0;
				}
				else
				{
				    SetDynamicObjectRot(BrF[5], 0,0,270);
					BrFS[5] = 1;
				}
			}
		}
		if(GetPlayerOrg(playerid) != 0 || PlayerInfo[playerid][pAdmin] >= 5000)
		{
			if(PlayerToPoint(20.0, playerid, -1770.29980469,984.19921875,25.29999924))
			{
				if(BrFS[6] == 1)
				{
					MoveDynamicObject(BrF[6], -1770.00000000,973.90002441,25.29999924, 1.5);
					BrFS[6] = 0;
				}
				else
				{
				    MoveDynamicObject(BrF[6], -1770.29980469,984.19921875,25.29999924, 1.5);
					BrFS[6] = 1;
				}
			}
		}
		if(GetPlayerOrg(playerid) != 0 || PlayerInfo[playerid][pAdmin] >= 5000)
		{
			if(PlayerToPoint(3.0, playerid, -1837.09960938,1159.31933594,6797.899902))
			{
				if(BrFS[7] == 1)
				{
				    SetDynamicObjectRot(BrF[7], 0,0,90);
					BrFS[7] = 0;
				}
				else
				{
				    SetDynamicObjectRot(BrF[7], 0,0,270);
					BrFS[7] = 1;
				}
			}
		}

		//old komi
		if(PlayerInfo[playerid][pAdmin] >= 1000 || IsAPolicja(playerid))
		{
			if(PlayerToPoint(10.0, playerid, 212.88121032715,124.91903686523,998.40710449219))
			{
				if(BramaKomiCelaS == 1)
				{
					MoveDynamicObject(BramaKomiCela, 212.88121032715,124.91903686523,998.40710449219 , 2.5);
					SetDynamicObjectRot(BramaKomiCela, 0, 0, 0);
					BramaKomiCelaS = 0;
				}
				else
				{
					MoveDynamicObject(BramaKomiCela, 208.77641296387,124.5825958252,998.40710449219, 2.5);
					SetDynamicObjectRot(BramaKomiCela, 0, 0, 0);
					BramaKomiCelaS = 1;
				}
			}
		}

		//recepcja fbi
		/*if(IsPlayerInRangeOfPoint(playerid,5,620.82562, -1458.85901, 89.61560))
		{
			if(FBImove1 == 0)
			{
				MoveDynamicObject(FBIdrzwi1,620.82562, -1458.85901, 89.61560+0.01,0.01,0,0,135);
				MoveDynamicObject(FBIdrzwi2, 622.93494, -1456.75122, 89.61560+0.01,0.01,0,0,135);
				FBImove1 = 1;
			}
			else
			{
				MoveDynamicObject(FBIdrzwi1,620.82562, -1458.85901, 89.61560-0.01,0.01,0,0,45);
				MoveDynamicObject(FBIdrzwi2, 622.93494, -1456.75122, 89.61560-0.01,0.01,0,0,225);
				FBImove1 = 0;
			}
		}*/
		//drzwi do wi?zienia stanowego FBI
		/*if(IsPlayerInRangeOfPoint(playerid,5,633.10693, -1488.77295, 89.61260))
		{
			if(FBImove4 == 0)
			{
				MoveDynamicObject(FBIdrzwi5,633.10693, -1488.77295, 89.61260+0.01,0.01,0,0,45);
				MoveDynamicObject(FBIdrzwi6,635.22333, -1490.88586, 89.61260+0.01,0.01,0,0,45);
				FBImove4 = 1;
			}
			else
			{
				MoveDynamicObject(FBIdrzwi5,633.10693, -1488.77295, 89.61260-0.01,0.01,0,0,315);
				MoveDynamicObject(FBIdrzwi6, 635.22333, -1490.88586, 89.61260-0.01,0.01,0,0,135);
				FBImove4 = 0;
			}
		}*/
		if(IsAFBI(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			//sale przesluchan oraz cele
			if(IsPlayerInRangeOfPoint(playerid,5,613.93781, -1482.25500, 89.61260))
			{
				if(FBImove2 == 0)
				{
					MoveDynamicObject(FBIdrzwi3,613.93781, -1482.25500, 89.61260+0.01,0.01,0,0,270);
					FBImove2 = 1;
				}
				else
				{
					MoveDynamicObject(FBIdrzwi3,613.93781, -1482.25500, 89.61260-0.01,0.01,0,0,0);
					FBImove2 = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,5,620.36481, -1482.25720, 89.61260))
			{
				if(FBImove3 == 0)
				{
					MoveDynamicObject(FBIdrzwi4,620.36481, -1482.25720, 89.61260+0.01,0.01,0,0,270);
					FBImove3 = 1;
				}
				else
				{
					MoveDynamicObject(FBIdrzwi4,620.36481, -1482.25720, 89.61260-0.01,0.01,0,0,0);
					FBImove3 = 0;
				}
			}
			//biura federalne
			if(IsPlayerInRangeOfPoint(playerid,5,628.0024, -1455.4712, 72.9411))
			{
				if(FBImove5 == 0)
				{
					MoveDynamicObject(FBIdrzwi7,628.0024, -1455.4712, 72.9411+0.01,0.01,0,0,0);
					FBImove5 = 1;
				}
				else
				{
					MoveDynamicObject(FBIdrzwi7,628.0024, -1455.4712, 72.9411-0.01,0.01,0,0,90);
					FBImove5 = 0;
				}
			}
		}
		/*if(IsAFBI(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 20.0, 615.2236328125, -1509.96484375, 16.714672088623))
			{
			    if(BramaWDolS == 1)
			    {
			        MoveDynamicObject(BramaWDol, 615.2236328125, -1509.96484375, 11.0, 2.5);
			        BramaWDolS = 0;
			    }
			    else
			    {
			    	MoveDynamicObject(BramaWDol, 615.2236328125, -1509.96484375, 16.714672088623, 2.5);
					BramaWDolS = 1;
			    }
			}
		} */
		if(GetPlayerFraction(playerid) == FRAC_ERS || PlayerInfo[playerid][pAdmin] >= 1000)//POCZ?TEK
		{
            if(IsPlayerInRangeOfPoint(playerid,3,1158.82922, -1325.31738, 31.39840))
        	{
         		if(lsmc1move == 0)
        		{
          			MoveDynamicObject(lsmc1, 1159.0520, -1325.2886, 31.3984, 1,  0.00001, 0.00000, 180.00000);
          			lsmc1move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc1, 1158.82922, -1325.31738, 31.39840, 1,  0.00000, 0.00000, 270.00000);
          			lsmc1move  = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1158.4498, -1317.0956, 31.4174))
        	{
         		if(lsmc2move == 0)
        		{
          			MoveDynamicObject(lsmc2, 1158.3795, -1317.1844, 31.4174, 1,  0.00001, 0.00000, 180.00000);
          			lsmc2move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc2, 1158.4498, -1317.0956, 31.4174, 1,  0.00000, 0.00000, 270.00000);
          			lsmc2move  = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1125.18225, -1354.87842, 24.37040))
        	{
         		if(lsmc3move == 0)
        		{
          			MoveDynamicObject(lsmc3, 1125.1648, -1354.9403, 24.3704, 1,  0.00001, 0.00000, -45.00000);
          			lsmc3move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc3, 1125.18225, -1354.87842, 24.37040, 1,  0.00000, 0.00000, 45.00000);
          			lsmc3move  = 0;
        		}

        	}
         	if(IsPlayerInRangeOfPoint(playerid,3,1109.01233, -1361.59814, 24.37040))
        	{
         		if(lsmc4move == 0)
        		{
          			MoveDynamicObject(lsmc4, 1108.9000, -1361.6304, 24.3704, 1,  0.00001, 0.00000, -45.00000);
          			lsmc4move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc4, 1109.01233, -1361.59814, 24.37040, 1,  0.00000, 0.00000, -135.00000);
          			lsmc4move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1116.87280, -1365.49927, 24.37040))
        	{
         		if(lsmc5move == 0)
        		{
          			MoveDynamicObject(lsmc5, 1116.8630, -1365.5190, 24.3704, 1,  0.00001, 0.00000, 0.00000);
          			lsmc5move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc5, 1116.8761, -1365.4594, 24.3704, 1,  0.00000, 0.00000, 270.00000);
          			lsmc5move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1126.30139, -1361.59656, 24.37040))
        	{
         		if(lsmc6move == 0)
        		{
          			MoveDynamicObject(lsmc6, 1126.3014, -1361.5966, 24.3704, 1,  0.00001, 0.00000, -135.00000);
          			lsmc6move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc6, 1126.2216, -1361.6056, 24.3704, 1,  0.00000, 0.00000, -45.00000);
          			lsmc6move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1109.9993, -1354.9357, 24.3704))
        	{
         		if(lsmc7move == 0)
        		{
          			MoveDynamicObject(lsmc7, 1109.9825, -1354.8597, 24.3704, 1,  0.00001, 0.00001, -135.00000);
          			lsmc7move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc7, 1109.9993, -1354.9357, 24.3704, 1,  0.00000, 0.00000, 135.00000);
          			lsmc7move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1116.8719, -1352.0619, 24.3704))
        	{
         		if(lsmc8move == 0)
        		{
          			MoveDynamicObject(lsmc8, 1116.9135, -1352.1210, 24.3704, 1,  0.00001, 0.00000, 90.00000);
          			lsmc8move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc8, 1116.8719, -1352.0619, 24.3704, 1,  0.00000, 0.00000, 0.00000);
          			lsmc8move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1104.5431, -1300.4729, 20.5547))
        	{
         		if(lsmc9move == 0)
        		{
          			MoveDynamicObject(lsmc9, 1104.5927, -1300.3982, 20.5547, 1,  0.00001, 0.00000, 270.00000);
          			lsmc9move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc9, 1104.5431, -1300.4729, 20.5547, 1,  0.00000, 0.00000, 0.00000);
          			lsmc9move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,5,1152.7046, -1371.6298, 25.7502))
        	{
         		if(lsmc10i11move == 0)
        		{
          			MoveDynamicObject(lsmc10, 1152.7639, -1371.6711, 25.7502, 1,  0.00001, 0.00000, 0.00000);
                    MoveDynamicObject(lsmc11, 1155.7543, -1371.6633, 25.7502, 1,  0.00001, 0.00000, 180.00000);
        			lsmc10i11move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc10, 1152.7046, -1371.6298, 25.7502, 1,  0.00000, 0.00000, 270.00000);
                    MoveDynamicObject(lsmc11, 1155.6904, -1371.6298, 25.7502, 1,  0.00001, 0.00000, 270.00000);
          			lsmc10i11move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,2,1161.5691, -1371.6663, 26.8429))
        	{
         		if(lsmc12move == 0)
        		{
          			MoveDynamicObject(lsmc12, 1162.9369, -1371.6052, 25.6152, 1,  0.00001, 0.00000, 180.00000);
          			lsmc12move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc12, 1162.9012, -1371.5494, 25.6152, 1,  0.00000, 0.00000, 270.00000);
          			lsmc12move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,2,1163.7167, -1369.0515, 26.8429))
        	{
         		if(lsmc13move == 0)
        		{
          			MoveDynamicObject(lsmc13, 1163.7758, -1370.6599, 25.6152, 1,  0.00001, 0.00000, 90.00000);
          			lsmc13move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc13, 1163.6547, -1370.6350, 25.6152, 1,  0.00000, 0.00000, 0.00000);
          			lsmc13move = 0;
        		}

        	}
         	if(IsPlayerInRangeOfPoint(playerid,3,1165.4852, -1292.2385, 30.6339))
        	{
         		if(lsmc14move == 0)
        		{
          			MoveDynamicObject(lsmc14, 1165.4761, -1292.2609, 30.6339, 1,  0.00001, 0.00000, 0.00000);
          			lsmc14move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc14, 1165.4852, -1292.2385, 30.6339, 1,  0.00000, 0.00000, 90.00000);
          			lsmc14move = 0;
        		}

        	}
          	if(IsPlayerInRangeOfPoint(playerid,3,1155.9778, -1292.3573, 30.5549))
        	{
         		if(lsmc15move == 0)
        		{
          			MoveDynamicObject(lsmc15, 1155.9312, -1292.2811, 30.6339, 1,  0.00001, 0.00000, 0.00000);
          			lsmc15move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc15, 1155.9778, -1292.3573, 30.6339, 1,  0.00000, 0.00000, 90.00000);
          			lsmc15move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1149.5372, -1292.2732, 30.5549))
        	{
         		if(lsmc16move == 0)
        		{
          			MoveDynamicObject(lsmc16, 1149.5341, -1292.2933, 30.6339, 1,  0.00001, 0.00000, 0.00000);
          			lsmc16move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc16, 1149.5850, -1292.3671, 30.5549, 1,  0.00000, 0.00000, 90.00000);
          			lsmc16move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1114.3738, -1340.2286, 19.1874))
        	{
         		if(lsmc17move == 0)
        		{
          			MoveDynamicObject(lsmc17, 1114.4199, -1340.3263, 19.1874, 1,  0.00001, 0.00000, 180.00000);
          			lsmc17move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc17, 1114.3738, -1340.2286, 19.1874, 1,  0.00000, 0.00000, 270.00000);
          			lsmc17move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1120.7749, -1340.2427, 19.1874))
        	{
         		if(lsmc18move == 0)
        		{
          			MoveDynamicObject(lsmc18, 1120.8298, -1340.3135, 19.1874, 1,  0.00001, 0.00000, 180.00000);
          			lsmc18move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc18, 1120.7749, -1340.2427, 19.1874, 1,  0.00000, 0.00000, 270.00000);
          			lsmc18move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1108.9688, -1338.3345, 19.1874))
        	{
         		if(lsmc19move == 0)
        		{
          			MoveDynamicObject(lsmc19, 1108.9124, -1338.3982, 19.1874, 1,  0.00001, 0.00000, 90.00000);
          			lsmc19move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc19, 1108.9688, -1338.3345, 19.1874, 1,  0.00000, 0.00000, 180.00000);
          			lsmc19move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1180.3314, -1374.3346, 22.9654))
        	{
         		if(lsmc20move == 0)
        		{
          			MoveDynamicObject(lsmc20, 1180.2574, -1374.2296, 22.9654, 1,  0.00001, 0.00000, 0.00000);
          			lsmc20move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc20, 1180.3314, -1374.3346, 22.9654, 1,  0.00000, 0.00000, 90.00000);
          			lsmc20move = 0;
        		}

        	}
        	if(IsPlayerInRangeOfPoint(playerid,3,1181.7303, -1378.7136, 22.9654))
        	{
         		if(lsmc21move == 0)
        		{
          			MoveDynamicObject(lsmc21, 1181.7854, -1378.7971, 22.9654, 1,  0.00001, 0.00000, 180.00000);
          			lsmc21move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmc21, 1181.7303, -1378.7136, 22.9654, 1,  0.00000, 0.00000, 270.00000);
          			lsmc21move = 0;
        		}

        	}
        }
		if(IsAUrzednik(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 5.0, -2059.30249023,568.60919189,1172.05114746))
			{
			    if(BramaBaySideS == 1)
			    {
			        MoveDynamicObject(BramaBaySide,-2059.30249023,568.60919189,1172.05114746,2,0.00000000,0.00000000,180.0);
    				BramaBaySideS = 0;
			    }
			    else
				{
				    MoveDynamicObject(BramaBaySide,-2059.30249023,568.60919189,1172.05114746,2,0.00000000,0.00000000,90.0);
    				BramaBaySideS = 1;
				}
			}
		}
		if(IsABOR(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(IsPlayerInRangeOfPoint(playerid,3,1073.5038, 1071.0618, -17.5000))
			{
			    if(movedmv[1] == 0)
			    {
			        MoveDynamicObject(bramadmv[1],1072.4418, 1070.0588, -17.5000,3);
			        movedmv[1] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[1],1073.5038, 1071.0618, -17.5000,3);
			        movedmv[1] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,1074.5497, 1060.8575, -17.5000))
			{
			    if(movedmv[2] == 0)
			    {
			        MoveDynamicObject(bramadmv[2],1075.5527, 1059.7955, -17.5000,3);
			        movedmv[2] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[2],1074.5497, 1060.8575, -17.5000,3);
			        movedmv[2] = 0;
				}
			}
		}
		if(IsAUrzednik(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(IsPlayerInRangeOfPoint(playerid,3,1062.3588, 1063.4921, -17.5000))
			{
			    if(movedmv[0] == 0)
			    {
			        MoveDynamicObject(bramadmv[0],1060.9288, 1063.4921, -17.5000,3);
			        movedmv[0] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[0],1062.3588, 1063.4921, -17.5000,3);
			        movedmv[0] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,1088.7262, 1088.5906, -17.4740))
			{
			    if(movedmv[19] == 0)
			    {
			        MoveDynamicObject(bramadmv[18],1088.7262, 1087.1826, -17.4740,3);
			        movedmv[19] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[18],1088.7262, 1088.5906, -17.4740,3);
			        movedmv[19] = 0;
				}
			}
		//BRAMY 1ST FLOOR
			if(IsPlayerInRangeOfPoint(playerid,3,1473.8502, -1770.2255, 162.5790))
			{
			    if(movedmv[4] == 0)
			    {
			        MoveDynamicObject(bramadmv[3],1473.8502, -1771.6345, 162.5790,3);
			        movedmv[4] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[3],1473.8502, -1770.2255, 162.5790,3);
			        movedmv[4] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,1473.8502, -1776.5929, 162.5790))
			{
			    if(movedmv[5] == 0)
			    {
			        MoveDynamicObject(bramadmv[4],1473.8502, -1778.0489, 162.5790,3);
			        movedmv[5] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[4],1473.8502, -1776.5929, 162.5790,3);
			        movedmv[5] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,1473.8502, -1783.0039, 162.5790))
			{
			    if(movedmv[6] == 0)
			    {
			        MoveDynamicObject(bramadmv[5],1473.8502, -1784.4599, 162.5790,3);
			        movedmv[6] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[5],1473.8502, -1783.0039, 162.5790,3);
			        movedmv[6] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,1479.0059, -1786.1598, 162.5790))
			{
			    if(movedmv[7] == 0)
			    {
			        MoveDynamicObject(bramadmv[6],1477.5499, -1786.1598, 162.5790,3);
			        movedmv[7] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[6],1479.0059, -1786.1598, 162.5790,3);
			        movedmv[7] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,1486.0873, -1783.0023, 162.5790))
			{
			    if(movedmv[8] == 0)
			    {
			        MoveDynamicObject(bramadmv[7],1486.0873, -1784.4583, 162.5790,3);
			        movedmv[8] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[7],1486.0873, -1783.0023, 162.5790,3);
			        movedmv[8] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,1486.0873, -1776.5881, 162.5790))
			{
			    if(movedmv[9] == 0)
			    {
			        MoveDynamicObject(bramadmv[8],1486.0873, -1778.0441, 162.5790,3);
			        movedmv[9] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[8],1486.0873, -1776.5881, 162.5790,3);
			        movedmv[9] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,1486.0873, -1770.1837, 162.5790))
			{
			    if(movedmv[10] == 0)
			    {
			        MoveDynamicObject(bramadmv[9],1486.0873, -1771.6397, 162.5790,3);
			        movedmv[10] = 1;
				}
				else
				{
			        MoveDynamicObject(bramadmv[9],1486.0873, -1770.1837, 162.5790,3);
			        movedmv[10] = 0;
				}
			}
        }
        if(IsAUrzednik(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			//bramy 2nd floor
			if(IsPlayerInRangeOfPoint(playerid,3,-1779.7819, 499.8180, -20.8394))
			{
			    if(movedmv[11] == 0)
			    {
			        MoveDynamicObject(bramadmv[10],-1781.2579, 499.8140, -20.8394,3);
			        movedmv[11] = 1;
				}
				else
				{
				    MoveDynamicObject(bramadmv[10],-1779.7819, 499.8180, -20.8394,3);
				    movedmv[11] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,-1792.4424, 513.1279, -20.8394))
			{
			    if(movedmv[12] == 0)
			    {
			        MoveDynamicObject(bramadmv[11],-1792.4424, 511.6879, -20.8394,3);
			        movedmv[12] = 1;
				}
				else
				{
				    MoveDynamicObject(bramadmv[11],-1792.4424, 513.1279, -20.8394,3);
				    movedmv[12] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,-1779.7920, 528.5160, -20.8394))
			{
			    if(movedmv[13] == 0)
			    {
			        MoveDynamicObject(bramadmv[12],-1781.2160, 528.5160, -20.8394,3);
			        movedmv[13] = 1;
				}
				else
				{
				    MoveDynamicObject(bramadmv[12],-1779.7920, 528.5160, -20.8394,3);
				    movedmv[13] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,-1783.0454, 532.7757, -20.8394))
			{
			    if(movedmv[14] == 0)
			    {
			        MoveDynamicObject(bramadmv[13],-1783.0454, 531.3037, -20.8394,3);
			        movedmv[14] = 1;
				}
				else
				{
				    MoveDynamicObject(bramadmv[13],-1783.0454, 532.7757, -20.8394,3);
				    movedmv[14] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,-1783.0752, 542.3167, -20.8394))
			{
			    if(movedmv[15] == 0)
			    {
			        MoveDynamicObject(bramadmv[14],-1783.0752, 540.8607, -20.8394,3);
			        movedmv[15] = 1;
				}
				else
				{
				    MoveDynamicObject(bramadmv[14],-1783.0752, 542.3167, -20.8394,3);
				    movedmv[15] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,-1775.2935, 542.3241, -20.8394))
			{
			    if(movedmv[16] == 0)
			    {
			        MoveDynamicObject(bramadmv[15],-1775.2935, 540.8681, -20.8394,3);
			        movedmv[16] = 1;
				}
				else
				{
				    MoveDynamicObject(bramadmv[15],-1775.2935, 542.3241, -20.8394,3);
				    movedmv[16] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,-1775.2826, 532.7743, -20.8394))
			{
			    if(movedmv[17] == 0)
			    {
			        MoveDynamicObject(bramadmv[16],-1775.2826, 531.3183, -20.8394,3);
			        movedmv[17] = 1;
				}
				else
				{
				    MoveDynamicObject(bramadmv[16],-1775.2826, 532.7743, -20.8394,3);
				    movedmv[17] = 0;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid,3,-1817.4670, 505.9481, -19.4634))
			{
			    if(movedmv[18] == 0)
			    {
			        MoveDynamicObject(bramadmv[17],-1817.4670, 504.5081, -19.4634,3);
			        movedmv[18] = 1;
				}
				else
				{
				    MoveDynamicObject(bramadmv[17],-1817.4670, 505.9481, -19.4634,3);
				    movedmv[18] = 0;
				}
			}
		}
		if(GetPlayerOrg(playerid) == 16 && PlayerInfo[playerid][pRank] >= 3)
		{
			if(IsPlayerInRangeOfPoint(playerid,3, 482.15, -1523.25, 45.01))//drzwi vipa
			{
				if(movegate[1] == 0)
				{
					MoveDynamicObject(bramka[0],482.1455, -1524.6294, 45.0147,3);
					movegate[1] = 1;
				}
				else
				{
					MoveDynamicObject(bramka[0],482.15, -1523.25, 45.01,3);
					movegate[1] = 0;
				}
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,5,505.0200, -1497.8800, 45.8200) && GetPlayerOrg(playerid) == 16|| IsPlayerInRangeOfPoint(playerid,5,488.2908,-1492.8959,43.6700) && GetPlayerOrg(playerid) == 16)
		{
			if(movegate[2] == 0)
			{
				MoveDynamicObject(bramka[5], 496.61, -1509.25, 48.30,3);
				MoveDynamicObject(bramka[6],502.26, -1509.94, 50.36,3);
				movegate[2] = 1;
			}
			else
			{
				MoveDynamicObject(bramka[5],496.61, -1509.25, 42.78,3);
				MoveDynamicObject(bramka[6],502.26, -1509.94, 45.18,3);
				movegate[2] = 0;
			}
		}
        //LSMC EXT
        if(IsPlayerInFraction(playerid, FRAC_ERS, 5000))
        {
        	if(IsPlayerInRangeOfPoint(playerid,10,1113.1650, -1291.4082, 15.3756))
        	{
         		if(lsmcex1move == 0)
        		{
          			MoveDynamicObject(lsmcex1, 1113.1650, -1291.4082, 15.3756, 3,  0.00000, 0.00000, 270.00000);
          			lsmcex1move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmcex1, 1113.1891, -1294.1810, 17.8536, 3,  0.00000, 76.00000, 270.00000);
          			lsmcex1move  = 0;
        		}
        		return 1;
        	}
         	if(IsPlayerInRangeOfPoint(playerid,10,1122.2708, -1291.4082, 15.3756))
        	{
         		if(lsmcex2move == 0)
        		{
          			MoveDynamicObject(lsmcex2, 1122.2708, -1291.4082, 15.3756, 3,  0.00000, 0.00000, 270.00000);
          			lsmcex2move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmcex2, 1122.3209, -1294.1860, 17.8536, 3,  0.00000, 76.00000, 270.00000);
          			lsmcex2move  = 0;
        		}
        		return 1;
        	}
        	if(IsPlayerInRangeOfPoint(playerid,10,1131.4741, -1291.4082, 15.3756))
        	{
         		if(lsmcex3move == 0)
        		{
          			MoveDynamicObject(lsmcex3, 1131.4741, -1291.4082, 15.3756, 3,  0.00000, 0.00000, 270.00000);
          			lsmcex3move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmcex3, 1131.4716, -1294.2262, 17.8536, 3,  0.00000, 76.00000, 270.00000);
          			lsmcex3move  = 0;
        		}
        		return 1;
        	}
        	if(IsPlayerInRangeOfPoint(playerid,10,1140.6681, -1291.3882, 15.3756))
        	{
         		if(lsmcex4move == 0)
        		{
          			MoveDynamicObject(lsmcex4, 1140.6681, -1291.3882, 15.3756, 3,  0.00000, 0.00000, 270.00000);
          			lsmcex4move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmcex4, 1140.6638, -1294.1620, 17.8536, 3,  0.00000, 76.00000, 270.00000);
          			lsmcex4move  = 0;
        		}
        		return 1;
        	}
        	if(IsPlayerInRangeOfPoint(playerid,5,1145.5428, -1315.6469, 12.7274))
        	{
         		if(lsmcex5move == 0)
        		{
          			MoveDynamicObject(lsmcex5, 1145.5428, -1315.6469, 12.7274, 1,  0.000001, 0.00000, 90.00000);
          			lsmcex5move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmcex5, 1145.5428, -1315.6469, 12.7275, 1,  0.000002, 0.00000, 180.00000);
          			lsmcex5move  = 0;
        		}
        		return 1;
        	}
         	if(IsPlayerInRangeOfPoint(playerid,10,1145.0775, -1355.1573, 12.8578))
        	{
         		if(lsmcex6move == 0)
        		{
          			MoveDynamicObject(lsmcex6, 1145.6217, -1354.9731, 16.2798, 3,  0.0000, 0.00000, 0.00000);
          			lsmcex6move = 1;
        		}
        		else
        		{
          			MoveDynamicObject(lsmcex6, 1153.5867, -1354.9731, 16.2798, 3,  0.0000, 0.00000, 0.00000);
          			lsmcex6move  = 0;
        		}
        		return 1;
        	}
        }
        if(IsAClub(playerid))
        {
            if(IsPlayerInRangeOfPoint(playerid, 5.0, 1903.2273,-2466.0583,17.9950) && PlayerInfo[playerid][pRank] > 5 && GetPlayerVirtualWorld(playerid) == 1) //RANGA
        	{
        		if(IbizaKanciapa) //otwarte
        		{
        			MoveDynamicObject(IbizaKanciapaObiekt, 1902.58, -2465.68, 19.12, 2.0);
        			IbizaKanciapa = false;
        		}
        		else
        		{
        			MoveDynamicObject(IbizaKanciapaObiekt, 1902.58, -2465.68, 21.72, 2.0);
        			IbizaKanciapa = true;
        		}
        		return 1;
        	}
        	if(IsPlayerInRangeOfPoint(playerid, 18.0, 420.9000, -1783.4000, 4.3100 ) && PlayerInfo[playerid][pRank] >=4) //RANGA
        	{

        		if(IbizaBrama[0])
        		{
        			MoveDynamicObject(IbizaBramaObiekty[0], 420.9000, -1783.4000, 3.4500, 2.0);
        			IbizaBrama[0] = false;
        		}
        		else
        		{
        			MoveDynamicObject(IbizaBramaObiekty[0], 420.9000, -1783.4000, 4.3100, 2.0);
        			IbizaBrama[0] = true;
        		}
        		return 1;
        	}
        	if(IsPlayerInRangeOfPoint(playerid, 18.0, 358.4000, -1783.9000, 4.2000) && PlayerInfo[playerid][pRank] >= 4 ) //RANGA
        	{
        		if(IbizaBrama[1])
        		{
        			MoveDynamicObject(IbizaBramaObiekty[1], 358.4000, -1783.9000, 3.3082, 2.0);
        			IbizaBrama[1] = false;
        		}
        		else
        		{
        			MoveDynamicObject(IbizaBramaObiekty[1], 358.4000, -1783.9000, 4.2000, 2.0);
        			IbizaBrama[1] = true;
        		}
        		return 1;
        	}
        }
        else if(IsAClub(playerid))
        {
            if (IsPlayerInRangeOfPoint(playerid,8.0,853.63031, -1384.23206, 13.65440))
            {
                if(!GATE_VINYL_S)
                {
                    MoveDynamicObject(GATE_VINYL, 853.63031, -1384.23206, 13.65440, 0.7, 0.0, 0.0, 0.0);
                    GATE_VINYL_S = true;
                }
                else
                {
                    MoveDynamicObject(GATE_VINYL, 853.63031, -1384.23206, 13.66440, 0.7, 0.0, 90.0, 0.0);
                    GATE_VINYL_S = false;
                }
            }
            if (IsPlayerInRangeOfPoint(playerid,3.0,817.06927, -1383.28040, 23.76980))
            {
                if(!GATE_VINYL_IN_S[0])
                {
                    MoveDynamicObject(GATE_VINYL_IN[0], 817.06927, -1383.28040, 23.76980, 0.7, 0.0, 0.0, 0.0);
                    GATE_VINYL_IN_S[0] = true;
                }
                else
                {
                    MoveDynamicObject(GATE_VINYL_IN[0], 817.06927, -1383.28040, 23.77980, 0.7, 0.0, 0.0, 90.0);
                    GATE_VINYL_IN_S[0] = false;
                }
            }
            if (IsPlayerInRangeOfPoint(playerid,3.0,821.13000, -1377.81714, 23.76980))
            {
                if(!GATE_VINYL_IN_S[1])
                {
                    MoveDynamicObject(GATE_VINYL_IN[1], 821.13000, -1377.81714, 23.76980, 0.7, 0.0, 0.0, 270.0);
                    GATE_VINYL_IN_S[1] = true;
                }
                else
                {
                    MoveDynamicObject(GATE_VINYL_IN[1], 821.13000, -1377.81714, 23.77980, 0.7, 0.0, 0.0, 0.0);
                    GATE_VINYL_IN_S[1] = false;
                }
            }
            if (IsPlayerInRangeOfPoint(playerid,3.0,823.68091, -1383.27795, 23.80980))
            {
                if(!GATE_VINYL_IN_S[2])
                {
                    MoveDynamicObject(GATE_VINYL_IN[2], 823.68091, -1383.27795, 23.80980, 0.7, 0.0, 0.0, 0.0);
                    GATE_VINYL_IN_S[2] = true;
                }
                else
                {
                    MoveDynamicObject(GATE_VINYL_IN[2], 823.68091, -1383.27795, 23.81980, 0.7, 0.0, 0.0, 90.0);
                    GATE_VINYL_IN_S[2] = false;
                }
            }
            if (IsPlayerInRangeOfPoint(playerid,3.0,811.50568, -1374.66809, 23.80980))
            {
                if(!GATE_VINYL_IN_S[3])
                {
                    MoveDynamicObject(GATE_VINYL_IN[3], 811.50568, -1374.66809, 23.80980, 0.7, 0.0, 0.0, 0.0);
                    GATE_VINYL_IN_S[3] = true;
                }
                else
                {
                    MoveDynamicObject(GATE_VINYL_IN[3], 811.50568, -1374.66809, 23.81980, 0.7, 0.0, 0.0, 90.0);
                    GATE_VINYL_IN_S[3] = false;
                }
            }
        }
	}
	return 1;
}
