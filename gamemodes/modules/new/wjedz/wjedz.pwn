//MODULE_NAME.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: MODULE_NAME.pwn ]------------------------------------------//
//Opis: Nowa funkcja, pozwalaj¹ca dodawaæ wjazdy praktycznie jedn¹ linijk¹! Stworzona w oparciu o bramy/wejscia Mrucznika
/*

*/
//Adnotacje: by Simeone 04-03-2019
/*

*/
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

//

//-----------------<[ Funkcje: ]>-------------------
stock StworzWjedz(Float:wjedzX, Float:wjedzY, Float:wjedzZ, Float:wyjedzX, Float:wyjedzY, Float:wyjedzZ, Float:RangePoint, VW, MessageIN[]=" ", MessageOut[]=" ", FracOwner=0, OrgOwner=0, local)
{
	wjazdy[valueWjedz][wj_X] = wjedzX;
	wjazdy[valueWjedz][wj_Y] = wjedzY;
	wjazdy[valueWjedz][wj_Z] = wjedzZ;
	wjazdy[valueWjedz][wy_X] = wyjedzX;
	wjazdy[valueWjedz][wy_Y] = wyjedzY;
	wjazdy[valueWjedz][wy_Z] = wyjedzZ;
	wjazdy[valueWjedz][wj_VW] = VW;
	wjazdy[valueWjedz][wj_PLOCAL] = local;
	wjazdy[valueWjedz][pFracOwn] = FracOwner;
	wjazdy[valueWjedz][pOrgOwn] = OrgOwner;
	wjazdy[valueWjedz][RangeofPoint] = RangePoint;

/*
	CreateDynamicPickup(1239, 2, wjedzX, wjedzY, wjedzZ, 0, 0);
	CreateDynamicPickup(1239, 2, wyjedzX, wyjedzY, wyjedzZ, VW, 0);
	
*/
	if(isnull(MessageIN)) 
	{
		CreateDynamicPickup(1239, 2, wjedzX, wyjedzY, wjedzZ, 0, 0);
	}
	else  
	{
		CreateDynamic3DTextLabel(MessageIN, COLOR_RED, wjedzX, wjedzY, wjedzZ, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	}
	if(isnull(MessageOut)) 
	{
		CreateDynamicPickup(1239, 2, wyjedzX, wyjedzY, wyjedzZ, VW, 0);
	}
	else 
	{
		CreateDynamic3DTextLabel(MessageOut, COLOR_RED, wyjedzX, wyjedzY, wyjedzZ, 9.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, VW, 0);
	}
	
	return valueWjedz++;
}
//new 
stock SprawdzWjazdy(playerid)
{
	if(GetPlayerVehicleSeat(playerid) != 0)
	{
		sendErrorMessage(playerid, "Nie jesteœ kierowc¹"); 
		return 1;
	}
	new pVehAcID = GetPlayerVehicleID(playerid);
	for(new i; i<valueWjedz; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]))//Wejœcie
		{
			if(wjazdy[i][pFracOwn] > 0 && wjazdy[i][pOrgOwn] > 0)
			{
				if(GetPlayerFraction(playerid) == wjazdy[i][pFracOwn] || GetPlayerOrg(playerid) == wjazdy[i][pOrgOwn])
				{
					if(IsPlayerInAnyVehicle(playerid))
					{
						TogglePlayerControllable(playerid, 0);
						WjedzTimer[playerid] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", playerid);
						PlayerTextDrawShow(playerid, textwjedz[playerid]);
						SetPVarInt(playerid, "JestPodczasWjezdzania", 1);
					}
					else
					{
						SetPlayerPos(playerid, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
						SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
					}
				}
				else
				{
					sendTipMessage(playerid, "Nie mo¿esz tutaj wjechaæ"); 
				}
			}
			else if(wjazdy[i][pFracOwn] > 0  && wjazdy[i][pOrgOwn] == 0)
			{
				if(GetPlayerFraction(playerid) == wjazdy[i][pFracOwn])
				{
					if(IsPlayerInAnyVehicle(playerid))
					{
						TogglePlayerControllable(playerid, 0);
						WjedzTimer[playerid] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", playerid);
						PlayerTextDrawShow(playerid, textwjedz[playerid]);
						SetPVarInt(playerid, "JestPodczasWjezdzania", 1);
					}
					else
					{
						SetPlayerPos(playerid, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
						SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
					}
				}
				else
				{
					sendTipMessage(playerid, "Nie mo¿esz tutaj wjechaæ"); 
				}
			
			}
			else if(wjazdy[i][pFracOwn] == 0 && wjazdy[i][pOrgOwn] > 0)
			{
				if(GetPlayerOrg(playerid) == wjazdy[i][pOrgOwn])
				{
					if(IsPlayerInAnyVehicle(playerid))
					{
						TogglePlayerControllable(playerid, 0);
						WjedzTimer[playerid] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", playerid);
						PlayerTextDrawShow(playerid, textwjedz[playerid]);
						SetPVarInt(playerid, "JestPodczasWjezdzania", 1);
					}
					else
					{
						SetPlayerPos(playerid, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
						SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
					}
				}
				else
				{
					sendTipMessage(playerid, "Nie mo¿esz tutaj wjechaæ"); 
				}
			
			}
			else if(wjazdy[i][pFracOwn] == 0 && wjazdy[i][pOrgOwn] == 0)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					TogglePlayerControllable(playerid, 0);
					WjedzTimer[playerid] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", playerid);
					PlayerTextDrawShow(playerid, textwjedz[playerid]);
					SetPVarInt(playerid, "JestPodczasWjezdzania", 1);
				}
				else
				{
					SetPlayerPos(playerid, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
					SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
				}
			}
			foreach(Player, i2)
			{
				if(GetPlayerVehicleID(i2) == pVehAcID && GetPlayerVehicleSeat(i2) != 0)
				{
					WjedzTimer[i2] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", i2);
					SetPVarInt(i2, "JestPodczasWjezdzaniaPasazer", 1);
					SetPVarInt(i2, "pSeatIDE", GetPlayerVehicleSeat(i2));
					TogglePlayerControllable(i2, 0);
				}
			}
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]))//wyjcie
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				TogglePlayerControllable(playerid, 0);
				WjedzTimer[playerid] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", playerid);
				PlayerTextDrawShow(playerid, textwjedz[playerid]);
				SetPVarInt(playerid, "JestPodczasWjezdzania", 1);
			}
			else
			{
				SetPlayerPos(playerid, wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]);
				SetPlayerVirtualWorld(playerid, 0);
			}
			foreach(Player, i2)
			{
				if(GetPlayerVehicleID(i2) == pVehAcID && GetPlayerVehicleSeat(i2) != 0)
				{
					WjedzTimer[i2] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", i2);
					SetPVarInt(i2, "JestPodczasWjezdzaniaPasazer", 1);
					SetPVarInt(i2, "pSeatIDE", GetPlayerVehicleSeat(i2));
					TogglePlayerControllable(i2, 0);
				}
			}
			return 1;
		}
		
	}
	return 0;
}
forward WjedzTimerDebug(playerid);
public WjedzTimerDebug(playerid)
{
	new pVehAcID = GetPlayerVehicleID(playerid);
	timeSecWjedz[playerid]++; 
	if(timeSecWjedz[playerid] == 2)
	{
		for(new i; i<valueWjedz; i++)
		{
		
			if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]))//Wejœcie
			{
				if(GetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer") == 1)
				{
					sendTipMessageEx(playerid, COLOR_RED, "==========[Wjedz]=========="); 
					sendTipMessage(playerid, "Ustalanie VW --> Udane"); 
					SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
					return 1;
				}
				RemovePlayerFromVehicle(playerid);
				SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
				SetVehicleVirtualWorld(pVehAcID, wjazdy[i][wj_VW]);
				sendTipMessageEx(playerid, COLOR_RED, "==========[Wjedz]=========="); 
				sendTipMessage(playerid, "Ustalanie VW --> Udane"); 		
			}
			if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]))//Wyjscie
			{
				if(GetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer") == 1)
				{
					sendTipMessageEx(playerid, COLOR_RED, "==========[Wjedz]=========="); 
					sendTipMessage(playerid, "Ustalanie VW --> Udane"); 
					SetPlayerVirtualWorld(playerid, 0);
					return 1;
				}
				RemovePlayerFromVehicle(playerid);
				SetPlayerVirtualWorld(playerid, 0);
				SetVehicleVirtualWorld(pVehAcID, 0);
				sendTipMessage(playerid, "Ustalanie zerowego VW --> Udane"); 
			}
			
		}
		PutPlayerInVehicle(playerid, pVehAcID, 0);
	}
	if(timeSecWjedz[playerid] == 4)
	{
		for(new i; i<valueWjedz; i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]))//Wejœcie
			{
				if(GetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer") == 1)
				{
					new pSeat = GetPVarInt(playerid, "pSeatIDE"); 
					sendTipMessage(playerid, "Ustalanie pozycji wyjazdowej --> Udane"); 
					sendTipMessageEx(playerid, COLOR_P@, "Pomyœlnie wykonano wjazd/wyjazd");
					sendTipMessageEx(playerid, COLOR_RED, "==========[Success]==========");
					PutPlayerInVehicle(playerid, pVehAcID, pSeat);
					KillTimer(WjedzTimer[playerid]);
					TogglePlayerControllable(playerid, 1);
					SetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer", 0);
					return 1;
				}
				SetVehiclePos(pVehAcID, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
				sendTipMessage(playerid, "Ustalanie pozycji wjazdowej --> Udane"); 	
			}
			else if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]))//Wejœcie
			{
				if(GetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer") == 1)
				{
					new pSeat = GetPVarInt(playerid, "pSeatIDE"); 
					sendTipMessage(playerid, "Ustalanie pozycji wyjazdowej --> Udane"); 
					sendTipMessageEx(playerid, COLOR_P@, "Pomyœlnie wykonano wjazd/wyjazd");
					sendTipMessageEx(playerid, COLOR_RED, "==========[Success]==========");
					PutPlayerInVehicle(playerid, pVehAcID, pSeat);
					KillTimer(WjedzTimer[playerid]);
					TogglePlayerControllable(playerid, 1);
					SetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer", 0);
					return 1;
				}
				SetVehiclePos(pVehAcID, wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]);
				sendTipMessage(playerid, "Ustalanie pozycji wyjazdowej --> Udane"); 
			}
		}
		PlayerTextDrawHide(playerid, textwjedz[playerid]);
		TogglePlayerControllable(playerid, 1);
		sendTipMessageEx(playerid, COLOR_P@, "Pomyœlnie wykonano wjazd/wyjazd");
		sendTipMessageEx(playerid, COLOR_RED, "==========[Success]==========");
		timeSecWjedz[playerid] = 0;
		SetPVarInt(playerid, "JestPodczasWjezdzania", 0);
		KillTimer(WjedzTimer[playerid]);
	}
	return 1;
}
/*
============================[OLD]==============================
stock SprawdzWjazdy(playerid)
{
	new playerVehicleID = GetPlayerVehicleID(playerid);
	new pSeatID = GetPlayerVehicleSeat(playerid);
	for(new i; i<valueWjedz; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]))
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				if(wjazdy[i][pFracOwn] == 0 && wjazdy[i][pOrgOwn] == 0)
				{
					SetVehiclePos(playerVehicleID, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
					SetVehicleVirtualWorld(playerVehicleID, wjazdy[i][wj_VW]);
					SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
					PutPlayerInVehicle(playerid, playerVehicleID, pSeatID);
					PlayerInfo[playerid][pLocal] = wjazdy[i][wj_PLOCAL];
					foreach(Player, i2)
					{
						if(IsPlayerInVehicle(i2, playerVehicleID) && GetPlayerVehicleSeat(i2) > 0)
						{
							pSeatID = GetPlayerVehicleSeat(i2);
							SetPlayerVirtualWorld(i2, wjazdy[i][wj_VW]);
							SetVehicleVirtualWorld(playerVehicleID, wjazdy[i][wj_VW]);
							SetVehiclePos(playerVehicleID, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
							PutPlayerInVehicle(i2, playerVehicleID, pSeatID);
							PlayerInfo[i2][pLocal] = wjazdy[i][wj_PLOCAL];
						}
					}
					return 1;
				}
				if(wjazdy[i][pFracOwn] > 0 && wjazdy[i][pOrgOwn] == 0)
				{
					if(GetPlayerFraction(playerid) == wjazdy[i][pFracOwn])
					{
						SetVehiclePos(playerVehicleID, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
						SetVehicleVirtualWorld(playerVehicleID, wjazdy[i][wj_VW]);
						SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
						PutPlayerInVehicle(playerid, playerVehicleID, pSeatID);
						PlayerInfo[playerid][pLocal] = wjazdy[i][wj_PLOCAL];
						foreach(Player, i2)
						{
							if(IsPlayerInVehicle(i2, playerVehicleID) && GetPlayerVehicleSeat(i2) > 0)
							{
								pSeatID = GetPlayerVehicleSeat(i2);
								SetPlayerVirtualWorld(i2, wjazdy[i][wj_VW]);
								SetVehicleVirtualWorld(playerVehicleID, wjazdy[i][wj_VW]);
								SetVehiclePos(playerVehicleID, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
								PutPlayerInVehicle(i2, playerVehicleID, pSeatID);
								PlayerInfo[i2][pLocal] = wjazdy[i][wj_PLOCAL];
							}
						}
					}
					else
					{
						sendErrorMessage(playerid, "Nie mo¿esz tutaj wjechaæ!"); 
					}
					return 1;
				}
				else if(wjazdy[i][pFracOwn] == 0 && wjazdy[i][pOrgOwn] > 0)
				{
					if(GetPlayerFraction(playerid) == wjazdy[i][pFracOwn])
					{
						SetVehiclePos(playerVehicleID, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
						SetVehicleVirtualWorld(playerVehicleID, wjazdy[i][wj_VW]);
						SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
						PutPlayerInVehicle(playerid, playerVehicleID, pSeatID);
						PlayerInfo[playerid][pLocal] = wjazdy[i][wj_PLOCAL];
						foreach(Player, i2)
						{
							if(IsPlayerInVehicle(i2, playerVehicleID) && GetPlayerVehicleSeat(i2) > 0)
							{
								pSeatID = GetPlayerVehicleSeat(i2);
								SetPlayerVirtualWorld(i2, wjazdy[i][wj_VW]);
								SetVehicleVirtualWorld(playerVehicleID, wjazdy[i][wj_VW]);
								SetVehiclePos(playerVehicleID, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
								PutPlayerInVehicle(i2, playerVehicleID, pSeatID);
								PlayerInfo[i2][pLocal] = wjazdy[i][wj_PLOCAL];
							}
						}
					}
					else
					{
						sendErrorMessage(playerid, "Nie mo¿esz tutaj wjechaæ!"); 
					}
					return 1;
				}
				else if(wjazdy[i][pFracOwn] > 0 && wjazdy[i][pOrgOwn] > 0)
				{
					if(GetPlayerFraction(playerid) == wjazdy[i][pFracOwn] || GetPlayerOrg(playerid) == wjazdy[i][pOrgOwn])
					{
						SetVehiclePos(playerVehicleID, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
						SetVehicleVirtualWorld(playerVehicleID, wjazdy[i][wj_VW]);
						SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
						PutPlayerInVehicle(playerid, playerVehicleID, pSeatID);
						PlayerInfo[playerid][pLocal] = wjazdy[i][wj_PLOCAL];
						foreach(Player, i2)
						{
							if(IsPlayerInVehicle(i2, playerVehicleID) && GetPlayerVehicleSeat(i2) > 0)
							{
								pSeatID = GetPlayerVehicleSeat(i2);
								SetPlayerVirtualWorld(i2, wjazdy[i][wj_VW]);
								SetVehicleVirtualWorld(playerVehicleID, wjazdy[i][wj_VW]);
								SetVehiclePos(playerVehicleID, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
								PutPlayerInVehicle(i2, playerVehicleID, pSeatID);
								PlayerInfo[i2][pLocal] = wjazdy[i][wj_PLOCAL];
							}
						}
					}
					else
					{
						sendErrorMessage(playerid, "Nie mo¿esz tutaj wjechaæ!"); 
					}
				}
				return 1;
			}
			else
			{
				sendTipMessage(playerid, "Mariusz_Cieæ mówi: Po co wchodzisz przez bramê? Drzwi nie masz?"); 
				SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
				PlayerInfo[playerid][pLocal] = wjazdy[i][wj_PLOCAL];
				SetPlayerPos(playerid, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
				return 1;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]))
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				if(wjazdy[i][pFracOwn] == 0 && wjazdy[i][pOrgOwn] == 0)
				{
					pSeatID = GetPlayerVehicleSeat(playerid);
					SetVehiclePos(playerVehicleID, wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]);
					SetVehicleVirtualWorld(playerVehicleID, 0);
					SetPlayerVirtualWorld(playerid, 0);
					PutPlayerInVehicle(playerid, playerVehicleID, pSeatID);
					PlayerInfo[playerid][pLocal] = 255;
					foreach(Player, i2)
					{
						if(IsPlayerInVehicle(i2, playerVehicleID) && GetPlayerVehicleSeat(i2) > 0)
						{
							pSeatID = GetPlayerVehicleSeat(i2);
							SetPlayerVirtualWorld(i2, 0);
							SetVehicleVirtualWorld(playerVehicleID, 0);
							SetVehiclePos(playerVehicleID, wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]);
							PutPlayerInVehicle(i2, playerVehicleID, pSeatID);
							PlayerInfo[i2][pLocal] = 255;
						}
					}
					return 1;
				}
				if(GetPlayerFraction(playerid) == wjazdy[i][pFracOwn] || GetPlayerOrg(playerid) == wjazdy[i][pOrgOwn])
				{
					pSeatID = GetPlayerVehicleSeat(playerid);
					SetVehiclePos(playerVehicleID, wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]);
					SetVehicleVirtualWorld(playerVehicleID, 0);
					SetPlayerVirtualWorld(playerid, 0);
					PutPlayerInVehicle(playerid, playerVehicleID, pSeatID);
					PlayerInfo[playerid][pLocal] = 255;
					foreach(Player, i2)
					{
						if(IsPlayerInVehicle(i2, playerVehicleID) && GetPlayerVehicleSeat(i2) > 0)
						{
							pSeatID = GetPlayerVehicleSeat(i2);
							SetPlayerVirtualWorld(i2, 0);
							SetVehicleVirtualWorld(playerVehicleID, 0);
							SetVehiclePos(playerVehicleID, wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]);
							PutPlayerInVehicle(i2, playerVehicleID, pSeatID);
							PlayerInfo[i2][pLocal] = 255;
						}
					}
					return 1;
				}
			}
			else
			{
				sendTipMessage(playerid, "Mariusz_Cieæ mówi: Po co wchodzisz przez bramê? Drzwi nie masz?"); 
				SetPlayerVirtualWorld(playerid, 0);
				PlayerInfo[playerid][pLocal] = 255;
				SetPlayerPos(playerid, wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]);
				return 1;
			}
		}	
	}
	return 0;
}
*/ 
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end
