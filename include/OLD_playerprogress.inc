/**
 *  Progress Bar 1.3.1.0
 *  Copyright 2007-2010 Infernus' Group,
 *  Flávio Toribio (flavio_toibio@hotmail.com)
 *
 *  Updated by Southclaw for use with the PlayerTextDraws of 0.3e
 *  Updated by Southclaw again with some minor fixes and improvements
 *
 */

#if defined _playerprogress_included
	#endinput
#endif

#if !defined _samp_included
	#tryinclude <a_samp>
	#if !defined _samp_included
		#error could not locate a_samp.inc file, please check your server includes
	#endif
#endif

#define _playerprogress_included
#define _playerprogress_version 0x1310

#define MAX_PLAYER_BARS             (MAX_PLAYER_TEXT_DRAWS / 3)
#define INVALID_PLAYER_BAR_VALUE    (Float:0xFFFFFFFF)
#define INVALID_PLAYER_BAR_ID       (PlayerBar:-1)
#define pb_percent(%1,%2,%3,%4) ((%1 - 6.0) + ((((%1 + 6.0 + %2 - 2.0) - %1) / %3) * %4))
//pb_percent(x, width, max, value)

/* Pawno/Infernus Pawn Editor function list
native PlayerBar:CreatePlayerProgressBar(playerid, Float:x, Float:y, Float:width=55.5, Float:height=3.2, color, Float:max=100.0);
native DestroyPlayerProgressBar(playerid, PlayerBar:barid);
native ShowPlayerProgressBar(playerid, PlayerBar:barid);
native HidePlayerProgressBar(playerid, PlayerBar:barid);
native SetPlayerProgressBarValue(playerid, PlayerBar:barid, Float:value);
native Float:GetPlayerProgressBarValue(playerid, PlayerBar:barid);
native SetPlayerProgressBarMaxValue(playerid, PlayerBar:barid, Float:max);
native SetPlayerProgressBarColor(playerid, PlayerBar:barid, color);
native UpdatePlayerProgressBar(playerid, PlayerBar:barid);
*/

forward PlayerBar:CreatePlayerProgressBar(playerid, Float:x, Float:y, Float:width=55.5, Float:height=3.2, color, Float:max=100.0);
forward Float:GetPlayerProgressBarValue(playerid, PlayerBar:barid);

enum E_BAR_DATA
{
Float:		pbar_x,
Float:		pbar_y,
Float:		pbar_w,
Float:		pbar_h,
Float:		pbar_m,
Float:		pbar_v,
			pbar_colour,
bool:		pbar_valid
}

enum E_BAR_TEXT_DRAW
{
PlayerText:	pbar_textdraw1,
PlayerText:	pbar_textdraw2,
PlayerText:	pbar_textdraw3
}


static
			pbar_Data[MAX_PLAYERS][MAX_PLAYER_BARS][E_BAR_DATA],
			pbar_TextDraw[MAX_PLAYERS][MAX_PLAYER_BARS][E_BAR_TEXT_DRAW];


stock PlayerBar:CreatePlayerProgressBar(playerid, Float:x, Float:y, Float:width = 55.5, Float:height = 3.2, color, Float:max = 100.0)
{
	new barid;

	for(barid = 0; barid < MAX_PLAYER_BARS; barid++)
	{
		if(!pbar_Data[playerid][barid][pbar_valid])
			break;
	}

	if(barid == MAX_PLAYER_BARS)
		return INVALID_PLAYER_BAR_ID;

	pbar_TextDraw[playerid][barid][pbar_textdraw1] = CreatePlayerTextDraw(playerid, x, y, "_");
	PlayerTextDrawUseBox        (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw1], 1);
	PlayerTextDrawTextSize      (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw1], x + width, 0.0);
	PlayerTextDrawLetterSize    (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw1], 1.0, height / 10);
	PlayerTextDrawBoxColor      (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw1], 0x00000000 | (color & 0x000000FF));

	pbar_TextDraw[playerid][barid][pbar_textdraw2] = CreatePlayerTextDraw(playerid, x + 1.2, y + 2.15, "_");
	PlayerTextDrawUseBox        (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw2], 1);
	PlayerTextDrawTextSize      (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw2], x + width - 2.0, 0.0);
	PlayerTextDrawLetterSize    (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw2], 1.0, height / 10 - 0.35);
	PlayerTextDrawBoxColor      (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw2], (color & 0xFFFFFF00) | (0x66 & ((color & 0x000000FF) / 2)));

	pbar_TextDraw[playerid][barid][pbar_textdraw3] = CreatePlayerTextDraw(playerid, x + 1.2, y + 2.15, "_");
	PlayerTextDrawTextSize      (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw3], pb_percent(x, width, max, 1.0), 0.0);
	PlayerTextDrawLetterSize    (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw3], 1.0, height / 10 - 0.35);
	PlayerTextDrawBoxColor      (playerid, pbar_TextDraw[playerid][barid][pbar_textdraw3], color);

	pbar_Data[playerid][barid][pbar_x] = x;
	pbar_Data[playerid][barid][pbar_y] = y;
	pbar_Data[playerid][barid][pbar_w] = width;
	pbar_Data[playerid][barid][pbar_h] = height;
	pbar_Data[playerid][barid][pbar_m] = max;
	pbar_Data[playerid][barid][pbar_colour] = color;
	pbar_Data[playerid][barid][pbar_valid] = true;

	return PlayerBar:barid;
}

stock DestroyPlayerProgressBar(playerid, PlayerBar:barid)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(!(PlayerBar:-1 < barid < PlayerBar:MAX_PLAYER_BARS))
		return 0;

	if(!pbar_Data[playerid][_:barid][pbar_valid])
		return 0;

	PlayerTextDrawDestroy(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw1]);
	PlayerTextDrawDestroy(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw2]);
	PlayerTextDrawDestroy(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw3]);

	pbar_Data[playerid][_:barid][pbar_x] = 0.0;
	pbar_Data[playerid][_:barid][pbar_y] = 0.0;
	pbar_Data[playerid][_:barid][pbar_w] = 0.0;
	pbar_Data[playerid][_:barid][pbar_h] = 0.0;
	pbar_Data[playerid][_:barid][pbar_m] = 0.0;
	pbar_Data[playerid][_:barid][pbar_v] = 0.0;
	pbar_Data[playerid][_:barid][pbar_colour] = 0;
	pbar_Data[playerid][_:barid][pbar_valid] = false;

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	for(new i; i < MAX_PLAYER_BARS; i++)
		pbar_Data[playerid][_:i][pbar_valid] = false;

	#if defined ppb_OnPlayerDisconnect
		return ppb_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
 
#define OnPlayerDisconnect ppb_OnPlayerDisconnect
#if defined ppb_OnPlayerDisconnect
	forward ppb_OnPlayerDisconnect(playerid, reason);
#endif

stock ShowPlayerProgressBar(playerid, PlayerBar:barid)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(!(PlayerBar:-1 < barid < PlayerBar:MAX_PLAYER_BARS))
		return 0;

	if(!pbar_Data[playerid][_:barid][pbar_valid])
		return 0;

	PlayerTextDrawShow(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw1]);
	PlayerTextDrawShow(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw2]);
	PlayerTextDrawShow(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw3]);

	return 1;
}

stock HidePlayerProgressBar(playerid, PlayerBar:barid)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(!(PlayerBar:-1 < barid < PlayerBar:MAX_PLAYER_BARS))
		return 0;

	if(!pbar_Data[playerid][_:barid][pbar_valid])
		return 0;

	PlayerTextDrawHide(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw1]);
	PlayerTextDrawHide(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw2]);
	PlayerTextDrawHide(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw3]);

	return 1;
}

stock SetPlayerProgressBarValue(playerid, PlayerBar:barid, Float:value)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(!(PlayerBar:-1 < barid < PlayerBar:MAX_PLAYER_BARS))
		return 0;

	if(!pbar_Data[playerid][_:barid][pbar_valid])
		return 0;

	value = (value < 0.0) ? (0.0) : (value > pbar_Data[playerid][_:barid][pbar_m]) ? (pbar_Data[playerid][_:barid][pbar_m]) : (value);

	PlayerTextDrawUseBox(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw3], value > 0.0);

	pbar_Data[playerid][_:barid][pbar_v] = value;

	PlayerTextDrawTextSize(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw3],
		pb_percent(pbar_Data[playerid][_:barid][pbar_x] + 4, pbar_Data[playerid][_:barid][pbar_w] - 12, pbar_Data[playerid][_:barid][pbar_m], value), 0.0);

	return 1;
}

stock Float:GetPlayerProgressBarValue(playerid, PlayerBar:barid)
{
	if(!IsPlayerConnected(playerid))
		return INVALID_PLAYER_BAR_VALUE;

	if(!(PlayerBar:-1 < barid < PlayerBar:MAX_PLAYER_BARS))
		return INVALID_PLAYER_BAR_VALUE;

	if(!pbar_Data[playerid][_:barid][pbar_valid])
		return INVALID_PLAYER_BAR_VALUE;

	return pbar_Data[playerid][_:barid][pbar_v];
}

stock SetPlayerProgressBarMaxValue(playerid, PlayerBar:barid, Float:max)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(!(PlayerBar:-1 < barid < PlayerBar:MAX_PLAYER_BARS))
		return 0;

	if(!pbar_Data[playerid][_:barid][pbar_valid])
		return 0;

	pbar_Data[playerid][_:barid][pbar_m] = max;
	SetPlayerProgressBarValue(playerid, barid, pbar_Data[playerid][_:barid][pbar_v]);

	return 1;
}

stock SetPlayerProgressBarColor(playerid, PlayerBar:barid, color)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(!(PlayerBar:-1 < barid < PlayerBar:MAX_PLAYER_BARS))
		return 0;

	if(!pbar_Data[playerid][_:barid][pbar_valid])
		return 0;

	pbar_Data[playerid][_:barid][pbar_colour] = color;
	PlayerTextDrawBoxColor(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw1], 0x00000000 | (color & 0x000000FF));

	PlayerTextDrawBoxColor(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw2], (color & 0xFFFFFF00) | (0x66 & ((color & 0x000000FF) / 2)));

	PlayerTextDrawBoxColor(playerid, pbar_TextDraw[playerid][_:barid][pbar_textdraw3], color);

	return 1;
}

stock UpdatePlayerProgressBar(playerid, PlayerBar:barid)
{
	return ShowPlayerProgressBar(playerid, barid);
}
