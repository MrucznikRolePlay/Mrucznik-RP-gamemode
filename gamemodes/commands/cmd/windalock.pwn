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
		|| IsPlayerInRangeOfPoint(playerid,3,287.7476,-1609.9395,33.0723)//wejscie glowne san news
        || IsPlayerInRangeOfPoint(playerid,3,292.0818,-1610.0715,124.7512)//recepcja Winda
        || IsPlayerInRangeOfPoint(playerid,3,296.9033,-1598.3610,117.0619)/* Studia */
        || IsPlayerInRangeOfPoint(playerid,3,295.1328,-1609.4705,115.6818)/*Akademia */
        || IsPlayerInRangeOfPoint(playerid,3,297.7128,-1612.1783,114.4219)/*Dach*/
        || IsPlayerInRangeOfPoint(playerid,3,290.7577,-1604.3273,134.6113)/*Biura SAN NEWS*/)
		{
			if(PlayerInfo[playerid][pLider] != FRAC_SN && PlayerInfo[playerid][pMember] != FRAC_SN)
			{
				sendErrorMessage(playerid, "Nie masz uprawnieñ - nie jesteœ z San News"); 
				return 1;
			}
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
			if(PlayerInfo[playerid][pLider] != FRAC_FBI && PlayerInfo[playerid][pMember] != FRAC_FBI)
			{
				sendErrorMessage(playerid, "Nie masz uprawnieñ do otwierania/zamykania windy!"); 
				return 1;
			}
			if(level > 11 || level < 0)
			{
				sendErrorMessage(playerid, "Poziom od 0 do 11");
				return 1;
			}
			if(levelLock[FRAC_FBI][level] == 1)
			{
				levelLock[FRAC_FBI][level] = 0; 
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i odblokowuje poziom [%d].", GetNick(playerid), level);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(levelLock[FRAC_FBI][level] == 0)
			{
				levelLock[FRAC_FBI][level] = 1; 
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i blokuje poziom [%d].", GetNick(playerid), level);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		}
		else if((IsPlayerInRangeOfPoint(playerid,3,1311.5483,-1361.2096,62.8567) //-1 archiwum
        || IsPlayerInRangeOfPoint(playerid,3,1305.9991,-1326.1344,52.5659) // 0 recepcja 
        || IsPlayerInRangeOfPoint(playerid,3,1309.9982,-1364.2216,59.6271) // 1 korytarze
        || IsPlayerInRangeOfPoint(playerid,3,1310.1989,-1328.8876,82.5859) // 2 biura
        || IsPlayerInRangeOfPoint(playerid,3,1310.2946,-1321.2517,74.6955) // 3 socjal
        || IsPlayerInRangeOfPoint(playerid,3,1310.3961,-1319.0530,35.6587))// 4 dach
		&& GetPlayerOrg(playerid) == FAMILY_SAD)
		{
		    if(level > 4 || level < -1)
			{
				sendErrorMessage(playerid, "Poziom od -1 do 4");
				return 1;
			}
			if(SadWinda[level+1] == 1)
			{
				SadWinda[level+1] = 0; 
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i odblokowuje poziom [%d].", GetNick(playerid), level);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else if(SadWinda[level+1] == 0)
			{
				SadWinda[level+1] = 1; 
				format(string, sizeof(string),"* %s wstukuje kod na panelu windy i blokuje poziom [%d].", GetNick(playerid), level);
				ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
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
