//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ komunikat ]-----------------------------------------------//
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

YCMD:komunikat(playerid, params[], help)
{
    new string[256], sendername[MAX_PLAYER_NAME], org;
    GetPlayerName(playerid, sendername, sizeof(sendername));
    if(!IsPlayerConnected(playerid)) return 1;
    org = GetPlayerOrg(playerid);
    if(!org) return sendErrorMessage(playerid, "Nie jesteœ w ¿adnej rodzinie!");
    if(PlayerInfo[playerid][pRank] < 5) 
    {
        return sendErrorMessage(playerid, "Musisz mieæ 5 range aby tego u¿ywaæ !");
    }
    else
    {
        if(org == 21 && PlayerInfo[playerid][pRank] < 4) return sendErrorMessage(playerid, "Musisz mieæ 4 range aby tego u¿ywaæ !"); //dla Ammunation Willowfield slot 21
    }
    if(isnull(params)) return sendErrorMessage(playerid, "U¿yj: /komunikat [tekst]");
    if(CMDKomunikat == 1) return sendErrorMessage(playerid, "Komunikat by³ u¿yty przed chwil¹!");
    if(IsAPrzestepca(playerid)) return sendErrorMessage(playerid, "Nie mo¿esz byæ w gangu/mafii!");
    if(PlayerInfo[playerid][pBP])
    {
        format(string, sizeof(string), "   Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
        SendClientMessage(playerid, TEAM_CYAN_COLOR, string);
        return 1;
    }
    format(string, sizeof(string), "|___________ %s ___________|", OrgInfo[org][o_Name]);
    SendClientMessageToAll(COLOR_WHITE, string);
    format(string, sizeof(string), "%s: %s", sendername, params);
    SendClientMessageToAll(COLOR_BLUE, string);
    CMDKomunikat = 1;
    SetTimer("KomunikatTimer", 60000, false);
    return 1;
}
