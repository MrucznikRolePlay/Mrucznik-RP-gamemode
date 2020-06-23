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
            if(eventid == 0) 
            SendClientMessage(playerid, COLOR_WHITE, "[Event Manager] Wy³¹czono eventy.");//wylaczenie
            else if(eventid == 1)
            SendClientMessage(playerid, COLOR_WHITE, "[Event Manager] Uruchomiono eventy.");  // wlaczenie
            else SendClientMessage(playerid, COLOR_WHITE, "[Event Manager] Enabled 1/0");
        }
    }
    return 1;
}

//end