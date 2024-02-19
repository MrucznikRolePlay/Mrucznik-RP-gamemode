//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ icons ]-------------------------------------------------//
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

// Opis:
/*

 */


// Notatki skryptera:
/*

 */

YCMD:icons(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
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

            if(Dom[i][hIkonka] == -1)
            {
                Dom[i][hIkonka] = CreateDynamicMapIcon(Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z], icon_type, 1, -1, -1, playerid, 125.0);
            }
            else if(!Streamer_IsInArrayData(STREAMER_TYPE_MAP_ICON, Dom[i][hIkonka], E_STREAMER_PLAYER_ID, playerid))
            {
                Streamer_AppendArrayData(STREAMER_TYPE_MAP_ICON, Dom[i][hIkonka], E_STREAMER_PLAYER_ID, playerid);
            }
        }
        MSGBOX_Show(playerid, "Ikony wlaczone!", MSGBOX_ICON_TYPE_OK);
    }
    return 1;
}
