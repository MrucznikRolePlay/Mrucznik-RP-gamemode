//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ sprawdzneon ]----------------------------------------------//
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

YCMD:sprawdzneon(playerid, params[], help)
{
    if(PlayerInfo[playerid][pJob] == 7 || PlayerInfo[playerid][pAdmin] >= 100)
    {
        if(gettime() < GetPVarInt(playerid, "checkNeonLimit")) return sendErrorMessage(playerid, "Neony mo¿esz sprawdzaæ co 40 sekund");
        if(PlayerInfo[playerid][pMechSkill] < 101 && PlayerInfo[playerid][pAdmin] < 100) return sendErrorMessage(playerid, "Komenda od 3 skilla w górê");
        new pid;
        if( sscanf(params, "k<fix>", pid))
        {
            sendTipMessage(playerid, "U¿yj /sprawdzneon [id gracza]");
            return 1;
        }
        if(pid == playerid) return sendErrorMessage(playerid, "Nie mo¿esz sprawdziæ neonów sam sobie");
        new string[128];
        //new veh_idx = VehicleUID[veh_id][vUID];
        new kolorneonu[16] = "";
        if(!IsPlayerInAnyVehicle(pid)) return sendErrorMessage(playerid, "Ten gracz nie jest w ¿adnym pojeŸdzie");
        if(GetDistanceBetweenPlayers(playerid,pid) > 5) return sendErrorMessage(playerid, "Jesteœcie od siebie zbyt daleko");
        new veh_id = GetPlayerVehicleID(pid);
        new cNeon = CarData[VehicleUID[veh_id][vUID]][c_Neon];
        RunCommand(playerid, "/me", "zagl¹da pod podwozie w poszukiwaniu neonów");
        if(cNeon != 0)
        {
            if(cNeon == 18652)
            {
                kolorneonu = "bia³e";
            }
            else if(cNeon == 18650)
            {
                 kolorneonu = "¿ó³te";
            }
            else if(cNeon == 18649)
            {
                kolorneonu = "zielone";
            }
            else if(cNeon == 18648)
            {
                kolorneonu = "niebieskie";
            }
            else if(cNeon == 18647)
            {
                kolorneonu = "czerwone";
            }
            else if(cNeon == 18651)
            {
                kolorneonu = "ró¿owe";
            }
            format(string, sizeof(string), "Mechanik %s: Pojazd %s posiada %s neony", GetNick(playerid), VehicleNames[GetVehicleModel(veh_id)-400], kolorneonu);
        }   
        else
        {
            format(string, sizeof(string), "Mechanik %s: Pojazd %s nie posiada neonów", GetNick(playerid), VehicleNames[GetVehicleModel(veh_id)-400]);
        }
        //SendClientMessage(pid, COLOR_GRAD1, string);
        //if(playerid != pid) SendClientMessage(playerid, COLOR_GRAD1, string);
        ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
        format(string, sizeof(string), "Pomog³eœ %s w sprawdzeniu neonów! Skill +1", GetNick(pid));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
        ZabierzKase(playerid, 10000);
        PlayerInfo[playerid][pMechSkill] ++;
        SetPVarInt(playerid, "checkNeonLimit", gettime() + 40);
    }
    else
    {
        noAccessMessage(playerid);
    }
    return 1;
}
