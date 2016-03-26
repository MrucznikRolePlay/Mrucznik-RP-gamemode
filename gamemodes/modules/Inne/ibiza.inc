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
new bool:IbizaBarierki = true;
new IbizaBarierkiObiekty[3];
new bool:IbizaZamek = true;
new bool:IbizaWjazd = false;
new IbizaKanciapaObiekt;
new bool:IbizaKanciapa = false;

new IbizaPiasek[4];
new IbizaParkiet = 0;
new IbizaPodloga[2];
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
stock WylaczSwiatla()
{
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz") || GetPVarInt(i, "IbizaKibel")) continue;
		SetPlayerWeather(i, 24);
		SetPlayerTime(i, 6, 0);
	}
	return 1;
}
stock IbizaOdswiezObiekty()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz") || GetPVarInt(i, "IbizaKibel")) continue;
		Streamer_Update(i);
	}
	return 1;
}
stock WylaczSwiatlaP(playerid)
{
	SetPlayerWeather(playerid, 24); //63
	SetPlayerTime(playerid, 6, 0);
	return 1;
}

stock WlaczSwiatlaP(playerid)
{
	SetPlayerWeather(playerid, 1);
	SetPlayerTime(playerid, 12, 0);
	return 1;
}

stock IbizaDrinkiPobierz()
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

stock IbizaDrinkiZapisz()
{
	new bufor[128];
	for(new i=0; i<12; i++)
	{
		format(bufor, sizeof bufor, "UPDATE `ibizadrinki` SET `cena`=%d WHERE `id`=%d", IbizaDrinkiCeny[i], i);
		mysql_query(bufor);
	}
	return 1;
}

stock IbizaWyjscie(playerid)
{
	new h, m, s;
	gettime(h, m, s);
	SetPlayerWeather(playerid, 4);
	SetPlayerTime(playerid, h, m);
	return 1;
}



stock PlayerName(playerid)
{
	new string[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, string, MAX_PLAYER_NAME);
	return string;
}



stock MikserDialog(playerid)
{
	ShowPlayerDialogEx(playerid, DIALOG_IBIZA_MIKSER, DIALOG_STYLE_LIST, "Konsola DJa", "Stream\nTelebim\nŒwiat³a\nStroboskopy\nMaszynka do dymu\nRury", "Wybierz", "Wyjdz");
	return 1;
}

stock PrezesDialog(playerid)
{
	new string[256];
	new drzwi[64],biuro[64],dach[64];
	if(IbizaZamek) format(drzwi, sizeof drzwi, "{FF0000}Drzwi do Klubu{FFFFFF}");
	else format(drzwi, sizeof drzwi, "{1F7D0C}Drzwi do Klubu{FFFFFF}");
	if(IbizaBiuro) format(biuro, sizeof biuro, "{1F7D0C}Drzwi do biura{FFFFFF}");
	else format(biuro, sizeof biuro, "{FF0000}Drzwi do biura{FFFFFF}");
	if(IbizaDach) format(dach, sizeof dach, "{1F7D0C}Wyjœcie na dach");
	else format(dach, sizeof dach, "{FF0000}Wyjœcie na dach");
	format(string, sizeof string, "Sejf\n%s\nCena biletu (%d$)\nCeny Baru\nBarierki\nMikser\nParkiet\n%s\n%s", drzwi, IbizaBilet, biuro, dach);
	ShowPlayerDialogEx(playerid, DIALOG_IBIZA_IBIZA, DIALOG_STYLE_LIST, "Panel Prezesa", string, "Wybierz", "WyjdŸ");
	return 1;
}

stock WlaczSwiatla()
{
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i) || !GetPVarInt(i, "IbizaWejdz")) continue;
		SetPlayerWeather(i, 1);
		SetPlayerTime(i, 12, 0);
	}
	return 1;
}

stock IbizaUstawKamere(playerid, index)
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


stock WlaczStream(id)
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
	
	if(repeat < 100) SetTimerEx("FreezeVeh", 50, false, "ddd", vehicleid, ddriver, repeat+1);
	else
	{
		IbizaWjazd = false;
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

