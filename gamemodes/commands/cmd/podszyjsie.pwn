//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ podszyjsie ]----------------------------------------------//
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


// YCMD:podszyj(playerid, params[], help) return RunCommand(playerid, "/podszyjsie",  params, help);
YCMD:podszyjsie(playerid, params[], help)
{
	/*
    if(IsPlayerConnected(playerid))
    {
        if(GetPlayerFraction(playerid) != FRAC_FBI) return 1;
		if(PlayerInfo[playerid][Rank] == 4 || PlayerInfo[playerid][Rank] == 5 || PlayerInfo[playerid][Rank] == 7 || PlayerInfo[playerid][Rank] == 8 || PlayerInfo[playerid][Rank] == 9)
		{
		    ShowPlayerDialogEx(playerid,DIALOGID_PODSZYJ,DIALOG_STYLE_LIST,"Podszyj siê.","FBI\n""Grove\n""Ballas\n""ICC\n""Yakuza\n""Latin Kings","Dalej",""); //zmieñ dialogid
		}
		else
		{
            SendClientMessage(playerid, COLOR_GRAD2, "	Nie mo¿esz siê podszywaæ!");
		}
	}
	*/
	return 1;
}

