//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  profiler                                                 //
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
// Autor: Mrucznik
// Data utworzenia: 15.03.2020


//

//------------------<[ Implementacja: ]>-------------------
command_profiler_Impl(playerid, option[32])
{
    if(!IsPlayerAdmin(playerid)) 
    {
        noAccessMessage(playerid);
        return 1;
    }

    if(strcmp(option, "start", true) == 0)
    {
		Profiler_Start();
        SendClientMessage(playerid, 0xFFFFFFFF, "Profilowanie wystartowane.");
        return 1;
    }
	else if(strcmp(option, "stop", true) == 0)
    {
		Profiler_Stop();
        SendClientMessage(playerid, 0xFFFFFFFF, "Profilowanie zatrzymane.");
        return 1;
    }
	else if(strcmp(option, "dump", true) == 0)
    {
		Profiler_Dump();
        SendClientMessage(playerid, 0xFFFFFFFF, "Dump stworzony.");
        return 1;
    }
	else if(strcmp(option, "status", true) == 0)
    {
		new ProfilerState:s = Profiler_GetState();
		switch(s) 
		{
			case PROFILER_DISABLED: SendClientMessage(playerid, 0xFFFFFFFF, "PROFILER_DISABLED");
			case PROFILER_ATTACHING: SendClientMessage(playerid, 0xFFFFFFFF, "PROFILER_ATTACHING");
			case PROFILER_ATTACHED: SendClientMessage(playerid, 0xFFFFFFFF, "PROFILER_ATTACHED");
			case PROFILER_STARTING: SendClientMessage(playerid, 0xFFFFFFFF, "PROFILER_STARTING");
			case PROFILER_STARTED: SendClientMessage(playerid, 0xFFFFFFFF, "PROFILER_STARTED");
			case PROFILER_STOPPING: SendClientMessage(playerid, 0xFFFFFFFF, "PROFILER_STOPPING");
			case PROFILER_STOPPED: SendClientMessage(playerid, 0xFFFFFFFF, "PROFILER_STOPPED");
		}
        return 1;
    }
    return 1;
}

//end