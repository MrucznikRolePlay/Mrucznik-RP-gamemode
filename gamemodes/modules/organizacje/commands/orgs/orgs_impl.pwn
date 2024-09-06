//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    orgs                                                   //
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
// Data utworzenia: 06.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_orgs_Impl(playerid, orgid)
{
    new string[256];
    if(orgid == -1)
    {
        for(new i=0;i<sizeof(OrgTypes);i++)
        {
            format(string, sizeof(string), "%s%s\n", string, OrgTypes[i]);
        }
        ShowPlayerDialogEx(playerid, D_ORGS, DIALOG_STYLE_LIST, "Spis organizacji", string, "Wybierz", "WyjdŸ");
        return 1;
    }
    
    if(!IsOrgValid(orgid)) return 1;
    format(string, sizeof(string), "|| Cz³onkowie ONLINE w %s ||", OrgInfo[orgid][o_Name]);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    foreach(new i : Player)
    {
        if(GetPlayerOrg(i) == orgid)
        {
            if(IsPlayerOrgLeader(i)) format(string, sizeof(string), "* %s (LIDER)", GetNick(i));
            else format(string, sizeof(string), "* %s (Ranga: %d)", GetNick(i), PlayerInfo[i][pRank]);
            SendClientMessage(playerid, COLOR_GRAD2, string);
        }
    }
    return 1;
}

cmd_organizacje_OnDialogResp(playerid, dialogid, response, listitem, inputtext[])
{
    #pragma unused inputtext

    if(dialogid == D_ORGS)
    {
        if(!response) return 1;

        new string[512];
        for(new i=0;i<MAX_ORG;i++)
        {
            if(!IsOrgValid(i)) continue;
            if(GetOrgType(i) == listitem)
            {
                format(string, sizeof(string), "%s{000000}%d\t{FFFFFF}%s\n", string, i, OrgInfo[i][o_Name]);
            }
        }
        if(strlen(string) > 3)
        {
            ShowPlayerDialogEx(playerid, D_ORGS_SELECT, DIALOG_STYLE_LIST, "Lista organizacji", string, "Cz³onkowie", "Wróæ");
        }
        return 1;
    }
    else if(dialogid == D_ORGS_SELECT)
    {
        if(!response) return RunCommand(playerid, "/organizacje",  "");
        new id = strval(inputtext);
        new string[16];
        valstr(string, id);
        RunCommand(playerid, "/organizacje", string);
        return 1;
    }
    return 0;
}

//end