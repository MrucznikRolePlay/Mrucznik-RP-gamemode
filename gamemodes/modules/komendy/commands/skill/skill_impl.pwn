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
command_skill_Impl(playerid, params[256])
{
    new string[128];
	new level;
	if( sscanf(params, "d", level))
	{
		SendClientMessage(playerid, COLOR_WHITE, "|__________________ Skill Info __________________|");
		SendClientMessage(playerid, COLOR_WHITE, "U¯YJ: /skill [numer]");
		SendClientMessage(playerid, COLOR_GREY, "| 1: £owca Nagród        6: Rybak");
		SendClientMessage(playerid, COLOR_GREY, "| 2: Prawnik             7: Mechanik");
		SendClientMessage(playerid, COLOR_GREY, "| 3: Prostytutka         8: Kierowca");
		SendClientMessage(playerid, COLOR_GREY, "| 4: Diler Dragów        9: Boxer");
		SendClientMessage(playerid, COLOR_GREY, "| 5: Z³odziej aut        10: Diler Broni");
		SendClientMessage(playerid, COLOR_GREY, "| 11: Kurier             12: --------");
		SendClientMessage(playerid, COLOR_WHITE, "|________________________________________________|");
		return 1;
	}

	if (level == 1)//£owca nagród
	{
		level = PlayerInfo[playerid][pDetSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci £owcy Nagród s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz znaleŸæ %d ludzi aby zwiêkszyæ skill.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci £owcy Nagród s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz znaleŸæ %d ludzi aby zwiêkszyæ skill.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci £owcy Nagród s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz znaleŸæ %d ludzi aby zwiêkszyæ skill.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci £owcy Nagród s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz znaleŸæ %d ludzi aby zwiêkszyæ skill.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci £owcy Nagród s¹ na poziomie = 5."); }
	}
	else if (level == 2)//Lawyer
	{
		level = PlayerInfo[playerid][pLawSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Prawnika s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz uwolniæ %d ludzi aby zwiêkszyæ skill.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Prawnika s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz uwolniæ %d ludzi aby zwiêkszyæ skill.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Prawnika s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz uwolniæ %d ludzi aby zwiêkszyæ skill.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Prawnika s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz uwolniæ %d ludzi aby zwiêkszyæ skill.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Prawnika s¹ na poziomie = 5."); }
	}
	else if (level == 3)//Whore
	{
		level = PlayerInfo[playerid][pSexSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Sexu s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz wyruchaæ %d ludzi aby zwiêkszyæ skill.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Sexu s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz wyruchaæ %d ludzi aby zwiêkszyæ skill.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Sexu s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz wyruchaæ %d ludzi aby zwiêkszyæ skill.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Sexu s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz wyruchaæ %d ludzi aby zwiêkszyæ skill.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Sexu s¹ na poziomie = 5."); }
	}
	else if (level == 4)//Drugs Dealer
	{
		level = PlayerInfo[playerid][pDrugsSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Dilera dragów s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz sprzedaæ dragi %d ludziom aby zwiêkszyæ skill up.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Dilera dragów s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz sprzedaæ dragi %d ludziom aby zwiêkszyæ skill up.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Dilera dragów s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz sprzedaæ dragi %d ludziom aby zwiêkszyæ skill up.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Dilera dragów s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz sprzedaæ dragi %d ludziom aby zwiêkszyæ skill up.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Dilera dragów s¹ na poziomie = 5."); }
	}
	else if (level == 5)//Car Jacker
	{
		level = PlayerInfo[playerid][pJackSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Z³odzieja Aut s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz ukraœæ %d aut aby zwiêkszyæ skill.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Z³odzieja Aut s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz ukraœæ %d aut aby zwiêkszyæ skill.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Z³odzieja Aut s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz ukraœæ %d aut aby zwiêkszyæ skill.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Z³odzieja Aut s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz ukraœæ %d aut aby zwiêkszyæ skill.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Z³odzieja Aut s¹ na poziomie = 5."); }
	}
	/*else if (level == 6)//News Reporter
	{
		level = PlayerInfo[playerid][pNewsSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Reportera s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz napisaæ %d newsów aby zwiêkszyæ skill.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Reportera s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz napisaæ %d newsów aby zwiêkszyæ skill.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Reportera s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz napisaæ %d newsów aby zwiêkszyæ skill.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Reportera s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz napisaæ %d newsów aby zwiêkszyæ skill.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Reportera s¹ na poziomie = 5."); }
	}*/
	else if (level == 6)//Fishing
	{
		level = PlayerInfo[playerid][pFishSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Wêdkowania s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz z³owiæ %d ryb aby zwiêkszyæ skill.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Wêdkowania s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz z³owiæ %d ryb aby zwiêkszyæ skill.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Wêdkowania s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz z³owiæ %d ryb aby zwiêkszyæ skill.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Wêdkowania s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz z³owiæ %d ryb aby zwiêkszyæ skill.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Wêdkowania s¹ na poziomie = 5."); }
	}
	else if (level == 7)//Car Mechanic
	{
		level = PlayerInfo[playerid][pMechSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Mechanika s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz daæ %d us³ug aby zwiêkszyæ skill.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Mechanika s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz daæ %d us³ug aby zwiêkszyæ skill.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Mechanika s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz daæ %d us³ug aby zwiêkszyæ skill.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Mechanika s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz daæ %d us³ug aby zwiêkszyæ skill.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Mechanika s¹ na poziomie = 5."); }
	}
	else if (level == 8)//Car Dealer
	{
		level = PlayerInfo[playerid][pCarSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Kierowcy s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz wykonaæ %d tras aby zwiêkszyæ skill.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Kierowcy s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz wykonaæ %d tras aby zwiêkszyæ skill.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Kierowcy s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz wykonaæ %d tras aby zwiêkszyæ skill.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Kierowcy s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz wykonaæ %d tras aby zwiêkszyæ skill.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Kierowcy s¹ na poziomie = 5."); }
	}
	else if (level == 9)//Boxer
	{
		level = PlayerInfo[playerid][pBoxSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Boksera s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz wygraæ %d rund aby zwiêkszyæ skill.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Boksera s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz wygraæ %d rund aby zwiêkszyæ skill.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Boksera s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz wygraæ %d rund aby zwiêkszyæ skill.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Boksera s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz wygraæ %d rund aby zwiêkszyæ skill.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Boksera s¹ na poziomie = 5."); }
	}
	else if (level == 10)//Diler Broni
	{
		level = PlayerInfo[playerid][pGunSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Dilera Broni s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz sprzedaæ %d broni aby zwiêkszyæ skill.", 50 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Dilera Broni s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz sprzedaæ %d broni aby zwiêkszyæ skill.", 100 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Dilera Broni s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz sprzedaæ %d broni aby zwiêkszyæ skill.", 200 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Dilera Broni s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz sprzedaæ %d broni aby zwiêkszyæ skill.", 400 - level); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Dilera Broni s¹ na poziomie = 5."); }
	}
    else if (level == 11)//Kurier
	{
		level = PlayerInfo[playerid][pTruckSkill];
		if(level >= 0 && level <= 50) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Kuriera s¹ na poziomie = 1."); format(string, sizeof(string), "Musisz przewiezc %d paczek aby zwiêkszyæ skill.", (50 - level)*5); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 51 && level <= 100) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Kuriera s¹ na poziomie = 2."); format(string, sizeof(string), "Musisz przewiezc %d paczek aby zwiêkszyæ skill.", (100 - level)*5); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 101 && level <= 200) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Kuriera s¹ na poziomie = 3."); format(string, sizeof(string), "Musisz przewiezc %d paczek aby zwiêkszyæ skill.", (200 - level)*5); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 201 && level <= 400) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Kuriera s¹ na poziomie = 4."); format(string, sizeof(string), "Musisz przewiezc %d paczek aby zwiêkszyæ skill.", (400 - level)*5); SendClientMessage(playerid, COLOR_YELLOW, string); }
		else if(level >= 401) { SendClientMessage(playerid, COLOR_YELLOW, "Twoje umiejêtnoœci Kuriera s¹ na poziomie = 5."); }
	}
	else
	{
        return RunCommand(playerid, "/skill",  "");
	}
    return 1;
}

//end
