//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ kuplicencje ]-----------------------------------------------//
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
// Autor: Sandal
// Data utworzenia: 24.01.2020

// Opis:
/*
    Kupno licencji prawniczej u NPC
*/


// Notatki skryptera:
/*
	
*/
YCMD:kuppozwolenie(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pJob] == 2)
        {
            //if jest w³¹czone wydawanie pozwo przez bota
            if(IsPlayerInRangeOfPoint(playerid, 3.0, -1677.7097,893.5458,-48.9141) && (GetPlayerVirtualWorld(playerid)==1)) 
            {
                if(kaska[playerid] >= 35000)
                {
                    ZabierzKase(playerid, 35000);
                    Sejf_Add(1, 20000);
                    ApprovedLawyer[playerid] = 1;
                    sendTipMessage(playerid, "Zakupi³eœ pozwolenie za 35000$");
                    return 1; 
                }
                else
                {
                    sendTipMessage(playerid, "Nie staæ cie!");
                    return 1;
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jesteœ przy osobie wydaj¹cej pozwolenia!");
                return 1; 
            }
        }
        else
        {
            sendTipMessage(playerid, "Komenda dostêpna tylko dla prawników.");
            return 1;
        }
    }
}