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
command_materialy_Impl(playerid, params[256])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    if (PlayerInfo[playerid][pJob] != 9)
		{
		    sendTipMessageEx(playerid,COLOR_GREY,"Nie jeste� dilerem broni !");
		    return 1;
		}
		new x_nr[16];
		new moneys=0;
		if( sscanf(params, "s[16]D(10)", x_nr, moneys))
		{
			sendTipMessage(playerid, "U�yj /mats [nazwa]");
			sendTipMessage(playerid, "Dost�pne nazwy: Wez, Dostarcz.");
			return 1;
		}
		if(strcmp(x_nr,"get",true) == 0 || strcmp(x_nr,"wez",true) == 0)
		{
		    if(PlayerToPoint(3.0,playerid,597.1277,-1248.6479,18.2734) ||
				IsPlayerInRangeOfPoint(playerid, 3.0, -4889.9229,661.9466,6.9799)) // Vice City
		    {
		        if(MatsHolding[playerid] >= 10)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie masz miejsca na wi�cej paczek !");
			        return 1;
		        }

		        if(moneys == 0)
				{
					sendTipMessage(playerid, "U�yj /mats get [ammount]");
					return 1;
				}

				if(moneys < 1 || moneys > 10) { sendTipMessageEx(playerid, COLOR_GREY, "Ilo�� paczek od 1 do 10 !"); return 1; }
				new price = moneys * 1200;
				if(kaska[playerid] > price)
				{
				    format(string, sizeof(string), "* Kupi�e� %d paczek materia��w za $%d jed� do fabryki materia��w. Dok�adn� lokalizacj� musisz ustali� sam.", moneys, price);
				    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				    ZabierzKase(playerid, price);
				    MatsHolding[playerid] = moneys;
				    SetPlayerCheckpoint(playerid, 2218.6000976563,-2228,13.5, 30);
				    SetTimerEx("Matsowanie", 1*51000 ,0,"d",playerid);
				    MatsGood[playerid] = 1;
				}
				else
				{
				    format(string, sizeof(string), "Nie masz $%d !", price);
				    sendTipMessageEx(playerid, COLOR_GREY, string);
				}
		    }
		    else
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� w fabryce materia��w w Los Santos !");
		        return 1;
		    }
		}
		else if(strcmp(x_nr,"deliver",true) == 0 || strcmp(x_nr,"dostarcz",true) == 0)
		{

            if(IsPlayerInRangeOfPoint(playerid, 1.5, MatsPoint[0], MatsPoint[1], MatsPoint[2]) ||
				IsPlayerInRangeOfPoint(playerid, 1.5, MatsPointVC[0], MatsPointVC[1], MatsPointVC[2])) 
		    {
		        if(MatsHolding[playerid] > 0)
		        {
		            if(MatsGood[playerid] != 1)
		            {
			            new payout = (50)*(MatsHolding[playerid]);
						if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_MATS))
						{
							payout *= 2;
							MruMessageGoodInfo(playerid, "Twoja organizacja posiada fabryk� materia��w, dzi�ki czemu otrzymujesz 2 razy wi�cej materia��w");
						}
			            format(string, sizeof(string), "Dosta�e� od handlarza %d materia��w z twoich %d paczek mats", payout, MatsHolding[playerid]);
					    sendTipMessage(playerid, string);
                        if(PlayerInfo[playerid][pMiserPerk] > 0) {
                            new poziom = PlayerInfo[playerid][pMiserPerk];
                            PlayerInfo[playerid][pMats] += poziom*30;
                            format(string, sizeof(string), "Dzi�ki ulepszeniu MATSIARZ otrzymujesz dodatkowo %d mats", poziom*30);
                            sendTipMessage(playerid, string);
                        }
			            PlayerInfo[playerid][pMats] += payout;
			            MatsHolding[playerid] = 0;
			            DisablePlayerCheckpoint(playerid);
			        }
			        else
			        {
			            GetPlayerName(playerid, sendername, sizeof(sendername));
					    format(string, sizeof(string), "AdmCmd: %s zostal zkickowany przez Admina: Marcepan_Marks, pow�d: teleport", sendername);
                        SendPunishMessage(string, playerid);
						Log(punishmentLog, INFO, "%s dosta� kicka od antycheata, pow�d: teleport do mats�w", GetPlayerLogName(playerid));
			        	KickEx(playerid, "teleport hack");
			        	return 1;
		        	}
		        }
		        else
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz paczek z materia�ami !");
			        return 1;
		        }
		    }
		    else
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� przy odbiorze paczek materia��w!");
		        return 1;
		    }
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Z�a nazwa !");
		    return 1;
		}
	}
	return 1;
}

//end
