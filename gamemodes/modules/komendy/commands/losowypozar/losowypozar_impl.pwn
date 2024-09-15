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
command_losowypozar_Impl(playerid)
{
    if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
	{
	    DeleteAllFire();
	    AktywujPozar();
	    sendTipMessage(playerid, "Aktywowa³eœ losowy po¿ar dla LSFD!");
	    sendTipMessage(playerid, "Aby usun¹æ po¿ar wpisz /usunpozar !");
	    
	    new string[128];
        format(string, 128, "CMD_Info: /losowypozar u¿yte przez %s [%d]", GetNick(playerid), playerid);
        SendCommandLogMessage(string);
		Log(adminLog, INFO, "Admin %s u¿y³ /losowypozar", GetPlayerLogName(playerid));
	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}

//end
