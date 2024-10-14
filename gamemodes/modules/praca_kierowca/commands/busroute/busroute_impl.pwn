//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  busroute                                                 //
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
// Data utworzenia: 13.10.2024


//

//------------------<[ Implementacja: ]>-------------------
command_busroute_Impl(playerid, route, action[32], param[128])
{
    if(route < 0 || route >= MAX_BUS_ROUTES)
    {
        MruMessageFail(playerid, "ID Trasy od 0 do "#MAX_BUS_ROUTES);
        return 1;
    }


    if(strcmp(action, "describe", true) == 0)
    {
        new busStops;
        for(busStops=0; busStops<MAX_BUS_STOPS; busStops++)
        {
            if(!BusStops[route][busStops][bs_Active])
            {
                break;
            }
        }
        SendClientMessage(playerid, -1, sprintf("Trasa autobusowa %s, hajs za przystanek: %d$, skill: %d, liczba przystanków: %d", 
            BusRoute[route][br_Name], BusRoute[route][br_MoneyPerStop], BusRoute[route][br_Skill], busStops));
        
        for(new busstop; busstop<MAX_BUS_STOPS; busstop++)
        {
            if(!BusStops[route][busstop][bs_Active])
            {
                break;
            }
            SendClientMessage(playerid, -1, sprintf("- Przystanek %s, Typ: %d, Checkpoint: %.4f, %.4f, %.4f, Obiekt: %.4f, %.4f, %.4f", 
                BusStops[route][busstop][bs_Name], BusStops[route][busstop][bs_Type],
                BusStops[route][busstop][bs_StopX], BusStops[route][busstop][bs_StopY], BusStops[route][busstop][bs_StopZ],
                BusStops[route][busstop][bs_ObjectX], BusStops[route][busstop][bs_ObjectY], BusStops[route][busstop][bs_ObjectZ]));
        }
        return 1;
    }
    else if(strcmp(action, "name", true) == 0)
    {
        format(BusRoute[route][br_Name], MAX_BUS_ROUTE_NAME, "%s", param);
    }
    else if(strcmp(action, "color", true) == 0)
    {
		new color;
		if(sscanf(param, "h", color))
		{
			sendTipMessage(playerid, "U¿yj /busroute color [kolor trafy w formacie RRGGBBAA (np. FF0000FF = czerwony, nieprzezroczysty)]");
			return 1;
		}
        BusRoute[route][br_Color] = color;
        SendClientMessage(playerid, color, "TO JEST NOWY KOLOR LINII AUTOBUSOWEJ");
    }
    else if(strcmp(action, "money", true) == 0)
    {
        new money = strval(param);
        if(money <= 0 || money > 1000000)
        {
            MruMessageFail(playerid, "Hajs od 1$ do 1 000 000$");
            return 1;
        }
        BusRoute[route][br_MoneyPerStop] = money;
    }
    else if(strcmp(action, "skill", true) == 0)
    {
        new skill = strval(param);
        if(skill <= 0 || skill > 5)
        {
            MruMessageFail(playerid, "Skill od 1 do 5");
            return 1;
        }
        BusRoute[route][br_Skill] = skill;
    }
    else
    {
        MruMessageFail(playerid, "Niepoprawna akcja.");
        RunCommand(playerid, "/busroute",  "");
        return 1;
    }
    MruMessageGoodInfo(playerid, sprintf("Ustawi³eœ %s na %s", action, param));
    SaveBusRoute(route);
    RecreateBusStops(route);
    return 1;
}

//end