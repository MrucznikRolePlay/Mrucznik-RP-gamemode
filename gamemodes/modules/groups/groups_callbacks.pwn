//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                   groups                                                   //
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
// Data utworzenia: 27.03.2020
//Opis:
/*
	
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnPlayerConnect(playerid)
{
	Textdraw0[playerid] = CreatePlayerTextDraw(playerid,141.000000, 159.000000, "Grupy");
	PlayerTextDrawBackgroundColor(playerid,Textdraw0[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw0[playerid], 0);
	PlayerTextDrawLetterSize(playerid,Textdraw0[playerid], 0.709999, 2.699999);
	PlayerTextDrawColor(playerid,Textdraw0[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw0[playerid], 1);
	PlayerTextDrawSetProportional(playerid,Textdraw0[playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw0[playerid], 0);

	Textdraw1[playerid] = CreatePlayerTextDraw(playerid,125.000000, 190.000000, "1  Nazwa");
	PlayerTextDrawBackgroundColor(playerid,Textdraw1[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw1[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw1[playerid], 0.500000, 1.500000);
	PlayerTextDrawColor(playerid,Textdraw1[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw1[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw1[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw1[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw1[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw1[playerid], 100);
	PlayerTextDrawTextSize(playerid,Textdraw1[playerid], 555.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw1[playerid], 0);

	Textdraw4[playerid] = CreatePlayerTextDraw(playerid,254.000000, 191.000000, "Online");
	PlayerTextDrawBackgroundColor(playerid,Textdraw4[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw4[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw4[playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw4[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw4[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw4[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw4[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw4[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw4[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw4[playerid], 305.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw4[playerid], 1);

	Textdraw7[playerid] = CreatePlayerTextDraw(playerid,321.000000, 191.000000, "Sluzba");
	PlayerTextDrawBackgroundColor(playerid,Textdraw7[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw7[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw7[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw7[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw7[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw7[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw7[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw7[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw7[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw7[playerid], 372.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw7[playerid], 1);

	Textdraw10[playerid] = CreatePlayerTextDraw(playerid,386.000000, 191.000000, "Magazyn");
	PlayerTextDrawBackgroundColor(playerid,Textdraw10[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw10[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw10[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw10[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw10[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw10[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw10[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw10[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw10[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw10[playerid], 458.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw10[playerid], 1);

	Textdraw13[playerid] = CreatePlayerTextDraw(playerid,480.000000, 191.000000, "Pojazdy");
	PlayerTextDrawBackgroundColor(playerid,Textdraw13[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw13[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw13[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw13[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw13[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw13[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw13[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw13[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw13[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw13[playerid], 544.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw13[playerid], 1);
	return 1;
}

hook OnGameModeInit()
{
	MruMySQL_LoadGroups();
	MruMySQL_LoadRanks();
	MruMySQL_LoadRanksPerms();
}

hook OnPlayerClickPTextDraw(playerid, PlayerText:playertextid)
{
	/*if(playertextid == Textdraw4[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_g(playerid, "1 online");
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == Textdraw5[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_g(playerid, "2 online");
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == Textdraw6[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_g(playerid, "3 online");
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == Textdraw7[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_duty(playerid, "1");
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == Textdraw8[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_duty(playerid, "2");
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == Textdraw9[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_duty(playerid, "3");
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == Textdraw10[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_g(playerid, "1 magazyn");
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == Textdraw11[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_g(playerid, "2 magazyn");
		CancelSelectTextDraw(playerid);
	}	
	if(playertextid == Textdraw12[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_g(playerid, "3 magazyn");
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == Textdraw13[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_g(playerid, "1 v");
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == Textdraw14[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_g(playerid, "2 v");
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == Textdraw15[playerid])
	{
		ShowGroupsForPlayer(playerid);
		cmd_g(playerid, "3 v");
		CancelSelectTextDraw(playerid);
	}*/
	return 1;
}

//end