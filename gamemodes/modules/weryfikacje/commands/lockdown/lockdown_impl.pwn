//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    anim                                                    //
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
// Autor: Mrucznik
// Data utworzenia: 11.06.2019


//

//------------------<[ Implementacja: ]>-------------------
command_lockdown_Impl(playerid, typLock)
{
    if(PlayerInfo[playerid][pAdmin] == 0) {
        return 1;
    }
    
    if(typLock == -1)
    {
        sendTipMessage(playerid, "U¿yj /lockdown [typ]");
        sendTipMessage(playerid, "[0] Wy³¹czenie [1] W³¹czenie dla kont z 0h [2] W³¹czenie dla kont z mniej ni¿ 3h");
        sendTipMessage(playerid, "Ka¿de konto po /weryfikacja bêdzie mia³o 'przepustke' do czasu restartu serwera.");
        new string[128];
        format(string, sizeof(string), "Aktualny tryb lockdown: [%d]", Lockdown_Mode);
        sendTipMessage(playerid, string);
        return 1;
    }

    if(typLock < 0 || typLock > 2)
    {
        sendErrorMessage(playerid, "Nie znaleziono typu lockdown przypisanego do tego numeru.");
        return 1;
    }

    if( IsPlayerConnected(playerid) && (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] == 10) && (typLock >= 0 && typLock <= 2) )
    {
        switch(typLock)
        {
            case 0:
            {
                Lockdown_Mode = LOCKDOWN_MODE_OFFLINE;
                ALockdown_Notify(playerid, LOCKDOWN_MODE_OFFLINE);
            }
            case 1:
            {
                Lockdown_Mode = LOCKDOWN_MODE_NEWACCOUNTS;
                ALockdown_Notify(playerid, LOCKDOWN_MODE_NEWACCOUNTS);
            }
            case 2:
            {
                Lockdown_Mode = LOCKDOWN_MODE_YOUNGACCOUNTS;
                ALockdown_Notify(playerid, LOCKDOWN_MODE_YOUNGACCOUNTS);
            }
            default:
                Lockdown_Mode = LOCKDOWN_MODE_OFFLINE;
        }
    }
    return 1;
}

//end