//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wyjedz ]------------------------------------------------//
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

CMD:wjedz(playerid) return cmd_wyjedz(playerid);
CMD:wyjedz(playerid)
{
//====================[DLA USSS]======================================
	if(GetPlayerFraction(playerid) == FRAC_BOR)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1827.0527,-1539.3645,13.2089))//Wjazdowa pozycja
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new pVehID = GetPlayerVehicleID(playerid);
				SetVehiclePos(pVehID, 1818.77222, -1536.09314, 13.11075);
				SetVehicleVirtualWorld(pVehID, 0);
				SetPlayerVirtualWorld(playerid, 0);
				PutPlayerInVehicle(playerid, pVehID, 0);
				foreach(new i : Player)//Sprawdza czy z graczem sπ inni gracze
				{
					if(IsPlayerInVehicle(i, pVehID))
					{
						new iseat = GetPlayerVehicleSeat(i);
						SetPlayerVirtualWorld(i, 0);
						PutPlayerInVehicle(i, pVehID, iseat);
					}
				}
			
			}
			else//Jeúli gracz jest sam, nie w pojeüdzie
			{
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPos(playerid, 1818.77222, -1536.09314, 13.11075);
				GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~Borowiku! Nie umiesz wchodzic drzwiami?", 4000, 3);
			}
		
		
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1818.77222, -1536.09314, 13.11075))//Wyjazdowa pozycja
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new pVehID = GetPlayerVehicleID(playerid);
				SetVehiclePos(pVehID, 1827.0527,-1539.3645,13.2089);
				SetVehicleVirtualWorld(pVehID, 0);
				SetPlayerVirtualWorld(playerid, 0);
				PutPlayerInVehicle(playerid, pVehID, 0);
				foreach(new i : Player)//Sprawdza czy z graczem sπ inni gracze
				{
					if(IsPlayerInVehicle(i, pVehID))
					{
						new iseat = GetPlayerVehicleSeat(i);
						SetPlayerVirtualWorld(i, 0);
						PutPlayerInVehicle(i, pVehID, iseat);
					}
				}
			
			}
			else//Jeúli gracz jest sam, nie w pojeüdzie
			{
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPos(playerid, 1825.18274, -1538.21204, 13.11075);
				GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~Borowiku! Nie umiesz wchodzic drzwiami?", 4000, 3);
			}
		
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1753.2124,-1538.7153,9.1894))//WJAZD NA PARKING PODZIEMNY
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new pVehID = GetPlayerVehicleID(playerid);
				SetVehiclePos(pVehID, 1481.5889,-1519.8298,66.9969);
				SetVehicleVirtualWorld(pVehID, 2);
				SetPlayerVirtualWorld(playerid, 2);
				PutPlayerInVehicle(playerid, pVehID, 0);
				foreach(new i : Player)//Sprawdza czy z graczem sπ inni gracze
				{
					if(IsPlayerInVehicle(i, pVehID))
					{
						new iseat = GetPlayerVehicleSeat(i);
						SetPlayerVirtualWorld(i, 2);
						PutPlayerInVehicle(i, pVehID, iseat);
					}
				}
			
			}
			else//Jeúli gracz jest sam, nie w pojeüdzie
			{
				SetPlayerVirtualWorld(playerid, 2);
				SetPlayerPos(playerid, 1481.5889,-1519.8298,66.9969);
				GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~Jak krecik, drzwi nie masz?", 4000, 3);
			}
		
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1481.5889,-1519.8298,66.9969))//WYJAZD Z PARKINGU PODZIEMNEGO
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new pVehID = GetPlayerVehicleID(playerid);
				SetVehiclePos(pVehID, 1753.2124,-1538.7153,9.1894);
				SetVehicleVirtualWorld(pVehID, 0);
				SetPlayerVirtualWorld(playerid, 0);
				PutPlayerInVehicle(playerid, pVehID, 0);
				foreach(new i : Player)//Sprawdza czy z graczem sπ inni gracze
				{
					if(IsPlayerInVehicle(i, pVehID))
					{
						new iseat = GetPlayerVehicleSeat(i);
						SetPlayerVirtualWorld(i, 0);
						PutPlayerInVehicle(i, pVehID, iseat);
					}
				}
			
			}
			else//Jeúli gracz jest sam, nie w pojeüdzie
			{
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPos(playerid, 1753.2124,-1538.7153,9.1894);
				GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~Jak krecik, drzwi nie masz?", 4000, 3);
			}
		
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteú w odpowiednim miejscu!"); 
		}
	
	}
	//===================[KOMENDA DLA FBI]=====================================
	else if(GetPlayerFraction(playerid) == FRAC_FBI)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, 593.47217, -1509.27258, 15.75509))//Wjazdowa pozycja
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new pVehID = GetPlayerVehicleID(playerid);
				SetVehiclePos(pVehID, 1059.91748, 1553.65698, 7.59697);
				SetVehicleVirtualWorld(pVehID, 2);
				SetPlayerVirtualWorld(playerid, 2);
				PutPlayerInVehicle(playerid, pVehID, 0);
				foreach(new i : Player)//Sprawdza czy z graczem sπ inni gracze
				{
					if(IsPlayerInVehicle(i, pVehID))
					{
						new iseat = GetPlayerVehicleSeat(i);
						SetPlayerVirtualWorld(i, 2);
						PutPlayerInVehicle(i, pVehID, iseat);
					}
				}
			
			}
			else//Jeúli gracz jest sam, nie w pojeüdzie
			{
				SetPlayerVirtualWorld(playerid, 2);
				SetPlayerPos(playerid, 1059.91748, 1553.65698, 7.59697);
			}
		
		
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5.0, 1059.91748, 1553.65698, 7.59697))//Pozycja wyjazdowa
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new pVehID = GetPlayerVehicleID(playerid);
				SetVehiclePos(pVehID, 593.47217, -1509.27258, 15.75509);
				SetVehicleVirtualWorld(pVehID, 0);
				SetPlayerVirtualWorld(playerid, 0);
				PutPlayerInVehicle(playerid, pVehID, 0);
				foreach(new i : Player)//Sprawdza czy z graczem sπ inni gracze
				{
					if(IsPlayerInVehicle(i, pVehID))
					{
						new iseat = GetPlayerVehicleSeat(i);
						SetPlayerVirtualWorld(i, 0);
						PutPlayerInVehicle(i, pVehID, iseat);
					}
				}
			
			}
			else//Jeúli gracz jest sam, nie w pojeüdzie
			{
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPos(playerid, 593.47217, -1509.27258, 15.75509);
			}
		
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteú w odpowiednim miejscu!"); 
		}
	
	
	}//==============================[KOMENDA DLA LSPD]====================================
	else if(GetPlayerFraction(playerid) == FRAC_LSPD)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1588.0006,-1633.5677,13.1671))
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new pVehID = GetPlayerVehicleID(playerid);
				SetVehiclePos(pVehID, 1588.9865,-1642.7157,12.4604);
				SetVehicleVirtualWorld(pVehID, 2);
				SetPlayerVirtualWorld(playerid, 2);
				PutPlayerInVehicle(playerid, pVehID, 0);
				foreach(new i : Player)//Sprawdza czy z graczem sπ inni gracze
				{
					if(IsPlayerInVehicle(i, pVehID))
					{
						new iseat = GetPlayerVehicleSeat(i);
						SetPlayerVirtualWorld(i, 2);
						PutPlayerInVehicle(i, pVehID, iseat);
					}
				}
			
			}
			else//Jeúli gracz jest sam, nie w pojeüdzie
			{
				SetPlayerVirtualWorld(playerid, 2);
				SetPlayerPos(playerid, 1588.9865,-1642.7157,12.4604);
			}
		
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1588.9865,-1642.7157,12.4604))
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new pVehID = GetPlayerVehicleID(playerid);
				SetVehiclePos(pVehID, 1588.0006,-1633.5677,13.1671);
				SetVehicleVirtualWorld(pVehID, 0);
				SetPlayerVirtualWorld(playerid, 0);
				PutPlayerInVehicle(playerid, pVehID, 0);
				foreach(new i : Player)//Sprawdza czy z graczem sπ inni gracze
				{
					if(IsPlayerInVehicle(i, pVehID))
					{
						new iseat = GetPlayerVehicleSeat(i);
						SetPlayerVirtualWorld(i, 0);
						PutPlayerInVehicle(i, pVehID, iseat);
					}
				}
			
			}
			else//Jeúli gracz jest sam, nie w pojeüdzie
			{
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPos(playerid, 1588.0006,-1633.5677,13.1671);
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteú w odpowiednim miejscu pauo!"); 
		}
	
	
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteú w organizacji, ktÛra ma parking podziemny!");
	}

	return 1;
}

