//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ mp3 ]--------------------------------------------------//
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

YCMD:mp3(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pCDPlayer])
        {
			ShowPlayerDialogEx(playerid, DIALOGID_MUZYKA, DIALOG_STYLE_LIST, "Odtwarzacz MP3.","Mrucznik Radio\n""SAN Radio kana� 1\n""SAN Radio kana� 2\n""Radio ZET\n""RMF FM\n""RMF MAXXX\n""Radio ESKA\n""Lepa Station\n""W�asny stream\n""MP3 OFF","Start",""); //zmie� dialogid
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz odtwarzacza mp3!");
		}
    }
    return 1;
}
