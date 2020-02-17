#include <a_samp>
#include <profiler>

public OnRconCommand(cmd[])
{
    if(strcmp(cmd, "profile start", true) == 0)
    {
		Profiler_Start();
        SendClientMessage(playerid, 0xFFFFFFFF, "Profilowanie wystartowane.");
        return 1;
    }
	else if(strcmp(cmd, "profile stop", true) == 0)
    {
		Profiler_Stop();
        SendClientMessage(playerid, 0xFFFFFFFF, "Profilowanie zatrzymane.");
        return 1;
    }
	else if(strcmp(cmd, "profile dump", true) == 0)
    {
		Profiler_Dump();
        SendClientMessage(playerid, 0xFFFFFFFF, "Dump stworzony.");
        return 1;
    }
    return 0;
}