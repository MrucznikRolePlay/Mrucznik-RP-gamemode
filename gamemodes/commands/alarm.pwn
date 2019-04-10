//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ alarm ]-------------------------------------------------//
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

CMD:alarm(playerid,cmdtext[]) //TODO
{
    if(GetPlayerFraction(playerid) == FRAC_BOR && PlayerInfo[playerid][pRank] > 2 || GetPlayerOrg(playerid) == FAMILY_SAD && PlayerInfo[playerid][pRank] > 2)
	{
        if(IsPlayerInRangeOfPoint(playerid,5,1321.1561, -1322.0787, 40.2077)
        || IsPlayerInRangeOfPoint(playerid,20,1309.6487, -1299.8835, 36.5567)
        || IsPlayerInRangeOfPoint(playerid,10,1310.2283, -1343.9265, 38.5291))
    	{
            if(!GATE_SAD_ALARM)
            {
        	    GATE_ALARM_OBJ[0] = CreateDynamicObject(18646, 1320.75305, -1328.18896, 41.55560,   0.00000, 0.00000, 0.00000, 500);
        		GATE_ALARM_OBJ[1] = CreateDynamicObject(18646, 1293.60901, -1329.04358, 41.55560,   0.00000, 0.00000, 0.00000, 500);
        		GATE_ALARM_OBJ[2] = CreateDynamicObject(18646, 1318.46729, -1320.96216, 41.55560,   0.00000, 0.00000, 0.00000, 500);
        		GATE_ALARM_OBJ[3] = CreateDynamicObject(18646, 1298.91919, -1305.46460, 41.22390,   0.00000, 0.00000, 0.00000, 501);
        		GATE_ALARM_OBJ[4] = CreateDynamicObject(18646, 1298.68286, -1294.45544, 41.22390,   0.00000, 0.00000, 0.00000, 501);
        		GATE_ALARM_OBJ[5] = CreateDynamicObject(18646, 1298.24878, -1291.82971, 41.22390,   0.00000, 0.00000, 0.00000, 501);
          		//INFORMACJA TYLKO DLA GSA
                SendFamilyMessage(FRAC_BOR, 0xFFFF0000, "[S³uchawka bluetooth] Uwaga! K3 w 0-6! W s¹dzie w³¹czy³ siê alarm! SprawdŸ to!");
			    MoveDynamicObject(GATE_SAD[18], 1310.2843, -1324.6620, 42.21040, 1,  0.00000, 180.00000, 90.00000);
				GATE_SAD_ALARM = true;
				new akcja[150];
				format(akcja,sizeof(akcja),"* %s wciska czerwony guzik pod biurkiem i w³¹cza alarm.",GetNick(playerid));
                ProxDetector(30.0, playerid, akcja, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                format(akcja, 150, "> %s uruchomi³ alarm w s¹dzie!", GetNick(playerid));
                SendNewFamilyMessage(FAMILY_SAD, TEAM_AZTECAS_COLOR, akcja);
                SendFamilyMessage(FRAC_BOR, 0xFFFF0000, akcja);
    		}
            else
            {
                for(new i=0;i<7;i++) DestroyDynamicObject(GATE_ALARM_OBJ[i]);
                GATE_SAD_ALARM = false;
                SendFamilyMessage(FRAC_BOR, 0xFFFF0000, "[S³uchawka bluetooth] Alarm w s¹dzie odwo³any.");
			    MoveDynamicObject(GATE_SAD[18], 1310.2843, -1324.6620, 45.7, 1,  0.00000, 180.00000, 90.00000);
				new akcja[150];
				format(akcja,sizeof(akcja),"* %s wciska czerwony guzik pod biurkiem i wy³¹cza alarm.",GetNick(playerid));
                ProxDetector(30.0, playerid, akcja, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            }
    	}
    }
    return 1;
}

