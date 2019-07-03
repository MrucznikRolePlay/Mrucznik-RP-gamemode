//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ graj ]-------------------------------------------------//
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

YCMD:graj(playerid, params[], help)
{
	if(PlayerToPoint(40.0,playerid, 1139.7068,-2.5457,1000.6797))
	{
		new string[128];
		if(PlayerInfo[playerid][pTraderPerk] > 0)
		{
			new skill = 400 / 100;
			new price = (skill)*(PlayerInfo[playerid][pTraderPerk]);
			new payout = 400 - price;
			DajKase(playerid,- payout);
			format(string, sizeof(string), "~r~-$%d", payout);
			GameTextForPlayer(playerid, string, 5000, 1);
		}
		else
		{
			ZabierzKase(playerid,400);
			format(string, sizeof(string), "~r~-$%d", 1000);
			GameTextForPlayer(playerid, string, 5000, 1);
		}
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);//DŸwiêk
		new prize;
		new symb1[32]; new symb2[32]; new symb3[32];
		new randcard1 = random(10);//minimum 1000  max 9999
		new randcard2 = random(10);//minimum 1000  max 9999
		new randcard3 = random(10);//minimum 1000  max 9999
		if(randcard1 >= 5)
		{
			format(symb1, sizeof(symb1), "~b~]");
			randcard1 = 1;
		}
		else if(randcard1 <= 4 && randcard1 >= 2)
		{
			format(symb1, sizeof(symb1), "~g~]");
			randcard1 = 2;
		}
		else if(randcard1 < 2)
		{
			format(symb1, sizeof(symb1), "~y~]");
			randcard1 = 3;
		}
		if(randcard2 >= 5)
		{
			format(symb2, sizeof(symb2), "~b~]");
			randcard2 = 1;
		}
		else if(randcard2 <= 4 && randcard2 >= 2)
		{
			format(symb2, sizeof(symb2), "~g~]");
			randcard2 = 2;
		}
		else if(randcard2 < 2)
		{
			format(symb2, sizeof(symb2), "~y~]");
			randcard2 = 3;
		}
		if(randcard3 >= 5)
		{
			format(symb3, sizeof(symb3), "~b~]");
			randcard3 = 1;
		}
		else if(randcard3 <= 4 && randcard3 >= 2)
		{
			format(symb3, sizeof(symb3), "~g~]");
			randcard3 = 2;
		}
		else if(randcard3 < 2)
		{
			format(symb3, sizeof(symb3), "~y~]");
			randcard3 = 3;
		}
		if(randcard1 == randcard2 && randcard1 == randcard3)
		{
			if(randcard1 > 5)
			{
				prize = 3500;
			}
			if(randcard1 <= 4 && randcard1 >= 2)
			{
				prize = 2000;
			}
			if(randcard1 < 2)
			{
				prize = 100;
			}
			DajKase(playerid,prize);
			format(string, sizeof(string), "%s %s %s ~n~~n~~w~~g~$%d",symb1,symb2,symb3, prize);
		}
		else
		{
			format(string, sizeof(string), "%s %s %s ~n~~n~~w~~r~$0",symb1,symb2,symb3);
		}
		GameTextForPlayer(playerid, string, 3000, 3);
		return 1;
	}
	return 1;
}
