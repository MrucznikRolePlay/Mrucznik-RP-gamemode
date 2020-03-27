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

	Textdraw1[playerid] = CreatePlayerTextDraw(playerid,125.000000, 190.000000, "1  LSPD");
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

	Textdraw2[playerid] = CreatePlayerTextDraw(playerid,125.000000, 215.000000, "2  LSMC");
	PlayerTextDrawBackgroundColor(playerid,Textdraw2[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw2[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw2[playerid], 0.500000, 1.500000);
	PlayerTextDrawColor(playerid,Textdraw2[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw2[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw2[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw2[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw2[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw2[playerid], 100);
	PlayerTextDrawTextSize(playerid,Textdraw2[playerid], 555.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw2[playerid], 0);

	Textdraw3[playerid] = CreatePlayerTextDraw(playerid,125.000000, 239.000000, "3 Silownia");
	PlayerTextDrawBackgroundColor(playerid,Textdraw3[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw3[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw3[playerid], 0.500000, 1.500000);
	PlayerTextDrawColor(playerid,Textdraw3[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw3[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw3[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw3[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw3[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw3[playerid], 100);
	PlayerTextDrawTextSize(playerid,Textdraw3[playerid], 555.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw3[playerid], 0);

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

	Textdraw5[playerid] = CreatePlayerTextDraw(playerid,254.000000, 216.000000, "Online");
	PlayerTextDrawBackgroundColor(playerid,Textdraw5[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw5[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw5[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw5[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw5[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw5[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw5[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw5[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw5[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw5[playerid], 305.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw5[playerid], 1);

	Textdraw6[playerid] = CreatePlayerTextDraw(playerid,254.000000, 240.000000, "Online");
	PlayerTextDrawBackgroundColor(playerid,Textdraw6[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw6[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw6[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw6[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw6[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw6[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw6[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw6[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw6[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw6[playerid], 305.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw6[playerid], 1);

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

	Textdraw8[playerid] = CreatePlayerTextDraw(playerid,321.000000, 216.000000, "Sluzba");
	PlayerTextDrawBackgroundColor(playerid,Textdraw8[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw8[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw8[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw8[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw8[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw8[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw8[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw8[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw8[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw8[playerid], 372.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw8[playerid], 1);

	Textdraw9[playerid] = CreatePlayerTextDraw(playerid,321.000000, 240.000000, "Sluzba");
	PlayerTextDrawBackgroundColor(playerid,Textdraw9[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw9[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw9[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw9[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw9[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw9[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw9[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw9[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw9[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw9[playerid], 372.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw9[playerid], 1);

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

	Textdraw11[playerid] = CreatePlayerTextDraw(playerid,386.000000, 216.000000, "Magazyn");
	PlayerTextDrawBackgroundColor(playerid,Textdraw11[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw11[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw11[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw11[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw11[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw11[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw11[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw11[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw11[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw11[playerid], 459.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw11[playerid], 1);

	Textdraw12[playerid] = CreatePlayerTextDraw(playerid,386.000000, 240.000000, "Magazyn");
	PlayerTextDrawBackgroundColor(playerid,Textdraw12[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw12[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw12[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw12[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw12[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw12[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw12[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw12[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw12[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw12[playerid], 460.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw12[playerid], 1);

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

	Textdraw14[playerid] = CreatePlayerTextDraw(playerid,480.000000, 216.000000, "Pojazdy");
	PlayerTextDrawBackgroundColor(playerid,Textdraw14[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw14[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw14[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw14[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw14[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw14[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw14[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw14[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw14[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw14[playerid], 544.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw14[playerid], 1);

	Textdraw15[playerid] = CreatePlayerTextDraw(playerid,480.000000, 240.000000, "Pojazdy");
	PlayerTextDrawBackgroundColor(playerid,Textdraw15[playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw15[playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw15[playerid], 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,Textdraw15[playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw15[playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw15[playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw15[playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw15[playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw15[playerid], 90);
	PlayerTextDrawTextSize(playerid,Textdraw15[playerid], 545.000000, 11.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw15[playerid], 1);
	return 1;
}

//end