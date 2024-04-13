//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                               praca_kierowca                                              //
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
// Data utworzenia: 31.03.2024
//Opis:
/*
	Praca kierowcy.
*/

//

//-----------------<[ Timery: ]>-------------------
Driver_JednaSekundaTimer(playerid)
{
	new string[MAX_MESSAGE_LENGTH];
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	new taxidriver = TransportDriver[playerid];
	if(taxidriver != 999) //Taxi
	{
		new Float:tx, Float:ty, Float:tz;
		GetPlayerPos(taxidriver, tx, ty, tz);
		new Float:distanceGain = (VectorSize(SavePlayerPos[taxidriver][LastX] - tx, SavePlayerPos[taxidriver][LastY] - ty, SavePlayerPos[taxidriver][LastZ]-tz)/1000)*3;

        SavePlayerPos[taxidriver][LastX] = tx;
        SavePlayerPos[taxidriver][LastY] = ty;
        SavePlayerPos[taxidriver][LastZ] = tz;
		SetPVarInt(taxidriver, "dont-update-pos", 1);

		if(distanceGain > 0.1) // próg 360km/h (100m/s) ?
		{
			distanceGain = 0.1;
		}
		TransportDist[playerid] += distanceGain;
		format(string, sizeof(string), "%.1fKM", TransportDist[playerid]);
		PlayerTextDrawSetString(playerid, TAXI_DIST[playerid], string);
		PlayerTextDrawSetString(taxidriver, TAXI_DIST[taxidriver], string);

		PlayerTextDrawShow(playerid, TAXI_DIST[playerid]);
		PlayerTextDrawShow(taxidriver, TAXI_DIST[taxidriver]);

		format(string, sizeof(string), "$%d", floatround((TransportDist[playerid] * TransportValue[taxidriver])+TransportValue[taxidriver]));
		PlayerTextDrawSetString(playerid, TAXI_COST[playerid], string);
		PlayerTextDrawSetString(taxidriver, TAXI_COST[taxidriver], string);

		PlayerTextDrawShow(playerid, TAXI_COST[playerid]);
		PlayerTextDrawShow(taxidriver, TAXI_COST[taxidriver]);
		return 1;
	}

	if(TaxiCallTime[playerid] > 0)
	{
		if(TaxiAccepted[playerid] < 999)
		{
			if(IsPlayerConnected(TaxiAccepted[playerid]))
			{
				GetPlayerPos(TaxiAccepted[playerid], x, y, z);
				SetPlayerCheckpoint(playerid, x, y, z, 5);
			}
		}
	}
	if(BusCallTime[playerid] > 0)
	{
		if(BusAccepted[playerid] < 999)
		{
			if(IsPlayerConnected(BusAccepted[playerid]))
			{
				GetPlayerPos(BusAccepted[playerid], x, y, z);
				SetPlayerCheckpoint(playerid, x, y, z, 5);
			}
		}
	}
	return 0;
}

//end