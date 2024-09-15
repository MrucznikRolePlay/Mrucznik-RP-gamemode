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
command_toglicznik_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		if(!ToggleSpeedo[playerid])
		{
			ToggleSpeedo[playerid] = true;
            MSGBOX_Show(playerid, "Licznik ~r~OFF", MSGBOX_ICON_TYPE_OK);
            //Speedo
            /*for(new i=0;i<sizeof(Speedo_BG);i++) TextDrawHideForPlayer(playerid, Speedo_BG[i]);
            TextDrawHideForPlayer(playerid, Speedo_ToggleGPS);
            TextDrawHideForPlayer(playerid, Speedo_ToggleStan);
    		PlayerTextDrawHide(playerid, Speedo_Engine[playerid]);
    		PlayerTextDrawHide(playerid, Speedo_Lights[playerid]);

            for(new i=0;i<5;i++) PlayerTextDrawHide(playerid, Speedo_Fuel[playerid][i]);
            PlayerTextDrawHide(playerid, Speedo_Paliwo[playerid]);
            PlayerTextDrawHide(playerid, Speedo_Speed[playerid]);

            PlayerTextDrawHide(playerid, Speedo_GPS[playerid]);*/
            PlayerTextDrawHide(playerid, Licznik[playerid]);
            //
		}
		else
		{
			ToggleSpeedo[playerid] = false;
            MSGBOX_Show(playerid, "Licznik ~g~ON", MSGBOX_ICON_TYPE_OK);
            //Speedo
            if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
            {
                /*for(new i=0;i<sizeof(Speedo_BG);i++) TextDrawShowForPlayer(playerid, Speedo_BG[i]);
                TextDrawShowForPlayer(playerid, Speedo_ToggleGPS);
                TextDrawShowForPlayer(playerid, Speedo_ToggleStan);
                new engine, lights, alarm, doors, bonnect, boot, objective;
                GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnect, boot, objective);
        		if(engine == 0) PlayerTextDrawShow(playerid, Speedo_Engine[playerid]);
        		if(lights == 1) PlayerTextDrawShow(playerid, Speedo_Lights[playerid]);

                for(new i=0;i<5;i++)
                {
                    PlayerTextDrawColor(playerid, Speedo_Fuel[playerid][i], -1);
                    PlayerTextDrawShow(playerid, Speedo_Fuel[playerid][i]);
                }
                if(engine == 1)
                {
                    PlayerTextDrawShow(playerid, Speedo_Paliwo[playerid]);
                    PlayerTextDrawShow(playerid, Speedo_Speed[playerid]);
                }
                if(ToggleSpeedoGPS[playerid]) PlayerTextDrawShow(playerid, Speedo_GPS[playerid]); */
                PlayerTextDrawShow(playerid, Licznik[playerid]);
            }
            //
		}
	}
	return 1;
}

//end
