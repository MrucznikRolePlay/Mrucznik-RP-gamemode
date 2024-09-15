//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                sprawdzneon                                                //
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
// Data utworzenia: 01.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_sprawdzneon_Impl(playerid, giveplayerid)
{
	if(PlayerInfo[playerid][pJob] != 7)
    {
        MruMessageFail(playerid, "Nie jesteœ mechanikiem.");
        return 1;
    }

    if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
    {
        MruMessageFail(playerid, "Gracz jest za daleko.");
        return 1;
    }

    if(SpamujeMechanik[playerid] != 0)
    {
        MruMessageFail(playerid, "Poczekaj 10 sekund przed ponownym u¿yciem komendy.");
        return 1;
    }

    if(GetPlayerJobSkill(playerid, JOB_MECHANIC) < 3)
    {
        MruMessageFail(playerid, "Musisz mieæ 3 skill mechanika aby sprawdzaæ neony.");
        return 1;
    }

    if(!IsPlayerInAnyVehicle(giveplayerid))
    {
        MruMessageFail(playerid, "Gracz nie jest w pojeŸdzie.");
        return 0;
    }

    ZabierzKase(playerid, 10000);
    ChatMe(playerid, "zagl¹da pod podwozie w poszukiwaniu neonów");

    new string[MAX_MESSAGE_LENGHT];
    new kolorneonu[16] = "";
    new veh_id = GetPlayerVehicleID(giveplayerid);
    new cNeon = CarData[VehicleUID[veh_id][vUID]][c_Neon];
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
    ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

    MruMessageGoodInfoF(playerid, "Pomog³eœ %s w sprawdzeniu neonów!", GetNick(giveplayerid));
    MruMessageGoodInfoF(giveplayerid, "%s pomóg³ Ci w sprawdzeniu neonów!", GetNick(playerid));
   
    IncreasePlayerJobSkill(playerid, JOB_MECHANIC, 1);
    
    SetTimerEx("AntySpamTimer",10000,0,"d",playerid);
    AntySpam[playerid] = 1;
    return 1;
}

//end