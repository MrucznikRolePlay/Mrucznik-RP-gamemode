//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ respawn ]------------------------------------------------//
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

CMD:respawn(playerid)
{
	new string[128];
	
	
	if(Count >= 20)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3 || IsAScripter(playerid))
		{
			GetPVarString(playerid, "pAdminDutyNickOn", AdminName, sizeof(AdminName)); 
		
			if(GetPlayerAdminDutyStatus(playerid) == 0)
			{
				SendClientMessage(playerid,COLOR_YELLOW, "Odliczanie rozpoczête");
				BroadCast(COLOR_PANICRED, "Uwaga! Za 20 sekund nast¹pi respawn nieu¿ywanych pojazdów !");
				format(string, sizeof(string), "AdmCmd: %s [ID: %d] rozpocz¹³ odliczanie do Respawnu Aut !", GetNick(playerid, true), playerid);
				ABroadCast(COLOR_PANICRED,string,1);
				CountDown();
			}
			else
			{
				SendClientMessage(playerid,COLOR_YELLOW, "Odliczanie rozpoczête");
				BroadCast(COLOR_PANICRED, "Uwaga! Za 20 sekund nast¹pi respawn nieu¿ywanych pojazdów !");
				format(string, sizeof(string), "AdmCmd: %s [ID: %d] rozpocz¹³ odliczanie do Respawnu Aut !", AdminName, playerid);
				ABroadCast(COLOR_PANICRED,string,1);
				CountDown();
			
			}
		}
		else
		{
			sendErrorMessage(playerid, "Poczekaj a¿ skoñczy siê to odliczanie!!!");
		}
	}
	return 1;
}


