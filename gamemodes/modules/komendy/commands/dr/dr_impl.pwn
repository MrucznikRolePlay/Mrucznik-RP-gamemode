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
command_dr_Impl(playerid)
{
    if(IsPlayerInAnyVehicle(playerid))
	{
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
			if(IsARower(GetPlayerVehicleID(playerid)))
			{
				sendErrorMessage(playerid, "Rower nie ma deski rozdzielczej!");
				return 1;
			}
		
			new veh = GetPlayerVehicleID(playerid);
		    new engine,lights,alarm,doors,bonnet,boot,objective;

		    new taknieL[16];
		    new taknieBON[16];
		    new taknieBOT[16];
		    new komunikat[256];
		    GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
			if(lights == 1) format(taknieL, sizeof(taknieL), "Wy��cz");
			else format(taknieL, sizeof(taknieL), "W��cz");
			if(bonnet == 1) format(taknieBON, sizeof(taknieBON), "Zamknij");
			else format(taknieBON, sizeof(taknieBON), "Otw�rz");
			if(boot == 1) format(taknieBOT, sizeof(taknieBOT), "Zamknij");
			else format(taknieBOT, sizeof(taknieBOT), "Otw�rz");
            //
            format(komunikat, sizeof(komunikat), "�wiat�a (%s)\nMaska (%s)\nBaga�nik (%s)", taknieL, taknieBON, taknieBOT); // max. 79char
            //
            if(PlayerInfo[playerid][pCB])
            {
                new cbr[16];
                if(cbradijo[playerid]) format(cbr, 16, "W��cz");
                else format(cbr, 16, "Wy��cz");
                format(komunikat, sizeof(komunikat), "%s\nCB-Radio (%s)", komunikat, cbr); //+ 18char
            }
            if(!Car_IsStealable(veh))
            {
                if(CarData[VehicleUID[veh][vUID]][c_Neon] != 0)
    			{
    			    new taknieNeo[16];
    				if(VehicleUID[veh][vNeon]) format(taknieNeo, sizeof(taknieNeo), "Wy��cz");
    				else format(taknieNeo, sizeof(taknieNeo), "W��cz");
                    format(komunikat, sizeof(komunikat), "%s\nNeony (%s)", komunikat, taknieNeo); //+ 15char
    			}
            }
            //sizemax: komunikat = 112char
            format(komunikat, sizeof(komunikat), "%s\nLepa Station\nVice City Radio\nRadio SAN1\nRadio SAN2\nWlasny Stream\nWy��cz radio", komunikat); //+ 35char
            //sizefinel: komunikat = 148char limit (256) OK.
			ShowPlayerDialogEx(playerid, 666, DIALOG_STYLE_LIST, "Deska rozdzielcza", komunikat, "Wybierz", "Anuluj");
		}
		else
		{
		    sendTipMessage(playerid, "Musisz by� kierowc� !");
        	return 1;
		}
	}
	else
	{
        sendTipMessage(playerid, "Musisz by� w wozie.");
        return 1;
	}
	return 1;
}

//end
