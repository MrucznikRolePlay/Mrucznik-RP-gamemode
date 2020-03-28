//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ lot ]--------------------------------------------------//
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

YCMD:lot(playerid, params[], help)
{
    new data[32], sub[128];
    if(sscanf(params, "s[32]S()[128]", data, sub))
    {
		sendTipMessageEx(playerid, COLOR_WHITE, "U¿yj /lot [nazwa]");
		sendTipMessageEx(playerid, COLOR_WHITE, "Dostepne Nazwy: bilet.");
		if(GetPlayerFraction(playerid) == FRAC_KT)
	    {
	    	sendTipMessageEx(playerid, COLOR_WHITE, "Pracownik: start, stop, (k)omunikat, koszt, drzwi, skoki.");
	    }
		return 1;
	}
    new string[128], sendername[MAX_PLAYER_NAME];
	if(strcmp(data,"bilet",true) == 0)
	{
        if(PlayerToPoint(3.0,playerid,1593.3000488281,-2285.6000976563,-75)||PlayerToPoint(3.0,playerid,1593.3000488281,-2280,-75)||PlayerToPoint(3.0,playerid,1674.8, 1442.3, 14.8)||PlayerToPoint(1.5,playerid,-1391.9000244141,-299.79998779297,-74.699996948242))
	    {
    	    if(kosztbiletu>0)
    	    {
                if(kaska[playerid] >= kosztbiletu)
    	        {
    	            sendTipMessageEx(playerid, COLOR_GREY, " Kupi³eœ bilet !");
    	            ZabierzKase(playerid, kosztbiletu);
                    Sejf_Add(FRAC_KT, kosztbiletu);
    	            PlayerInfo[playerid][pBiletsamolotowy]=1;
    		        return 1;
    	        }
    	        else
    	        {
    	            format(string, sizeof(string), " Nie staæ ciê na bilet ($%d) !", kosztbiletu);
    	            sendTipMessageEx(playerid, COLOR_GREY, string);
    	            return 1;
    	        }
    		}
    		else sendTipMessageEx(playerid, COLOR_YELLOW, "LSBD: Nie ustalono jeszcze ceny biletu !");
		}
	    else return sendTipMessageEx(playerid, COLOR_GREY, " Nie jesteœ przy kasie lotniska Los Santos !");
	}
    if(GetPlayerFraction(playerid) == FRAC_KT)
    {
    	if(strcmp(data,"start",true) == 0)
    	{
    	    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 577)
    	    {
       			if(IsPlayerInRangeOfPoint(playerid, 10,1941.0000,-2294.5068,13.4720) || IsPlayerInRangeOfPoint(playerid, 10, -1344.1194,-229.2785,14.0624) || IsPlayerInRangeOfPoint(playerid, 10, 1565.5919,1448.4813,10.7384))
    	        {
    	    		GetPlayerName(playerid, sendername, sizeof(sendername));
    	    	    foreach(new i : Player)
	    	        {
	    	            if(PlayerInfo[i][pWsamolocieLS]==1)
   		 				{
							format(string, sizeof(string), "LSAD: Pilot %s rozpoczyna lot", sendername);
							SendClientMessage(i, COLOR_YELLOW, string);
							sendTipMessageEx(i, COLOR_GREY, " Nie mo¿esz teraz opuœciæ samolotu.");
							PlayerInfo[i][pWlociej]=1;
                            PlayerInfo[i][pBiletsamolotowy]=0;
						}
			        }
                    format(string, sizeof(string), "Pilot KTAir %s rozpoczyna lot po stanie San Andreas", sendername);
					OOCNews(TEAM_GROVE_COLOR,string);
    				SendClientMessage(playerid, COLOR_YELLOW, "LSBD: Rozpoczynasz lot");
    				format(string, sizeof(string), "LSAD: W samolocie znajduje siê %d osób", osoby);
    				SendClientMessage(playerid, COLOR_YELLOW, string);
    			}
    			else
    			{
                    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ na lotnisku !");
    			}
    		}
    		else
    		{
    			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w samolocie !");
    		}
    	}
    	else if(strcmp(data,"stop",true) == 0)
    	{
    	    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 577)
    	    {
    	    	if(IsPlayerInRangeOfPoint(playerid, 10,1941.0000,-2294.5068,13.4720) || IsPlayerInRangeOfPoint(playerid, 10, -1344.1194,-229.2785,14.0624) || IsPlayerInRangeOfPoint(playerid, 10, 1565.5919,1448.4813,10.7384))
    	        {
    	    		GetPlayerName(playerid, sendername, sizeof(sendername));
    	    	    foreach(new i : Player)
	    	        {
	    	            if(PlayerInfo[i][pWsamolocieLS]==1)
   		 				{
							format(string, sizeof(string), "LSAD: Pilot %s zakoñczy³ lot!", sendername);
							SendClientMessage(i, COLOR_YELLOW, string);
							sendTipMessageEx(i, COLOR_GREY, " Mo¿esz teraz opuœciæ samolotu.");
							PlayerInfo[i][pWlociej]=0;
						}
			        }
    				SendClientMessage(playerid, COLOR_YELLOW, "LSAD: Zakañczasz lot");
    			}
    			else
    			{
    			     sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ na lotnisku !");
    			}
    		}
    		else
    		{
    			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w samolocie !");
    		}
    	}
    	else if(strcmp(data,"koszt",true) == 0)
    	{
    	    if(PlayerInfo[playerid][Rank]>=4)
    	    {
                new koszt;
        		if(sscanf(sub, "d", koszt)) return sendTipMessage(playerid, "U¿yj /lot koszt [ilosc]");

    		    if(koszt < 0 || koszt > 100000) { sendTipMessageEx(playerid, COLOR_GREY, "Cena biletu nie mo¿e byæ mniejsza od 0$ i nie wiêksza od 100.000$"); return 1; }
                kosztbiletu = koszt;
                if(kosztbiletu>0)
    		    {
        			GetPlayerName(playerid, sendername, sizeof(sendername));
        			format(string, sizeof(string), "Kasa 1\nCena biletu:\n$%d\n(/lot)", kosztbiletu);
        			UpdateDynamic3DTextLabelText(NapislotLS1, COLOR_BLUE, string);
        			format(string, sizeof(string), "Kasa 2\nCena biletu:\n$%d\n(/lot)", kosztbiletu);
        			UpdateDynamic3DTextLabelText(NapislotLS2, COLOR_BLUE, string);
        			format(string, sizeof(string), "Kasa 1\nCena biletu:\n$%d\n(/lot)", kosztbiletu);
        			UpdateDynamic3DTextLabelText(NapislotLV1, COLOR_BLUE, string);
        			format(string, sizeof(string), "Kasa 1\nCena biletu:\n$%d\n(/lot)", kosztbiletu);
        			UpdateDynamic3DTextLabelText(NapislotSF1, COLOR_BLUE, string);
    			}
    			else
    			{
        			GetPlayerName(playerid, sendername, sizeof(sendername));
        			UpdateDynamic3DTextLabelText(NapislotLS1, COLOR_BLUE, "Kasa 1\nCena biletu:\nBrak");
        			UpdateDynamic3DTextLabelText(NapislotLS2, COLOR_BLUE, "Kasa 2\nCena biletu:\nBrak");
        			UpdateDynamic3DTextLabelText(NapislotLV1, COLOR_BLUE, "Kasa 1\nCena biletu:\nBrak");
        			UpdateDynamic3DTextLabelText(NapislotSF1, COLOR_BLUE, "Kasa 1\nCena biletu:\nBrak");
    			}
    			format(string, sizeof(string), "AirLine: Pilot %s ustali³ now¹ cenê biletu ($%d)", sendername, kosztbiletu);
    			SendFamilyMessage(10, COLOR_YELLOW, string);
    		}
    		else
    		{
    			sendErrorMessage(playerid, "Nie posiadasz 4 rangi !");
    		}
    	}
        else if(strcmp(data,"drzwi",true) == 0)
    	{
    	    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 577)
    	    {
    	        if(planeisstopped == 0)
    	        {
    	    		GetPlayerName(playerid, sendername, sizeof(sendername));
    				format(string, sizeof(string), " Pilot %s otwiera drzwi do samolotu", sendername);
    				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    				planeisstopped = 1;
    			}
    			else
    			{
    				GetPlayerName(playerid, sendername, sizeof(sendername));
    				format(string, sizeof(string), " Pilot %s zamyka drzwi do samolotu", sendername);
    				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    				planeisstopped = 0;
    			}
    		}
    		else
    		{
    			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w samolocie !");
    		}
    	}
    	else if(strcmp(data,"skoki",true) == 0)
    	{
    	    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 577)
    	    {
        		foreach(new i : Player)
    	        {
    	            if(PlayerInfo[i][pWsamolocieLS]==1)
     				{
    					SendClientMessage(i, COLOR_YELLOW, "LSAD: Pilot otworzy³ klapê skokow¹! Szykuj siê do skoków!");
    					PlayerInfo[i][pMozeskakacAT]=1;
    				}
    	        }
    			SendClientMessage(playerid, COLOR_YELLOW, "LSAD: Otwierasz klapê skokow¹");
    		}
    		else
    		{
    			sendTipMessageEx(playerid, COLOR_GREY, " Nie jesteœ w samolocie !");
    		}
    	}
    	else if(strcmp(data,"k",true) == 0 || strcmp(data,"komunikat",true) == 0)
    	{
    	    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 577)
    	    {
    	    	GetPlayerName(playerid, sendername, sizeof(sendername));
                new result[128];
                if(sscanf(sub, "s[128]", result)) return sendTipMessageEx(playerid, COLOR_GRAD2, "U¿yj /lot (/k)omunikat [tekst]");
    			foreach(new i : Player)
    	        {
    	            if(PlayerInfo[i][pWsamolocieLS]==1)
     				{
    					format(string, sizeof(string), "Pilot %s: {FF9900}%s", sendername, result);
    					SendClientMessage(i, COLOR_LIGHTBLUE, string);
    				}
    	        }
    			format(string, sizeof(string), "Pilot %s mówi przez radio: {FF9900}%s", sendername, result);
    			ProxDetector(30.0, playerid, string, COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
    		}
    		else
    		{
    			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w samolocie !");
    		}
    	}
    }
    else sendErrorMessage(playerid, "Nie jesteœ z Korporacji Transportowej !");
	return 1;
}
