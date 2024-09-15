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
command_noooc_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
        new string[128];
		if (PlayerInfo[playerid][pAdmin] >= 20)
		{
			if(!noooc)
			{
				noooc = 1;
				BroadCast(COLOR_GRAD2, "»» Czat OOC Zosta³ zablokowany przez Administratora !");
			}
			else
			{
				noooc = 0;
				BroadCast(COLOR_GRAD2, "»» Czat OOC Zosta³ odblokowany przez Administratora !");
			}

            format(string, 128, "CMD_Info: /noooc u¿yte przez %s [%d]", GetNickEx(playerid), playerid);
            SendCommandLogMessage(string);
			Log(adminLog, INFO, "Admin %s u¿y³ /noooc", GetPlayerLogName(playerid));
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

//end
