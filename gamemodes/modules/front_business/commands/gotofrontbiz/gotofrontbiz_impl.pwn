//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                gotofrontbiz                                               //
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
// Data utworzenia: 08.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_gotofrontbiz_Impl(playerid, bizId, position)
{
    if(PlayerInfo[playerid][pAdmin] < 1)
    {
        noAccessMessage(playerid);
        return 1;
    }

    if(bizId < 0 || bizId >= sizeof(FrontBusiness))
    {
        MruMessageFailF(playerid, "IS biznesu musi byæ wiêksze lub równe 0 i mniejsza ni¿ %d", sizeof(FrontBusiness) -1);
        return 1;
    }

    new Float:x, Float:y, Float:z;
    switch(position)
    {
        case 0: // wejœcie
        {
			x = FrontBusiness[bizId][OutX];
			y = FrontBusiness[bizId][OutY];
            z = FrontBusiness[bizId][OutZ];
            if(x == 0.0 && y == 0.0 && z == 0.0) 
            {
                MruMessageFail(playerid, "Brak zapisanej pozycji pod tym ID.");
                return 1;
            }
            SetPlayerPos(playerid, x, y, z);
            SetPlayerVirtualWorld(playerid, FrontBusiness[bizId][OutVw]);
            SetPlayerInterior(playerid, FrontBusiness[bizId][OutInt]);
        }
        case 1: // wyjdŸ
        {
			x = FrontBusiness[bizId][InX];
			y = FrontBusiness[bizId][InY];
            z = FrontBusiness[bizId][InZ];
            if(x == 0.0 && y == 0.0 && z == 0.0) 
            {
                MruMessageFail(playerid, "Brak zapisanej pozycji pod tym ID.");
                return 1;
            }
            SetPlayerPos(playerid, x, y, z);
            SetPlayerVirtualWorld(playerid, FrontBusiness[bizId][InVw]);
            SetPlayerInterior(playerid, FrontBusiness[bizId][InInt]);
        }
        case 2: // przejmowanie
        {
			x = FrontBusiness[bizId][TakeoverX];
			y = FrontBusiness[bizId][TakeoverY];
            z = FrontBusiness[bizId][TakeoverZ];
            if(x == 0.0 && y == 0.0 && z == 0.0) 
            {
                MruMessageFail(playerid, "Brak zapisanej pozycji pod tym ID.");
                return 1;
            }
            SetPlayerPos(playerid, x, y, z);
            SetPlayerVirtualWorld(playerid, FrontBusiness[bizId][TakeoverVw]);
            SetPlayerInterior(playerid, FrontBusiness[bizId][TakeoverInt]);
        }
        default:
        {
            MruMessageFail(playerid, "Dostêpne pozycje: 0 - wejœcie, 1 - wyjœcie, 2 - przejmowanie.");
            return 1;
        }
    }
    MruMessageGoodInfoF(playerid, "Teleportowa³eœ siê do pracy %s", GetJobName(job));
    return 1;
}

//end