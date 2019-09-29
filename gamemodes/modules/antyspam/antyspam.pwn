//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  antyspam                                                 //
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
// Autor: Simeone
// Data utworzenia: 25.09.2019
//Opis:
/*
	Timery i funkcje dotycz¹ce anty-spamu
*/

//Bêdê to rozwija³ g³ównie pod uniwersalizm, aby antyspam nie nak³ada³ siê na siebie i nie tworzyæ milionów zmiennych.
//Póki co podstawowe za³o¿enie siê sprawdza - wiêc na jakiœ czas pozostaje to w takim stadium :) 

//-----------------<[ Funkcje: ]>-------------------
SetAntySpamForPlayer(playerid, ANTY_SPAM_TYPE)
{
	if(ANTY_SPAM_TYPE == 30)
	{
		SetTimerEx("AntySpam30", 10000, 0, "d", playerid);
	}
	return 1;
}
CheckAntySpamForPlayer(playerid, ANTY_SPAM_TYPE)
{
	if(ANTY_SPAM_TYPE == 30)
	{
		if(antySpam30[playerid] == 1)
		{
			return true;
		}
	}
	return false;
}

//end