//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                   prace                                                   //
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
// Data utworzenia: 15.05.2019
//Opis:
/*
	System prac.
*/

//

//------------------<[ obs³uga komendy /akceptuj: ]>--------------------
command_akceptuj_praca(playerid)
{
    new job = GettingJob[playerid];
    if(job > 0)
    {
        if(!CanPlayerTakeJob(playerid, job))
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie mo¿esz wzi¹æ tej pracy, jesteœ we frakcji!");
            return 1;
        }
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Podpisa³eœ umowe na 5 godzin, zaczynasz now¹ pracê.");
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Gratulujemy nowej pracy, wpisz /pomoc aby zobaczyæ nowe komendy.");
        PlayerInfo[playerid][pJob] = GettingJob[playerid];
        Log(serverLog, INFO, "%s do³¹czy³ do pracy %s", GetPlayerLogName(playerid), GetJobLogName(PlayerInfo[playerid][pJob]));
        GettingJob[playerid] = 0;

        if(GetPlayerJob(playerid) == JOB_MEDIC)
        {
            if(PlayerInfo[playerid][pSex] == 1) PlayerInfo[playerid][pUniform] = 20743;
            else PlayerInfo[playerid][pUniform] = 20468;
        }
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "   W tym miejscu nie mo¿na wzi¹æ pracy!");
        return 1;
    }
}
