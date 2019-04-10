//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ respawncar ]----------------------------------------------//
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

CMD:respcar(playerid, params[]) return cmd_respawncar(playerid, params);
CMD:respawncar(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pNewAP] < 1) return 1;
    new v;
    if(sscanf(params, "d", v)) return sendTipMessage(playerid, "U¿yj /respawncar [ID pojazdu]");
    if(!(0 < v < MAX_VEHICLES)) return 1;
    if(GetVehicleModel(v) == 0) return sendErrorMessage(playerid, "Niepoprawne ID pojazdu.");
    new bool:used=false;
    foreach(Player, p)
	{
		if(GetPlayerVehicleID(p) == v)
		{
            used=true;
            break;
		}
	}
    if(used) return sendErrorMessage(playerid, "Pojazd nie jest pusty");
    else
    {
        SetVehicleToRespawn(v);
	    if(Car_GetOwnerType(v) == CAR_OWNER_PLAYER)
	    {
            Car_Unspawn(v);
        }
    }
    printf("[RESPAWN] Pojazd %d unspawnowany przez %s", v, GetNick(playerid));
    return 1;
}
