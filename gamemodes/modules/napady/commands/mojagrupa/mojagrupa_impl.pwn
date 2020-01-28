//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 mojagrupa                                                 //
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
// Autor: Simeone
// Data utworzenia: 28.01.2020


//

//------------------<[ Implementacja: ]>-------------------
command_mojagrupa_Impl(playerid)
{
    new string[256];
    new stringReturn[MAX_PLAYER_NAME]; 
    if(GetPlayerOrgType(playerid) != ORG_TYPE_GANG)
    {
        sendErrorMessage(playerid, "Komenda jest dostêpna tylko dla gangów!"); 
        return 1;
    }
    if(!isRobbery[playerid])
    {
        sendErrorMessage(playerid, "Nie organizujesz napadu!"); 
        return 1;
    }
    format(string, sizeof(string), "%s", GetName(playerid));
    for(new i; i != MAX_TEAMROBBERY+1; i++)
    {
        if(robberyTeam[GetPlayerOrg(playerid)][i] == INVALID_PLAYERID)
        {
            format(stringReturn, sizeof(stringReturn), "Brak"); 
            format(string, sizeof(string), "%s, %s", string, stringReturn); 
        }
        else if(robberyTeam[GetPlayerOrg(playerid)][i] != INVALID_PLAYERID 
        && robberyTeam[GetPlayerOrg(playerid)][i] != playerid)
        {
            format(stringReturn, sizeof(stringReturn), "%s", GetName(i)); 
            format(string, sizeof(string), "%s, %s", string, stringReturn); 
        }
    }
    SendClientMessage(playerid, COLOR_GREEN, "===========[EKIPA NAPADU:]===========");
    SendClientMessage(playerid, COLOR_GREEN, string); 
    return 1;
}

//end