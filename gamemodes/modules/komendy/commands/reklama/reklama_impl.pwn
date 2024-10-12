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
command_reklama_Impl(playerid)
{
    if(!IsAHA(playerid))
	{
		sendErrorMessage(playerid, "Nie jesteœ z agencji!");
		return 1;
	}
	if(AntySpam[playerid] == 0)
	{
        new string[128];
		if(PlayerInfo[playerid][pBP] >= 1)
		{
			format(string, sizeof(string), "   Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			sendTipMessage(playerid, string);
			return 1;
		}
		SendClientMessageToAll(COLOR_WHITE, "|___________ Firma Sprz¹taj¹ca ___________|");
		SendClientMessageToAll(COLOR_LIGHTBLUE, "Chcesz pozbyæ siê jakiegoœ œmiecia? Skorzystaj z us³ug ciecia! ((/kontrakt))");
        format(string, sizeof(string), "CMD_Info: /ha u¿yte przez %s [%d]", GetNick(playerid), playerid);
        SendCommandLogMessage(string);
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pAdmin] == 0 && PlayerInfo[i][pNewAP] == 0 && (PlayerInfo[i][pMember] == 8 || PlayerInfo[i][pLider] == 8))
			{
				SendClientMessage(i, 0xD8C173FF, string);
			}
		}
        Log(warningLog, INFO, "%s u¿y³ /ha", GetPlayerLogName(playerid));
		AntySpam[playerid] = 1;
		SetTimerEx("AntySpamTimer",10000,0,"d",playerid);
	}
	else
	{
		sendTipMessage(playerid, "Odczekaj 10 sekund");
	}
	return 1;
}

//end
