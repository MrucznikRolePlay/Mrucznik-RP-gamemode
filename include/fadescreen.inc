#if defined _fadescreen_included
	#endinput
#endif
#define _fadescreen_included

#include a_samp.inc

//------------------------------//
//  FadeScreen v2.1 by Maku     //
//------------------------------//


static Text:fs_FadeScreen[MAX_PLAYERS];
static fs_FadeID;
static fs_FadeScreenON[MAX_PLAYERS];

forward OnPlayerFadeScreenEnd(playerid, fadeid, timeleft, step);
forward OnPlayerFadeScreenChange(playerid, fadeid, timeleft, step);
#define RGB(%0,%1,%2,%3) ((%0*16777216)+(%1*65536)+(%2*256)+%3)
#define ShowPlayerFadeScreenRandom(%0,%1,%3) ShowPlayerFadeScreen(%0,%1,random(255),random(255),random(255),%3,random(255),random(255),random(255),%3)
#define ShowPlayerFadeScreenToBlank(%0,%1,%2,%3,%4,%5) ShowPlayerFadeScreen(%0,%1,%2,%3,%4,%5,%2,%3,%4,0)
#define HidePlayerFilledScreen(%0) HidePlayerFadeScreen(%0)
stock HidePlayerFadeScreen(playerid)
{
	if(fs_FadeScreenON[playerid] == 0) return 0;
	
	fs_FadeScreenON[playerid]=0;
	TextDrawHideForPlayer(playerid,fs_FadeScreen[playerid]);
	TextDrawDestroy(fs_FadeScreen[playerid]);
	return 1;
}
/*
native ShowPlayerFilledScreen(playerid, red, green, blue, alpha);
native HidePlayerFilledScreen(playerid);
native RGB(red, green, blue, alpha);
native ShowPlayerFadeScreenRandom(playerid, speed, alpha);
native ShowPlayerFadeScreenToBlank(playerid, speed, red, green, blue, alpha);
native ShowPlayerFadeScreen(playerid, speed, s_red, s_green, s_blue, s_alpha, e_red, e_green, e_blue, e_alpha);
native HidePlayerFadeScreen(playerid);
*/
stock ShowPlayerFilledScreen(playerid, red, green, blue, alpha)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(fs_FadeScreenON[playerid] != 0)
	{
		HidePlayerFadeScreen(playerid);
	}
	fs_FadeScreenON[playerid] = -1;
	
	fs_FadeScreen[playerid] = TextDrawCreate(320.000000, -5.000000, "_");
	TextDrawAlignment(fs_FadeScreen[playerid], 2);
	TextDrawFont(fs_FadeScreen[playerid], 3);
	TextDrawLetterSize(fs_FadeScreen[playerid], 1.700000, 54.000000);
	TextDrawUseBox(fs_FadeScreen[playerid], 1);
	TextDrawBoxColor(fs_FadeScreen[playerid], RGB(red, green, blue, alpha));
	TextDrawTextSize(fs_FadeScreen[playerid], 10.000000, 690.000000);
	TextDrawShowForPlayer(playerid, fs_FadeScreen[playerid]);
	return 1;
}

stock ShowPlayerFadeScreen(playerid, speed, s_red, s_green, s_blue, s_alpha, e_red, e_green,e_blue, e_alpha)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(fs_FadeScreenON[playerid] != 0)
	{
		HidePlayerFadeScreen(playerid);
	}
	fs_FadeID++;
	fs_FadeScreenON[playerid] = fs_FadeID;
	
	fs_FadeScreen[playerid] = TextDrawCreate(320.000000, -5.000000, "_");
	TextDrawAlignment(fs_FadeScreen[playerid], 2);
	TextDrawFont(fs_FadeScreen[playerid], 3);
	TextDrawLetterSize(fs_FadeScreen[playerid], 1.700000, 54.000000);
	TextDrawUseBox(fs_FadeScreen[playerid], 1);
	TextDrawBoxColor(fs_FadeScreen[playerid], RGB(s_red, s_green, s_blue, s_alpha));
	TextDrawTextSize(fs_FadeScreen[playerid], 10.000000, 690.000000);
	TextDrawShowForPlayer(playerid, fs_FadeScreen[playerid]);

	SetTimerEx("FadeScreen_Timer", speed, 0, "dddddddddddd",
				playerid,s_red,s_green,s_blue,s_alpha,
				e_red,e_green,e_blue,e_alpha,speed,fs_FadeID,0);

	return fs_FadeID;
}

public OnPlayerDisconnect(playerid, reason)
{
    fs_FadeScreenON[playerid] = 0;
	CallLocalFunction("FadeS_OnPlayerDisconnect", "dd", playerid, reason);
	return 1;
}

forward FadeScreen_Timer(playerid, red, green, blue, alpha, ered, egreen, eblue, ealpha, speed, fadeid, time);
public FadeScreen_Timer(playerid, red, green, blue, alpha, ered, egreen, eblue, ealpha, speed, fadeid, time)
{
	if(fs_FadeScreenON[playerid] != fadeid) return 0;

	time++;
	
	if(red != ered)
	{
	    if(red < ered) red++;
	    else red--;
	}
	if(green != egreen)
	{
	    if(green < egreen) green++;
	    else green--;
	}
	if(blue != eblue)
	{
	    if(blue < eblue) blue++;
	    else blue--;
	}
	if(alpha != ealpha)
	{
	    if(alpha < ealpha) alpha++;
	    else alpha--;
	}

	TextDrawHideForPlayer(playerid, fs_FadeScreen[playerid]);
	TextDrawDestroy(fs_FadeScreen[playerid]);

	if(red == ered && green == egreen && blue == eblue && alpha == ealpha || alpha == 0)
	{
	    fs_FadeScreenON[playerid] = 0;
	    CallRemoteFunction("OnPlayerFadeScreenEnd", "dddd", playerid, fadeid, (time * speed), time);
		return 1;
	}
	fs_FadeScreen[playerid] = TextDrawCreate(320.000000, -5.000000, "_");
	TextDrawAlignment(fs_FadeScreen[playerid], 2);
	TextDrawFont(fs_FadeScreen[playerid], 3);
	TextDrawLetterSize(fs_FadeScreen[playerid], 1.700000, 54.000000);
	TextDrawUseBox(fs_FadeScreen[playerid], 1);
	TextDrawBoxColor(fs_FadeScreen[playerid], RGB(red, green, blue, alpha));
	TextDrawTextSize(fs_FadeScreen[playerid], 10.000000, 690.000000);
	TextDrawShowForPlayer(playerid, fs_FadeScreen[playerid]);
	CallRemoteFunction("OnPlayerFadeScreenChange", "dddd", playerid, fadeid, (time * speed), time);
    SetTimerEx("FadeScreen_Timer", speed, 0, "dddddddddddd", playerid, red, green, blue, alpha, ered, egreen, eblue, ealpha, speed, fadeid, time);
	return 1;
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect FadeS_OnPlayerDisconnect
forward FadeS_OnPlayerDisconnect(playerid, reason);

