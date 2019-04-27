//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ adminduty ]-----------------------------------------------//
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

CMD:adminduty(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
	{
	
		new adminMaWolnyNick = 0;
		
		SetPVarString(playerid, "pAdminDutyNickOn", params);
		new adminNameDuo[MAX_PLAYER_NAME];
		GetPVarString(playerid, "pAdminDutyNickOn", adminNameDuo, sizeof(adminNameDuo)); 
		
		
		if(GetPlayerAdminDutyStatus(playerid) == 0)
		{
			if(isnull(params))
			{
				sendTipMessage(playerid, "U¿yj /adminduty [NICK 4UM]");
				return 1;
			}
			if(OnDuty[playerid] == 1 || JobDuty[playerid] == 1 || SanDuty[playerid] == 1)//Zabezpieczenie przed duty - odkryte w doœæ ciekawy sposób, dlatego traktujemy jako easter egg
			{
				sendTipMessage(playerid, "Najpierw zejdŸ z duty! Powodujesz bugi, które muszê naprawiaæ!");
				return 1;
			}
			else
			{
				if(strlen(params) < MAX_PLAYER_NAME)//Maksymalnie 32 znaki nicku
				{
					if(strlen(params) >= MIN_ADMIN_NAME)//Minimalnie 3 znaki
					{
						//Symbole i znaki specjalne
						if(SprawdzZnaki(params) ==  0)
						{
							foreach(new i : Player)
							{
								//if(strfind(GetNick(i), AdminName, true) != -1)
								if(strfind(GetNick(i), adminNameDuo) == -1)
								{
									adminMaWolnyNick = 0;	
								}
								else
								{
									adminMaWolnyNick = 1;
								}
							}
							if(adminMaWolnyNick == 0)
							{
								AdminDutyPlayer(playerid, 1);
							}
							else
							{
								sendErrorMessage(playerid, "Ten nick jest ju¿ zajêty!");
								return 1;
							}
							
						}	
						else
						{
							sendErrorMessage(playerid, "U¿y³eœ nieprawid³owych znaków!"); 
							MSGBOX_Show(playerid, "Zle znaki!", MSGBOX_ICON_TYPE_ERROR);
							return 1;
						}
					}	
					else
					{
						sendErrorMessage(playerid, "Minimalna d³ugoœæ nicku to 3 znaki!"); 
						return 1;
					}
						
				}
				else
				{
					sendErrorMessage(playerid, "Maksymalna d³ugoœæ nicku to 32 znaki!"); 
					return 1;
				}
			}
				
			return 1;	
		}
		else if(GetPlayerAdminDutyStatus(playerid) == 1)//Wykonuje zejœcie z duty
		{	
			AdminDutyPlayer(playerid, 0); 
			return 1;
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ administratorem, wiêc nie mo¿esz tego u¿yæ!"); 
		MSGBOX_Show(playerid, "Nie masz uprawnien!", MSGBOX_ICON_TYPE_ERROR);
		return 1; 
	}

	return 1; 
}

