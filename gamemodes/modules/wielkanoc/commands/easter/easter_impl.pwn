//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   easter                                                  //
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
// Autor: gumbal
// Data utworzenia: 09.04.2020


//

//------------------<[ Implementacja: ]>-------------------
command_easter_Impl(playerid, opcja[24], opcja2[24])
{
    if(EasterEggs_CanUse(playerid))
    {
        if(strcmp(opcja,"wlacz",true) == 0)
        {
            new string[128];
            EasterEggs_Setting_Started = 1;
            format(string, sizeof(string), "[EasterEgg]Admin %s w³¹czy³ mo¿liwoœæ podnoszenia jajek!", GetNick(playerid));
            SendMessageToAdmin(string, COLOR_P@);
            SendClientMessage(playerid, COLOR_GREY, "Podnoszenie jajek w³¹czone.");
            Log(adminLog, INFO, "%s w³¹czy³ mo¿liwoœæ podnoszenia jajek.", GetPlayerLogName(playerid));
        }
        if(strcmp(opcja,"wylacz",true) == 0)
        {
            new string[128];
            EasterEggs_Setting_Started = 0;
            format(string, sizeof(string), "[EasterEgg]Admin %s wy³¹czy³ mo¿liwoœæ podnoszenia jajek!", GetNick(playerid));
            SendMessageToAdmin(string, COLOR_P@);
            SendClientMessage(playerid, COLOR_GREY, "Podnoszenie jajek wy³¹czone.");
            Log(adminLog, INFO, "%s wy³¹czy³ mo¿liwoœæ podnoszenia jajek.", GetPlayerLogName(playerid));
        }
        if(strcmp(opcja,"goto",true) == 0)
        {
            if(strcmp(opcja2,"none", true) == 0) sendTipMessage(playerid, "Wpisz ID jajka.");
            else
            {
                new id = opcja2;
                if(EasterEggs_Exist(id))
                {
                    Wchodzenie(playerid);
                    SetPlayerVirtualWorld(playerid, EasterEggs[id][eggVW]);
                    SetPlayerInterior(playerid, EasterEggs[id][eggINT]);
                    SetPlayerPos(playerid, EasterEggs[id][egg_x_pos], EasterEggs[id][egg_y_pos], EasterEggs[id][egg_z_pos]);
                    Log(adminLog, INFO, "%s teleportowa³ siê do jajka o id %d.", GetPlayerLogName(playerid), id);
                }
                else sendTipMessage(playerid, "Jajko nie istnieje.");
            }
        }
        if(strcmp(opcja,"setmc",true) == 0)
        {
            new value, string[128];
            value = opcja2;
            if(value < 0 || value > EASTER_MAX_MCOINS) SendClientMessage(playerid, COLOR_RED, "Za wysoka kwota MC!");
            else
            {
                format(string, sizeof(string), "[EasterEgg]Admin %s ustawi³ nagrodê MC w wysokoœci %dMC!", GetNick(playerid), value);
                SendMessageToAdmin(string, COLOR_P@); 
                EasterEggs_Setting_MCOINS = value;
                Log(adminLog, INFO, "%s ustawi³ nagrodê za podniesienie jajka na %dMC.", GetPlayerLogName(playerid), value);
            }
        }
        if(strcmp(opcja,"setcash",true) == 0)
        {
            new value, string[128];
            value = opcja2;
            if(value < 0 || value > EASTER_MAX_CASH) SendClientMessage(playerid, COLOR_RED, "Za wysoka kwota!");
            else
            {
                format(string, sizeof(string), "[EasterEgg]Admin %s ustawi³ nagrodê pieniê¿n¹ %d$!", GetNick(playerid), value);
                SendMessageToAdmin(string, COLOR_P@);
                EasterEggs_Setting_CASH = value;
                Log(adminLog, INFO, "%s ustawi³ nagrodê za podniesienie jajka na %d$.", GetPlayerLogName(playerid), value);
            }
        }
        if(strcmp(opcja,"stworz",true) == 0)
        {
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            if(strcmp(opcja2,"mc",true) == 0)
            {
                new id = EasterEggs_Create(playerid, x, y, z, 2);
                Log(adminLog, INFO, "%s stworzy³ jajko z Mrucznik Coinsami o id %d.", GetPlayerLogName(playerid), id);
            }
            else if(strcmp(opcja2,"cash",true) == 0)
            {
                new id = EasterEggs_Create(playerid, x, y, z, 1);
                Log(adminLog, INFO, "%s stworzy³ jajko z hajsem o id %d.", GetPlayerLogName(playerid), id);
            }
            else SendClientMessage(playerid, COLOR_RED, "Nie podano opcji (mc/cash)!");
        }
        if(strcmp(opcja,"usun",true) == 0)
        {
            if(strcmp(opcja2,"none",true) == 0)
            {
                new i = EasterEggs_FindNearest(playerid);
                if(i != INVALID_EGG_ID)
                {
                    EasterEggs_Delete(playerid, i);
                }
                else
                {
                    sendTipMessage(playerid, "Nie znaleziono jajka w pobli¿u.");
                }
            }
            else EasterEggs_Delete(playerid, strval(opcja2));
        }
    }
    return 1;
}

//end