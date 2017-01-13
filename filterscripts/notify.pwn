#include <a_samp>
#include <zcmd>
new PlayerText:InfoBoxTextdraw[MAX_PLAYERS][2];
new PlayerText:InfoBoxPLTextdraw[MAX_PLAYERS][2];
new bool:InfoTextState[MAX_PLAYERS];
new InfoBoxTimer[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" MRP Notify 1.0 INIT");
	print("--------------------------------------\n");
	for(new i=0; i<MAX_PLAYERS; i++) {
		OnPlayerConnect(i);
	}
	return 1;
}
public OnPlayerConnect(playerid) {
	InfoBoxTextdraw[playerid][0] = CreatePlayerTextDraw(playerid, 630.000000, 105.000000, "~n~~n~~n~~n~~n~~n~~n~~n~");
	PlayerTextDrawBackgroundColor(playerid, InfoBoxTextdraw[playerid][0], 255);
	PlayerTextDrawFont(playerid, InfoBoxTextdraw[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, InfoBoxTextdraw[playerid][0], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, InfoBoxTextdraw[playerid][0], 120);
	PlayerTextDrawSetOutline(playerid, InfoBoxTextdraw[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, InfoBoxTextdraw[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, InfoBoxTextdraw[playerid][0], 1);
	PlayerTextDrawUseBox(playerid, InfoBoxTextdraw[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, InfoBoxTextdraw[playerid][0], 336860270);
	PlayerTextDrawTextSize(playerid, InfoBoxTextdraw[playerid][0], 480.000000, 0.000000);

	InfoBoxTextdraw[playerid][1] = CreatePlayerTextDraw(playerid, 630.000000, 105.000000, "_");
	PlayerTextDrawBackgroundColor(playerid, InfoBoxTextdraw[playerid][1], 255);
	PlayerTextDrawFont(playerid, InfoBoxTextdraw[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, InfoBoxTextdraw[playerid][1], 0.500000, 1.500000);
	PlayerTextDrawColor(playerid, InfoBoxTextdraw[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid, InfoBoxTextdraw[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, InfoBoxTextdraw[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, InfoBoxTextdraw[playerid][1], 1);
	PlayerTextDrawUseBox(playerid, InfoBoxTextdraw[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, InfoBoxTextdraw[playerid][1], 255);
	PlayerTextDrawTextSize(playerid, InfoBoxTextdraw[playerid][1], 480.000000, 0.000000);


	InfoBoxPLTextdraw[playerid][0] = CreatePlayerTextDraw(playerid, 509.000000, 105.000000, "_");
	PlayerTextDrawBackgroundColor(playerid, InfoBoxPLTextdraw[playerid][0], 255);
	PlayerTextDrawFont(playerid, InfoBoxPLTextdraw[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, InfoBoxPLTextdraw[playerid][0], 0.300000, 1.299998);
	PlayerTextDrawColor(playerid, InfoBoxPLTextdraw[playerid][0], -65281);
	//PlayerTextDrawSetOutline(playerid, InfoBoxPLTextdraw[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, InfoBoxPLTextdraw[playerid][0], 1);
	PlayerTextDrawAlignment(playerid, InfoBoxPLTextdraw[playerid][0], 2);

	InfoBoxPLTextdraw[playerid][1] = CreatePlayerTextDraw(playerid, 487.000000, 124.000000, "_");
	PlayerTextDrawBackgroundColor(playerid, InfoBoxPLTextdraw[playerid][1], 255);
	PlayerTextDrawFont(playerid, InfoBoxPLTextdraw[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, InfoBoxPLTextdraw[playerid][1], 0.259999, 0.899999);
	PlayerTextDrawColor(playerid, InfoBoxPLTextdraw[playerid][1], -1);
	//PlayerTextDrawSetOutline(playerid, InfoBoxPLTextdraw[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, InfoBoxPLTextdraw[playerid][1], 1);			
	PlayerTextDrawAlignment(playerid, InfoBoxPLTextdraw[playerid][0], 2);
}
public OnFilterScriptExit()
{
	print("\n--------------------------------------");
	print(" MRP Notify 1.0 EXIT");
	print("--------------------------------------\n");
	return 1;
}
forward notify(playerid, overview[], text[], time);
public notify(playerid,overview[],text[],time)
{
	if(!InfoTextState[playerid])
	{
		KillTimer(InfoBoxTimer[playerid]);
		PlayerTextDrawShow(playerid,InfoBoxTextdraw[playerid][0]);
		PlayerTextDrawShow(playerid,InfoBoxTextdraw[playerid][1]);

		PlayerTextDrawSetString(playerid, InfoBoxPLTextdraw[playerid][0], overview);
		new lines = 1;
		for(new i=0; i<strlen(text)+1; i++) {
			if(text[i] == '~' && text[i+1] == 'n') {
				lines++;
			}
		}
		new tdlinestring[48];
		tdlinestring = "~n~~n~~n~";
		for(new i=1; i<lines; i++) {
			strcat(tdlinestring, "~n~");
		}
		PlayerTextDrawSetString(playerid, InfoBoxTextdraw[playerid][0], tdlinestring);	
		PlayerTextDrawSetString(playerid, InfoBoxPLTextdraw[playerid][1], text);
						
	 	PlayerTextDrawShow(playerid,InfoBoxPLTextdraw[playerid][0]);
	 	PlayerTextDrawShow(playerid,InfoBoxPLTextdraw[playerid][1]);
	 	InfoTextState[playerid]=true;
		InfoBoxTimer[playerid]=SetTimerEx("hideNotification",time,0,"u",playerid);
	} else {
		hideNotification(playerid);
		notify(playerid,overview,text,time);
	}
}
forward hideNotification(playerid);
public hideNotification(playerid)
{
	PlayerTextDrawHide(playerid,InfoBoxTextdraw[playerid][0]);
	PlayerTextDrawHide(playerid,InfoBoxTextdraw[playerid][1]);
	PlayerTextDrawHide(playerid,InfoBoxPLTextdraw[playerid][0]);
 	PlayerTextDrawHide(playerid,InfoBoxPLTextdraw[playerid][1]);
 	InfoTextState[playerid]=false; 
	KillTimer(InfoBoxTimer[playerid]);
 	return 1;
}