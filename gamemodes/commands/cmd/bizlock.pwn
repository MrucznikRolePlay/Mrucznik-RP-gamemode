//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ bizlock ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

CMD:bizlock(playerid, params[])
{
	if(PlayerInfo[playerid][pPbiskey] >= 0 && PlayerInfo[playerid][pPbiskey] <= MAX_BIZNES)
	{
		new bizid = PlayerInfo[playerid][pPbiskey];
		new string[128];
		if(BizOpenStatus[bizid] == 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, BizData[bizid][eBizWejX], BizData[bizid][eBizWejY], BizData[bizid][eBizWejZ]))
			{
				format(string, sizeof(string), "%s przekrêca kluczyk i otwiera biznes %s", GetNick(playerid, true), BizData[bizid][eBizName]);
				ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				BizOpenStatus[bizid] = 1;
			}
			else
			{
				sendErrorMessage(playerid, "Musisz byæ pod drzwiami swojego biznesu, aby tego dokonaæ!"); 
			}
		}
		else
		{
			if(IsPlayerInRangeOfPoint(playerid, 5.0, BizData[bizid][eBizWejX], BizData[bizid][eBizWejY], BizData[bizid][eBizWejZ]))
			{
				format(string, sizeof(string), "%s przekrêca kluczyk i zamyka biznes %s", GetNick(playerid, true), BizData[bizid][eBizName]);
				ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				BizOpenStatus[bizid] = 0;
			}
			else
			{
				sendErrorMessage(playerid, "Musisz byæ pod drzwiami swojego biznesu, aby tego dokonaæ!"); 
			}
		
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie masz w³asnego biznesu! ~ Zakup go w Wydziale Planowania."); 
	}
	return 1;
}
