//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ news ]-------------------------------------------------//
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

YCMD:news(playerid, params[], help)
{
	new string[128];
	new string2[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
		{
		    new newcar = GetPlayerVehicleID(playerid);
	        if(PlayerInfo[playerid][pMute] == 1)
			{
				sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz mówiæ poniewa¿ zosta³eœ wyciszony");
				return 1;
			}
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				sendErrorMessage(playerid, "Nie mo¿esz u¿ywaæ /news podczas s³u¿by administratora!"); 
				return 1;
			}

            new bool:inpos=false;
            for(new i=0;i<MAX_VEHICLES;i++)
            {
                if(Car_GetOwner(i) == FRAC_SN && Car_GetOwnerType(i) == CAR_OWNER_FRACTION)
                {
                    if(newcar == i)
                    {
                        inpos=true;
                        break;
                    }
                }
            }

			if(inpos ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 676.9533,-1339.5132,30.3588) ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 660.1057,-1339.6501,29.3712) ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 655.8636,-1377.5455,28.4672) ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 652.1369,-1367.9576,28.5072) ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 651.2371,-1367.7997,28.5072) ||
                IsPlayerInRangeOfPoint(playerid, 20.0, 667.8975,-1380.4872,28.4672))
			{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if(isnull(params))
				{
					sendTipMessage(playerid, "U¿yj /news [newstext]");
					return 1;
				}
				if (strfind(params , "ip:" , true)>=0 ||strfind(params , "www." , true)>=0 || strfind(params , ".pl" , true)>=0 || strfind(params , ",pl" , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , ":3" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0)
				{
					SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
					format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
					ABroadCast(COLOR_LIGHTRED,string,1);
					Log(warningLog, INFO, "%s reklamuje na /news: %s", GetPlayerLogName(playerid), params);
				}
				else
				{
				    if(AntySpam[playerid] == 1)
				    {
				        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 3 sekund");
				        return 1;
				    }
					format(string, sizeof(string), "%s", params);
					if(strlen(params) > 100)
					{
						new stringRef[124]; 
						strcat(stringRef, params); 
						new pos = strfind(stringRef, " ", true, 90);
						new allL = strlen(stringRef);
						allL = allL-pos;  
						strdel(stringRef, pos, pos+allL);
						format(string2, sizeof(string2), "~y~NR %s: ~w~%s [..]", GetNick(playerid), stringRef); 
					}
					else if(strlen(params) <= 100)
					{
						format(string2, sizeof(string2), "~y~NR %s: ~w~%s", GetNick(playerid), params); 
					}
					OOCNews(COLOR_NEWS,string);
					SendDiscordMessage(DISCORD_SAN_NEWS, string);
                    //OOCNews(0xFF8C55FF, string);
					PlayerInfo[playerid][pNewsSkill] ++;
					if(PlayerInfo[playerid][pNewsSkill] == 50)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 2, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 100)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 3, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 200)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 4, mo¿esz teraz lataæ helikopterem."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 400)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 5, mo¿esz teraz prowadziæ wywiady na ¿ywo z kim chcesz."); }
                    SetTimerEx("AntySpamTimer",3000,0,"d",playerid);
	    			AntySpam[playerid] = 1;
				}
			}
			else if(PlayerToPoint(10.5, playerid, 1820.0637,-1315.9836,109.9520))
			{
				if(isnull(params))
				{
					sendTipMessage(playerid, "U¿yj /news [newstext]");
					return 1;
				}
				if (strfind(params , "ip:" , true)>=0 ||strfind(params , "www." , true)>=0 || strfind(params , ".pl" , true)>=0 || strfind(params , ",pl" , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , ":3" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0)
				{
					SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
					format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
					ABroadCast(COLOR_LIGHTRED,string,1);
					Log(warningLog, INFO, "%s reklamuje na /news: %s", GetPlayerLogName(playerid), params);
				}
				else
				{
				    if(AntySpam[playerid] == 1)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 3 sekund");
				        return 1;
				    }
					//OOCNews(COLOR_NEWS,string);
					format(string, sizeof(string), "%s", params); 
					if(strlen(params) > 100)
					{
						new stringRef[124]; 
						strcat(stringRef, params); 
						new pos = strfind(stringRef, " ", true, 90);
						new allL = strlen(stringRef);
						allL = allL-pos;  
						strdel(stringRef, pos, pos+allL);
						format(string2, sizeof(string2), "~y~NR %s: ~w~%s [..]", GetNick(playerid), stringRef); 
					}
					else if(strlen(params) <= 100)
					{
						format(string2, sizeof(string2), "~y~NR %s: ~w~%s", GetNick(playerid), params); 
					}
					OOCNews(COLOR_NEWS,string);
					SendDiscordMessage(DISCORD_SAN_NEWS, string);
					PlayerInfo[playerid][pNewsSkill] ++;
					if(PlayerInfo[playerid][pNewsSkill] == 50)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 2, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 100)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 3, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 200)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 4, mo¿esz teraz lataæ helikopterem."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 400)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 5, mo¿esz teraz prowadziæ wywiady na ¿ywo z kim chcesz."); }
                    SetTimerEx("AntySpamTimer",3000,0,"d",playerid);
	    			AntySpam[playerid] = 1;
				}
			}
			else if(GetPLocal(playerid) == PLOCAL_ORG_SN)
			{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if(isnull(params))
				{
					sendTipMessage(playerid, "U¿yj /news [newstext]");
					return 1;
				}
				if (strfind(params , "ip:" , true)>=0 ||strfind(params , "www." , true)>=0 || strfind(params , ".pl" , true)>=0 || strfind(params , ",pl" , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , ":3" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0)
				{
					SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
					format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
					ABroadCast(COLOR_LIGHTRED,string,1);
					Log(warningLog, INFO, "%s reklamuje na /news: %s", GetPlayerLogName(playerid), params);
					return 1;
				}
				else
				{
				    if(AntySpam[playerid] == 1)
				    {
				        SendClientMessage(playerid, COLOR_GREY, "Odczekaj 3 sekund");
				        return 1;
				    }
					format(string, sizeof(string), "NR %s: %s", sendername, params);
					if(strlen(params) > 100)
					{
						new stringRef[124]; 
						strcat(stringRef, params); 
						new pos = strfind(stringRef, " ", true, 90);
						new allL = strlen(stringRef);
						allL = allL-pos;  
						strdel(stringRef, pos, pos+allL);
						format(string2, sizeof(string2), "~y~NR %s: ~w~%s [..]", GetNick(playerid), stringRef); 
					}
					else if(strlen(params) <= 100)
					{
						format(string2, sizeof(string2), "~y~NR %s: ~w~%s", GetNick(playerid), params); 
					}
					OOCNews(COLOR_NEWS,string);
					SendDiscordMessage(DISCORD_SAN_NEWS, string);
					PlayerInfo[playerid][pNewsSkill] ++;
					if(PlayerInfo[playerid][pNewsSkill] == 50)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 2, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 100)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 3, Nied³ugo bêdziesz móg³ lataæ helikopterem i prowadziæ wywiady."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 200)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 4, mo¿esz teraz lataæ helikopterem."); }
					else if(PlayerInfo[playerid][pNewsSkill] == 400)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci Reportera wynosz¹ teraz 5, mo¿esz teraz prowadziæ wywiady na ¿ywo z kim chcesz."); }
                    SetTimerEx("AntySpamTimer",3000,0,"d",playerid);
	    			AntySpam[playerid] = 1;
				}
			
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w wozie SAN News !");
			    return 1;
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ Reporterem !");
		}
	}//not connected
	return 1;
}
