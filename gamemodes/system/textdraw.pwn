//Textdraw.pwn
//13.06.2014 Kubi

/*----------------------------------------- MessageBox system by Kubi ------------------------------------------*/
//native MSGBOX_Show(playerid, title[], icon, time=2, bool:priority=false);
//native MSGBOX_Hide(playerid);
#define MSGBOX_ICON_TYPE_OK         0
#define MSGBOX_ICON_TYPE_ERROR      1
#define MSGBOX_ICON_TYPE_SMILE      2
#define MSGBOX_ICON_TYPE_WARNING    3
#define MSGBOX_ICON_TYPE_EXPLODE    4
#define MSGBOX_ICON_TYPE_WAIT       5
#define MSGBOX_ICON_TYPE_FLOWER     6
#define MSGBOX_ICON_TYPE_POLICE     7
#define MSGBOX_ICON_TYPE_FIST       8
#define MSGBOX_ICON_TYPE_ARROW      9

new MSGBOX_Icons[][32] = {
    {"LD_CHAT:thumbup"},
    {"LD_CHAT:thumbdn"},
    {"LD_CHAT:goodcha"},
    {"LD_CHAT:badchat"},
    {"LD_DUAL:ex2"},
    {"LD_GRAV:timer"},
    {"LD_GRAV:flwr"},
    {"LD_SHTR:pm3"},
    {"hud:fist"},
    {"hud:arrow"}
};

forward MSGBOX_Hide(playerid); //Do timera
new MSGBOX_Timer[MAX_PLAYERS];
//TXD   MSGBOX
new PlayerText:MSGBOXtd_Title[MAX_PLAYERS];
new PlayerText:MSGBOXtd_Icon[MAX_PLAYERS];
new Text:MSGBOXtd_Sign;
new Text:MSGBOXtd_Ver;
new Text:MSGBOXtd_Kubi;
new PlayerText:textwjedz[MAX_PLAYERS];

/*----------------------------------------- MessageBox END ---------------------------------------------------*/

new PlayerText:TextInformacyjny[MAX_PLAYERS];
new PlayerText:TextOferta1[MAX_PLAYERS];

//TXD   Taxi licznik
new Text:TAXI_BG[2];
new PlayerText:TAXI_DIST[MAX_PLAYERS];
new PlayerText:TAXI_COST[MAX_PLAYERS];

//TXD tempomat
new PlayerText:CRUISECONTROL_AMOUNT[MAX_PLAYERS];
//TXD   Stanowe - Textdrawy keypad
new Text:NG_GateTD[8];
//25.07 stefy
new Text:ZoneTXD[4];
new PlayerText:ZonePTXD_Name[MAX_PLAYERS];
new PlayerText:ZonePTXD_Cash[MAX_PLAYERS];
new PlayerText:ZonePTXD_Area[MAX_PLAYERS];
new PlayerText:ZonePTXD_Member[MAX_PLAYERS];
//speedo
/*new Text:Speedo_BG[6];
new Text:Speedo_ToggleGPS;
new Text:Speedo_ToggleStan;
new PlayerText:Speedo_Engine[MAX_PLAYERS];
new PlayerText:Speedo_Lights[MAX_PLAYERS];
new PlayerText:Speedo_Speed[MAX_PLAYERS];
new PlayerText:Speedo_Fuel[MAX_PLAYERS][5];
new PlayerText:Speedo_Paliwo[MAX_PLAYERS];
new PlayerText:Speedo_GPS[MAX_PLAYERS]; */
new PlayerText:Licznik[MAX_PLAYERS];

new Text:Loading_Box;
new Text:Loading_Title;
new Text:Loading_Info;

new Text:PatrolMap;
new Text:PatrolAlfa[2];
new Text:PatrolBeta[2];
new Text:PatrolGamma[2];
new Text:PatrolDelta[2];
new Text:PatrolAlfaSq;
new Text:PatrolBetaSq;
new Text:PatrolGammaSq;
new Text:PatrolDeltaSq;
new Text:PatrolLabel;
new Text:PatrolMarker[MAX_PATROLS];

new PlayerText:Kary[MAX_PLAYERS];
new PlayerText:SN_MESS[MAX_PLAYERS];

//STATYSTYKI
new PlayerText:TXDSTATS_Background[MAX_PLAYERS];
new PlayerText:TXDSTATS_SkinShow[MAX_PLAYERS];
new PlayerText:TXDSTATS_UID[MAX_PLAYERS];
new PlayerText:TXDSTATS_LVL[MAX_PLAYERS];
new PlayerText:TXDSTATS_NICK[MAX_PLAYERS];
new PlayerText:TXDSTATS_PLEC[MAX_PLAYERS];
new PlayerText:TXDSTATS_Pochodzenie[MAX_PLAYERS];
new PlayerText:TXDSTATS_Zdrowie[MAX_PLAYERS];
new PlayerText:TXDSTATS_Kasa[MAX_PLAYERS];
new PlayerText:TXDSTATS_Bank[MAX_PLAYERS];
new PlayerText:TXDSTATS_Telefon[MAX_PLAYERS]; 
new PlayerText:TXDSTATS_KP[MAX_PLAYERS];
new PlayerText:TXDSTATS_Wiek[MAX_PLAYERS];
new PlayerText:TXDSTATS_Slub[MAX_PLAYERS];
new PlayerText:TXDSTATS_OnLine[MAX_PLAYERS];
new PlayerText:TXDSTATS_Respekt[MAX_PLAYERS];
new PlayerText:TXDSTATS_Rodzina[MAX_PLAYERS];
new PlayerText:TXDSTATS_RodzinaRanga[MAX_PLAYERS];
new PlayerText:TXDSTATS_BOID[MAX_PLAYERS];
new PlayerText:TXDSTATS_BMID[MAX_PLAYERS];
new PlayerText:TXDSTATS_Skin[MAX_PLAYERS];
new PlayerText:TXDSTATS_Dom[MAX_PLAYERS];
new PlayerText:TXDSTATS_Warny[MAX_PLAYERS];
new PlayerText:TXDSTATS_Praca[MAX_PLAYERS];
new PlayerText:TXDSTATS_Drugs[MAX_PLAYERS];
new PlayerText:TXDSTATS_Admin[MAX_PLAYERS];
new PlayerText:TXDSTATS_Mats[MAX_PLAYERS];
new PlayerText:TXDSTATS_Fraction[MAX_PLAYERS];
new PlayerText:TXDSTATS_FractionRank[MAX_PLAYERS];
new PlayerText:TXDSTATS_Przestepstwa[MAX_PLAYERS];
new PlayerText:TXDSTATS_Zabic[MAX_PLAYERS];
new PlayerText:TXDSTATS_Smierci[MAX_PLAYERS];
new PlayerText:TXDSTATS_ZmienNick[MAX_PLAYERS];
new PlayerText:TXDSTATS_AresztTime[MAX_PLAYERS];
new PlayerText:TXDSTATS_WozKlucz[MAX_PLAYERS];
new PlayerText:TXDSTATS_Pkt[MAX_PLAYERS];
new PlayerText:TXDSTATS_Sila[MAX_PLAYERS];
new PlayerText:TXDSTATS_WL[MAX_PLAYERS];
new PlayerText:TXDSTATS_WantedDeath[MAX_PLAYERS];
new PlayerText:TXDSTATS_Ryba[MAX_PLAYERS];
new PlayerText:TXDSTATS_Data[MAX_PLAYERS];
new PlayerText:TXDSTATS_Czas[MAX_PLAYERS];
new PlayerText:TXDSTATS_LogoMRP[MAX_PLAYERS];
new PlayerText:TXDSTATS_Linia_01[MAX_PLAYERS];
new PlayerText:TXDSTATS_Linia_02[MAX_PLAYERS];
new PlayerText:TXDSTATS_Linia_03[MAX_PLAYERS];
new PlayerText:TXDSTATS_Linia_04[MAX_PLAYERS];
new PlayerText:TXDSTATS_ZnakWodny[MAX_PLAYERS];

new Text:TXD_Worek;
new blackmap;

new Text:RealtimeTXD;
new Text:ServerVersionTXD;
new Text:BottomBarTXD;
new realtime_string[32];

//Oil 16.09
new Text:OilTXD_BG[2];
new PlayerText:OilPTXD_Arrow[5][MAX_PLAYERS];
//01.10
new Text:TXD_Info;
LoadTXD()
{
    //Debug dla peirwszego TXD
    TextDrawCreate(-10.0, -10.0, "_");

    NG_CreateGateTD();  //Dywan NG keypad

    //----------------------------------------
    fMSGBOX_Init(); //MessageBox by Kubi
    //----------------------------------------

    TAXI_BG[0] = TextDrawCreate(320.000000, 67.000000, "~n~"); //box
    TextDrawAlignment(TAXI_BG[0], 2);
    TextDrawBackgroundColor(TAXI_BG[0], 255);
    TextDrawFont(TAXI_BG[0], 1);
    TextDrawLetterSize(TAXI_BG[0], 0.400000, 6.000000);
    TextDrawColor(TAXI_BG[0], -1);
    TextDrawSetOutline(TAXI_BG[0], 0);
    TextDrawSetProportional(TAXI_BG[0], 1);
    TextDrawSetShadow(TAXI_BG[0], 0);
    TextDrawUseBox(TAXI_BG[0], 1);
    TextDrawBoxColor(TAXI_BG[0], 68);
    TextDrawTextSize(TAXI_BG[0], 0.000000, 130.000000);
    TextDrawSetSelectable(TAXI_BG[0], 0);

    TAXI_BG[1] = TextDrawCreate(263.000000, 3.000000, "IMAGE"); //taxi sign
    TextDrawBackgroundColor(TAXI_BG[1], 0);
    TextDrawFont(TAXI_BG[1], 5);
    TextDrawLetterSize(TAXI_BG[1], 0.500000, 1.000000);
    TextDrawColor(TAXI_BG[1], -1);
    TextDrawSetOutline(TAXI_BG[1], 0);
    TextDrawSetProportional(TAXI_BG[1], 1);
    TextDrawSetShadow(TAXI_BG[1], 1);
    TextDrawUseBox(TAXI_BG[1], 1);
    TextDrawBoxColor(TAXI_BG[1], 255);
    TextDrawTextSize(TAXI_BG[1], 120.000000, 110.000000);
    TextDrawSetPreviewModel(TAXI_BG[1], 19308);
    TextDrawSetPreviewRot(TAXI_BG[1], 0.000000, 0.000000, 90.000000, 1.000000);
    TextDrawSetSelectable(TAXI_BG[1], 0);

    ZoneTXD_Load();

    Loading_Box = TextDrawCreate(641.666687, 1.500000, "usebox");
    TextDrawLetterSize(Loading_Box, 0.000000, 49.415019);
    TextDrawTextSize(Loading_Box, -2.000000, 0.000000);
    TextDrawAlignment(Loading_Box, 1);
    TextDrawColor(Loading_Box, 0);
    TextDrawUseBox(Loading_Box, true);
    TextDrawBoxColor(Loading_Box, 255);
    TextDrawSetShadow(Loading_Box, 0);
    TextDrawSetOutline(Loading_Box, 0);
    TextDrawFont(Loading_Box, 0);

    Loading_Title = TextDrawCreate(320.000000, 213.214828, "~g~~h~~h~~h~Mrucznik~w~-~g~~h~~h~~h~RP");
    TextDrawLetterSize(Loading_Title, 0.449999, 1.600000);
    TextDrawAlignment(Loading_Title, 2);
    TextDrawColor(Loading_Title, -1);
    TextDrawSetShadow(Loading_Title, 0);
    TextDrawSetOutline(Loading_Title, 1);
    TextDrawBackgroundColor(Loading_Title, 51);
    TextDrawFont(Loading_Title, 1);
    TextDrawSetProportional(Loading_Title, 1);

    Loading_Info = TextDrawCreate(320.000000, 233.296279, "WCZYTYWANIE ...");
    TextDrawLetterSize(Loading_Info, 0.230000, 1.052444);
    TextDrawAlignment(Loading_Info, 2);
    TextDrawColor(Loading_Info, -1);
    TextDrawSetShadow(Loading_Info, 0);
    TextDrawSetOutline(Loading_Info, 1);
    TextDrawBackgroundColor(Loading_Info, 51);
    TextDrawFont(Loading_Info, 2);
    TextDrawSetProportional(Loading_Info, 1);

    Oil_LoadTXD();

    TXD_Info = TextDrawCreate(610.000000, 0.000000, "_");
    TextDrawBackgroundColor(TXD_Info, 0);
    TextDrawFont(TXD_Info, 5);
    TextDrawLetterSize(TXD_Info, 0.500000, 1.000000);
    TextDrawColor(TXD_Info, -1);
    TextDrawSetOutline(TXD_Info, 0);
    TextDrawSetProportional(TXD_Info, 1);
    TextDrawSetShadow(TXD_Info, 1);
    TextDrawUseBox(TXD_Info, 1);
    TextDrawBoxColor(TXD_Info, 255);
    TextDrawTextSize(TXD_Info, 30.000000, 30.000000);
    TextDrawSetPreviewModel(TXD_Info, 19131);
    TextDrawSetPreviewRot(TXD_Info, 0.000000, 90.000000, 90.000000, 1.000000);
    TextDrawSetSelectable(TXD_Info, 1);

	TXD_Worek = TextDrawCreate(-20.000000,2.000000,"|");
	TextDrawUseBox(TXD_Worek,1);
	TextDrawBoxColor(TXD_Worek,0x000000ff);
	TextDrawTextSize(TXD_Worek,660.000000,22.000000);
	TextDrawAlignment(TXD_Worek,0);
	TextDrawBackgroundColor(TXD_Worek,0x000000ff);
	TextDrawFont(TXD_Worek,3);
	TextDrawLetterSize(TXD_Worek,1.000000,52.200000);
	TextDrawColor(TXD_Worek,0x000000ff);
	TextDrawSetOutline(TXD_Worek,1);
	TextDrawSetProportional(TXD_Worek,1);
	TextDrawSetShadow(TXD_Worek,1);

	BottomBarTXD = TextDrawCreate(1.000000, 450.000000, "BottomBarTXD");
	TextDrawFont(BottomBarTXD, 2);
	TextDrawLetterSize(BottomBarTXD, -0.024999, -1.900000);
	TextDrawTextSize(BottomBarTXD, 655.000000, 54.500000);
	TextDrawSetOutline(BottomBarTXD, 0);
	TextDrawSetShadow(BottomBarTXD, 0);
	TextDrawAlignment(BottomBarTXD, 1);
	TextDrawColor(BottomBarTXD, -256);
	TextDrawBackgroundColor(BottomBarTXD, 0);
	TextDrawBoxColor(BottomBarTXD, 60);
	TextDrawUseBox(BottomBarTXD, 1);
	TextDrawSetProportional(BottomBarTXD, 0);
	TextDrawSetSelectable(BottomBarTXD, 0);

	RealtimeTXD = TextDrawCreate(606.000000, 436.000000, "0000/00/00 00:00");
	TextDrawFont(RealtimeTXD, 1);
	TextDrawLetterSize(RealtimeTXD, 0.187499, 1.100000);
	TextDrawTextSize(RealtimeTXD, 396.500000, 29.500000);
	TextDrawSetOutline(RealtimeTXD, 1);
	TextDrawSetShadow(RealtimeTXD, 0);
	TextDrawAlignment(RealtimeTXD, 2);
	TextDrawColor(RealtimeTXD, -21);
	TextDrawBackgroundColor(RealtimeTXD, 100);
	TextDrawBoxColor(RealtimeTXD, 50);
	TextDrawUseBox(RealtimeTXD, 0);
	TextDrawSetProportional(RealtimeTXD, 1);
	TextDrawSetSelectable(RealtimeTXD, 0);

	new txd[58];
	format(txd, sizeof(txd), "Mrucznik-RP %s", VERSION);
	ServerVersionTXD = TextDrawCreate(36.000000, 436.000000, txd);
	TextDrawFont(ServerVersionTXD, 2);
	TextDrawLetterSize(ServerVersionTXD, 0.166666, 1.049999);
	TextDrawTextSize(ServerVersionTXD, 413.000000, 76.500000);
	TextDrawSetOutline(ServerVersionTXD, 0);
	TextDrawSetShadow(ServerVersionTXD, 0);
	TextDrawAlignment(ServerVersionTXD, 2);
	TextDrawColor(ServerVersionTXD, -2686761);
	TextDrawBackgroundColor(ServerVersionTXD, 0);
	TextDrawBoxColor(ServerVersionTXD, 213);
	TextDrawUseBox(ServerVersionTXD, 0);
	TextDrawSetProportional(ServerVersionTXD, 1);
	TextDrawSetSelectable(ServerVersionTXD, 0);

}

BottomBar(playerid, show = 1)
{
	if(!show)
	{
		TextDrawHideForPlayer(playerid, BottomBarTXD);
    	TextDrawHideForPlayer(playerid, ServerVersionTXD);
    	TextDrawHideForPlayer(playerid, RealtimeTXD);
		return 1;
	}
    TextDrawShowForPlayer(playerid, BottomBarTXD);
    TextDrawShowForPlayer(playerid, ServerVersionTXD);
    TextDrawShowForPlayer(playerid, RealtimeTXD);
	return 1;
}

LoadingShow(playerid)
{
    TextDrawShowForPlayer(playerid, Loading_Box);
    TextDrawShowForPlayer(playerid, Loading_Title);
    TextDrawShowForPlayer(playerid, Loading_Info);
}

LoadingHide(playerid)
{
    TextDrawHideForPlayer(playerid, Loading_Box);
    TextDrawHideForPlayer(playerid, Loading_Title);
    TextDrawHideForPlayer(playerid, Loading_Info);
}

UnloadTXD()
{
    TextDrawDestroy(Text:1);
    //----------------------------------------
    fMSGBOX_Exit(); //MessageBox by Kubi
    //----------------------------------------
    for(new i=0;i<2;i++) TextDrawDestroy(TAXI_BG[i]);
    for(new i=0;i<8;i++) TextDrawDestroy(NG_GateTD[i]);

    TextDrawDestroy(Loading_Box);
    TextDrawDestroy(Loading_Title);
    TextDrawDestroy(Loading_Info);

    ZoneTXD_Unload();
    Oil_UnloadTXD();

    TextDrawDestroy(TXD_Info);
    //Speedo_Unload();
}
KaryTXDLoadForPlayer(playerid)
{
    Kary[playerid] = CreatePlayerTextDraw(playerid, 7.000000, 281.000000, "_");
	PlayerTextDrawFont(playerid, Kary[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Kary[playerid], 0.308333, 1.200000);
	PlayerTextDrawTextSize(playerid, Kary[playerid], 687.000000, 144.500000);
	PlayerTextDrawSetOutline(playerid, Kary[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Kary[playerid], 0);
	PlayerTextDrawAlignment(playerid, Kary[playerid], 1);
	PlayerTextDrawColor(playerid, Kary[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Kary[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Kary[playerid], 50);
	PlayerTextDrawUseBox(playerid, Kary[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Kary[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Kary[playerid], 0);
    /*
    ==================> STARY TXD

    Kary[playerid] = CreatePlayerTextDraw(playerid, 6.000000, 257.000000, "_");
    PlayerTextDrawFont(playerid, Kary[playerid], 2);
    PlayerTextDrawLetterSize(playerid, Kary[playerid], 0.433333, 1.700000);
    PlayerTextDrawTextSize(playerid, Kary[playerid], 328.500000, -135.500000);
    PlayerTextDrawSetOutline(playerid, Kary[playerid], 0);
    PlayerTextDrawSetShadow(playerid, Kary[playerid], 2);
    PlayerTextDrawAlignment(playerid, Kary[playerid], 1);
    PlayerTextDrawColor(playerid, Kary[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, Kary[playerid], 255);
    PlayerTextDrawBoxColor(playerid, Kary[playerid], 50);
    PlayerTextDrawUseBox(playerid, Kary[playerid], 0);
    PlayerTextDrawSetProportional(playerid, Kary[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, Kary[playerid], 0);*/
}
SN_Message_Load(playerid)
{
    SN_MESS[playerid] = CreatePlayerTextDraw(playerid, 2.000000, 433.000000, "_");
	PlayerTextDrawFont(playerid, SN_MESS[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SN_MESS[playerid], 0.279166, 1.449998);
	PlayerTextDrawTextSize(playerid, SN_MESS[playerid], 682.000000, 640.000000);
	PlayerTextDrawSetOutline(playerid, SN_MESS[playerid], 0);
	PlayerTextDrawSetShadow(playerid, SN_MESS[playerid], 2);
	PlayerTextDrawAlignment(playerid, SN_MESS[playerid], 1);
	PlayerTextDrawColor(playerid, SN_MESS[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, SN_MESS[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SN_MESS[playerid], 172);
	PlayerTextDrawUseBox(playerid, SN_MESS[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SN_MESS[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SN_MESS[playerid], 0);
    return 1;
}
Stats_TXD_Load(playerid)
{
    TXDSTATS_Background[playerid] = CreatePlayerTextDraw(playerid, 126.000000, 153.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Background[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Background[playerid], 0.600000, 23.599998);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Background[playerid], 498.500000, 147.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Background[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Background[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Background[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Background[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Background[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Background[playerid], 538976456);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Background[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Background[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Background[playerid], 0);

	TXDSTATS_SkinShow[playerid] = CreatePlayerTextDraw(playerid, 407.000000, 93.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_SkinShow[playerid], 5);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_SkinShow[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_SkinShow[playerid], 115.000000, 89.500000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_SkinShow[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_SkinShow[playerid], 1);
	PlayerTextDrawAlignment(playerid, TXDSTATS_SkinShow[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_SkinShow[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_SkinShow[playerid], 0);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_SkinShow[playerid], 0);
	PlayerTextDrawUseBox(playerid, TXDSTATS_SkinShow[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_SkinShow[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_SkinShow[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, TXDSTATS_SkinShow[playerid], 305);
	PlayerTextDrawSetPreviewRot(playerid, TXDSTATS_SkinShow[playerid], -10.000000, 1.000000, -22.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, TXDSTATS_SkinShow[playerid], 1, 1);

	TXDSTATS_UID[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 198.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_UID[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_UID[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_UID[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_UID[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_UID[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_UID[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_UID[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_UID[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_UID[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_UID[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_UID[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_UID[playerid], 0);

	TXDSTATS_LVL[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 209.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_LVL[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_LVL[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_LVL[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_LVL[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_LVL[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_LVL[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_LVL[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_LVL[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_LVL[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_LVL[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_LVL[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_LVL[playerid], 0);

	TXDSTATS_NICK[playerid] = CreatePlayerTextDraw(playerid, 263.000000, 175.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_NICK[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_NICK[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_NICK[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_NICK[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_NICK[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_NICK[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_NICK[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_NICK[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_NICK[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_NICK[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_NICK[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_NICK[playerid], 0);

	TXDSTATS_PLEC[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 243.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_PLEC[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_PLEC[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_PLEC[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_PLEC[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_PLEC[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_PLEC[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_PLEC[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_PLEC[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_PLEC[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_PLEC[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_PLEC[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_PLEC[playerid], 0);

	TXDSTATS_Pochodzenie[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 254.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Pochodzenie[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Pochodzenie[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Pochodzenie[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Pochodzenie[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Pochodzenie[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Pochodzenie[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Pochodzenie[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Pochodzenie[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Pochodzenie[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Pochodzenie[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Pochodzenie[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Pochodzenie[playerid], 0);

	TXDSTATS_Zdrowie[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 265.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Zdrowie[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Zdrowie[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Zdrowie[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Zdrowie[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Zdrowie[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Zdrowie[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Zdrowie[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Zdrowie[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Zdrowie[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Zdrowie[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Zdrowie[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Zdrowie[playerid], 0);

	TXDSTATS_Kasa[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 220.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Kasa[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Kasa[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Kasa[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Kasa[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Kasa[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Kasa[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Kasa[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Kasa[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Kasa[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Kasa[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Kasa[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Kasa[playerid], 0);

	TXDSTATS_Bank[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 231.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Bank[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Bank[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Bank[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Bank[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Bank[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Bank[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Bank[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Bank[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Bank[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Bank[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Bank[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Bank[playerid], 0);

	TXDSTATS_Telefon[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 276.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Telefon[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Telefon[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Telefon[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Telefon[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Telefon[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Telefon[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Telefon[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Telefon[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Telefon[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Telefon[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Telefon[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Telefon[playerid], 0);

	TXDSTATS_KP[playerid] = CreatePlayerTextDraw(playerid, 272.000000, 350.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_KP[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_KP[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_KP[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_KP[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_KP[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_KP[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_KP[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_KP[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_KP[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_KP[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_KP[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_KP[playerid], 0);

	TXDSTATS_Wiek[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 287.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Wiek[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Wiek[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Wiek[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Wiek[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Wiek[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Wiek[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Wiek[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Wiek[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Wiek[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Wiek[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Wiek[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Wiek[playerid], 0);

	TXDSTATS_Slub[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 298.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Slub[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Slub[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Slub[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Slub[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Slub[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Slub[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Slub[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Slub[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Slub[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Slub[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Slub[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Slub[playerid], 0);

	TXDSTATS_OnLine[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 199.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_OnLine[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_OnLine[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_OnLine[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_OnLine[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_OnLine[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_OnLine[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_OnLine[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_OnLine[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_OnLine[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_OnLine[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_OnLine[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_OnLine[playerid], 0);

	TXDSTATS_Respekt[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 211.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Respekt[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Respekt[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Respekt[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Respekt[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Respekt[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Respekt[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Respekt[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Respekt[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Respekt[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Respekt[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Respekt[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Respekt[playerid], 0);

	TXDSTATS_Rodzina[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 223.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Rodzina[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Rodzina[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Rodzina[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Rodzina[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Rodzina[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Rodzina[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Rodzina[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Rodzina[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Rodzina[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Rodzina[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Rodzina[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Rodzina[playerid], 0);

	TXDSTATS_RodzinaRanga[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 235.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_RodzinaRanga[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_RodzinaRanga[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_RodzinaRanga[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_RodzinaRanga[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_RodzinaRanga[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_RodzinaRanga[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_RodzinaRanga[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_RodzinaRanga[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_RodzinaRanga[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_RodzinaRanga[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_RodzinaRanga[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_RodzinaRanga[playerid], 0);

	TXDSTATS_BOID[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 247.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_BOID[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_BOID[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_BOID[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_BOID[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_BOID[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_BOID[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_BOID[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_BOID[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_BOID[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_BOID[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_BOID[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_BOID[playerid], 0);

	TXDSTATS_BMID[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 260.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_BMID[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_BMID[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_BMID[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_BMID[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_BMID[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_BMID[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_BMID[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_BMID[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_BMID[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_BMID[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_BMID[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_BMID[playerid], 0);

	TXDSTATS_Skin[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 272.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Skin[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Skin[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Skin[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Skin[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Skin[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Skin[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Skin[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Skin[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Skin[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Skin[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Skin[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Skin[playerid], 0);

	TXDSTATS_Dom[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 284.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Dom[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Dom[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Dom[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Dom[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Dom[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Dom[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Dom[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Dom[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Dom[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Dom[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Dom[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Dom[playerid], 0);

	TXDSTATS_Warny[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 295.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Warny[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Warny[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Warny[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Warny[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Warny[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Warny[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Warny[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Warny[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Warny[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Warny[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Warny[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Warny[playerid], 0);

	TXDSTATS_Praca[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 307.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Praca[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Praca[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Praca[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Praca[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Praca[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Praca[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Praca[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Praca[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Praca[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Praca[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Praca[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Praca[playerid], 0);

	TXDSTATS_Drugs[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 309.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Drugs[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Drugs[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Drugs[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Drugs[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Drugs[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Drugs[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Drugs[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Drugs[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Drugs[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Drugs[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Drugs[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Drugs[playerid], 0);

	TXDSTATS_Admin[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 331.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Admin[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Admin[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Admin[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Admin[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Admin[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Admin[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Admin[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Admin[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Admin[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Admin[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Admin[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Admin[playerid], 0);

	TXDSTATS_Mats[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 320.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Mats[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Mats[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Mats[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Mats[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Mats[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Mats[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Mats[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Mats[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Mats[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Mats[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Mats[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Mats[playerid], 0);

	TXDSTATS_Fraction[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 320.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Fraction[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Fraction[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Fraction[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Fraction[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Fraction[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Fraction[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Fraction[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Fraction[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Fraction[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Fraction[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Fraction[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Fraction[playerid], 0);

	TXDSTATS_FractionRank[playerid] = CreatePlayerTextDraw(playerid, 273.000000, 332.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_FractionRank[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_FractionRank[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_FractionRank[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_FractionRank[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_FractionRank[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_FractionRank[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_FractionRank[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_FractionRank[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_FractionRank[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_FractionRank[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_FractionRank[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_FractionRank[playerid], 0);

	TXDSTATS_Przestepstwa[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 199.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Przestepstwa[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Przestepstwa[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Przestepstwa[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Przestepstwa[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Przestepstwa[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Przestepstwa[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Przestepstwa[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Przestepstwa[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Przestepstwa[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Przestepstwa[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Przestepstwa[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Przestepstwa[playerid], 0);

	TXDSTATS_Zabic[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 210.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Zabic[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Zabic[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Zabic[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Zabic[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Zabic[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Zabic[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Zabic[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Zabic[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Zabic[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Zabic[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Zabic[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Zabic[playerid], 0);

	TXDSTATS_Smierci[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 221.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Smierci[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Smierci[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Smierci[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Smierci[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Smierci[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Smierci[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Smierci[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Smierci[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Smierci[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Smierci[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Smierci[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Smierci[playerid], 0);

	TXDSTATS_ZmienNick[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 232.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_ZmienNick[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_ZmienNick[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_ZmienNick[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_ZmienNick[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_ZmienNick[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_ZmienNick[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_ZmienNick[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_ZmienNick[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_ZmienNick[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_ZmienNick[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_ZmienNick[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_ZmienNick[playerid], 0);

	TXDSTATS_AresztTime[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 243.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_AresztTime[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_AresztTime[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_AresztTime[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_AresztTime[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_AresztTime[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_AresztTime[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_AresztTime[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_AresztTime[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_AresztTime[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_AresztTime[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_AresztTime[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_AresztTime[playerid], 0);

	TXDSTATS_WozKlucz[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 254.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_WozKlucz[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_WozKlucz[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_WozKlucz[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_WozKlucz[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_WozKlucz[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_WozKlucz[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_WozKlucz[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_WozKlucz[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_WozKlucz[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_WozKlucz[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_WozKlucz[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_WozKlucz[playerid], 0);

	TXDSTATS_Pkt[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 265.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Pkt[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Pkt[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Pkt[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Pkt[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Pkt[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Pkt[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Pkt[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Pkt[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Pkt[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Pkt[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Pkt[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Pkt[playerid], 0);

	TXDSTATS_Sila[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 276.000000, "Sila: 0J");
	PlayerTextDrawFont(playerid, TXDSTATS_Sila[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Sila[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Sila[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Sila[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Sila[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Sila[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Sila[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Sila[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Sila[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Sila[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Sila[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Sila[playerid], 0);

	TXDSTATS_WL[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 287.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_WL[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_WL[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_WL[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_WL[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_WL[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_WL[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_WL[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_WL[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_WL[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_WL[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_WL[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_WL[playerid], 0);

	TXDSTATS_WantedDeath[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 298.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_WantedDeath[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_WantedDeath[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_WantedDeath[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_WantedDeath[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_WantedDeath[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_WantedDeath[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_WantedDeath[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_WantedDeath[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_WantedDeath[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_WantedDeath[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_WantedDeath[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_WantedDeath[playerid], 0);

	TXDSTATS_Ryba[playerid] = CreatePlayerTextDraw(playerid, 399.000000, 309.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Ryba[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Ryba[playerid], 0.149998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Ryba[playerid], 628.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Ryba[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Ryba[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Ryba[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Ryba[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Ryba[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Ryba[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Ryba[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Ryba[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Ryba[playerid], 0);

	TXDSTATS_Data[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 153.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Data[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Data[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Data[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Data[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Data[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Data[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Data[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Data[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Data[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Data[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Data[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Data[playerid], 0);

	TXDSTATS_Czas[playerid] = CreatePlayerTextDraw(playerid, 137.000000, 165.000000, "_");
	PlayerTextDrawFont(playerid, TXDSTATS_Czas[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Czas[playerid], 0.224998, 1.500000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Czas[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Czas[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Czas[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Czas[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Czas[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Czas[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Czas[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Czas[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Czas[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Czas[playerid], 0);

    TXDSTATS_LogoMRP[playerid] = CreatePlayerTextDraw(playerid,192.000000, 114.000000, "_");
	PlayerTextDrawFont(playerid,TXDSTATS_LogoMRP[playerid], 5);
	PlayerTextDrawLetterSize(playerid,TXDSTATS_LogoMRP[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_LogoMRP[playerid], 226.000000, 72.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_LogoMRP[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_LogoMRP[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_LogoMRP[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_LogoMRP[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_LogoMRP[playerid], 0);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_LogoMRP[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_LogoMRP[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_LogoMRP[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_LogoMRP[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, TXDSTATS_LogoMRP[playerid], -1003);
	PlayerTextDrawSetPreviewRot(playerid, TXDSTATS_LogoMRP[playerid], 0.000000, 0.000000, -90.000000, 0.919999);
	PlayerTextDrawSetPreviewVehCol(playerid, TXDSTATS_LogoMRP[playerid], 1, 1);

	TXDSTATS_Linia_01[playerid] = CreatePlayerTextDraw(playerid,137.000000, 349.000000, "_");
	PlayerTextDrawFont(playerid,TXDSTATS_Linia_01[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Linia_01[playerid], 0.600000, -0.050000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Linia_01[playerid], 484.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Linia_01[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Linia_01[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Linia_01[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Linia_01[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Linia_01[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Linia_01[playerid], -364693505);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Linia_01[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Linia_01[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Linia_01[playerid], 0);

	TXDSTATS_Linia_02[playerid] = CreatePlayerTextDraw(playerid,272.000000, 346.000000, "_");
	PlayerTextDrawFont(playerid,TXDSTATS_Linia_02[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Linia_02[playerid], 0.929167, -16.200004);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Linia_02[playerid], 267.000000, 16.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Linia_02[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Linia_02[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Linia_02[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Linia_02[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Linia_02[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Linia_02[playerid], -364693505);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Linia_02[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Linia_02[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Linia_02[playerid], 0);

	TXDSTATS_Linia_03[playerid] = CreatePlayerTextDraw(playerid,399.000000, 324.000000, "_");
	PlayerTextDrawFont(playerid,TXDSTATS_Linia_03[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Linia_03[playerid], 0.929167, -13.749999);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Linia_03[playerid], 394.000000, 31.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Linia_03[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Linia_03[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Linia_03[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Linia_03[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Linia_03[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Linia_03[playerid], -364693505);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Linia_03[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Linia_03[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Linia_03[playerid], 0);

	TXDSTATS_Linia_04[playerid] = CreatePlayerTextDraw(playerid,137.000000, 196.000000, "_");
	PlayerTextDrawFont(playerid,TXDSTATS_Linia_04[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_Linia_04[playerid], 0.600000, -0.100000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_Linia_04[playerid], 484.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_Linia_04[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_Linia_04[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_Linia_04[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_Linia_04[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_Linia_04[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_Linia_04[playerid], -364693505);
	PlayerTextDrawUseBox(playerid, TXDSTATS_Linia_04[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_Linia_04[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_Linia_04[playerid], 0);

	TXDSTATS_ZnakWodny[playerid] = CreatePlayerTextDraw(playerid,609.000000, 3.000000, "by Simeone");
	PlayerTextDrawFont(playerid,TXDSTATS_ZnakWodny[playerid], 3);
	PlayerTextDrawLetterSize(playerid, TXDSTATS_ZnakWodny[playerid], 0.141666, 0.850000);
	PlayerTextDrawTextSize(playerid, TXDSTATS_ZnakWodny[playerid], 655.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TXDSTATS_ZnakWodny[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXDSTATS_ZnakWodny[playerid], 0);
	PlayerTextDrawAlignment(playerid, TXDSTATS_ZnakWodny[playerid], 1);
	PlayerTextDrawColor(playerid, TXDSTATS_ZnakWodny[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TXDSTATS_ZnakWodny[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TXDSTATS_ZnakWodny[playerid], 50);
	PlayerTextDrawUseBox(playerid, TXDSTATS_ZnakWodny[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TXDSTATS_ZnakWodny[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TXDSTATS_ZnakWodny[playerid], 0);
}
LoadTextDraws(playerid)
{
    TAXI_DIST[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 77.000000, "0KM");
    PlayerTextDrawAlignment(playerid, TAXI_DIST[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, TAXI_DIST[playerid], 255);
    PlayerTextDrawFont(playerid, TAXI_DIST[playerid], 2);
    PlayerTextDrawLetterSize(playerid, TAXI_DIST[playerid], 0.500000, 1.600000);
    PlayerTextDrawColor(playerid, TAXI_DIST[playerid], -1);
    PlayerTextDrawSetOutline(playerid, TAXI_DIST[playerid], 0);
    PlayerTextDrawSetProportional(playerid, TAXI_DIST[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TAXI_DIST[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, TAXI_DIST[playerid], 0);

    TAXI_COST[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 96.000000, "0$");
    PlayerTextDrawAlignment(playerid, TAXI_COST[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, TAXI_COST[playerid], 255);
    PlayerTextDrawFont(playerid, TAXI_COST[playerid], 2);
    PlayerTextDrawLetterSize(playerid, TAXI_COST[playerid], 0.500000, 1.600000);
    PlayerTextDrawColor(playerid, TAXI_COST[playerid], -1);
    PlayerTextDrawSetOutline(playerid, TAXI_COST[playerid], 0);
    PlayerTextDrawSetProportional(playerid, TAXI_COST[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TAXI_COST[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, TAXI_COST[playerid], 0);

	CRUISECONTROL_AMOUNT[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 77.000000, "0KM");
    PlayerTextDrawAlignment(playerid, CRUISECONTROL_AMOUNT[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, CRUISECONTROL_AMOUNT[playerid], 255);
    PlayerTextDrawFont(playerid, CRUISECONTROL_AMOUNT[playerid], 2);
    PlayerTextDrawLetterSize(playerid, CRUISECONTROL_AMOUNT[playerid], 0.500000, 1.600000);
    PlayerTextDrawColor(playerid, CRUISECONTROL_AMOUNT[playerid], -1);
    PlayerTextDrawSetOutline(playerid, CRUISECONTROL_AMOUNT[playerid], 0);
    PlayerTextDrawSetProportional(playerid, CRUISECONTROL_AMOUNT[playerid], 1);
    PlayerTextDrawSetShadow(playerid, CRUISECONTROL_AMOUNT[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, CRUISECONTROL_AMOUNT[playerid], 0);

    Speedo_PlayerLoad(playerid);

    TextInformacyjny[playerid] = CreatePlayerTextDraw(playerid, 510.000000, 300.000000, "");
    //CreatePlayerTextDraw(playerid, Float:x, Float:y, text[])
    PlayerTextDrawAlignment(playerid, TextInformacyjny[playerid], 2);\
    PlayerTextDrawBackgroundColor(playerid, TextInformacyjny[playerid], 255);
    PlayerTextDrawFont(playerid, TextInformacyjny[playerid], 1);
    PlayerTextDrawLetterSize(playerid, TextInformacyjny[playerid], 0.469998, 1.399999);
    PlayerTextDrawColor(playerid, TextInformacyjny[playerid], -1);
    PlayerTextDrawSetOutline(playerid, TextInformacyjny[playerid], 1);
    PlayerTextDrawSetProportional(playerid, TextInformacyjny[playerid], 1);
    PlayerTextDrawUseBox(playerid, TextInformacyjny[playerid], 1);
    PlayerTextDrawBoxColor(playerid, TextInformacyjny[playerid], 55);
    PlayerTextDrawTextSize(playerid, TextInformacyjny[playerid], 93.000000, 191.000000);


    TextOferta1[playerid] = CreatePlayerTextDraw(playerid, 519.000000, 141.700012, " ");
    PlayerTextDrawAlignment(playerid, TextOferta1[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, TextOferta1[playerid], 255);
    PlayerTextDrawFont(playerid, TextOferta1[playerid], 1);
    PlayerTextDrawLetterSize(playerid, TextOferta1[playerid], 0.319999, 0.899999);
    PlayerTextDrawColor(playerid, TextOferta1[playerid], -1);
    PlayerTextDrawSetOutline(playerid, TextOferta1[playerid], 0);
    PlayerTextDrawSetProportional(playerid, TextOferta1[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TextOferta1[playerid], 1);
    PlayerTextDrawUseBox(playerid, TextOferta1[playerid], 1);
    PlayerTextDrawBoxColor(playerid, TextOferta1[playerid], 926365495);
    PlayerTextDrawTextSize(playerid, TextOferta1[playerid], 608.000000, 221.000000);
	
	textwjedz[playerid] = CreatePlayerTextDraw(playerid, 230.0, 250.0, "~r~Trwa przejazd"); 
	PlayerTextDrawFont(playerid, textwjedz[playerid], 1);
	PlayerTextDrawColor(playerid, TextOferta1[playerid], 0x80FF00FF);
    KaryTXDLoadForPlayer(playerid); 
    SN_Message_Load(playerid);
    Stats_TXD_Load(playerid);
	
    //TEXTDRAWY OD KAR
	return 1;
}

UnLoadTextDraws(playerid)
{
    PlayerTextDrawDestroy(playerid, TAXI_DIST[playerid]);
    PlayerTextDrawDestroy(playerid, TAXI_COST[playerid]);
    //PlayerTextDrawDestroy(playerid, Speedo_GPS[playerid]);
	PlayerTextDrawDestroy(playerid, CRUISECONTROL_AMOUNT[playerid]);
    Speedo_PlayerUnload(playerid);
    ZonePTXD_Unload(playerid);
	return 1;
}

NG_CreateGateTD()
{
    NG_GateTD[0] = TextDrawCreate(450.000000, 220.000000, "New Textdraw");
    TextDrawBackgroundColor(NG_GateTD[0], 0);
    TextDrawFont(NG_GateTD[0], 5);
    TextDrawLetterSize(NG_GateTD[0], 0.500000, 1.000000);
    TextDrawColor(NG_GateTD[0], 567069898);
    TextDrawSetOutline(NG_GateTD[0], 0);
    TextDrawSetProportional(NG_GateTD[0], 0);
    TextDrawSetShadow(NG_GateTD[0], 0);
    TextDrawUseBox(NG_GateTD[0], 1);
    TextDrawBoxColor(NG_GateTD[0], -1);
    TextDrawTextSize(NG_GateTD[0], 185.000000, 167.000000);
    TextDrawSetPreviewModel(NG_GateTD[0], 2922);
    TextDrawSetPreviewRot(NG_GateTD[0], 0.000000, 0.000000, 0.000000, 0.670000);
    TextDrawSetSelectable(NG_GateTD[0], 0);

    NG_GateTD[1] = TextDrawCreate(501.000000, 298.000000, "1");
    TextDrawFont(NG_GateTD[1], 1);
    TextDrawLetterSize(NG_GateTD[1], 0.549999, 2.500000);
	TextDrawTextSize(NG_GateTD[1],  513, 20);
    TextDrawSetShadow(NG_GateTD[1], 1);

    NG_GateTD[2] = TextDrawCreate(536.000000, 298.000000, "2");
    TextDrawFont(NG_GateTD[2], 1);
	TextDrawTextSize(NG_GateTD[2],  536+12, 20);
    TextDrawLetterSize(NG_GateTD[2], 0.549999, 2.500000);
    TextDrawSetShadow(NG_GateTD[2], 1);

    NG_GateTD[3] = TextDrawCreate(572.000000, 298.000000, "3");
    TextDrawFont(NG_GateTD[3], 1);
	TextDrawTextSize(NG_GateTD[3],  572+12, 20);
    TextDrawLetterSize(NG_GateTD[3], 0.549999, 2.500000);
    TextDrawSetShadow(NG_GateTD[3], 1);

    NG_GateTD[4] = TextDrawCreate(500.000000, 333.000000, "4");
    TextDrawFont(NG_GateTD[4], 1);
	TextDrawTextSize(NG_GateTD[4],  500+12, 20);
    TextDrawLetterSize(NG_GateTD[4], 0.549999, 2.500000);
    TextDrawSetShadow(NG_GateTD[4], 1);

    NG_GateTD[5] = TextDrawCreate(536.000000, 333.000000, "5");
    TextDrawFont(NG_GateTD[5], 1);
	TextDrawTextSize(NG_GateTD[5],  536+12, 20);
    TextDrawLetterSize(NG_GateTD[5], 0.549999, 2.500000);
    TextDrawSetShadow(NG_GateTD[5], 1);

    NG_GateTD[6] = TextDrawCreate(572.000000, 333.000000, "6");
    TextDrawFont(NG_GateTD[6], 1);
	TextDrawTextSize(NG_GateTD[6],  572+12, 20);
    TextDrawLetterSize(NG_GateTD[6], 0.549999, 2.500000);
    TextDrawSetShadow(NG_GateTD[6], 1);

    NG_GateTD[7] = TextDrawCreate(488.000000, 248.000000, "0000");
    TextDrawBackgroundColor(NG_GateTD[7], -1);
    TextDrawFont(NG_GateTD[7], 1);
    TextDrawLetterSize(NG_GateTD[7], 0.659999, 2.299999);
    TextDrawColor(NG_GateTD[7], 869020671);
    TextDrawSetOutline(NG_GateTD[7], 1);
    TextDrawSetProportional(NG_GateTD[7], 1);
    TextDrawSetSelectable(NG_GateTD[7], 0);

    for(new i=1;i<7;i++)
    {
        TextDrawAlignment(NG_GateTD[i], 1);
        TextDrawSetSelectable(NG_GateTD[i], 1);
    }
}

/*              MESSAGE BOX                 FUNKCJE                 By KUBI                  */
MSGBOX_Show(playerid, title[], icon, time=2, bool:priority=false)
{
    if(GetPVarInt(playerid, "MSGBOX-display") == 1)
    {
        if(GetPVarInt(playerid, "MSGBOX-priority") == 1 && priority == true) MSGBOX_Hide(playerid);
        else if(GetPVarInt(playerid, "MSGBOX-priority") == 1 && priority == false) return 1;
        MSGBOX_Hide(playerid);
    }
    fMSGBOX_InitForPlayer(playerid, title, MSGBOX_Icons[icon]);
    TextDrawShowForPlayer(playerid, MSGBOXtd_Sign);
    TextDrawShowForPlayer(playerid, MSGBOXtd_Ver);
    TextDrawShowForPlayer(playerid, MSGBOXtd_Kubi);
    PlayerTextDrawShow(playerid, MSGBOXtd_Title[playerid]);
    PlayerTextDrawShow(playerid, MSGBOXtd_Icon[playerid]);
    SetPVarInt(playerid, "MSGBOX-display", 1);
    SetPVarInt(playerid, "MSGBOX-priority", priority);
    if(time != 0) MSGBOX_Timer[playerid] = SetTimerEx("MSGBOX_Hide", time*1000, 0, "i", playerid);
    return 1;
}

public MSGBOX_Hide(playerid)
{
    fMSGBOX_ExitForPlayer(playerid);
    TextDrawHideForPlayer(playerid, MSGBOXtd_Sign);
    TextDrawHideForPlayer(playerid, MSGBOXtd_Ver);
    TextDrawHideForPlayer(playerid, MSGBOXtd_Kubi);
    SetPVarInt(playerid, "MSGBOX-display", 0);
    KillTimer(MSGBOX_Timer[playerid]);
    if(GetPVarInt(playerid, "MSGBOX-priority") == 1) SetPVarInt(playerid, "MSGBOX-priority", 0);
}

fMSGBOX_InitForPlayer(playerid, title[], icon[])
{
    new len = strlen(title),pos=0, pos2=0;
    while((pos = strfind(title, "~", false, pos)) != -1 || pos >= len)
    {
        if((pos2 = strfind(title, "~", false, pos+1)) != -1)
        {
            len -= pos2-pos+1;
            pos = pos2+1;
        }
        else break;
    }
    new str[64], Float:size=7.0/len;
    if(size > 0.7) size = 0.7;
    format(str, 64, "_~n~____%s~n~_", title);

    MSGBOXtd_Title[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 120.000000, str);
    PlayerTextDrawAlignment(playerid, MSGBOXtd_Title[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, MSGBOXtd_Title[playerid], 255);
    PlayerTextDrawFont(playerid, MSGBOXtd_Title[playerid], 1);
    PlayerTextDrawLetterSize(playerid, MSGBOXtd_Title[playerid], size, 1.400000);
    PlayerTextDrawColor(playerid, MSGBOXtd_Title[playerid], -1);
    PlayerTextDrawSetOutline(playerid, MSGBOXtd_Title[playerid], 0);
    PlayerTextDrawSetProportional(playerid, MSGBOXtd_Title[playerid], 1);
    PlayerTextDrawSetShadow(playerid, MSGBOXtd_Title[playerid], 1);
    PlayerTextDrawUseBox(playerid, MSGBOXtd_Title[playerid], 1);
    PlayerTextDrawBoxColor(playerid, MSGBOXtd_Title[playerid], 85);
    PlayerTextDrawTextSize(playerid, MSGBOXtd_Title[playerid], 0.000000, 220.000000);
    PlayerTextDrawSetSelectable(playerid, MSGBOXtd_Title[playerid], 0);

    MSGBOXtd_Icon[playerid] = CreatePlayerTextDraw(playerid, 224.000000, 128.000000, icon);
    PlayerTextDrawBackgroundColor(playerid, MSGBOXtd_Icon[playerid], 255);
    PlayerTextDrawFont(playerid, MSGBOXtd_Icon[playerid], 4);
    PlayerTextDrawLetterSize(playerid, MSGBOXtd_Icon[playerid], 0.000000, 0.000000);
    PlayerTextDrawColor(playerid, MSGBOXtd_Icon[playerid], -1);
    PlayerTextDrawSetOutline(playerid, MSGBOXtd_Icon[playerid], 0);
    PlayerTextDrawSetProportional(playerid, MSGBOXtd_Icon[playerid], 1);
    PlayerTextDrawSetShadow(playerid, MSGBOXtd_Icon[playerid], 0);
    PlayerTextDrawUseBox(playerid, MSGBOXtd_Icon[playerid], 1);
    PlayerTextDrawBoxColor(playerid, MSGBOXtd_Icon[playerid], 255);
    PlayerTextDrawTextSize(playerid, MSGBOXtd_Icon[playerid], 25.000000, 20.000000);
    PlayerTextDrawSetSelectable(playerid, MSGBOXtd_Icon[playerid], 0);
}

fMSGBOX_Init()
{
    MSGBOXtd_Sign = TextDrawCreate(210.000000, 153.000000, "M-RP");
    TextDrawBackgroundColor(MSGBOXtd_Sign, 255);
    TextDrawFont(MSGBOXtd_Sign, 2);
    TextDrawLetterSize(MSGBOXtd_Sign, 0.209999, 0.599999);
    TextDrawColor(MSGBOXtd_Sign, 16711935);
    TextDrawSetOutline(MSGBOXtd_Sign, 0);
    TextDrawSetProportional(MSGBOXtd_Sign, 1);
    TextDrawSetShadow(MSGBOXtd_Sign, 1);
    TextDrawSetSelectable(MSGBOXtd_Sign, 0);

    new str[32];
    format(str, 32, "%s", VERSION);
    strdel(str, 0, 1);
    MSGBOXtd_Ver = TextDrawCreate(417.000000, 153.000000, str);
    TextDrawBackgroundColor(MSGBOXtd_Ver, 255);
    TextDrawAlignment(MSGBOXtd_Ver, 2);
    TextDrawFont(MSGBOXtd_Ver, 2);
    TextDrawLetterSize(MSGBOXtd_Ver, 0.209999, 0.599999);
    TextDrawColor(MSGBOXtd_Ver, 16711935);
    TextDrawSetOutline(MSGBOXtd_Ver, 0);
    TextDrawSetProportional(MSGBOXtd_Ver, 1);
    TextDrawSetShadow(MSGBOXtd_Ver, 1);
    TextDrawSetSelectable(MSGBOXtd_Ver, 0);

    MSGBOXtd_Kubi = TextDrawCreate(414.000000, 118.000000, "c KUBI");
    TextDrawBackgroundColor(MSGBOXtd_Kubi, 255);
    TextDrawFont(MSGBOXtd_Kubi, 1);
    TextDrawLetterSize(MSGBOXtd_Kubi, 0.170000, 0.399999);
    TextDrawColor(MSGBOXtd_Kubi, 51);
    TextDrawSetOutline(MSGBOXtd_Kubi, 0);
    TextDrawSetProportional(MSGBOXtd_Kubi, 1);
    TextDrawSetShadow(MSGBOXtd_Kubi, 0);
    TextDrawSetSelectable(MSGBOXtd_Kubi, 0);
}

fMSGBOX_ExitForPlayer(playerid)
{
    PlayerTextDrawDestroy(playerid,MSGBOXtd_Title[playerid]);
    PlayerTextDrawDestroy(playerid,MSGBOXtd_Icon[playerid]);
}

fMSGBOX_Exit()
{
    TextDrawDestroy(MSGBOXtd_Sign);
    TextDrawDestroy(MSGBOXtd_Ver);
    TextDrawDestroy(MSGBOXtd_Kubi);
    for(new i=0;i<MAX_PLAYERS;i++)
    {
        if(GetPVarInt(i, "MSGBOX-display") == 1)
        {
            MSGBOX_Hide(i);
        }
    }
}

//strefy
ZonePTXD_Unload(playerid)
{
    PlayerTextDrawDestroy(playerid, ZonePTXD_Name[playerid]);
    PlayerTextDrawDestroy(playerid, ZonePTXD_Cash[playerid]);
    PlayerTextDrawDestroy(playerid, ZonePTXD_Area[playerid]);
    PlayerTextDrawDestroy(playerid, ZonePTXD_Member[playerid]);
}

ZonePTXD_Load(playerid)
{
    ZonePTXD_Name[playerid] = CreatePlayerTextDraw(playerid, 552.666503, 208.614776, "Kontrolowana~n~przez: Brak");
    PlayerTextDrawLetterSize(playerid, ZonePTXD_Name[playerid], 0.149333, 1.010963);
    PlayerTextDrawAlignment(playerid, ZonePTXD_Name[playerid], 1);
    PlayerTextDrawColor(playerid, ZonePTXD_Name[playerid], -1);
    PlayerTextDrawSetShadow(playerid, ZonePTXD_Name[playerid], 0);
    PlayerTextDrawSetOutline(playerid, ZonePTXD_Name[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, ZonePTXD_Name[playerid], 51);
    PlayerTextDrawFont(playerid, ZonePTXD_Name[playerid], 1);
    PlayerTextDrawSetProportional(playerid, ZonePTXD_Name[playerid], 1);

    ZonePTXD_Cash[playerid] = CreatePlayerTextDraw(playerid, 553.666442, 229.896301, "Zysk:~n~____0$");
    PlayerTextDrawLetterSize(playerid, ZonePTXD_Cash[playerid], 0.149333, 1.010963);
    PlayerTextDrawAlignment(playerid, ZonePTXD_Cash[playerid], 1);
    PlayerTextDrawColor(playerid, ZonePTXD_Cash[playerid], -1);
    PlayerTextDrawSetShadow(playerid, ZonePTXD_Cash[playerid], 0);
    PlayerTextDrawSetOutline(playerid, ZonePTXD_Cash[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, ZonePTXD_Cash[playerid], 51);
    PlayerTextDrawFont(playerid, ZonePTXD_Cash[playerid], 1);
    PlayerTextDrawSetProportional(playerid, ZonePTXD_Cash[playerid], 1);

    ZonePTXD_Area[playerid] = CreatePlayerTextDraw(playerid, 553.666442, 249.148284, "Powierzchnia:~n~____0 km");
    PlayerTextDrawLetterSize(playerid, ZonePTXD_Area[playerid], 0.149333, 1.010963);
    PlayerTextDrawAlignment(playerid, ZonePTXD_Area[playerid], 1);
    PlayerTextDrawColor(playerid, ZonePTXD_Area[playerid], -1);
    PlayerTextDrawSetShadow(playerid, ZonePTXD_Area[playerid], 0);
    PlayerTextDrawSetOutline(playerid, ZonePTXD_Area[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, ZonePTXD_Area[playerid], 51);
    PlayerTextDrawFont(playerid, ZonePTXD_Area[playerid], 1);
    PlayerTextDrawSetProportional(playerid, ZonePTXD_Area[playerid], 1);

    ZonePTXD_Member[playerid] = CreatePlayerTextDraw(playerid, 553.666442, 269.148284, "Wymagana liczba~n~atakujacych:____0");
    PlayerTextDrawLetterSize(playerid, ZonePTXD_Member[playerid], 0.149333, 1.010963);
    PlayerTextDrawAlignment(playerid, ZonePTXD_Member[playerid], 1);
    PlayerTextDrawColor(playerid, ZonePTXD_Member[playerid], -1);
    PlayerTextDrawSetShadow(playerid, ZonePTXD_Member[playerid], 0);
    PlayerTextDrawSetOutline(playerid, ZonePTXD_Member[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, ZonePTXD_Member[playerid], 51);
    PlayerTextDrawFont(playerid, ZonePTXD_Member[playerid], 1);
    PlayerTextDrawSetProportional(playerid, ZonePTXD_Member[playerid], 1);
}

ZoneTXD_Load()
{
    ZoneTXD[0] = TextDrawCreate(636.000000, 204.551849, "usebox");
    TextDrawLetterSize(ZoneTXD[0], 0.000000, 10.468517);
    TextDrawTextSize(ZoneTXD[0], 519.000000, 0.000000);
    TextDrawAlignment(ZoneTXD[0], 1);
    TextDrawColor(ZoneTXD[0], 0);
    TextDrawUseBox(ZoneTXD[0], true);
    TextDrawBoxColor(ZoneTXD[0], 102);
    TextDrawSetShadow(ZoneTXD[0], 0);
    TextDrawSetOutline(ZoneTXD[0], 0);
    TextDrawFont(ZoneTXD[0], 0);

    ZoneTXD[1] = TextDrawCreate(524.000122, 205.955596, "s g~n~t a~n~r n~n~e g~n~f u~n~a");
    TextDrawLetterSize(ZoneTXD[1], 0.265333, 1.645630);
    TextDrawAlignment(ZoneTXD[1], 1);
    TextDrawColor(ZoneTXD[1], 16777215);
    TextDrawSetShadow(ZoneTXD[1], 0);
    TextDrawSetOutline(ZoneTXD[1], 1);
    TextDrawBackgroundColor(ZoneTXD[1], 51);
    TextDrawFont(ZoneTXD[1], 2);
    TextDrawSetProportional(ZoneTXD[1], 1);

    ZoneTXD[2] = TextDrawCreate(546.666687, 204.966674, "usebox");
    TextDrawLetterSize(ZoneTXD[2], 0.000000, 10.396911);
    TextDrawTextSize(ZoneTXD[2], 543.333312, 0.000000);
    TextDrawAlignment(ZoneTXD[2], 1);
    TextDrawColor(ZoneTXD[2], 0);
    TextDrawUseBox(ZoneTXD[2], true);
    TextDrawBoxColor(ZoneTXD[2], -1061109505);
    TextDrawSetShadow(ZoneTXD[2], 0);
    TextDrawSetOutline(ZoneTXD[2], 0);
    TextDrawFont(ZoneTXD[2], 0);

    ZoneTXD[3] = TextDrawCreate(609.666381, 285.866821, "ATAKUJ");
    TextDrawLetterSize(ZoneTXD[3], 0.149333, 1.010963);
    TextDrawAlignment(ZoneTXD[3], 1);
    TextDrawColor(ZoneTXD[3], -1);
    TextDrawSetShadow(ZoneTXD[3], 0);
    TextDrawSetOutline(ZoneTXD[3], 1);
    TextDrawBackgroundColor(ZoneTXD[3], -16776961);
    TextDrawFont(ZoneTXD[3], 1);
    TextDrawSetProportional(ZoneTXD[3], 1);
    TextDrawSetSelectable(ZoneTXD[3], true);

	blackmap = GangZoneCreate(-3000.0,-3000.0,3000.0,3000.0);
}

/*stock Speedo_Load()
{
    Speedo_BG[0] = TextDrawCreate(527.000000, 335.000000, "LD_POOL:ball");
	TextDrawAlignment(Speedo_BG[0], 2);
	TextDrawBackgroundColor(Speedo_BG[0], 255);
	TextDrawFont(Speedo_BG[0], 4);
	TextDrawLetterSize(Speedo_BG[0], 0.500000, 1.000000);
	TextDrawColor(Speedo_BG[0], 255);
	TextDrawSetOutline(Speedo_BG[0], 0);
	TextDrawSetProportional(Speedo_BG[0], 1);
	TextDrawSetShadow(Speedo_BG[0], 1);
	TextDrawUseBox(Speedo_BG[0], 1);
	TextDrawBoxColor(Speedo_BG[0], 255);
	TextDrawTextSize(Speedo_BG[0], 102.000000, 102.000000);
	TextDrawSetSelectable(Speedo_BG[0], 0);

	Speedo_BG[1] = TextDrawCreate(528.000000, 336.000000, "LD_POOL:ball");
	TextDrawAlignment(Speedo_BG[1], 2);
	TextDrawBackgroundColor(Speedo_BG[1], 255);
	TextDrawFont(Speedo_BG[1], 4);
	TextDrawLetterSize(Speedo_BG[1], 0.500000, 1.000000);
	TextDrawColor(Speedo_BG[1], 65535);
	TextDrawSetOutline(Speedo_BG[1], 0);
	TextDrawSetProportional(Speedo_BG[1], 1);
	TextDrawSetShadow(Speedo_BG[1], 1);
	TextDrawUseBox(Speedo_BG[1], 1);
	TextDrawBoxColor(Speedo_BG[1], 255);
	TextDrawTextSize(Speedo_BG[1], 100.000000, 100.000000);
	TextDrawSetSelectable(Speedo_BG[1], 0);

	Speedo_BG[2] = TextDrawCreate(530.000000, 338.000000, "LD_POOL:ball");
	TextDrawAlignment(Speedo_BG[2], 2);
	TextDrawBackgroundColor(Speedo_BG[2], 255);
	TextDrawFont(Speedo_BG[2], 4);
	TextDrawLetterSize(Speedo_BG[2], 0.500000, 1.000000);
	TextDrawColor(Speedo_BG[2], 255);
	TextDrawSetOutline(Speedo_BG[2], 0);
	TextDrawSetProportional(Speedo_BG[2], 1);
	TextDrawSetShadow(Speedo_BG[2], 1);
	TextDrawUseBox(Speedo_BG[2], 1);
	TextDrawBoxColor(Speedo_BG[2], 255);
	TextDrawTextSize(Speedo_BG[2], 96.000000, 96.000000);
	TextDrawSetSelectable(Speedo_BG[2], 0);

	Speedo_BG[3] = TextDrawCreate(533.000000, 332.000000, "bg");
	TextDrawBackgroundColor(Speedo_BG[3], 0);
	TextDrawFont(Speedo_BG[3], 5);
	TextDrawLetterSize(Speedo_BG[3], 0.900000, -0.199999);
	TextDrawColor(Speedo_BG[3], 65535);
	TextDrawSetOutline(Speedo_BG[3], 0);
	TextDrawSetProportional(Speedo_BG[3], 1);
	TextDrawSetShadow(Speedo_BG[3], 1);
	TextDrawUseBox(Speedo_BG[3], 1);
	TextDrawBoxColor(Speedo_BG[3], 255);
	TextDrawTextSize(Speedo_BG[3], 90.000000, 90.000000);
    TextDrawSetPreviewModel(Speedo_BG[3], 18851);
    TextDrawSetPreviewRot(Speedo_BG[3], 0.000000, 0.000000, 90.000000, 0.699998);
	TextDrawSetSelectable(Speedo_BG[3], 0);

    Speedo_BG[4] = TextDrawCreate(584.000000, 410.000000, "FUEL");
    TextDrawAlignment(Speedo_BG[4], 3);
    TextDrawBackgroundColor(Speedo_BG[4], 255);
    TextDrawFont(Speedo_BG[4], 1);
    TextDrawLetterSize(Speedo_BG[4], 0.170000, 0.799999);
    TextDrawColor(Speedo_BG[4], -1);
    TextDrawSetOutline(Speedo_BG[4], 0);
    TextDrawSetProportional(Speedo_BG[4], 1);
    TextDrawSetShadow(Speedo_BG[4], 1);
    TextDrawSetSelectable(Speedo_BG[4], 0);

    Speedo_BG[5] = TextDrawCreate(586.000000, 364.000000, "km/h");
    TextDrawAlignment(Speedo_BG[5], 3);
    TextDrawBackgroundColor(Speedo_BG[5], 255);
    TextDrawFont(Speedo_BG[5], 1);
    TextDrawLetterSize(Speedo_BG[5], 0.170000, 0.799999);
    TextDrawColor(Speedo_BG[5], -1);
    TextDrawSetOutline(Speedo_BG[5], 0);
    TextDrawSetProportional(Speedo_BG[5], 1);
    TextDrawSetShadow(Speedo_BG[5], 1);
    TextDrawSetSelectable(Speedo_BG[5], 0);

    Speedo_ToggleGPS = TextDrawCreate(574.000000, 410.000000, ".");
    TextDrawAlignment(Speedo_ToggleGPS, 3);
    TextDrawBackgroundColor(Speedo_ToggleGPS, 255);
    TextDrawFont(Speedo_ToggleGPS, 3);
    TextDrawLetterSize(Speedo_ToggleGPS, 0.500000, 2.000000);
    TextDrawColor(Speedo_ToggleGPS, -1);
    TextDrawSetOutline(Speedo_ToggleGPS, 0);
    TextDrawSetProportional(Speedo_ToggleGPS, 1);
    TextDrawSetShadow(Speedo_ToggleGPS, 1);
    TextDrawTextSize(Speedo_ToggleGPS, 584.000000, 420.000000);
    TextDrawSetSelectable(Speedo_ToggleGPS, 1);

    Speedo_ToggleStan = TextDrawCreate(587.000000, 410.000000, ".");
    TextDrawAlignment(Speedo_ToggleStan, 3);
    TextDrawBackgroundColor(Speedo_ToggleStan, 255);
    TextDrawFont(Speedo_ToggleStan, 3);
    TextDrawLetterSize(Speedo_ToggleStan, 0.500000, 2.000000);
    TextDrawColor(Speedo_ToggleStan, -1);
    TextDrawSetOutline(Speedo_ToggleStan, 0);
    TextDrawSetProportional(Speedo_ToggleStan, 1);
    TextDrawSetShadow(Speedo_ToggleStan, 1);
    TextDrawTextSize(Speedo_ToggleStan, 597.000000, 420.000000);
    TextDrawSetSelectable(Speedo_ToggleStan, 1);
}

Speedo_Unload()
{
    for(new i=0;i<sizeof(Speedo_BG);i++) TextDrawDestroy(Speedo_BG[i]);
    TextDrawDestroy(Speedo_ToggleStan);
    TextDrawDestroy(Speedo_ToggleGPS);
}*/

Speedo_PlayerLoad(playerid)
{
    /*Speedo_Engine[playerid] = CreatePlayerTextDraw(playerid, 594.000000, 414.000000, "E");
	PlayerTextDrawBackgroundColor(playerid, Speedo_Engine[playerid], 255);
	PlayerTextDrawFont(playerid, Speedo_Engine[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Speedo_Engine[playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, Speedo_Engine[playerid], -16776961);
	PlayerTextDrawSetOutline(playerid, Speedo_Engine[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Speedo_Engine[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Speedo_Engine[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Speedo_Engine[playerid], 0);

	Speedo_Lights[playerid] = CreatePlayerTextDraw(playerid, 552.000000, 414.000000, "D");
	PlayerTextDrawBackgroundColor(playerid, Speedo_Lights[playerid], 255);
	PlayerTextDrawFont(playerid, Speedo_Lights[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Speedo_Lights[playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, Speedo_Lights[playerid], 16711935);
	PlayerTextDrawSetOutline(playerid, Speedo_Lights[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Speedo_Lights[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Speedo_Lights[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Speedo_Lights[playerid], 0);

    Speedo_Speed[playerid] = CreatePlayerTextDraw(playerid,587.000000, 369.000000, "0");
    PlayerTextDrawAlignment(playerid,Speedo_Speed[playerid], 3);
    PlayerTextDrawBackgroundColor(playerid,Speedo_Speed[playerid], 255);
    PlayerTextDrawFont(playerid,Speedo_Speed[playerid], 3);
    PlayerTextDrawLetterSize(playerid,Speedo_Speed[playerid], 0.500000, 2.000000);
    PlayerTextDrawColor(playerid,Speedo_Speed[playerid], -1);
    PlayerTextDrawSetOutline(playerid,Speedo_Speed[playerid], 0);
    PlayerTextDrawSetProportional(playerid,Speedo_Speed[playerid], 1);
    PlayerTextDrawSetShadow(playerid,Speedo_Speed[playerid], 1);
    PlayerTextDrawSetSelectable(playerid,Speedo_Speed[playerid], 0);

    Speedo_Fuel[playerid][0] = CreatePlayerTextDraw(playerid,598.000000, 381.000000, "-");
    PlayerTextDrawAlignment(playerid,Speedo_Fuel[playerid][0], 2);
    PlayerTextDrawBackgroundColor(playerid,Speedo_Fuel[playerid][0], 255);
    PlayerTextDrawFont(playerid,Speedo_Fuel[playerid][0], 3);
    PlayerTextDrawLetterSize(playerid,Speedo_Fuel[playerid][0], 1.300000, 4.000000);
    PlayerTextDrawColor(playerid,Speedo_Fuel[playerid][0], -1);
    PlayerTextDrawSetOutline(playerid,Speedo_Fuel[playerid][0], 0);
    PlayerTextDrawSetProportional(playerid,Speedo_Fuel[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid,Speedo_Fuel[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid,Speedo_Fuel[playerid][0], 0);

    Speedo_Fuel[playerid][1] = CreatePlayerTextDraw(playerid,598.000000, 371.000000, "-");
    PlayerTextDrawAlignment(playerid,Speedo_Fuel[playerid][1], 2);
    PlayerTextDrawBackgroundColor(playerid,Speedo_Fuel[playerid][1], 255);
    PlayerTextDrawFont(playerid,Speedo_Fuel[playerid][1], 3);
    PlayerTextDrawLetterSize(playerid,Speedo_Fuel[playerid][1], 1.300000, 4.000000);
    PlayerTextDrawColor(playerid,Speedo_Fuel[playerid][1], -1);
    PlayerTextDrawSetOutline(playerid,Speedo_Fuel[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid,Speedo_Fuel[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid,Speedo_Fuel[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid,Speedo_Fuel[playerid][1], 0);

    Speedo_Fuel[playerid][2] = CreatePlayerTextDraw(playerid,598.000000, 361.000000, "-");
    PlayerTextDrawAlignment(playerid,Speedo_Fuel[playerid][2], 2);
    PlayerTextDrawBackgroundColor(playerid,Speedo_Fuel[playerid][2], 255);
    PlayerTextDrawFont(playerid,Speedo_Fuel[playerid][2], 3);
    PlayerTextDrawLetterSize(playerid,Speedo_Fuel[playerid][2], 1.300000, 4.000000);
    PlayerTextDrawColor(playerid,Speedo_Fuel[playerid][2], -1);
    PlayerTextDrawSetOutline(playerid,Speedo_Fuel[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid,Speedo_Fuel[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid,Speedo_Fuel[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid,Speedo_Fuel[playerid][2], 0);

    Speedo_Fuel[playerid][3] = CreatePlayerTextDraw(playerid,598.000000, 351.000000, "-");
    PlayerTextDrawAlignment(playerid,Speedo_Fuel[playerid][3], 2);
    PlayerTextDrawBackgroundColor(playerid,Speedo_Fuel[playerid][3], 255);
    PlayerTextDrawFont(playerid,Speedo_Fuel[playerid][3], 3);
    PlayerTextDrawLetterSize(playerid,Speedo_Fuel[playerid][3], 1.300000, 4.000000);
    PlayerTextDrawColor(playerid,Speedo_Fuel[playerid][3], -1);
    PlayerTextDrawSetOutline(playerid,Speedo_Fuel[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid,Speedo_Fuel[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid,Speedo_Fuel[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid,Speedo_Fuel[playerid][3], 0);

    Speedo_Fuel[playerid][4] = CreatePlayerTextDraw(playerid,598.000000, 341.000000, "-");
    PlayerTextDrawAlignment(playerid,Speedo_Fuel[playerid][4], 2);
    PlayerTextDrawBackgroundColor(playerid,Speedo_Fuel[playerid][4], 255);
    PlayerTextDrawFont(playerid,Speedo_Fuel[playerid][4], 3);
    PlayerTextDrawLetterSize(playerid,Speedo_Fuel[playerid][4], 1.300000, 4.000000);
    PlayerTextDrawColor(playerid,Speedo_Fuel[playerid][4], -1);
    PlayerTextDrawSetOutline(playerid,Speedo_Fuel[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid,Speedo_Fuel[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid,Speedo_Fuel[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid,Speedo_Fuel[playerid][4], 0);

    Speedo_Paliwo[playerid] = CreatePlayerTextDraw(playerid,578.000000, 399.000000, "100");
    PlayerTextDrawAlignment(playerid,Speedo_Paliwo[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid,Speedo_Paliwo[playerid], 255);
    PlayerTextDrawFont(playerid,Speedo_Paliwo[playerid], 3);
    PlayerTextDrawLetterSize(playerid,Speedo_Paliwo[playerid], 0.300000, 1.000000);
    PlayerTextDrawColor(playerid,Speedo_Paliwo[playerid], -1);
    PlayerTextDrawSetOutline(playerid,Speedo_Paliwo[playerid], 0);
    PlayerTextDrawSetProportional(playerid,Speedo_Paliwo[playerid], 1);
    PlayerTextDrawSetShadow(playerid,Speedo_Paliwo[playerid], 1);
    PlayerTextDrawSetSelectable(playerid,Speedo_Paliwo[playerid], 0);

    Speedo_GPS[playerid] = CreatePlayerTextDraw(playerid,89.000000, 427.000000, "_");
    PlayerTextDrawAlignment(playerid,Speedo_GPS[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid,Speedo_GPS[playerid], 255);
    PlayerTextDrawFont(playerid,Speedo_GPS[playerid], 1);
    PlayerTextDrawLetterSize(playerid,Speedo_GPS[playerid], 0.300000, 1.500000);
    PlayerTextDrawColor(playerid,Speedo_GPS[playerid], -1);
    PlayerTextDrawSetOutline(playerid,Speedo_GPS[playerid], 0);
    PlayerTextDrawSetProportional(playerid,Speedo_GPS[playerid], 1);
    PlayerTextDrawSetShadow(playerid,Speedo_GPS[playerid], 1);
    PlayerTextDrawSetSelectable(playerid,Speedo_GPS[playerid], 0); */

    Licznik[playerid] = CreatePlayerTextDraw(playerid,529.000000, 379.000000, "Speed: 320 km/h~n~Paliwo: 320/320l~n~Stan:   100~n~GPS: Los Santos Airport");
    PlayerTextDrawBackgroundColor(playerid,Licznik[playerid], 153);
    PlayerTextDrawFont(playerid,Licznik[playerid], 1);
    PlayerTextDrawLetterSize(playerid,Licznik[playerid], 0.340000, 1.100000);
    PlayerTextDrawColor(playerid,Licznik[playerid], -1);
    PlayerTextDrawSetOutline(playerid,Licznik[playerid], 1);
    PlayerTextDrawSetProportional(playerid,Licznik[playerid], 1);
    PlayerTextDrawUseBox(playerid,Licznik[playerid], 1);
    PlayerTextDrawBoxColor(playerid,Licznik[playerid], 51);
    PlayerTextDrawTextSize(playerid,Licznik[playerid], 635.000000, 124.000000);
    PlayerTextDrawSetSelectable(playerid,Licznik[playerid], 0);
}

Speedo_PlayerUnload(playerid)
{
    /*PlayerTextDrawDestroy(playerid, Speedo_Lights[playerid]);
    PlayerTextDrawDestroy(playerid, Speedo_Engine[playerid]);

    for(new i=0;i<5;i++) PlayerTextDrawDestroy(playerid, Speedo_Fuel[playerid][i]);
    PlayerTextDrawDestroy(playerid, Speedo_Paliwo[playerid]);
    PlayerTextDrawDestroy(playerid, Speedo_Speed[playerid]);

    PlayerTextDrawDestroy(playerid, Speedo_GPS[playerid]);*/
    PlayerTextDrawDestroy(playerid, Licznik[playerid]);
}

Oil_LoadTXD()
{
    OilTXD_BG[0] = TextDrawCreate(414.333374, 375.662780, "usebox");
    TextDrawLetterSize(OilTXD_BG[0], 0.000000, 4.768930);
    TextDrawTextSize(OilTXD_BG[0], 230.333374, 0.000000);
    TextDrawAlignment(OilTXD_BG[0], 1);
    TextDrawColor(OilTXD_BG[0], 0);
    TextDrawUseBox(OilTXD_BG[0], true);
    TextDrawBoxColor(OilTXD_BG[0], -239);
    TextDrawSetShadow(OilTXD_BG[0], 0);
    TextDrawSetOutline(OilTXD_BG[0], 0);
    TextDrawFont(OilTXD_BG[0], 0);

    OilTXD_BG[1] = TextDrawCreate(305.0, 373.333190, "LD_CHAT:dpad_64");
    TextDrawLetterSize(OilTXD_BG[1], 0.000000, 0.000000);
    TextDrawTextSize(OilTXD_BG[1], 32.666637, 55.585147);
    TextDrawAlignment(OilTXD_BG[1], 1);
    TextDrawColor(OilTXD_BG[1], 268435455);
    TextDrawSetShadow(OilTXD_BG[1], 0);
    TextDrawSetOutline(OilTXD_BG[1], 0);
    TextDrawBackgroundColor(OilTXD_BG[1], -1);
    TextDrawFont(OilTXD_BG[1], 4);
}

Oil_UnloadTXD()
{
    TextDrawDestroy(OilTXD_BG[0]);
    TextDrawDestroy(OilTXD_BG[1]);
}

Oil_LoadPTXD(playerid)
{
    OilPTXD_Arrow[0][playerid] = CreatePlayerTextDraw(playerid, 235.0, 375.0, "_"); //last   235.0
    PlayerTextDrawLetterSize(playerid, OilPTXD_Arrow[0][playerid], 0.536999, 3.458371);
    PlayerTextDrawAlignment(playerid, OilPTXD_Arrow[0][playerid], 1);
    PlayerTextDrawColor(playerid, OilPTXD_Arrow[0][playerid], 16777215);
    PlayerTextDrawSetShadow(playerid, OilPTXD_Arrow[0][playerid], 0);
    PlayerTextDrawSetOutline(playerid, OilPTXD_Arrow[0][playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, OilPTXD_Arrow[0][playerid], 51);
    PlayerTextDrawFont(playerid, OilPTXD_Arrow[0][playerid], 1);
    PlayerTextDrawSetProportional(playerid, OilPTXD_Arrow[0][playerid], 1);

    OilPTXD_Arrow[1][playerid] = CreatePlayerTextDraw(playerid, 270.0, 375.0, "_"); //prev  270.0
    PlayerTextDrawLetterSize(playerid, OilPTXD_Arrow[1][playerid], 0.536999, 3.458371);
    PlayerTextDrawAlignment(playerid, OilPTXD_Arrow[1][playerid], 1);
    PlayerTextDrawColor(playerid, OilPTXD_Arrow[1][playerid], 16777215);
    PlayerTextDrawSetShadow(playerid, OilPTXD_Arrow[1][playerid], 0);
    PlayerTextDrawSetOutline(playerid, OilPTXD_Arrow[1][playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, OilPTXD_Arrow[1][playerid], 51);
    PlayerTextDrawFont(playerid, OilPTXD_Arrow[1][playerid], 1);
    PlayerTextDrawSetProportional(playerid, OilPTXD_Arrow[1][playerid], 1);

    OilPTXD_Arrow[2][playerid] = CreatePlayerTextDraw(playerid, 305.0, 375.0, "_"); //mid  305.0
    PlayerTextDrawLetterSize(playerid, OilPTXD_Arrow[2][playerid], 0.536999, 3.458371);
    PlayerTextDrawAlignment(playerid, OilPTXD_Arrow[2][playerid], 1);
    PlayerTextDrawColor(playerid, OilPTXD_Arrow[2][playerid], 16777215);
    PlayerTextDrawSetShadow(playerid, OilPTXD_Arrow[2][playerid], 0);
    PlayerTextDrawSetOutline(playerid, OilPTXD_Arrow[2][playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, OilPTXD_Arrow[2][playerid], 51);
    PlayerTextDrawFont(playerid, OilPTXD_Arrow[2][playerid], 1);
    PlayerTextDrawSetProportional(playerid, OilPTXD_Arrow[2][playerid], 1);

    OilPTXD_Arrow[3][playerid] = CreatePlayerTextDraw(playerid, 345.0, 375.0, "_"); //1st //345.0
    PlayerTextDrawLetterSize(playerid, OilPTXD_Arrow[3][playerid], 0.536999, 3.458371);
    PlayerTextDrawAlignment(playerid, OilPTXD_Arrow[3][playerid], 1);
    PlayerTextDrawColor(playerid, OilPTXD_Arrow[3][playerid], 16777215);
    PlayerTextDrawSetShadow(playerid, OilPTXD_Arrow[3][playerid], 0);
    PlayerTextDrawSetOutline(playerid, OilPTXD_Arrow[3][playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, OilPTXD_Arrow[3][playerid], 51);
    PlayerTextDrawFont(playerid, OilPTXD_Arrow[3][playerid], 1);
    PlayerTextDrawSetProportional(playerid, OilPTXD_Arrow[3][playerid], 1);

    OilPTXD_Arrow[4][playerid] = CreatePlayerTextDraw(playerid, 380.0, 375.0, "_"); //2nd //380.0
    PlayerTextDrawLetterSize(playerid, OilPTXD_Arrow[4][playerid], 0.536999, 3.458371);
    PlayerTextDrawAlignment(playerid, OilPTXD_Arrow[4][playerid], 1);
    PlayerTextDrawColor(playerid, OilPTXD_Arrow[4][playerid], 16777215);
    PlayerTextDrawSetShadow(playerid, OilPTXD_Arrow[4][playerid], 0);
    PlayerTextDrawSetOutline(playerid, OilPTXD_Arrow[4][playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, OilPTXD_Arrow[4][playerid], 51);
    PlayerTextDrawFont(playerid, OilPTXD_Arrow[4][playerid], 1);
    PlayerTextDrawSetProportional(playerid, OilPTXD_Arrow[4][playerid], 1);
}

Oil_UnloadPTXD(playerid)
{
    for(new i=0;i<5;i++)
    {
        PlayerTextDrawDestroy(playerid, OilPTXD_Arrow[i][playerid]);
    }
}

//EOF
