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
    if( IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] >= 1 && (typLock >= 0 && typLock <= 2) )
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