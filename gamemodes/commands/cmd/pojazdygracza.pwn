//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ pojazdygracza ]---------------------------------------------//
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

YCMD:pojazdygracza(playerid, params[], help)
{
	new string[256];
    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /pojazdygracza [playerid/CzêœæNicku]");
			return 1;
		}

        if(!IsPlayerConnected(para1))
        {
            return sendErrorMessage(playerid, "Nie ma takiego gracza.");
        }


		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || Uprawnienia(playerid, ACCESS_PANEL) || IsAScripter(playerid))
		{
            format(string, sizeof(string), "|---------- Auta %s ----------|",GetNickEx(para1));
    		SendClientMessage(playerid, COLOR_GREEN, string);
            new lUID, lPID = PlayerInfo[para1][pUID];
            for(new i=0;i<MAX_CAR_SLOT;i++)
            {
                if((lUID = PlayerInfo[para1][pCars][i]) != 0)
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
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
