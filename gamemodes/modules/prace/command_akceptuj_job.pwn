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
command_akceptuj_job(playerid)
{
    new job = GettingJob[playerid];
    new bool:canTakeJob = true;
    if(job > 0)
    {
        if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0 || PlayerInfo[playerid][pOrg] != 0)
        {
            if(IsAPrzestepca(playerid))
            {
                if(job != JOB_DRAGDEALER && job != JOB_CARTHIEF && job != JOB_GUNDEALER)
                {
                    canTakeJob = false;
                }
            }
            else
            {
                if(job != JOB_DRIVER)
                {
                    canTakeJob = false;
                }
            }
        }

        if(!canTakeJob)
        {
            SendClientMessage(playerid, COLOR_GREY, "   Nie mo¿esz wzi¹æ tej pracy, jesteœ we frakcji!");
            return 1;
        }
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Podpisa³eœ umowe na 2,5 godziny, zaczynasz now¹ pracê.");
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Gratulujemy nowej pracy, wpisz /pomoc aby zobaczyæ nowe komendy.");
        PlayerInfo[playerid][pJob] = GettingJob[playerid];
        Log(serverLog, INFO, "Gracz %s do³¹czy³ do pracy %d.", GetPlayerLogName(playerid), PlayerInfo[playerid][pJob]);
        GettingJob[playerid] = 0;
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "   W tym miejscu nie mo¿na wzi¹æ pracy!");
        return 1;
    }
}