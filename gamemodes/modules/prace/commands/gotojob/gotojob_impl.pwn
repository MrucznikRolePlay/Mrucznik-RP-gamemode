//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  gotojob                                                  //
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
// Data utworzenia: 21.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_gotojob_Impl(playerid, job, index, type)
{

    if(PlayerInfo[playerid][pAdmin] < 1)
    {
        noAccessMessage(playerid);
        return 1;
    }

    if(job <= 0 || job >= Jobs)
    {
        MruMessageFailF(playerid, "Praca musi byæ wiêksza ni¿ 0 i mniejsza ni¿ %d", Jobs-1);
        return 1;
    }

    if(index < 0)
    {
        MruMessageFail(playerid, "Index musi byæ wiêkszy lub równy 0.");
        return 1;
    }

    switch(type)
    {
        case 0: // join
        {
            if(index >= MAX_JOB_JOINS)
            {
                MruMessageFailF(playerid, "Index musi byæ mniejszy ni¿ %d.", MAX_JOB_JOINS);
                return 1;
            }

            SetPlayerPos(playerid, JobJoinPositions[job][index][JOB_JOIN_X], JobJoinPositions[job][index][JOB_JOIN_Y], JobJoinPositions[job][index][JOB_JOIN_Z]);
        }
        case 1: // spawn
        {
            if(index >= MAX_JOB_SPAWNS)
            {
                MruMessageFailF(playerid, "Index musi byæ mniejszy ni¿ %d.", MAX_JOB_SPAWNS);
                return 1;
            }

            SetPlayerPos(playerid, JobSpawns[job][index][JOB_SPAWN_X], JobSpawns[job][index][JOB_SPAWN_Y], JobSpawns[job][index][JOB_SPAWN_Z]);
            SetPlayerFacingAngle(playerid, JobSpawns[job][index][JOB_SPAWN_A]);
        }
        case 2: // icon
        {
            if(index >= MAX_JOB_JOINS)
            {
                MruMessageFailF(playerid, "Index musi byæ mniejszy ni¿ %d.", MAX_JOB_JOINS);
                return 1;
            }

            SetPlayerPos(playerid, JobJoinPositions[job][index][0], JobIconPositions[job][index][1], JobJoinPositions[job][index][2]);
        }
        default:
        {
            MruMessageFail(playerid, "Niepoprawny typ. U¿yj: 0 - pozycja do³¹czenia do pracy, 1 - spawn pracy, 2 - ikonka pracy.");
            return 1;
        }
    }
    MruMessageGoodInfoF(playerid, "Teleportowa³eœ siê do pracy %s", GetJobName(job));
    return 1;
}

//end