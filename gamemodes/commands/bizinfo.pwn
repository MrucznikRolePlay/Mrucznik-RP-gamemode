//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ bizinfo ]------------------------------------------------//
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

CMD:bizinfo(playerid)
{
    if(IsPlayerConnected(playerid))
    {
	    if(gPlayerLogged[playerid] == 1)
	    {
			new string[256];
			for(new i=0;i<MAX_BIZNES;i++)
		    {
				if(IsPlayerInRangeOfPoint(playerid, 3.0, BizData[i][eBizWejX], BizData[i][eBizWejY], BizData[i][eBizWejZ]))
				{
				    new bizowner[64];
					bizowner = Biz_Owner(i);
        			if(strfind(bizowner, "mru_konta", true)>=0)
					{
					    format(string, sizeof(string), "{ff704d}NIERUCHOMOŒÆ [0%d]\n{fbfe00}[%s]\n\n{ffffff}W³aœciciel:\tBrak (biznes na sprzeda¿)\nPremia PayDay:\t%d$", i, BizData[i][eBizName],BizData[i][eBizMoney]);
	        			ShowPlayerDialogEx(playerid, 9900, DIALOG_STYLE_MSGBOX, "Informacje o biznesie", string, "Zamknij", "");
					}
					else
					{
					    format(string, sizeof(string), "{ff704d}NIERUCHOMOŒÆ [0%d]\n{fbfe00}[%s]\n\n{ffffff}W³aœciciel:\t%s\nPremia PayDay:\t%d$", i, BizData[i][eBizName],bizowner,BizData[i][eBizMoney]);
	        			ShowPlayerDialogEx(playerid, 9900, DIALOG_STYLE_MSGBOX, "Informacje o biznesie", string, "Zamknij", "");
	 				}
                }
			}
	    }
	}
	return 1;
}
