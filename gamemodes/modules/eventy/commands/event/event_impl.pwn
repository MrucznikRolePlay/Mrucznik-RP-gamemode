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
                format(string, sizeof(string), "* %s zabiera paczkê z stosu skrzyñ.", GetNick(playerid));
			    ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
                SendClientMessage(playerid, COLOR_RED, "Dostarcz teraz paczkê do dilera na dokach!");
                SendClientMessage(playerid, COLOR_GREY, "Masz 2 minuty na dostarczenie tej paczki, inaczej wybuchnie!");
            }
            else if(IsPlayerInRangeOfPoint(playerid, 4.0, EVENT_GIVEBOX_X, EVENT_GIVEBOX_Y, EVENT_GIVEBOX_Z))
            {
                format(string, sizeof(string), "* %s oddaje paczkê dilerowi.", GetNick(playerid));
			    ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
            }
            else SendClientMessage(playerid, COLOR_RED, "Nie jesteœ obok skrzynek!");
        }
    }
    else SendClientMessage(playerid, COLOR_WHITE, "Nie jest uruchomiony ¿aden event aktualnie!");
    return 1;
}

//end