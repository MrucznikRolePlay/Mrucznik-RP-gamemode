//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_icons_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
        new turn_on = 1;
        for(new i; i<=dini_Int("Domy/NRD.ini", "NrDomow"); i++)
        {
            // Szukamy, czy gracz ma jak¹kolwiek ikonkê domu na mapie - je¿eli tak, to przyjmujemy, ¿e chce on wy³¹czyæ wszystkie ikony.
            if(Dom[i][hIkonka] != -1 && Streamer_IsInArrayData(STREAMER_TYPE_MAP_ICON, Dom[i][hIkonka], E_STREAMER_PLAYER_ID, playerid))
            {
                turn_on = 0;
                break;
            }
        }

        new icon_type;
        for(new i; i<=dini_Int("Domy/NRD.ini", "NrDomow"); i++)
        {
            if(Dom[i][hKupiony] == 0)
            {
                icon_type = 31;
            } 
            else if(Dom[i][hWynajem] != 0)
            {
                icon_type = 32;
            }
            else
            {
                continue;
            }

            if(turn_on)
            {
                if(Dom[i][hIkonka] == -1)
                {
                    Dom[i][hIkonka] = MruCreateDynamicMapIcon(Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z], icon_type, 1, -1, -1, playerid, 125.0);
                }
                else if(!Streamer_IsInArrayData(STREAMER_TYPE_MAP_ICON, Dom[i][hIkonka], E_STREAMER_PLAYER_ID, playerid))
                {
                    Streamer_AppendArrayData(STREAMER_TYPE_MAP_ICON, Dom[i][hIkonka], E_STREAMER_PLAYER_ID, playerid);
                }
            }
            else if(Dom[i][hIkonka] != -1 && Streamer_IsInArrayData(STREAMER_TYPE_MAP_ICON, Dom[i][hIkonka], E_STREAMER_PLAYER_ID, playerid))
            {
                Streamer_RemoveArrayData(STREAMER_TYPE_MAP_ICON, Dom[i][hIkonka], E_STREAMER_PLAYER_ID, playerid);
            }
        }

        if(turn_on)
        {
            MSGBOX_Show(playerid, "Ikony domow ~g~wlaczone!", MSGBOX_ICON_TYPE_OK);
        }
        else
        {
            MSGBOX_Show(playerid, "Ikony domow ~r~wylaczone!", MSGBOX_ICON_TYPE_OK);
        }
    }
    return 1;
}

//end
