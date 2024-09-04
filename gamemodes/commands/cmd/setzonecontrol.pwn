//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ setzonecontrol ]--------------------------------------------//
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

YCMD:setzonecontrol(playerid, params[], help)
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid)) {
        new id, frac;
        if(sscanf(params, "dd", id, frac)) return sendTipMessage(playerid, "U¿yj /setzonecontrol [ZoneID] [Owner]");
        if(id < 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Numer od 0");
        ZoneControl[id] = frac;
        MruMySQL_SetZoneControl(frac, id);

        new org;
        if(frac > 100) org = orgID(frac-100);

        foreach(new i : Player)
        {
            if(frac > 100)
            {
                GangZoneHideForPlayer(i, id);
                GangZoneShowForPlayer(i, id, OrgInfo[org][o_Color] | 0x44);
            }
        }

        SendClientMessage(playerid, COLOR_GRAD2, "SET.");
    }
    return 1;

}
