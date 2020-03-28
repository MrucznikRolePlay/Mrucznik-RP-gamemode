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
		if(PlayerInfo[playerid][pRank] == 4 || PlayerInfo[playerid][pRank] == 5 || PlayerInfo[playerid][pRank] == 7 || PlayerInfo[playerid][pRank] == 8 || PlayerInfo[playerid][pRank] == 9)
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

