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
    new string[1024];
    if(orgid != -1)
    {
        if(PlayerInfo[playerid][pAdmin] > 0)
        {
            SendClientMessage(playerid, COLOR_GREEN, "Cz³onkowie Online:");
            foreach(new i : Player)
            {
                if(GetPlayerOrg(i) == orgid)
                {
                    format(string, sizeof(string), "{%06x}%s{B4B5B7} [%d] ranga %d", (GetPlayerColor(i) >>> 8), GetNick(i), i, PlayerInfo[i][pRank]);
                    SendClientMessage(playerid, COLOR_GRAD1, string);
                }
            }
        }
        return 1;
    }

    for(new i=1;i<MAX_ORG;i++)
    {
        if(!IsActiveOrg(i)) continue;
        format(string, sizeof(string), "%s{000000}%d\t{FFFFFF}%s\t%s\n", string, i, OrgInfo[i][o_Name], OrgTypes[OrgInfo[i][o_Type]]);
    }
    if(strlen(string) == 0)
    {
        MruMessageFail(playerid, "Brak organizacji na serwerze.");
        return 1;
    }

    if(PlayerInfo[playerid][pAdmin] > 0)
        ShowPlayerDialogEx(playerid, D_ORGS, DIALOG_STYLE_LIST, "Lista organizacji", string, "Cz³onkowie", "WyjdŸ");
    else
        ShowPlayerDialogEx(playerid, D_ORGS, DIALOG_STYLE_LIST, "Lista organizacji", string, "WyjdŸ", "");
    return 1;
}

cmd_organizacje_OnDialogResp(playerid, dialogid, response, listitem, inputtext[])
{
    #pragma unused listitem

    if(dialogid == D_ORGS)
    {
        if(response && PlayerInfo[playerid][pAdmin] > 0)
        {
            new id = strval(inputtext);
            new string[16];
            valstr(string, id);
            RunCommand(playerid, "/organizacje", string);
        }
        return 1;
    }
    return 0;
}

//end