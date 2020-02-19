//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 nawigacja                                                 //
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
// Autor: Simeone
// Data utworzenia: 09.02.2020
//Opis:
/*
	Prosty system nawigacji, wskazuj¹cy punkt docelowy.
*/

//

//-----------------<[ Funkcje: ]>-------------------
ShowNawiDialog(playerid, dTYPE)
{
	new string[456];
	if(dTYPE == DIALOG_NAWI_MAIN)
	{
		ShowPlayerDialogEx(playerid, DIALOG_NAWI_MAIN, DIALOG_STYLE_LIST, "Nawigacja", "Znane Miejsca\nBiznesy\nUlice\nTelefon innego gracza", "Dalej", "WyjdŸ"); 
	}
	else if(dTYPE == DIALOG_NAWI_ZNANEMIEJSCA)
	{
		format(string, sizeof(string), 
		"Nazwa\tOdleg³oœæ\n\
		Urz¹d Miasta LS\t%0.2f metrów\n\
		Bank 0Verte\t%0.2f metrów\n\
		LSPD\t%0.2f metrów\n\
		Baza mechaników\t%0.2f metrów\n\
		Vinyl Club\t%0.2f metrów\n\
		Ibiza Club\t%0.2f metrów",
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_UMLS][N_POSX], posNawi[NAWI_UMLS][N_POSY], posNawi[NAWI_UMLS][N_POSZ]),
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_BANK][N_POSX], posNawi[NAWI_BANK][N_POSY], posNawi[NAWI_BANK][N_POSZ]),
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_LSPD][N_POSX], posNawi[NAWI_LSPD][N_POSY], posNawi[NAWI_LSPD][N_POSZ]), 
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_BAZA][N_POSX], posNawi[NAWI_BAZA][N_POSY], posNawi[NAWI_BAZA][N_POSZ]),
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_VINYL][N_POSX], posNawi[NAWI_VINYL][N_POSY], posNawi[NAWI_VINYL][N_POSZ]),
		GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_IBIZA][N_POSX], posNawi[NAWI_IBIZA][N_POSY], posNawi[NAWI_IBIZA][N_POSZ]));
		ShowPlayerDialogEx(playerid, DIALOG_NAWI_ZNANEMIEJSCA, DIALOG_STYLE_TABLIST_HEADERS, SetDefaultCaption(), 
		string, "JedŸ", "WyjdŸ");
	}
	else if(dTYPE == DIALOG_NAWI_BIZNESY)
	{
		//sendErrorMessage(playerid, "Wyst¹pi³ problem - nawigacja nie mo¿e po³aczyæ siê z baz¹ biznesów");
		ShowPlayerDialogEx(playerid, DIALOG_NAWI_BIZNESY, DIALOG_STYLE_INPUT, SetDefaultCaption(), "WprowadŸ poni¿ej ID b¹dŸ nazwê biznesu,\nktóry chcesz zlokalizowaæ.\nSystem przeanalizuje wszystkie istniej¹ce biznesy\npod k¹tem twoich wskazañ - mo¿e to trochê potrwaæ!",
		"Akceptuj", "WyjdŸ");
	}
	else if(dTYPE == DIALOG_NAWI_ULICE)
	{
		sendErrorMessage(playerid, "Wyst¹pi³ problem - nawigacja nie mo¿e po³¹czyæ siê z baz¹ ulic"); 
	}
	else //nie powinno siê wydarzyæ
	{
		sendErrorMessage(playerid, "Nie znany dType (dialog choice)"); 
	}
	return 1;
}
StartNavigation(playerid, NAWI)
{
	ShowPlayerNaviTextDraws(playerid);
	navigationCheckPoint[playerid] = CreateDynamicCP(posNawi[NAWI][N_POSX], posNawi[NAWI][N_POSY], posNawi[NAWI][N_POSZ], 5.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid, 8000.0);
	nawiTimer[playerid] = SetTimerEx("nawiStart", 5000, true, "i", playerid); 
	return 1;
}
StartNavigationEx(playerid, doceloweNazwa[64], Float:doceloweX, Float:doceloweY, Float:doceloweZ)
{
	ShowPlayerNaviTextDraws(playerid);
	SetPVarString(playerid, "miejsceDoceloweStr", doceloweNazwa);
	SetPVarFloat(playerid, "miejsceDoceloweX", doceloweX);
	SetPVarFloat(playerid, "miejsceDoceloweX", doceloweY);
	SetPVarFloat(playerid, "miejsceDoceloweX", doceloweZ);
	navigationCheckPoint[playerid] = CreateDynamicCP(doceloweX, doceloweY, doceloweZ, 5.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid, 8000.0);
	nawiTimer[playerid] = SetTimerEx("nawiStartEx", 5000, true, "i", playerid); 
	return 1; 
}
StopPlayerNavigation(playerid, bool:dojechal=false)
{
	HidePlayerNaviTextDraws(playerid);
	DestroyDynamicCP(navigationCheckPoint[playerid]);
	navigationCheckPoint[playerid] = INVALID_STREAMER_ID; 
	KillTimer(nawiTimer[playerid]); 
	sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
	if(dojechal)
	{
		sendTipMessage(playerid, "Gratulacje uda³o Ci siê dotrzeæ do celu!");
	}
	sendTipMessage(playerid, "Trwa wy³¹czanie systemu nawigacji."); 
	sendTipMessage(playerid, "Pomyœlnie wy³¹czono!"); 
	return 1;
}
PlayerHasNavigation(playerid)
{
	if(PlayerInfo[playerid][pNawigacja] == 1)
	{
		return true;
	}
	return false;
}
CreatePlayerNaviTextDraws(playerid)
{
	roadsLeft_0[playerid] = CreatePlayerTextDraw(playerid, 233.000000, 388.000000, "_");
	PlayerTextDrawFont(playerid, roadsLeft_0[playerid], 1);
	PlayerTextDrawLetterSize(playerid, roadsLeft_0[playerid], 0.600000, 6.500000);
	PlayerTextDrawTextSize(playerid, roadsLeft_0[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, roadsLeft_0[playerid], 1);
	PlayerTextDrawSetShadow(playerid, roadsLeft_0[playerid], 0);
	PlayerTextDrawAlignment(playerid, roadsLeft_0[playerid], 1);
	PlayerTextDrawColor(playerid, roadsLeft_0[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, roadsLeft_0[playerid], 255);
	PlayerTextDrawBoxColor(playerid, roadsLeft_0[playerid], 232);
	PlayerTextDrawUseBox(playerid, roadsLeft_0[playerid], 1);
	PlayerTextDrawSetProportional(playerid, roadsLeft_0[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, roadsLeft_0[playerid], 0);

	roadsLeft_1[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 388.000000, "~r~Navigation System");
	PlayerTextDrawFont(playerid, roadsLeft_1[playerid], 1);
	PlayerTextDrawLetterSize(playerid, roadsLeft_1[playerid], 0.350000, 2.000000);
	PlayerTextDrawTextSize(playerid, roadsLeft_1[playerid], 499.500000, -8.000000);
	PlayerTextDrawSetOutline(playerid, roadsLeft_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, roadsLeft_1[playerid], 3);
	PlayerTextDrawAlignment(playerid, roadsLeft_1[playerid], 1);
	PlayerTextDrawColor(playerid, roadsLeft_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, roadsLeft_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, roadsLeft_1[playerid], 50);
	PlayerTextDrawUseBox(playerid, roadsLeft_1[playerid], 0);
	PlayerTextDrawSetProportional(playerid, roadsLeft_1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, roadsLeft_1[playerid], 0);

	roadsLeft_2[playerid] = CreatePlayerTextDraw(playerid, 283.000000, 406.000000, "]Manana]");
	PlayerTextDrawFont(playerid, roadsLeft_2[playerid], 2);
	PlayerTextDrawLetterSize(playerid, roadsLeft_2[playerid], 0.191666, 1.100000);
	PlayerTextDrawTextSize(playerid, roadsLeft_2[playerid], 499.500000, -8.000000);
	PlayerTextDrawSetOutline(playerid, roadsLeft_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, roadsLeft_2[playerid], 3);
	PlayerTextDrawAlignment(playerid, roadsLeft_2[playerid], 1);
	PlayerTextDrawColor(playerid, roadsLeft_2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, roadsLeft_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, roadsLeft_2[playerid], 50);
	PlayerTextDrawUseBox(playerid, roadsLeft_2[playerid], 0);
	PlayerTextDrawSetProportional(playerid, roadsLeft_2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, roadsLeft_2[playerid], 0);

	roadsLeft_3[playerid] = CreatePlayerTextDraw(playerid, 333.000000, 423.000000, "[]");
	PlayerTextDrawFont(playerid, roadsLeft_3[playerid], 5);
	PlayerTextDrawLetterSize(playerid, roadsLeft_3[playerid], 0.325000, 1.500000);
	PlayerTextDrawTextSize(playerid, roadsLeft_3[playerid], 114.500000, -98.000000);
	PlayerTextDrawSetOutline(playerid, roadsLeft_3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, roadsLeft_3[playerid], 3);
	PlayerTextDrawAlignment(playerid, roadsLeft_3[playerid], 1);
	PlayerTextDrawColor(playerid, roadsLeft_3[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, roadsLeft_3[playerid], 0);
	PlayerTextDrawBoxColor(playerid, roadsLeft_3[playerid], 0);
	PlayerTextDrawUseBox(playerid, roadsLeft_3[playerid], 0);
	PlayerTextDrawSetProportional(playerid, roadsLeft_3[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, roadsLeft_3[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, roadsLeft_3[playerid], 445);
	PlayerTextDrawSetPreviewRot(playerid, roadsLeft_3[playerid], 3.000000, 180.000000, 35.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, roadsLeft_3[playerid], 29, 1);

	roadsLeft_4[playerid] = CreatePlayerTextDraw(playerid, 233.000000, 417.000000, "Docelowe: ~g~*aktualizuje*");
	PlayerTextDrawFont(playerid, roadsLeft_4[playerid], 1);
	PlayerTextDrawLetterSize(playerid, roadsLeft_4[playerid], 0.216666, 1.500000);
	PlayerTextDrawTextSize(playerid, roadsLeft_4[playerid], 499.500000, -8.000000);
	PlayerTextDrawSetOutline(playerid, roadsLeft_4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, roadsLeft_4[playerid], 3);
	PlayerTextDrawAlignment(playerid, roadsLeft_4[playerid], 1);
	PlayerTextDrawColor(playerid, roadsLeft_4[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, roadsLeft_4[playerid], 255);
	PlayerTextDrawBoxColor(playerid, roadsLeft_4[playerid], 50);
	PlayerTextDrawUseBox(playerid, roadsLeft_4[playerid], 0);
	PlayerTextDrawSetProportional(playerid, roadsLeft_4[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, roadsLeft_4[playerid], 0);

	roadsLeft_5[playerid] = CreatePlayerTextDraw(playerid, 233.000000, 430.000000, "Pozostalo: ~g~*aktualizuje*");
	PlayerTextDrawFont(playerid, roadsLeft_5[playerid], 1);
	PlayerTextDrawLetterSize(playerid, roadsLeft_5[playerid], 0.216666, 1.500000);
	PlayerTextDrawTextSize(playerid, roadsLeft_5[playerid], 499.500000, -8.000000);
	PlayerTextDrawSetOutline(playerid, roadsLeft_5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, roadsLeft_5[playerid], 3);
	PlayerTextDrawAlignment(playerid, roadsLeft_5[playerid], 1);
	PlayerTextDrawColor(playerid, roadsLeft_5[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, roadsLeft_5[playerid], 255);
	PlayerTextDrawBoxColor(playerid, roadsLeft_5[playerid], 50);
	PlayerTextDrawUseBox(playerid, roadsLeft_5[playerid], 0);
	PlayerTextDrawSetProportional(playerid, roadsLeft_5[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, roadsLeft_5[playerid], 0);
	return 0; 
}
DestroyPlayerNaviTextDraws(playerid)
{
	PlayerTextDrawDestroy(playerid, roadsLeft_0[playerid]);
	PlayerTextDrawDestroy(playerid, roadsLeft_1[playerid]);
	PlayerTextDrawDestroy(playerid, roadsLeft_2[playerid]);
	PlayerTextDrawDestroy(playerid, roadsLeft_3[playerid]);
	PlayerTextDrawDestroy(playerid, roadsLeft_4[playerid]);
	PlayerTextDrawDestroy(playerid, roadsLeft_5[playerid]);
	return 0; 
}
UpdateNaviTextDrawsForPlayer(playerid)
{
	new string[124];
	new stringVeh[124];
	new idVeh = PlayerInfo[playerid][pSkin]; 
	format(stringVeh, sizeof(stringVeh), "]Pieszo]"); 
	new nawLokacja = GetPVarInt(playerid, "miejsceDoceloweID");
	new nawLokacjaString[64];
	GetPVarString(playerid, "miejsceDoceloweStr", nawLokacjaString, sizeof(nawLokacjaString));
	if(IsPlayerInAnyVehicle(playerid))//Je¿eli jest w wozie
	{
		idVeh = GetVehicleModel(GetPlayerVehicleID(playerid)); 
		format(stringVeh, sizeof(stringVeh), "]%s]", Odpolszcz(VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]));
	}
	format(string, sizeof(string), "Pozostalo: ~g~%0.2f~w~m", 
	GetPlayerDistanceFromPoint(playerid, posNawi[nawLokacja][N_POSX], posNawi[nawLokacja][N_POSY], posNawi[nawLokacja][N_POSZ]));
	PlayerTextDrawSetString(playerid, roadsLeft_5[playerid], string); 
	format(string, sizeof(string), "Docelowe: ~g~%s", Odpolszcz(nawLokacjaString)); 
	PlayerTextDrawSetString(playerid, roadsLeft_4[playerid], string); 
	PlayerTextDrawSetString(playerid, roadsLeft_2[playerid], stringVeh); 
	PlayerTextDrawSetPreviewModel(playerid, roadsLeft_3[playerid], idVeh);
	PlayerTextDrawSetPreviewRot(playerid, roadsLeft_3[playerid], 3.000000, 180.000000, 35.000000, 1.000000);
	return 1;
}
UpdateNaviTextDrawsForPlayerEx(playerid, Float:dPosX, Float:dPosY, Float:dPosZ, dLocation[64])
{
	new string[124];
	new stringVeh[124];
	format(stringVeh, sizeof(stringVeh), "]Pieszo]"); 
	new idVeh = PlayerInfo[playerid][pSkin]; 
	if(IsPlayerInAnyVehicle(playerid))//Je¿eli jest w wozie
	{
		idVeh = GetVehicleModel(GetPlayerVehicleID(playerid)); 
		format(stringVeh, sizeof(stringVeh), "]%s]", Odpolszcz(VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]));
	}
	format(string, sizeof(string), "Pozostalo: ~g~%0.2f~w~m", 
	GetPlayerDistanceFromPoint(playerid, dPosX, dPosY, dPosZ));
	PlayerTextDrawSetString(playerid, roadsLeft_5[playerid], string); 
	format(string, sizeof(string), "Docelowe: ~g~%s", Odpolszcz(dLocation)); 
	PlayerTextDrawSetString(playerid, roadsLeft_4[playerid], string); 
	PlayerTextDrawSetString(playerid, roadsLeft_2[playerid], stringVeh); 
	PlayerTextDrawSetPreviewModel(playerid, roadsLeft_3[playerid], idVeh);
	PlayerTextDrawSetPreviewRot(playerid, roadsLeft_3[playerid], 3.000000, 180.000000, 35.000000, 1.000000);
	return 1;
}
ShowPlayerNaviTextDraws(playerid)
{
	PlayerTextDrawShow(playerid, roadsLeft_0[playerid]);
	PlayerTextDrawShow(playerid, roadsLeft_1[playerid]);
	PlayerTextDrawShow(playerid, roadsLeft_2[playerid]);
	PlayerTextDrawShow(playerid, roadsLeft_3[playerid]);
	PlayerTextDrawShow(playerid, roadsLeft_4[playerid]);
	PlayerTextDrawShow(playerid, roadsLeft_5[playerid]);
	return 1; 
}
HidePlayerNaviTextDraws(playerid)
{
	PlayerTextDrawHide(playerid, roadsLeft_0[playerid]);
	PlayerTextDrawHide(playerid, roadsLeft_1[playerid]);
	PlayerTextDrawHide(playerid, roadsLeft_2[playerid]);
	PlayerTextDrawHide(playerid, roadsLeft_3[playerid]);
	PlayerTextDrawHide(playerid, roadsLeft_4[playerid]);
	PlayerTextDrawHide(playerid, roadsLeft_5[playerid]);
	return 1;
}
//end