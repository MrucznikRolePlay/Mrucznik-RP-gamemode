new Text:NowaWybieralka_Select;
new Text:NowaWybieralka_Left;
new Text:NowaWybieralka_Right;


NowaWybieralka_Setup(playerid)
{

	if(GetPVarInt(playerid, "wyborPierwszego") == 0)
	{
		GetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
	    Unspec[playerid][sPint] = GetPlayerInterior(playerid);
	    Unspec[playerid][sPvw] = GetPlayerVirtualWorld(playerid);
	}

	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 5151+playerid);

	SetPlayerPos(playerid, 208.3876,-34.8742,1001.9297);
	SetPlayerFacingAngle(playerid, 138.8926);

	SetPlayerCameraPos(playerid, 206.288314, -38.114028, 1002.229675);
	SetPlayerCameraLookAt(playerid, 208.775955, -34.981678, 1001.929687);

	TextDrawShowForPlayer(playerid, NowaWybieralka_Select);
	TextDrawShowForPlayer(playerid, NowaWybieralka_Left);
	TextDrawShowForPlayer(playerid, NowaWybieralka_Right);

	SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);

	SetPVarInt(playerid, "NowaWybieralkaSelect", PlayerInfo[playerid][pSkin]);

    SelectTextDraw(playerid, 0xAFAFAFAA);
	TogglePlayerControllable(playerid,0);

	SetPlayerCameraPos(playerid, 206.288314, -38.114028, 1002.229675);
	SetPlayerCameraLookAt(playerid, 208.775955, -34.981678, 1001.929687);
}

NowaWybieralka_Init()
{
	NowaWybieralka_CreateTxd();

	return 1;
}


NowaWybieralka_CreateTxd()
{

	NowaWybieralka_Left = TextDrawCreate(250.154693, 383.833343, "<<<");
    TextDrawLetterSize(NowaWybieralka_Left, 0.449999, 1.600000);
    TextDrawTextSize(NowaWybieralka_Left, 18.000000, 47.833335);
    TextDrawAlignment(NowaWybieralka_Left, 2);
    TextDrawColor(NowaWybieralka_Left, -1378294017);
    //TextDrawUseBox(NowaWybieralka_Left, true);
    TextDrawBoxColor(NowaWybieralka_Left, 1717986918);
    TextDrawSetShadow(NowaWybieralka_Left, 0);
    TextDrawSetOutline(NowaWybieralka_Left, 1);
    //TextDrawBackgroundColor(NowaWybieralka_Left, 255);
    TextDrawFont(NowaWybieralka_Left, 2);
    TextDrawSetProportional(NowaWybieralka_Left, 1);
    TextDrawSetSelectable(NowaWybieralka_Left, true);

    NowaWybieralka_Select = TextDrawCreate(312.503204, 363.833465, ">OK<");
    TextDrawLetterSize(NowaWybieralka_Select, 0.449999, 1.600000);
    TextDrawTextSize(NowaWybieralka_Select, 18.000000, 51.916660);
    TextDrawAlignment(NowaWybieralka_Select, 2);
    TextDrawColor(NowaWybieralka_Select, -1378294017);
    //TextDrawUseBox(NowaWybieralka_Select, true);
    TextDrawBoxColor(NowaWybieralka_Select, 1717986918);
    TextDrawSetShadow(NowaWybieralka_Select, 0);
    TextDrawSetOutline(NowaWybieralka_Select, 1);
    //TextDrawBackgroundColor(NowaWybieralka_Select, 255);
    TextDrawFont(NowaWybieralka_Select, 2);
    TextDrawSetProportional(NowaWybieralka_Select, 1);
    TextDrawSetSelectable(NowaWybieralka_Select, true);

    NowaWybieralka_Right = TextDrawCreate(373.914733, 383.833343, ">>>");
    TextDrawLetterSize(NowaWybieralka_Right, 0.449999, 1.600000);
    TextDrawTextSize(NowaWybieralka_Right, 18.000000, 46.083316);
    TextDrawAlignment(NowaWybieralka_Right, 2);
    TextDrawColor(NowaWybieralka_Right, -1378294017);
    //TextDrawUseBox(NowaWybieralka_Right, true);
    TextDrawBoxColor(NowaWybieralka_Right, 1717986918);
    TextDrawSetShadow(NowaWybieralka_Right, 0);
    TextDrawSetOutline(NowaWybieralka_Right, 1);
    //TextDrawBackgroundColor(NowaWybieralka_Right, 255);
    TextDrawFont(NowaWybieralka_Right, 2);
    TextDrawSetProportional(NowaWybieralka_Right, 1);
    TextDrawSetSelectable(NowaWybieralka_Right, true);

	return 1;
}

NowaWybieralka_ClickedTxd(playerid, Text:clickedid)
{
	//Przebierz
	if(clickedid == NowaWybieralka_Left)
	{

		if(GetPVarInt(playerid, "NowaWybieralka") <= 0) SetPVarInt(playerid, "NowaWybieralka", sizeof(Przebierz)-1);
		else SetPVarInt(playerid, "NowaWybieralka", GetPVarInt(playerid, "NowaWybieralka")-1);

		SetPlayerSkinEx(playerid, Przebierz[GetPVarInt(playerid, "NowaWybieralka")][0]);

		SetPVarInt(playerid, "NowaWybieralkaSelect", Przebierz[GetPVarInt(playerid, "NowaWybieralka")][0]);
		return 1;
	}
	if(clickedid == NowaWybieralka_Right)
	{
		if(GetPVarInt(playerid, "NowaWybieralka") >= sizeof(Przebierz)-1) SetPVarInt(playerid, "NowaWybieralka", 0);
		else SetPVarInt(playerid, "NowaWybieralka", GetPVarInt(playerid, "NowaWybieralka")+1);

		SetPlayerSkinEx(playerid, Przebierz[GetPVarInt(playerid, "NowaWybieralka")][0]);

		SetPVarInt(playerid, "NowaWybieralkaSelect", Przebierz[GetPVarInt(playerid, "NowaWybieralka")][0]);

		return 1;
	}
	if(clickedid == NowaWybieralka_Select)
	{
		CancelSelectTextDraw(playerid);
		TextDrawHideForPlayer(playerid,NowaWybieralka_Left);
		TextDrawHideForPlayer(playerid,NowaWybieralka_Right);
		TextDrawHideForPlayer(playerid,NowaWybieralka_Select);

		PlayerInfo[playerid][pSkin] = GetPVarInt(playerid, "NowaWybieralkaSelect");

		if(GetPVarInt(playerid, "wyborPierwszego") == 1)
		{
			SetPlayerSpawn(playerid);
			SetPlayerSpawnPos(playerid);
			SetPlayerInterior(playerid, 0);
			if(GetPVarInt(playerid, "Lockdown-izolacja") != 0) ALockdown_SetLockdownVW(playerid);
			else SetPlayerVirtualWorld(playerid, 0);
		}
		else
		{
			PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
	    	PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
	        SetPlayerInterior(playerid, Unspec[playerid][sPint]);
	        SetPlayerVirtualWorld(playerid, Unspec[playerid][sPvw]);
	    	SetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
	        Wchodzenie(playerid);
	        sendTipMessageEx(playerid, COLOR_P@, sprintf("Kupi³eœ skin %d za $5000", PlayerInfo[playerid][pSkin]));
	        ZabierzKase(playerid, 5000);
		}
		TogglePlayerControllable(playerid, 1);		

		//sendTipMessageEx(playerid, COLOR_P@, sprintf("Kupi³eœ skin %d za $5000", PlayerInfo[playerid][pModel]));

		SetPlayerSpawnSkin(playerid);

		SetCameraBehindPlayer(playerid);

		return 1;
	}
	return 1;
}