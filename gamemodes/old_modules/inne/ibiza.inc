#define DIALOG_IBIZA_BILET 9001
#define DIALOG_IBIZA_BAR 9002
#define DIALOG_IBIZA_MIKSER 9003
#define DIALOG_IBIZA_TELEBIM 9004
#define DIALOG_IBIZA_TEKST  9005
#define DIALOG_IBIZA_KOLOR  9006
#define DIALOG_IBIZA_ANIM   9007
#define DIALOG_IBIZA_CZCIONKA 9008
#define DIALOG_IBIZA_STREAM  9009
#define DIALOG_IBIZA_STREAM_WLASNY 9010
#define DIALOG_IBIZA_IBIZA 9011
#define DIALOG_IBIZA_CENNIK 9012
#define DIALOG_IBIZA_SEJF 9013
#define DIALOG_IBIZA_INFO 9014
#define DIALOG_IBIZA_WPLATA 9015
#define DIALOG_IBIZA_WYPLATA 9016
#define DIALOG_IBIZA_CENNIK_ZMIEN 9017
#define DIALOG_IBIZA_CENNIK_ZMIEN_2 9018
#define DIALOG_IBIZA_BILET_CENA 9019
#define DIALOG_IBIZA_PARKIET 9020
#define DLUGOSC_TELEBIMA 19
#define IBIZA_WYPELNIENIE " "

//forwardy
forward TelebimAnim(ile);
forward Odmrozenie(playerid);
forward FreezeVeh(vehicleid, ddriver, repeat);


//zmienne
new Float:IbizaKameryLA[12][3] = { {1946.757446, -2490.115966, 13.635937},
								   {1933.881591, -2493.383544, 13.626562},
								   {1903.059204, -2486.899902, 14.019104},
								   {1902.456176, -2479.868896, 13.626562},
								   {1899.978881, -2484.652343, 13.626562},
								   {1746.502685, -2471.337158, 14.226562},
								   {1538.020629, -2553.440185, 13.588956},
								   {1538.020629, -2553.440185, 13.588956},
								   {377.942779, -1823.872558, 7.835937},
								   {402.687744, -1797.629028, 7.834552},
								   {403.977600, -1797.482543, 7.828125},
								   {329.497589, -1792.312377, 4.824112}
}; //pozycja na któr¹ patrzy kamera
new IbizaKoloryTelebim[] = { 0xFFFFFFFF, 0xFFff8400, 0xFF0f62d3, 0xFF0fd318, 0xFFfcff00};
							//   bia³y		  pomarañcz   niebieski   zielony    ¿ó³ty


new IbizaStream[][128] = {"", "http://listen.slotex.pl/7490.pls", "http://ts.avatat.pl:8000/listen.pls"};
new  IbizaCzcionkiTelebim[][25] = {"Arial", "Verdana", "Courier New", "Comic Sans MS", "Tahoma" };
new IbizaDrinkiNazwy[][20] = {	
"Ibiza",
"Godfather", 
"Kamikaze",
"A day at the Beach", 
"Dry Martini",
"Blue Lagoon",
"Ballantine's",
"Margherita",
"Amaretto Cobbler",
"Cuba Libre",
"Casablanca",
"Tequila Sunrise"
};

new IbizaStreamID = 1;
new bool:IbizaStrobo = false;
new IbizaStroboObiekty[28];
new bool:IbizaRury = false;
new IbizaRuryObiekty[4];
new bool:IbizaDym = false;
new IbizaDymObiekty[10];
new IbizaKafle[4];
new IbizaBilet;
new bool:IbizaSwiatla = true;
new IbizaBarierkiObiekty[3];
new bool:IbizaZamek = true;
new IbizaKanciapaObiekt;
new bool:IbizaKanciapa = false;

new IbizaPiasek[4];
new bool:IbizaBrama[2] = {true, true};
new IbizaBramaObiekty[2];
new bool:IbizaBiuro = false;
new bool:IbizaDach = false;
new Text:TDIbiza[3];
new IbizaKameryObiekty[12];
new IbizaKameryVW[12] = {1,1,1,1,1,1,1,2,0,0,0,0};


new IbizaDrinkiCeny [12];

enum telebim{
	tID,
	tCzcionkaKolor,
	tTekstAnim[128],
	tSzybkosc,
	tIndex,
	tSize,
	tFSize,
	tBold,
	tRuchomy,
	tWRuchu,
	tBackg,
	tAli,
	tTekst[128],
	tCzcionka[25]
};

new Telebim[telebim];


//stocki
WylaczSwiatla()
{
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz") || GetPVarInt(i, "IbizaKibel")) continue;
		SetPlayerWeather(i, 24);
		SetPlayerTime(i, 6, 0);
	}
	return 1;
}
IbizaOdswiezObiekty()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz") || GetPVarInt(i, "IbizaKibel")) continue;
		Streamer_Update(i);
	}
	return 1;
}
WylaczSwiatlaP(playerid)
{
	SetPlayerWeather(playerid, 24); //63
	SetPlayerTime(playerid, 6, 0);
	return 1;
}

WlaczSwiatlaP(playerid)
{
	SetPlayerWeather(playerid, 1);
	SetPlayerTime(playerid, 12, 0);
	return 1;
}

IbizaDrinkiPobierz()
{
	new string[128];
	for(new i=0; i<12; i++)
	{
		format(string, sizeof string, "SELECT cena FROM ibizadrinki WHERE id=%d", i);
		mysql_query(string);
		mysql_store_result();
		if(mysql_num_rows())
		{
			mysql_fetch_row_format(string, "|");
			sscanf(string, "d", IbizaDrinkiCeny[i]);
		}
		mysql_free_result();
	}
	return 1;
}

IbizaWyjscie(playerid)
{
	new h, m, s;
	gettime(h, m, s);
	SetPlayerWeather(playerid, 4);
	SetPlayerTime(playerid, h, m);
	return 1;
}



PlayerName(playerid)
{
	new string[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, string, MAX_PLAYER_NAME);
	return string;
}



MikserDialog(playerid)
{
	ShowPlayerDialogEx(playerid, DIALOG_IBIZA_MIKSER, DIALOG_STYLE_LIST, "Konsola DJa", "Stream\nTelebim\nŒwiat³a\nStroboskopy\nMaszynka do dymu\nRury", "Wybierz", "Wyjdz");
	return 1;
}

WlaczSwiatla()
{
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz")) continue;
		SetPlayerWeather(i, 1);
		SetPlayerTime(i, 12, 0);
	}
	return 1;
}

IbizaUstawKamere(playerid, index)
{
	new dd,mm,rr, g,m,s, string[64];
	format(string, sizeof string, "CAM %02d", index+1);
	PlayerTextDrawSetString(playerid, PlayerText:GetPVarInt(playerid, "IbizaCam"), string);
	new Float:x, Float:y, Float:z;
	if(index == 7 || index == 6) SetPlayerPos(playerid, 1536.3556,-2562.2925,13.5469); //kible
	else if(index > 7) SetPlayerPos(playerid, 397.1197,-1810.7117, 7.8298); //dwór
	else //intex
	{
		x = GetPVarFloat(playerid, "IbizaKameraX");
		y = GetPVarFloat(playerid, "IbizaKameraY");
		z = GetPVarFloat(playerid, "IbizaKameraZ");
		SetPlayerPos(playerid, x, y, z);
	}
	GetDynamicObjectPos(IbizaKameryObiekty[index], x, y, z);
	SetPlayerCameraPos(playerid, x, y, z);
	SetPlayerCameraLookAt(playerid, IbizaKameryLA[index][0], IbizaKameryLA[index][1], IbizaKameryLA[index][2]);
	SetPlayerVirtualWorld(playerid, IbizaKameryVW[index]);
	Streamer_UpdateEx(playerid, x, y, z, IbizaKameryVW[index]);
	gettime(g,m,s); getdate(rr,mm,dd);
	format(string, sizeof string, "%02d/%02d/%d  %02d:%02d", dd, mm, rr, g,m);
	TextDrawSetString(TDIbiza[0], string);
	return 1;
}


WlaczStream(id)
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz") ) continue;
		PlayAudioStreamForPlayer(i, IbizaStream[id]);
	}
	return 1;
}



public Odmrozenie(playerid) //POWTÓRKA
{
	TogglePlayerControllable(playerid, true);
	return 1;
}


public FreezeVeh(vehicleid, ddriver, repeat)
{
	SetVehicleVelocity(vehicleid, 0, 0 ,0);
	
	if(repeat < 100) 
	{
		SetTimerEx("FreezeVeh", 50, false, "ddd", vehicleid, ddriver, repeat+1);
	}
	else
	{
		TogglePlayerControllable(ddriver, true);
	}
	return 1;
}

public TelebimAnim(ile)
{
	SetDynamicObjectMaterialText(Telebim[tID], 0 , Telebim[tTekstAnim],  Telebim[tSize], Telebim[tCzcionka], Telebim[tFSize], Telebim[tBold], Telebim[tCzcionkaKolor], Telebim[tBackg], Telebim[tAli]);
	if(ile)
	{
		strdel(Telebim[tTekstAnim], 0, 1);
		strins(Telebim[tTekstAnim], " ", strlen(Telebim[tTekstAnim])-1);
		SetTimerEx("TelebimAnim", Telebim[tSzybkosc], false, "d", ile-1);
	}	
	else
	{
		if(Telebim[tRuchomy])
		{
			new dl = strlen(Telebim[tTekst]);
			format(Telebim[tTekstAnim], sizeof Telebim[tTekstAnim], "");
			for(new i; i<28+(2*dl); i++)
			{
				format(Telebim[tTekstAnim], sizeof Telebim[tTekstAnim], "%s%s", Telebim[tTekstAnim], IBIZA_WYPELNIENIE);
			}
			format(Telebim[tTekstAnim], sizeof(Telebim[tTekstAnim]), "%s%s|", Telebim[tTekstAnim], Telebim[tTekst]);
			SetDynamicObjectMaterialText(Telebim[tID], 0 , Telebim[tTekstAnim],  Telebim[tSize], Telebim[tCzcionka], Telebim[tFSize], Telebim[tBold], Telebim[tCzcionkaKolor], Telebim[tBackg], Telebim[tAli]);
			Telebim[tRuchomy] = 1;
			Telebim[tWRuchu] = 1;
			SetTimerEx("TelebimAnim", Telebim[tSzybkosc], false, "d", strlen(Telebim[tTekstAnim]));
		}
		else
		{
			SetDynamicObjectMaterialText(Telebim[tID], 0 , Telebim[tTekst],  Telebim[tSize], Telebim[tCzcionka], Telebim[tFSize], Telebim[tBold], Telebim[tCzcionkaKolor], Telebim[tBackg], Telebim[tAli]);
			Telebim[tWRuchu] = 0;
		}
	}
	return 1;
}

IBIZA_Reszta()
{
    IbizaDrinkiPobierz();
	mysql_query("SELECT `hajs` FROM `ibiza` WHERE `id`=2");
	mysql_store_result();
	if(mysql_num_rows())
	{
		new bufor[64];
		mysql_fetch_row_format(bufor, "|");
		sscanf(bufor, "d", IbizaBilet);
	}
	mysql_free_result();
	//TEXTDRAWY

    TDIbiza[0] = TextDrawCreate(390.00000, 21.500000, "01/01/1999  21:21");
    TextDrawFont(TDIbiza[0], 2);
    TextDrawLetterSize(TDIbiza[0], 0.599999, 2.000000);
    TextDrawColor(TDIbiza[0], 0xFFFFFFFF);
    TextDrawSetOutline(TDIbiza[0], 1);

    TDIbiza[1] = TextDrawCreate(326.000000, 373.000000, "LD_BEAT:right");
    TextDrawFont(TDIbiza[1], 4);
	TextDrawTextSize(TDIbiza[1], 40.00, 40.00);
	TextDrawSetSelectable(TDIbiza[1], 1);

    TDIbiza[2] = TextDrawCreate(261.500000, 373.000000, "LD_BEAT:left");
    TextDrawFont(TDIbiza[2], 4);
	TextDrawTextSize(TDIbiza[2], 40.00, 40.00);
	TextDrawSetSelectable(TDIbiza[2], 1);

    	//OBIEKTY INTEK IBIZA
	IbizaKafle[0] = CreateDynamicObject(19128,1936.5900000,-2482.1700000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 473
	IbizaKafle[1] = CreateDynamicObject(19128,1953.6400000,-2482.1300000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 474
	IbizaKafle[2] = CreateDynamicObject(19128,1953.6500000,-2497.4700000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 475
	IbizaKafle[3] = CreateDynamicObject(19128,1936.6100000,-2497.4700000,12.5084,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 476
	IbizaRuryObiekty[0] = CreateDynamicObject(3503,1936.6000, -2482.1799, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 477
	IbizaRuryObiekty[1] = CreateDynamicObject(3503,1953.6300, -2482.1299, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 478
	IbizaRuryObiekty[2] = CreateDynamicObject(3503,1936.5900, -2497.4700, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 479
	IbizaRuryObiekty[3] = CreateDynamicObject(3503,1953.6500, -2497.4600, 11.0000,0.0000000,0.0000000,0.0000000, 1, 0, -1); //Object number 480
	IbizaBarierkiObiekty[0] = CreateDynamicObject(2773,1953.8400000,-2470.7100000,14.9000000,0.0000000,0.0000000,93.1800000, 1, 0, -1); //Object number 423
	IbizaBarierkiObiekty[1] = CreateDynamicObject(2773,1951.9300000,-2470.8200000,14.9000000,0.0000000,0.0000000,93.1800000, 1, 0, -1); //Object number 424
	IbizaBarierkiObiekty[2] = CreateDynamicObject(2773,1950.0100000,-2470.8700000,14.9000000,0.0000000,0.0000000,89.7000000, 1, 0, -1); //Object number 425
	IbizaPiasek[0] = CreateDynamicObject(19377,1939.8800000,-2485.0000000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaPiasek[1] = CreateDynamicObject(19377,1950.3800000,-2485.0000000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaPiasek[2] = CreateDynamicObject(19377,1939.8800000,-2494.6300000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaPiasek[3] = CreateDynamicObject(19377,1950.3800000,-2494.6300000,12.5500000,0.0000000,90.0000000,0.0000000, 1, 0, -1);
	IbizaKameryObiekty[0] = CreateDynamicObject(1616,1958.9700000,-2477.3400000,21.7100000,0.0000000,0.0000000,90.7200000, 1, 0, -1); //przy scenie, paczy na VIP
	IbizaKameryObiekty[1] = CreateDynamicObject(1616,1921.0300000,-2503.7500000,22.6100000,0.0000000,0.0000000,-97.3800000, 1, 0, -1); //nad VIPEm, paczy na parkiet
	IbizaKameryObiekty[2] = CreateDynamicObject(1616,1892.9300000,-2473.6900000,21.7100000,0.0000000,0.0000000,-197.8200000, 1, 0, -1); //paczy na wejscie i bar, po lewo od prezesa
	IbizaKameryObiekty[3] = CreateDynamicObject(1616,1892.9700000,-2493.0300000,20.7300000,0.0000000,0.0000000,-114.3000000, 1, 0, -1); //nad wejœciem paczy na prezesa
	IbizaKameryObiekty[4] = CreateDynamicObject(1616,1913.9400000,-2474.1600000,21.3700000,0.0000000,0.0000000,73.5000000, 1, 0, -1); //przy prezesie prawo
	IbizaKameryObiekty[5] = CreateDynamicObject(1616,1757.2200000,-2467.5000000,24.0100000,-15.7800000,-14.4000000,40.1400000, 1, 0, -1); //przedsionek
	IbizaKameryObiekty[6] = CreateDynamicObject(1616,1533.5800000,-2558.0900000,19.00000,0.0000000,0.0000000,-118.6800000, 1, 0, -1); //kibel
	IbizaKameryObiekty[7] = CreateDynamicObject(1616,1533.5800000,-2558.0900000,19.00000,0.0000000,0.0000000,-118.6800000, 2, 0, -1); //kibel
	IbizaKanciapaObiekt = CreateDynamicObject(19302, 1902.58, -2465.68, 19.12,   0.00, 0.00, 90.00, 1, 0, -1);

	//IBIZA OBIEKTY NA ZEWN¥TRZ
	IbizaKameryObiekty[8] = CreateDynamicObject(1616,386.9000000,-1808.9100000,12.9700000,0.0000000,0.0000000,20.0400000,0, 0, -1); //przy bramie
	IbizaKameryObiekty[9] = CreateDynamicObject(1616,389.5400000,-1805.8600000,12.9800000,0.0000000,0.0000000,-114.0600000,0, 0, -1); //nad wejœciem
	IbizaKameryObiekty[10] = CreateDynamicObject(1616,436.0300000,-1787.4700000,19.5600000,0.0000000,0.0000000,48.3000000,0, 0, -1); //palma bli¿sza na wejœcie
	IbizaKameryObiekty[11] = CreateDynamicObject(1616,308.5300000,-1816.9700000,10.0100000,0.0000000,0.0000000,-122.2800000,0, 0, -1); //z parkingu
	IbizaBramaObiekty[0] = CreateDynamicObject(2372,420.9000000,-1783.4000000,4.3100000,0.0000000,0.0000000,0.0000000,0, 0, -1);
	IbizaBramaObiekty[1] = CreateDynamicObject(2372,358.4000000,-1783.9000000,4.2000000,0.0000000,0.0000000,0.0000000,0, 0, -1);
}

