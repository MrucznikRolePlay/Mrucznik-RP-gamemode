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
command_toglicznik_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if(!ToggleSpeedo[playerid])
		{
			ToggleSpeedo[playerid] = true;
            MSGBOX_Show(playerid, "Licznik ~r~OFF", MSGBOX_ICON_TYPE_OK);
            //Speedo
            PlayerTextDrawHide(playerid, Licznik[playerid]);
		}
		else
		{
			ToggleSpeedo[playerid] = false;
            MSGBOX_Show(playerid, "Licznik ~g~ON", MSGBOX_ICON_TYPE_OK);
            //Speedo
            if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
            {
                PlayerTextDrawShow(playerid, Licznik[playerid]);
            }
		}
	}
	return 1;
}

//end
