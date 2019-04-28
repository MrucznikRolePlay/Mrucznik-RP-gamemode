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
    
    //TODO: move to func
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
    MruMySQL_UpdateFamily(id, nazwa);
    return 1;
}
