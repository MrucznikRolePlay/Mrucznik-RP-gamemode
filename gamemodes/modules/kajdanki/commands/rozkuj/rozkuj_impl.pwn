//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   rozkuj                                                  //
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
// Autor: NikodemBanan
// Data utworzenia: 01.03.2024


//

//------------------<[ Implementacja: ]>-------------------
command_rozkuj_Impl(playerid, uncuffedplayerid)
{
    if(IsRozkujInvalid(playerid, uncuffedplayerid))
	{
		return 1;
	}

	new message_s[128];

	format(message_s, sizeof(message_s), "* Zosta³eœ rozkuty przez %s.", GetNick(playerid));
	SendClientMessage(uncuffedplayerid, COLOR_LIGHTBLUE, message_s);
	GameTextForPlayer(uncuffedplayerid, "~g~Rozkuty", 2500, 3);

	format(message_s, sizeof(message_s), "* Rozku³eœ %s.", GetNick(uncuffedplayerid));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, message_s);

	// pomijalna redundancja, by unikn¹æ bugów
	UncuffPlayer(uncuffedplayerid);
	UncuffPlayerCuffedBy(playerid);

	PlayerTied[uncuffedplayerid] = false;
	PlayerTiedTime[uncuffedplayerid] = 0;
	PlayerInfo[uncuffedplayerid][pMuted] = false;

	return 1;
}

//end