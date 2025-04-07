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

//------------------<[ obs�uga komendy /akceptuj: ]>--------------------
command_akceptuj_praca(playerid)
{
    new job = GettingJob[playerid];
    if(job > 0)
    {
        if(!CanPlayerTakeJob(playerid, job))
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie mo�esz wzi�� tej pracy, jeste� we frakcji!");
            return 1;
        }
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Podpisa�e� umowe na 5 godzin, zaczynasz now� prac�.");
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Gratulujemy nowej pracy, wpisz /pomoc aby zobaczy� nowe komendy.");
        PlayerInfo[playerid][pJob] = GettingJob[playerid];
        Log(serverLog, INFO, "Gracz %s do��czy� do pracy %d.", GetPlayerLogName(playerid), PlayerInfo[playerid][pJob]);
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
        SendClientMessage(playerid, COLOR_GREY, "   W tym miejscu nie mo�na wzi�� pracy!");
        return 1;
    }
}
