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
new Text:SkinSelectionAccept,Text:SkinSelectionDenied, Text:SkinSelectionMy;
new Text:Kary;


//Oil 16.09
new Text:OilTXD_BG[2];
new PlayerText:OilPTXD_Arrow[5][MAX_PLAYERS];
//01.10
new Text:TXD_Info;
KaryTXDLoad()
{
	Kary  = TextDrawCreate(16.481735, 272.249847, "_");
	TextDrawLetterSize(Kary, 0.200876, 2.004995);
	TextDrawAlignment(Kary, 1);
	TextDrawColor(Kary, -1);
	TextDrawSetShadow(Kary, 0);
	TextDrawSetOutline(Kary, 1);
	TextDrawBackgroundColor(Kary, 83);
	TextDrawFont(Kary, 1);
	TextDrawSetProportional(Kary, 1);
	TextDrawSetShadow(Kary, 0);
}
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

    //13.07 skin selector
    SkinSelectionAccept = TextDrawCreate(200.0, 240.0, "WYBIERZ");
    TextDrawFont(SkinSelectionAccept, 2);
    TextDrawColor(SkinSelectionAccept, 0x00FF00FF);
    TextDrawAlignment(SkinSelectionAccept, 2);
    TextDrawTextSize(SkinSelectionAccept, 11.0, 75.0);
    TextDrawSetSelectable(SkinSelectionAccept, 1);

    SkinSelectionDenied = TextDrawCreate(440.0, 240.0, "ANULUJ");
    TextDrawFont(SkinSelectionDenied, 2);
    TextDrawColor(SkinSelectionDenied, 0xFF0000FF);
    TextDrawAlignment(SkinSelectionDenied, 2);
    TextDrawTextSize(SkinSelectionDenied, 11.0, 75.0);
    TextDrawSetSelectable(SkinSelectionDenied, 1);

    SkinSelectionMy = TextDrawCreate(320.0, 160.0, "CYWIL");
    TextDrawFont(SkinSelectionMy, 2);
    TextDrawColor(SkinSelectionMy, 0xFFFFFFFF);
    TextDrawAlignment(SkinSelectionMy, 2);
    TextDrawTextSize(SkinSelectionMy, 11.0, 70.0);
    TextDrawSetSelectable(SkinSelectionMy, 1);

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

    Loading_Info = TextDrawCreate(320.000000, 233.296279, "WCZYTYWANIE");
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

    TextDrawDestroy(SkinSelectionAccept);
    TextDrawDestroy(SkinSelectionDenied);
    TextDrawDestroy(SkinSelectionMy);

    TextDrawDestroy(Loading_Box);
    TextDrawDestroy(Loading_Title);
    TextDrawDestroy(Loading_Info);

    ZoneTXD_Unload();
    Oil_UnloadTXD();

    TextDrawDestroy(TXD_Info);
    //Speedo_Unload();
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
	//PlayerTextDrawSetShadow
	PlayerTextDrawColor(playerid, TextOferta1[playerid], 0x80FF00FF);
	//PlayerTextDrawUseBox(playerid, textwjedz[playerid], 1);
	//PlayerTextDrawBoxColor(playerid, textwjedz[playerid], 0xFFFFFFFF);
	//PlayerTextDrawTextSize(playerid, TextOferta1[playerid], 608.000000, 221.000000);
	
    
	return 1;
}

UnLoadTextDraws(playerid)
{
    PlayerTextDrawDestroy(playerid, TAXI_DIST[playerid]);
    PlayerTextDrawDestroy(playerid, TAXI_COST[playerid]);
    //PlayerTextDrawDestroy(playerid, Speedo_GPS[playerid]);

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

    Licznik[playerid] = CreatePlayerTextDraw(playerid,529.000000, 379.000000, "Speed: 320 km/h~n~Paliwo: 320/320l~n~Stan:   100%~n~GPS: Los Santos Airport");
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
