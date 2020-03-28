//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ mojeauta ]-----------------------------------------------//
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

YCMD:mojeauta(playerid, params[], help)
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        format(string, sizeof(string), "|---------- Auta %s ----------|",sendername);
		SendClientMessage(playerid, COLOR_GREEN, string);
        new lUID, lPID = PlayerInfo[playerid][pUID];
        for(new i=0;i<MAX_CAR_SLOT;i++)
        {
            if((lUID = PlayerInfo[playerid][pCars][i]) != 0)
            {
                if(CarData[lUID][c_Owner] == lPID)
                {
                    if(CarData[lUID][c_ID] == 0) format(string, sizeof(string), "Auto %d: Marka %s, UID %d (unspawnowane)", i+1, VehicleNames[CarData[lUID][c_Model]-400], CarData[lUID][c_UID]);
                    else format(string, sizeof(string), "Auto %d: Marka %s, UID %d (SA-MP ID %d)", i+1, VehicleNames[CarData[lUID][c_Model]-400], CarData[lUID][c_UID], CarData[lUID][c_ID]);
				    SendClientMessage(playerid, COLOR_YELLOW, string);
                }
            }
        }
        new day, month, year, hour, minuite, second;
        getdate(year, month, day);
        gettime(hour, minuite, second);
        format(string, sizeof(string), "%d/%d/%d %d:%d:%d", day, month, year, hour, minuite, second);
		SendClientMessage(playerid, COLOR_GREY, string);
    }
    return 1;
}
