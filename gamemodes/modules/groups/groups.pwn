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
		if(PlayerInfo[playerid][Group1] || PlayerInfo[playerid][Group2] || PlayerInfo[playerid][Group3])
		{
			PlayerTextDrawShow(playerid, Textdraw0[playerid]);
			SelectTextDraw(playerid, 0xD4C598AA);

			new str[64];
			
			if(PlayerInfo[playerid][Group1] != 0)
			{
				format(str, sizeof(str), "1  %s", GroupInfo[PlayerInfo[playerid][Group1]][gName]);
				PlayerTextDrawSetString(playerid, Textdraw1[playerid], str);
				PlayerTextDrawShow(playerid, Textdraw1[playerid]);
				PlayerTextDrawShow(playerid, Textdraw4[playerid]);
				PlayerTextDrawShow(playerid, Textdraw7[playerid]);
				PlayerTextDrawShow(playerid, Textdraw10[playerid]);
				PlayerTextDrawShow(playerid, Textdraw13[playerid]);
			}
			if(PlayerInfo[playerid][Group2] != 0)
			{
				format(str, sizeof(str), "2  %s", GroupInfo[PlayerInfo[playerid][Group2]][gName]);
				PlayerTextDrawSetString(playerid, Textdraw2[playerid], str);
				PlayerTextDrawShow(playerid, Textdraw2[playerid]);
				PlayerTextDrawShow(playerid, Textdraw5[playerid]);
				PlayerTextDrawShow(playerid, Textdraw8[playerid]);
				PlayerTextDrawShow(playerid, Textdraw11[playerid]);
				PlayerTextDrawShow(playerid, Textdraw14[playerid]);
			}
			if(PlayerInfo[playerid][Group3] != 0)
			{
				format(str, sizeof(str), "3  %s", GroupInfo[PlayerInfo[playerid][Group3]][gName]);
				PlayerTextDrawSetString(playerid, Textdraw3[playerid], str);
				PlayerTextDrawShow(playerid, Textdraw3[playerid]);
				PlayerTextDrawShow(playerid, Textdraw6[playerid]);
				PlayerTextDrawShow(playerid, Textdraw9[playerid]);
				PlayerTextDrawShow(playerid, Textdraw12[playerid]);
				PlayerTextDrawShow(playerid, Textdraw15[playerid]);
			}
			
			PlayerInfo[playerid][pGroupsShow] = 1;
		}
		else
		{
  			GameTextForPlayer(playerid, "~w~Nie posiadasz przynaleznosci do ~r~zadnej ~w~grupy!", 3000, 4);
		}
	}
	else
	{
		PlayerInfo[playerid][pGroupsShow] = 0;
		CancelSelectTextDraw(playerid);
		PlayerTextDrawHide(playerid, Textdraw0[playerid]);
		PlayerTextDrawHide(playerid, Textdraw1[playerid]);
		PlayerTextDrawHide(playerid, Textdraw2[playerid]);
		PlayerTextDrawHide(playerid, Textdraw3[playerid]);
		PlayerTextDrawHide(playerid, Textdraw4[playerid]);
		PlayerTextDrawHide(playerid, Textdraw5[playerid]);
		PlayerTextDrawHide(playerid, Textdraw6[playerid]);
		PlayerTextDrawHide(playerid, Textdraw7[playerid]);
		PlayerTextDrawHide(playerid, Textdraw8[playerid]);
		PlayerTextDrawHide(playerid, Textdraw9[playerid]);
		PlayerTextDrawHide(playerid, Textdraw10[playerid]);
		PlayerTextDrawHide(playerid, Textdraw11[playerid]);
		PlayerTextDrawHide(playerid, Textdraw12[playerid]);
		PlayerTextDrawHide(playerid, Textdraw13[playerid]);
		PlayerTextDrawHide(playerid, Textdraw14[playerid]);
		PlayerTextDrawHide(playerid, Textdraw15[playerid]);
	}
	return 1;
}

//end