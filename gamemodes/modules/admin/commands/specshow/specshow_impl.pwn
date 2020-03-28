//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  specshow                                                 //
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
// Autor: Simeone
// Data utworzenia: 13.10.2019


//

//------------------<[ Implementacja: ]>-------------------
command_specshow_Impl(playerid, valueSpec)
{
    if(PlayerInfo[playerid][pAdmin] >= 2000 || IsAScripter(playerid))
    {
        new string[124];
        if(playerSeeSpec[playerid] == 0)
        {
            if(valueSpec == -1)
            {
                playerSeeSpec[playerid] = -1; 
                sendTipMessageEx(playerid, COLOR_RED, "W³¹czy³eœ podgl¹d u¿ycia komendy /spectate na wszystkich administratorów"); 
                return 1;
            }
            if(IsPlayerConnected(valueSpec))
            {
                if(PlayerInfo[valueSpec][pAdmin] == 0 && PlayerInfo[valueSpec][pHalfAdmin] == 0)
                {
                    sendErrorMessage(playerid, "Ta osoba nie jest administratorem!"); 
                    return 1;
                }
                if(playerSeeSpec[playerid] == INVALID_SPECTATE_ID)
                {
                    format(string, sizeof(string), "Oznaczy³eœ %s jako swój cel pogl¹du u¿yæ komendy /spectate!", GetNick(valueSpec)); 
                    playerTargetSpec[valueSpec] = playerid; 
                    playerSeeSpec[playerid] = valueSpec;
                    sendTipMessageEx(playerid, COLOR_RED, string); 
                    sendTipMessage(playerid, "Ka¿de u¿ycie komendy przez t¹ osobê, zostanie Ci wyœwietlone"); 
                }
                else
                {
                    sendErrorMessage(playerid, "Masz ju¿ w³¹czony show-spectate! Wyst¹pi³ b³¹d."); 
                    return 1;
                }
            }
            else
            {
                sendErrorMessage(playerid, "Nie ma na serwerze takiej osoby!"); 
                return 1;
            }
        }
        else
        {
            playerSeeSpec[playerid] = INVALID_SPECTATE_ID; 
            playerTargetSpec[valueSpec] = INVALID_SPECTATE_ID; 
            sendTipMessage(playerid, "Wy³¹czy³eœ podgl¹d spectate"); 
        }
    }
    else 
    {
        noAccessMessage(playerid); 
    }
    return 1;
}

//end