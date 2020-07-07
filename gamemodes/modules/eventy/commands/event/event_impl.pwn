//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   event                                                   //
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
// Data utworzenia: 22.06.2020


//

//------------------<[ Implementacja: ]>-------------------
command_event_Impl(playerid, opcja1[24], opcja2[24])
{
    if(Events_CanUseCommand(playerid))
    {
        if(strcmp(opcja1,"info",true) == 0)
        {
            new string[128];
            if(IsPlayerInRangeOfPoint(playerid, 4.0, EVENT_GETBOX_X, EVENT_GETBOX_Y, EVENT_GETBOX_Z))
            {
                if(EVENTS_player_joined[playerid] != 0)
                {
                    SendClientMessage(playerid, COLOR_LIGHTRED, "Masz ju¿ przy sobie paczkê.");
                    return 1;
                }
                else if(IsAPolicja(playerid))
                {
                    SendClientMessage(playerid, COLOR_LIGHTRED, "Jako s³u¿ba porz¹dkowa masz obowi¹zek zabijaæ terrorystów!");
                    return 1;
                }
                Events_PlayerJoined(playerid, 1);
            }
            else if(IsPlayerInRangeOfPoint(playerid, 4.0, EVENT_GIVEBOX_X, EVENT_GIVEBOX_Y, EVENT_GIVEBOX_Z) && EVENTS_player_joined[playerid] != 0)
            {
                if(EVENTS_player_joined[playerid] == 0)
                {
                    SendClientMessage(playerid, COLOR_LIGHTRED, "Nie masz przy sobie paczki!");
                    return 1; 
                }
                Events_PlayerLeft(playerid, 1, 1);
            }
            else SendClientMessage(playerid, COLOR_RED, "Nie jesteœ obok skrzynek!");
        }
    }
    else SendClientMessage(playerid, COLOR_WHITE, "Nie jest uruchomiony ¿aden event aktualnie!");
    return 1;
}

//end