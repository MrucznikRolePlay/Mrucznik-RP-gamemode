//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ rodzinaskrypt ]---------------------------------------------//
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

YCMD:rodzinaskrypt(playerid, params[], help)
{
    if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY)) return 1;
    new id, nazwa[32];
    if(sscanf(params, "s[32]d", nazwa, id)) return sendTipMessage(playerid, "/rodzinaskrypt [nazwa ! nie ruszaj jak nie wiesz.. !] [slot]");
    if(strcmp(nazwa, "FAMILY_SAD") == 0)
    {
        FAMILY_SAD = id;
    }
    else if(strcmp(nazwa, "FAMILY_RSC") == 0)
    {
        FAMILY_RSC = id;
    }
    else if(strcmp(nazwa, "FAMILY_ALHAMBRA") == 0)
    {
        FAMILY_ALHAMBRA = id;
    }
    else if(strcmp(nazwa, "FAMILY_VINYL") == 0)
    {
        FAMILY_VINYL = id;
    }
    else if(strcmp(nazwa, "FAMILY_IBIZA") == 0)
    {
        FAMILY_IBIZA = id;
    }
    else if(strcmp(nazwa, "FAMILY_FDU") == 0)
    {
        FAMILY_FDU = id;
    }
    new query[75];
	new nazwa_escaped[32];
	mysql_real_escape_string(nazwa, nazwa_escaped);
    format(query, 75, "UPDATE `mru_rodziny` SET `id`=%d WHERE `name`='%s'", id, nazwa_escaped);
    mysql_query(query);
    return 1;
}


/*CMD:opis(playerid, params[])
{
    //SendClientMessage(playerid, COLOR_RED, "Komenda wy³¹czona na czas naprawy. Przepraszamy za utrudnienia.");
    
    if(PlayerInfo[playerid][pConnectTime] < 4) return sendErrorMessage(playerid, "Opis dostêpny od 4 godzin online!");
    new var[8], id=-1;
    sscanf(params, "s[8]K<fix>(-1)", var, id);
    if(strlen(var) == 4 && (strcmp(var, "usuñ", true) == 0 || strcmp(var, "usun", true) == 0))
    {
        if(id != -1 && PlayerInfo[playerid][pAdmin] >= 1)
        {
            if(!Opis_Usun(id)) return SendClientMessage(playerid, -1, "Opis: Gracz nie posiada opisu.");
            else
            {
                new str[64];
                format(str, 64, "(OPIS) - Administrator %s usun¹³ Twój opis.", GetNick(playerid, true));
                SendClientMessage(id, COLOR_PURPLE, str);
                format(str, 64, "(OPIS) - Usun¹³eœ opis graczowi %s.", GetNick(id, true));
                SendClientMessage(playerid, COLOR_PURPLE, str);
                return 1;
            }
        }
        else if(!Opis_Usun(playerid, true)) return SendClientMessage(playerid, -1, "Opis: Nie posiadasz opisu.");
        return 1;
    }
    if(PlayerInfo[playerid][pBP] == 0)
    {
        new lStr[256];
        strunpack(lStr, PlayerDesc[playerid]);
        format(lStr, 256, "%s\n» Ustaw opis\n» Zmieñ opis\n» {FF0000}Usuñ", lStr);
        ShowPlayerDialogEx(playerid, D_OPIS, DIALOG_STYLE_LIST, "Opis postaci", lStr, "Wybierz", "WyjdŸ");
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Posiadasz blokadê pisania na czatach globalnych, nie mo¿esz utworzyæ opisu.");
    }
    return 1;
} */

