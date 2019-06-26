//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ windalock ]-----------------------------------------------//
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

YCMD:windalock(playerid, params[], help)
{
	new string[128];
	new nick[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new level;
		if( sscanf(params, "d", level))
		{
			sendTipMessage(playerid, "U¿yj: /windalock [nr poziomu]");
			return 1;
		}

		if(IsPlayerInRangeOfPoint(playerid,5,288.0914,-1609.7465,17.9994)//parking SAN News
        || IsPlayerInRangeOfPoint(playerid,3,292.0818,-1610.0715,124.7512)//recepcja Winda
        || IsPlayerInRangeOfPoint(playerid,3,296.9033,-1598.3610,117.0619)/* Studia */
        || IsPlayerInRangeOfPoint(playerid,3,295.1328,-1609.4705,115.6818)/*Akademia */
        || IsPlayerInRangeOfPoint(playerid,3,297.7128,-1612.1783,114.4219)/*Dach*/
        || IsPlayerInRangeOfPoint(playerid,3,290.7577,-1604.3273,134.6113)/*Biura SAN NEWS*/ 
		&& (PlayerInfo[playerid][pMember] == FRAC_SN || PlayerInfo[playerid][pLider] == FRAC_SN))
		{
			if(level > 7 || level < 0)
			{
				sendErrorMessage(playerid, "Poziom od 0 do 7");
				return 1;
			}
			if(levelLock[FRAC_SN][level] == 1)
			{
				levelLock[FRAC_SN][level] = 0; 
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i odblokowuje poziom [%d].", GetNick(playerid), level);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(levelLock[FRAC_SN][level] == 0)
			{
				levelLock[FRAC_SN][level] = 1; 
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i blokuje poziom [%d].", GetNick(playerid), level);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		}
		else if((IsPlayerInRangeOfPoint(playerid,3,1327.6746, -1324.7770, 39.9210)
        || IsPlayerInRangeOfPoint(playerid,3,1289.0969, -1292.7489, 35.9681)
        || IsPlayerInRangeOfPoint(playerid,3,1310.3494, -1361.7319, 39.0876)
        || IsPlayerInRangeOfPoint(playerid,3,1310.0021, -1319.7189, 35.5984)) && GetPlayerOrg(playerid) == FAMILY_SAD)
		{
		    if(level == 1 && SadWindap1 == 0)//level 01
		    {
		    	SadWindap1 = 1;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zamkn¹³eœ poziom nr [1]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i blokuje poziom [1].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 1 && SadWindap1 == 1)//level 01
		    {
		    	SadWindap1 = 0;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Otworzy³eœ poziom nr [1]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i otwiera poziom [1].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 2 && SadWindap2 == 0)//level 02
		    {
		    	SadWindap2 = 1;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zamkn¹³eœ poziom nr [2]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i blokuje poziom [2].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 2 && SadWindap2 == 1)//level 02
		    {
		    	SadWindap2 = 0;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Otworzy³eœ poziom nr [2]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i otwiera poziom [2].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 3 && SadWindap3 == 0)//level 03
		    {
		    	SadWindap3 = 1;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zamkn¹³eœ poziom nr [3]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i blokuje poziom [3].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 3 && SadWindap3 == 1)//level 03
		    {
		    	SadWindap3 = 0;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Otworzy³eœ poziom nr [3]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i otwiera poziom [3].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 4 && SadWindap4 == 0)//level 04
		    {
		    	SadWindap4 = 1;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zamkn¹³eœ poziom nr [4]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i blokuje poziom [4].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 4 && SadWindap4 == 1)//level 04
		    {
		    	SadWindap4 = 0;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Otworzy³eœ poziom nr [4]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i otwiera poziom [4].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else
			{
		 		sendErrorMessage(playerid, "Nieodpowiedni poziom windy!");
		 		return 1;
			}
		}
		else if((IsPlayerInRangeOfPoint(playerid,2.0, 1144.4740, -1333.2556, 13.8348) ||
        IsPlayerInRangeOfPoint(playerid,2.0, 1167.2428,-1311.8409,31.6567) ||
        IsPlayerInRangeOfPoint(playerid,2.0,1104.2808,-1291.9760,21.6958)||
        IsPlayerInRangeOfPoint(playerid,2.0,1135.2930,-1358.6663,25.5729)||
        IsPlayerInRangeOfPoint(playerid,2.0,1170.3951,-1296.2148,31.7773)||
        IsPlayerInRangeOfPoint(playerid,2.0,1155.3907,-1363.1615,26.9370)||
        IsPlayerInRangeOfPoint(playerid,2.0,1127.3309,-1344.8870,20.3422)||
        IsPlayerInRangeOfPoint(playerid,2.0,1174.5618,-1376.4209,24.2193)||
        IsPlayerInRangeOfPoint(playerid,2.0, 1161.8228, -1337.0521, 31.6112)) && (PlayerInfo[playerid][pMember] == 4 || PlayerInfo[playerid][pLider] == 4))
        {
            if(level == 0 && LSMCWindap0 == 0)//level 00
		    {
		    	LSMCWindap0 = 1;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zamkn¹³eœ poziom nr [0]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i blokuje poziom [0].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 0 && LSMCWindap0 == 1)//level 00
		    {
		    	LSMCWindap0 = 0;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Otworzy³eœ poziom nr [0]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i otwiera poziom [0].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 2 && LSMCWindap2 == 0)//level 02
		    {
		    	LSMCWindap2 = 1;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zamkn¹³eœ poziom nr [2]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i blokuje poziom [2].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 2 && LSMCWindap2 == 1)//level 02
		    {
		    	LSMCWindap2 = 0;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Otworzy³eœ poziom nr [2]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i otwiera poziom [2].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 8 && LSMCWindap8 == 0)//level 08
		    {
		    	LSMCWindap8 = 1;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zamkn¹³eœ poziom nr [8]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i blokuje poziom [8].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(level == 8 && LSMCWindap8 == 1)//level 08
		    {
		    	LSMCWindap8 = 0;
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Otworzy³eœ poziom nr [8]!");
				GetPlayerName(playerid, nick, sizeof(nick));
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i otwiera poziom [8].", nick);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else
		    {
				sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "B³¹d! Mo¿esz zarz¹dzaæ tylko poziomami [0], [2], [8]!");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie znajdujesz siê obok windy, któr¹ mo¿esz zarz¹dzaæ!");
		}
	}
	return 1;
}
