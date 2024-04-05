//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ wez ]--------------------------------------------------//
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

YCMD:wez(playerid, params[], help)
{
	new string[144];

    if(IsPlayerConnected(playerid))
    {
		new x_job[16];
		new ammount=0;
		if( sscanf(params, "s[16]D", x_job, ammount))
		{
			SendClientMessage(playerid, COLOR_WHITE, "|__________________ WeŸ __________________|");
			SendClientMessage(playerid, COLOR_WHITE, "U¿yj /wez [nazwa]");
	  		SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: Dragi, Kanister, Gasnice, Mundur");
			SendClientMessage(playerid, COLOR_GREEN, "|_________________________________________|");
			return 1;
		}

	    if(strcmp(x_job,"drugs",true) == 0 || strcmp(x_job,"dragi",true) == 0)
		{
			diler_wez_dragi(playerid, ammount);
		}
		else if(strcmp(x_job,"fuel",true) == 0 || strcmp(x_job,"kanister",true) == 0 || strcmp(x_job,"paliwo",true) == 0)
		{
		    if(IsAtGasStation(playerid))
			{
			    new price = 20 * 120;
			    format(string, sizeof(string), "* Wzi¹³eœ kanister z 20% paliwa za $%d",price);
			    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			    PlayerInfo[playerid][pFuel] = 20;
				ZabierzKase(playerid, price);
				return 1;
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY," Nie jesteœ na stacji benzynowej!");
				return 1;
			}
		}
		else if(strcmp(x_job,"gasnice",true) == 0 || strcmp(x_job,"gasnica",true) == 0)
		{
			if (PlayerInfo[playerid][pMember] == 4)
			{
				new vehicleid = GetClosestCar(playerid, 3.5);
				if(vehicleid != -1)
    			{
					if(Car_GetOwnerType(vehicleid) == CAR_OWNER_FRACTION && (GetVehicleModel(vehicleid) == 407 || GetVehicleModel(vehicleid) == 544))// wszystkie auta frakcji
					{
						if(Car_GetOwner(vehicleid) == GetPlayerFraction(playerid))
						{
							format(string, sizeof(string), "*** %s chwyta za now¹ gaœnicê z wozu stra¿ackiego. ***", GetNick(playerid));
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							GivePlayerWeapon(playerid, 42, 9999);
	                     	PlayerInfo[playerid][pGun9] = 42;
	                     	PlayerInfo[playerid][pAmmo9] = 9999;
							return 1;
						}
						else
						{
							sendTipMessage(playerid, "Ten wóz stra¿acki nie nale¿y do LSRS.");
							return 1;
						}
					}
					else
					{
						format(string, sizeof(string), "Ten pojazd nie jest wozem stra¿ackim LSRS. (%s)", VehicleNames[GetVehicleModel(vehicleid)-400]);
						sendTipMessage(playerid, string);
						return 1;
					}
				}
				else
				{
					sendTipMessage(playerid, "Brak aut w pobli¿u.");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY, "Komenda dostêpna tylko dla LSRS.");
				return 1;
			}
		}
		else if(strcmp(x_job,"mundur",true) == 0)
		{
			if (PlayerInfo[playerid][pMember] == 4)
			{
				new vehicleid = GetClosestCar(playerid, 3.5);
				if(vehicleid != -1)
    			{
					if(Car_GetOwnerType(vehicleid) == CAR_OWNER_FRACTION && (GetVehicleModel(vehicleid) == 407 || GetVehicleModel(vehicleid) == 544))// wszystkie auta frakcji
					{
						if(Car_GetOwner(vehicleid) == GetPlayerFraction(playerid))
						{
							if(ERS_mundur[playerid] == 1)
							{
								format(string, sizeof(string), "*** %s zdejmuje z siebie specjalistyczny mundur ***", GetNick(playerid));
								ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
								if(JobDuty[playerid]==0) SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
								else  SetPlayerSkinEx(playerid, PlayerInfo[playerid][pUniform]);
								ERS_mundur[playerid] = 0;
								return 1;
							}
							else
							{
								format(string, sizeof(string), "*** %s przebiera siê w specjalistyczny mundur ***", GetNick(playerid));
								ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
								SetPlayerSkinEx(playerid, 277);
								ERS_mundur[playerid] = 1;
								return 1;
							}
						}
						else
						{
							sendTipMessage(playerid, "Ten wóz stra¿acki nie nale¿y do LSRS.");
							return 1;
						}
					}
					else
					{
						format(string, sizeof(string), "Ten pojazd nie jest wozem stra¿ackim LSRS. (%s)", VehicleNames[GetVehicleModel(vehicleid)-400]);
						sendTipMessage(playerid, string);
						return 1;
					}
				}
				else
				{
					sendTipMessage(playerid, "Brak aut w pobli¿u.");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY, "Komenda dostêpna tylko dla LSRS.");
				return 1;
			}
		}
		else { return 1; }
	}//not connected
	return 1;
}
