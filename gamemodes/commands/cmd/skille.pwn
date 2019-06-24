//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ skille ]------------------------------------------------//
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

#if DEBUG_MODE == 1
YCMD:skille(playerid, params[], help)
{
    PlayerInfo[playerid][pDetSkill] = 5000;
    PlayerInfo[playerid][pLawSkill] = 5000;
    PlayerInfo[playerid][pMechSkill] = 5000;
    PlayerInfo[playerid][pNewsSkill] = 5000;
    PlayerInfo[playerid][pJackSkill] = 5000;
    PlayerInfo[playerid][pDrugsSkill] = 5000;
    PlayerInfo[playerid][pSexSkill] = 5000;
    PlayerInfo[playerid][pBoxSkill] = 5000;
    PlayerInfo[playerid][pGunSkill] = 5000;
    PlayerInfo[playerid][pFishSkill] = 5000;
    PlayerInfo[playerid][pFishSkill] = 5000;
    PlayerInfo[playerid][pTruckSkill] = 5000;

    PlayerInfo[playerid][pMats] = 50000;

    sendTipMessage(playerid, "[Dosta³eœ skille 5 w ka¿dej dziedzinie i 50000 mats]");

    return 1;
}
#endif
