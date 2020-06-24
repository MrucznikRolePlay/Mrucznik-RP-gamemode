//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               event_manager                                               //
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
// Autor: Sanda³
// Data utworzenia: 23.06.2020


//

//------------------<[ Implementacja: ]>-------------------
command_event_manager_Impl(playerid, opcja[24], eventid, opcjaparam[24], argopcjaparam[24])
{
    if(Events_CanUseManageCommand(playerid))
    {
        if(strcmp(opcja, "info", true) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "tutaj info");
        }
        else if(strcmp(opcja, "enabled", true) == 0)
        {
            if(eventid == 0 && EVENTS_enabled <= 0) 
            {
                EVENTS_enabled = -1;
                SendClientMessage(playerid, COLOR_WHITE, "[Event Manager] Wy³¹czono eventy.");//wylaczenie
            }
            else if(eventid == 1)
            {
                EVENTS_enabled = 0;
                SendClientMessage(playerid, COLOR_WHITE, "[Event Manager] Uruchomiono eventy.");  // wlaczenie
            }
            else SendClientMessage(playerid, COLOR_WHITE, "[Event Manager] Enabled 1/0");
        }
        else if(strcmp(opcja, "load", true) == 0)
        {
            if(EVENTS_enabled == 0)
            {
                if(!Events_EventExist(eventid)) sendTipMessage(playerid, "[Event Manager] Nie znaleziono eventu.");
                else Events_LoadStaticEvent(playerid, eventid);
            }
            else
            {
                sendTipMessage(playerid, "[Event Manager] Eventy s¹ wy³¹czone.");
            }
        }
        else if(strcmp(opcja, "unload", true) == 0)
        {
            if(EVENTS_enabled > 0)
            {
                Events_UnloadStaticEvent(playerid, eventid);
            }
            else
            {
                sendTipMessage(playerid, "[Event Manager] ¯aden event nie jest aktualnie za³adowany.");
            }
        }
    }
    return 1;
}

//end