//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ organizacje ]----------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

CMD:rodziny(playerid, p[]) return cmd_organizacje(playerid, p);
CMD:biznesy(playerid, p[]) return cmd_organizacje(playerid, p);
CMD:organizacje(playerid, p[])
{
    new lStr[128];
    if(isnull(p))
    {
        for(new i=0;i<sizeof(OrgTypes);i++)
        {
            format(lStr, 128, "%s%s\n", lStr, OrgTypes[i]);
        }
        ShowPlayerDialogEx(playerid, D_ORGS, DIALOG_STYLE_LIST, "Spis organizacji", lStr, "Wybierz", "WyjdŸ");
        return 1;
    }
    new lID;
    sscanf(p, "d", lID);
    if(!orgIsValid(orgID(lID))) return 1;
    format(lStr, 128, "|| Cz³onkowie ONLINE w %s ||", OrgInfo[orgID(lID)][o_Name]);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, lStr);
    foreach(Player, i)
    {
        if(GetPlayerOrg(i) == lID)
        {
            if(gPlayerOrgLeader[i]) format(lStr, 128, "* %s (LIDER)", GetNick(i));
            else format(lStr, 128, "* %s (Ranga: %d)", GetNick(i), PlayerInfo[i][pRank]);
            SendClientMessage(playerid, COLOR_GRAD2, lStr);
        }
    }
    return 1;
}

