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

YCMD:organizacje(playerid, params[], help)
{
    new lStr[128];
    if(isnull(params))
    {
        for(new i=0;i<sizeof(OrgTypes);i++)
        {
            format(lStr, 128, "%s%s\n", lStr, OrgTypes[i]);
        }
        ShowPlayerDialogEx(playerid, D_ORGS, DIALOG_STYLE_LIST, "Spis organizacji", lStr, "Wybierz", "WyjdŸ");
        return 1;
    }
    new lID;
    sscanf(params, "d", lID);
    if(!IsOrgValid(lID)) return 1;
    format(lStr, 128, "|| Cz³onkowie ONLINE w %s ||", OrgInfo[lID][o_Name]);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, lStr);
    foreach(new i : Player)
    {
        if(GetPlayerOrg(i) == lID)
        {
            if(IsPlayerOrgLeader(i)) format(lStr, 128, "* %s (LIDER)", GetNick(i));
            else format(lStr, 128, "* %s (Ranga: %d)", GetNick(i), PlayerInfo[i][pRank]);
            SendClientMessage(playerid, COLOR_GRAD2, lStr);
        }
    }
    return 1;
}
