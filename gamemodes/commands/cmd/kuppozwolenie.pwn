//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ kuppozwolenie ]---------------------------------------------//
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
            if(IsPlayerInRangeOfPoint(playerid, 3.0, 1582.2563,-1677.6565,62.2363) && (GetPlayerVirtualWorld(playerid)==25)) 
            {
                if(ApprovedLawyer[playerid] == 0)
                {
                    if(PozwolenieBot == 0)
                    {
                        sendTipMessage(playerid, "Wy³¹czono mo¿liwoœæ automatycznego kupna pozwoleñ.");
                        return 1;
                    }
                    if(kaska[playerid] >= CENA_POZWOLENIE)
                    {
                        ZabierzKase(playerid, CENA_POZWOLENIE);
                        Sejf_Add(FRAC_LSPD, CENA_POZWOLENIE);
                        ApprovedLawyer[playerid] = 1;
                        Log(payLog, INFO, "%s zakupi³ pozwolenie od aktora za "#CENA_POZWOLENIE"$", GetPlayerLogName(playerid));
                        sendTipMessage(playerid, "Zakupi³eœ pozwolenie za "#CENA_POZWOLENIE"$");
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
                    sendTipMessage(playerid, "Posiadasz ju¿ pozwolenie.");
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
    return 1;
}
