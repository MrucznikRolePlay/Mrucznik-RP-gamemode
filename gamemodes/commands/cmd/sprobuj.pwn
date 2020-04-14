//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ sprobuj ]------------------------------------------------//
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

YCMD:sprobuj(playerid, params[], help)
{
	if(isnull(params)) return sendTipMessage(playerid, "U¿yj /sprobuj [Akcja] np. trafiæ do kosza");
	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		sendErrorMessage(playerid, "Nie mo¿esz u¿yæ tej komendy podczas s³u¿by administratora!"); 
		return 1;
	}
    new string[256];
	//switch(random(4)+1) 
	new rand = random(2);
    switch(rand)
	{
		case 0: format(string, 256, "*** %s spróbowa³ %s i uda³o mu siê ***",GetNick(playerid), params);
		case 1: format(string, 256, "*** %s spróbowa³ %s i nie uda³o mu siê ***",GetNick(playerid), params);
	}
    ProxDetector(30.0, playerid, string, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
	Log(chatLog, INFO, "%s spróbuj: %s", GetPlayerLogName(playerid), params);
	return 1;
}
