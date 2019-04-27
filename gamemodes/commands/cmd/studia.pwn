//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ studia ]------------------------------------------------//
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

YCMD:studia(playerid, params[], help)
{
	new string[128];

    if(gPlayerLogged[playerid] == 1)
    {
        if(PlayerInfo[playerid][pMember] == 9 && PlayerInfo[playerid][pRank] >= 2 || PlayerInfo[playerid][pLider] == 9)
        {
            new drukarniatxt[32];
			new studiovictxt[32];
			new studiogtxt[32];
			new studiontxt[32];
			new biurosantxt[32];
			if(drukarnia == 1)
			{
			    drukarniatxt = "Zamkniête";
			}
			else
			{
			    drukarniatxt = "Otwarte";
			}
			if(studiovic == 1)
			{
			    studiovictxt = "Zamkniête";
			}
			else
			{
			    studiovictxt = "Otwarte";
			}
			if(studiog == 1)
			{
			    studiogtxt = "Zamkniête";
			}
			else
			{
			    studiogtxt = "Otwarte";
			}
			if(studion == 1)
			{
			    studiontxt = "Zamkniête";
			}
			else
			{
			    studiontxt = "Otwarte";
			}
			if(biurosan == 1)
			{
			    biurosantxt = "Zamkniête";
			}
			else
			{
			    biurosantxt = "Otwarte";
			}
			if(GUIExit[playerid] == 0)
			{
				format(string, sizeof(string), "Drukarnia (%s)\nStudio Victim (%s)\nStudio g³ówne (%s)\nStudio nagrañ (%s)\nGabinet red. naczelnego (%s)", drukarniatxt, studiovictxt, studiogtxt, studiontxt, biurosantxt);
	            ShowPlayerDialogEx(playerid, 322, DIALOG_STYLE_LIST, "Zamykanie i otwieranie studiów", string, "Close/Open", "WyjdŸ");
			}
		}
        else
        {
            sendTipMessageEx(playerid, COLOR_NEWS, "Nie jesteœ z SAN/nie masz 2 rangi.");
        }
    }
	return 1;
}
