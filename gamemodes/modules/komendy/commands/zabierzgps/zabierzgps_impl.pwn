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
command_zabierzgps_Impl(playerid, params[256])
{
    if(IsAKidnapper(playerid))
	{
        new para1;
        if(sscanf(params, "k<fix>d", para1))
        {
            sendTipMessage(playerid, "U�yj /zabierzgps [playerid/Cz��Nicku]");
            return 1;
        }

        new string[144];
        if(GetDistanceBetweenPlayers(playerid, para1) < 4 && (PlayerInfo[para1][pBW] > 0 || PlayerInfo[para1][pInjury] > 0))
        {
            if(PDGPS == para1)
            {
                PDGPS = -1;
                new pZone[MAX_ZONE_NAME];
			    GetPlayer2DZone(para1, pZone, MAX_ZONE_NAME);
                format(string, sizeof(string), "* %s zabiera nadajnik GPS %s, nast�pnie go niszczy.", GetNick(playerid), GetNick(para1));
                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                format(string, sizeof(string), "* Zabra�e� %s nadajnik GPS. Nadawanie lokalizacji zosta�o przerwane.", GetNick(para1));
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "=: Sygna� z nadajnika GPS %s %s zosta� przerwany. Ostatnia lokalizacja: %s :=", FracRang[GetPlayerFraction(para1)][PlayerInfo[para1][pRank]], GetNick(para1), pZone);
                SendRadioMessage(1, COLOR_YELLOW2, string);
                SendRadioMessage(2, COLOR_YELLOW2, string);
                SendRadioMessage(3, COLOR_YELLOW2, string);
                SendRadioMessage(4, COLOR_YELLOW2, string);
                return ShowPlayerInfoDialog(para1, "Mrucznik Role Play", "Zabrano Ci nadajnik GPS."); 
            }
            else
            {
                format(string, sizeof(string), "* Gracz nie ma w��czonego nadajnika GPS.");
                SendClientMessage(playerid, COLOR_GREY, string);
            }
        }
        else
        {
            return ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "Gracz musi by� nieprzytomny lub jeste� za daleko.");     
        }
	}
	return 1;
}

//end
