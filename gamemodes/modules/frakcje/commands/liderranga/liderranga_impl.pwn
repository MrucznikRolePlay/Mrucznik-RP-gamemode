//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 liderranga                                                //
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
// Data utworzenia: 10.02.2024


//

//------------------<[ Implementacja: ]>-------------------
command_liderranga_Impl(playerid, rank, rawRankName[32])
{
    // check permissions
    new type;
    new orgId;
    if(PlayerInfo[playerid][pLider] > 0) {
        type = 0;
        orgId = PlayerInfo[playerid][pLider];
    } else if(GetPlayerOrg(playerid) > 0 && gPlayerOrgLeader[playerid]){
        type = 1;
        orgId = GetPlayerOrg(playerid);
    } else {
        sendErrorMessage(playerid, "Nie jesteœ liderem frakcji lub organizacji!");
        return 1;
    }

    // validate parameters
    if(rank < 0 || rank > 10) {
        sendErrorMessage(playerid, "Numer rangi od 0 do 9!");
        return 1;
    }

    new rankName[32];
    mysql_real_escape_string(rawRankName, rankName);
    new length = strlen(rankName);
    if(length == 0) 
    {
        command_liderranga_showRank(playerid, type, orgId, rank);
        return 1;
    }
    else if(length > 24)
    {
        sendErrorMessage(playerid, "Nazwa rangi powinna zawieraæ maksymalnie 24 znaków!");
        return 1;
    }

    // command body
    if(rawRankName[0] == '-')
    {
        // delete rank
        if(type == 0) strdel(FracRang[orgId][rank], 0, MAX_RANG_LEN);
        else if(type == 1) strdel(FamRang[orgId][rank], 0, MAX_RANG_LEN);
    }
    else
    {
        // edit rank
        if(type == 0) format(FracRang[orgId][rank], MAX_RANG_LEN, "%s", rankName);
        else if(type == 1) format(FamRang[orgId][rank], MAX_RANG_LEN, "%s", rankName);
    }
    EDIT_SaveRangs(type, orgId);
    SendClientMessage(playerid, COLOR_PINK, "Ranga zmieniona!");
    command_liderranga_showRank(playerid, type, orgId, rank);
    return 1;
}

command_liderranga_showRank(playerid, type, orgId, rank)
{
    new string[128];
    if(type == 0) format(string, sizeof(string), "Aktualna ranga %d: %s", rank, FracRang[orgId][rank]);
    else if(type == 1) format(string, sizeof(string), "Aktualna ranga %d: %s", rank, FamRang[orgId][rank]);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    return 1;
}


//end