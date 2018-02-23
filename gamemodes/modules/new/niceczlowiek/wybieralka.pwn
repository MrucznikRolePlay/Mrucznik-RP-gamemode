new Text:NowaWybieralka::Select;
new Text:NowaWybieralka::Left;
new Text:NowaWybieralka::Right;


//COMMAND:ubranie(playerid)
/*{

	if((OnDuty[playerid] == 1 && OnDutyCD[playerid] == 0) || SanDuty[playerid] == 1)
	{
		return sendErrorMessage(playerid, "Bêd¹c na s³u¿bie nie mo¿esz wybraæ skina cywilnego.");
	}

	NowaWybieralka::Setup(playerid);
} */

stock NowaWybieralka::Setup(playerid)
{

	if(GetPVarInt(playerid, "wyborPierwszego") == 0)
	{
		GetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
	    Unspec[playerid][sPint] = GetPlayerInterior(playerid);
	    Unspec[playerid][sPvw] = GetPlayerVirtualWorld(playerid);
	}

	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 5151+playerid);

	SetPlayerPosEx(playerid, 208.3876,-34.8742,1001.9297);
	SetPlayerFacingAngle(playerid, 138.8926);

	SetPlayerCameraPos(playerid, 206.288314, -38.114028, 1002.229675);
	SetPlayerCameraLookAt(playerid, 208.775955, -34.981678, 1001.929687);

	TextDrawShowForPlayer(playerid, NowaWybieralka::Select);
	TextDrawShowForPlayer(playerid, NowaWybieralka::Left);
	TextDrawShowForPlayer(playerid, NowaWybieralka::Right);

	SetPlayerSkin(playerid, PlayerInfo[playerid][pModel]);

	SetPVarInt(playerid, "NowaWybieralkaSelect", PlayerInfo[playerid][pModel]);

    SelectTextDraw(playerid, 0xAFAFAFAA);
	TogglePlayerControllable(playerid,0);

	SetPlayerCameraPos(playerid, 206.288314, -38.114028, 1002.229675);
	SetPlayerCameraLookAt(playerid, 208.775955, -34.981678, 1001.929687);
}

stock NowaWybieralka::Init()
{
	NowaWybieralka::CreateTxd();

	return 1;
}


stock NowaWybieralka::InitPlayer(playerid)
{

	return 1;
}


stock NowaWybieralka::CreateTxd()
{

	NowaWybieralka::Left = TextDrawCreate(250.154693, 383.833343, "<<<");
    TextDrawLetterSize(NowaWybieralka::Left, 0.449999, 1.600000);
    TextDrawTextSize(NowaWybieralka::Left, 18.000000, 47.833335);
    TextDrawAlignment(NowaWybieralka::Left, 2);
    TextDrawColor(NowaWybieralka::Left, -1378294017);
    //TextDrawUseBox(NowaWybieralka::Left, true);
    TextDrawBoxColor(NowaWybieralka::Left, 1717986918);
    TextDrawSetShadow(NowaWybieralka::Left, 0);
    TextDrawSetOutline(NowaWybieralka::Left, 1);
    //TextDrawBackgroundColor(NowaWybieralka::Left, 255);
    TextDrawFont(NowaWybieralka::Left, 2);
    TextDrawSetProportional(NowaWybieralka::Left, 1);
    TextDrawSetSelectable(NowaWybieralka::Left, true);

    NowaWybieralka::Select = TextDrawCreate(312.503204, 363.833465, ">OK<");
    TextDrawLetterSize(NowaWybieralka::Select, 0.449999, 1.600000);
    TextDrawTextSize(NowaWybieralka::Select, 18.000000, 51.916660);
    TextDrawAlignment(NowaWybieralka::Select, 2);
    TextDrawColor(NowaWybieralka::Select, -1378294017);
    //TextDrawUseBox(NowaWybieralka::Select, true);
    TextDrawBoxColor(NowaWybieralka::Select, 1717986918);
    TextDrawSetShadow(NowaWybieralka::Select, 0);
    TextDrawSetOutline(NowaWybieralka::Select, 1);
    //TextDrawBackgroundColor(NowaWybieralka::Select, 255);
    TextDrawFont(NowaWybieralka::Select, 2);
    TextDrawSetProportional(NowaWybieralka::Select, 1);
    TextDrawSetSelectable(NowaWybieralka::Select, true);

    NowaWybieralka::Right = TextDrawCreate(373.914733, 383.833343, ">>>");
    TextDrawLetterSize(NowaWybieralka::Right, 0.449999, 1.600000);
    TextDrawTextSize(NowaWybieralka::Right, 18.000000, 46.083316);
    TextDrawAlignment(NowaWybieralka::Right, 2);
    TextDrawColor(NowaWybieralka::Right, -1378294017);
    //TextDrawUseBox(NowaWybieralka::Right, true);
    TextDrawBoxColor(NowaWybieralka::Right, 1717986918);
    TextDrawSetShadow(NowaWybieralka::Right, 0);
    TextDrawSetOutline(NowaWybieralka::Right, 1);
    //TextDrawBackgroundColor(NowaWybieralka::Right, 255);
    TextDrawFont(NowaWybieralka::Right, 2);
    TextDrawSetProportional(NowaWybieralka::Right, 1);
    TextDrawSetSelectable(NowaWybieralka::Right, true);

	return 1;
}

stock NowaWybieralka::ClickedTxd(playerid, Text:clickedid)
{
	//Przebierz
	if(clickedid == NowaWybieralka::Left)
	{

		if(GetPVarInt(playerid, "NowaWybieralka") <= 0) SetPVarInt(playerid, "NowaWybieralka", sizeof(Przebierz)-1);
		else SetPVarInt(playerid, "NowaWybieralka", GetPVarInt(playerid, "NowaWybieralka")-1);

		SetPlayerSkin(playerid, Przebierz[GetPVarInt(playerid, "NowaWybieralka")][0]);

		SetPVarInt(playerid, "NowaWybieralkaSelect", Przebierz[GetPVarInt(playerid, "NowaWybieralka")][0]);
		return 1;
	}
	if(clickedid == NowaWybieralka::Right)
	{

		if(GetPVarInt(playerid, "NowaWybieralka") >= sizeof(Przebierz)-1) SetPVarInt(playerid, "NowaWybieralka", 0);
		else SetPVarInt(playerid, "NowaWybieralka", GetPVarInt(playerid, "NowaWybieralka")+1);

		SetPlayerSkin(playerid, Przebierz[GetPVarInt(playerid, "NowaWybieralka")][0]);

		SetPVarInt(playerid, "NowaWybieralkaSelect", Przebierz[GetPVarInt(playerid, "NowaWybieralka")][0]);

		return 1;
	}
	if(clickedid == NowaWybieralka::Select)
	{
		CancelSelectTextDraw(playerid);
		TextDrawHideForPlayer(playerid,NowaWybieralka::Left);
		TextDrawHideForPlayer(playerid,NowaWybieralka::Right);
		TextDrawHideForPlayer(playerid,NowaWybieralka::Select);

		PlayerInfo[playerid][pModel] = GetPVarInt(playerid, "NowaWybieralkaSelect");

		if(GetPVarInt(playerid, "wyborPierwszego") == 1)
		{
			SpawnPlayer(playerid);
			SetPlayerSpawnPos(playerid);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
		}
		else
		{
			PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
	    	PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
	        SetPlayerInterior(playerid, Unspec[playerid][sPint]);
	        SetPlayerVirtualWorld(playerid, Unspec[playerid][sPvw]);
	    	SetPlayerPosEx(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
	        Wchodzenie(playerid);
	        sendTipMessageEx(playerid, COLOR_P@, sprintf("Kupi³eœ skin %d za $5000", PlayerInfo[playerid][pModel]));
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