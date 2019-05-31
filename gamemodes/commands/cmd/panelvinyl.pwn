//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ panelvinyl ]----------------------------------------------//
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
	Skrypt pozwalaj¹cy zarz¹dzaæ vinyl-clubem
*/


// Notatki skryptera:
/*
	
*/

YCMD:panelvinyl(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
        if(GetPlayerFraction(playerid) == FRAC_SN && PlayerInfo[playerid][pRank] >= 6)
        {
            sendTipMessage(playerid, "Witamy w panelu zarz¹dzania Vinyl-Club");
            ShowPlayerDialogEx(playerid, 6999, DIALOG_STYLE_TABLIST, "Laptop Lidera", "Open/Close\nUstal cene Norm.\nUstal cene VIP\nUstal cene napoi\nUstal nazwe napoi", "Wybierz", "Odrzuæ");
        }
        else
        {
            sendErrorMessage(playerid, "Nie jesteœ z San News, nie mo¿esz zarz¹dzaæ vinylem!");
        }
    }
	return 1;
}
