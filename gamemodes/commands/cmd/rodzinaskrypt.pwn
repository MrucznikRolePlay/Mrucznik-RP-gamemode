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
