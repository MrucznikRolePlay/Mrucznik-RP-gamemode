//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  groups                                                   //
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
// Autor: Creative
// Data utworzenia: 22.03.2020
//Opis:
/*
	System grup.
*/

//

//-----------------<[ Funkcje: ]>-------------------
stock ShowGroupsForPlayer(playerid)
{
	if(PlayerInfo[playerid][pGroupsShow] == 0)
	{
		if(PlayerInfo[playerid][pGroup])
		{
			PlayerTextDrawShow(playerid, Textdraw0[playerid]);
			SelectTextDraw(playerid, 0xD4C598AA);

			new str[64];
			format(str, sizeof(str), "1  %s", GroupInfo[PlayerInfo[playerid][pGroup]][gName]);
			PlayerTextDrawSetString(playerid, Textdraw1[playerid], str);
			PlayerTextDrawShow(playerid, Textdraw1[playerid]);
			PlayerTextDrawShow(playerid, Textdraw4[playerid]);
			PlayerTextDrawShow(playerid, Textdraw7[playerid]);
			PlayerTextDrawShow(playerid, Textdraw10[playerid]);
			PlayerTextDrawShow(playerid, Textdraw13[playerid]);
			PlayerInfo[playerid][pGroupsShow] = 1;
		}
		else
		{
  			GameTextForPlayer(playerid, "~w~Nie nalezysz do ~r~zadnej ~w~grupy!", 3000, 4);
		}
	}
	else
	{
		PlayerInfo[playerid][pGroupsShow] = 0;
		CancelSelectTextDraw(playerid);
		PlayerTextDrawHide(playerid, Textdraw0[playerid]);
		PlayerTextDrawHide(playerid, Textdraw1[playerid]);
		PlayerTextDrawHide(playerid, Textdraw4[playerid]);
		PlayerTextDrawHide(playerid, Textdraw7[playerid]);
		PlayerTextDrawHide(playerid, Textdraw10[playerid]);
		PlayerTextDrawHide(playerid, Textdraw13[playerid]);
	}
	return 1;
}

SetPlayerGroup(playerid, uid)
{
	PlayerInfo[playerid][pGroup] = uid;
	PlayerInfo[playerid][pRank] = 0;
	PlayerInfo[playerid][pUniform] = 0;
	return 1;
}

stock ShowOnlineGroupPlayers(playerid)
{
	new big_str[1024], strNick[128], plrs, header[144];
	foreach(new i : Player)
	{
		if(PlayerInfo[playerid][pGroup] == PlayerInfo[i][pGroup])
		{
			format(strNick, sizeof(strNick), "%d\t%s",i, GetNick(i));
			format(big_str, sizeof(big_str), "%s%s\n", big_str, strNick);
			plrs++;
		}
	}
	format(header, sizeof(header), "Pracownicy (%s)", GroupInfo[PlayerInfo[playerid][pGroup]][gName]);
	if(plrs) ShowPlayerDialogEx(playerid, DIALOG_LIST, DIALOG_STYLE_LIST, header, big_str, "OK", "");
	else ShowPlayerDialogEx(playerid, DIALOG_LIST, DIALOG_STYLE_LIST, header, "Nie ma nikogo online z tej grupy.", "OK", "");
	return 1;
}

//end