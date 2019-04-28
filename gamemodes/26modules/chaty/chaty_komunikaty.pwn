//chaty.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: chaty.pwn ]---------------------------------------------//
//Opis:
/*
	Zawiera wszelkie chaty globalne (komunikaty)
	Wliczamy w to:
		> DMV - wiadomoœæ rz¹dowa
		
*/
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

//

//-----------------<[ Funkcje: ]>-------------------
stock GetFractionColor(fraction)
{
	new fracColor;
	if(fraction == 1)
	{
		fracColor = COLOR_LIGHTBLUE;
	}
	if(fraction == 2)
	{
		fracColor = COLOR_LFBI;
	}
	if(fraction == 3)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 4)
	{
		fracColor = COLOR_LIGHTBLUE; 
	}
	if(fraction == 5)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 6)
	{
		fracColor = COLOR_WHITE; 
	}
	if(fraction == 7)
	{
		fracColor = COLOR_PURPLE;
	}
	if(fraction == 8)
	{
		fracColor = COLOR_BLUE;
	}
	if(fraction == 9)
	{
		fracColor = COLOR_NEWS;
	}
	if(fraction == 10)
	{
		fracColor = COLOR_YELLOW;
	}
	if(fraction == 11)
	{
		fracColor = COLOR_LIGHTGREEN;
	}
	if(fraction == 12)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 13)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 14)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 15)
	{
		fracColor = COLOR_BROWN;
	}
	if(fraction == 16)
	{
		fracColor = COLOR_WHITE;
	}
	if(fraction == 17)
	{
		fracColor = COLOR_LIGHTRED;
	}
	if(fraction == 18)
	{
		fracColor = COLOR_WHITE;
	}
	return fracColor;
}
stock sendFractionMessageToAll(playerid, text[])
{
	new sContent[256];
	foreach(new i : Player) 
	{
		if(GetPVarInt(i, "TOG_frakcja_info") == 0)
		{
			fractionMessageRange++; 
			format(sContent, sizeof(sContent), "|___________ %s ___________|", FractionNames[GetPlayerFraction(playerid)]); 
			SendClientMessage(i, COLOR_WHITE, sContent); 
			format(sContent, sizeof(sContent), "%s %s: %s", FracRang[PlayerInfo[playerid][pMember]][PlayerInfo[playerid][pRank]], GetNick(playerid, true), text);
			SendClientMessage(i, GetFractionColor(PlayerInfo[playerid][pMember]), sContent); 
		}
	}
	format(sContent, sizeof(sContent), "Wiadomoœæ dotar³a do %d graczy", fractionMessageRange); 
	sendTipMessage(playerid, sContent); 
	fractionMessageRange = 0; 
	return 1;
}

//end