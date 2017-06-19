//exampleObjects.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//-----------------------------------------[ Modu³: exampleObjects.pwn ]--------------------------------------------//
//Autor:
/*
	
*/
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

//

//-----------------<[ G³ówne funkcje: ]>-------------------
exampleObjects_Init() //t¹ metodê wklejamy do nowe_obiekty -> obiekty_OnGameModeInit()
{
	StworzObiekty();
	StworzBramy();
	StworzBudynki();
	return 1;
}

exampleObjects_Connect(playerid) //t¹ metodê wklejamy do nowe_obiekty -> obiekty_OnGameModeInit()
{
	UsunObiekty(playerid);
	return 1;
}

//-----------------<[ Funkcje: ]>-------------------
static StworzObiekty()
{
	//Tutaj wstawiamy obiekty/pickupy/3dtexty/ikonki w nastêpuj¹cym formacie:
	//CreateDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, STREAMER_TAG_AREA areaid = STREAMER_TAG_AREA -1, priority = 0);
	//CreateDynamicPickup(modelid, type, Float:x, Float:y, Float:z, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_PICKUP_SD, STREAMER_TAG_AREA areaid = STREAMER_TAG_AREA -1, priority = 0);
	//CreateDynamic3DTextLabel(const text[], color, Float:x, Float:y, Float:z, Float:drawdistance, attachedplayer = INVALID_PLAYER_ID, attachedvehicle = INVALID_VEHICLE_ID, testlos = 0, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_3D_TEXT_LABEL_SD, STREAMER_TAG_AREA areaid = STREAMER_TAG_AREA -1, priority = 0);
	//CreateDynamicMapIcon(Float:x, Float:y, Float:z, type, color, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_MAP_ICON_SD, style = MAPICON_LOCAL, STREAMER_TAG_AREA areaid = STREAMER_TAG_AREA -1, priority = 0);
	return 1;
}

static StworzBramy()
{
	//Tutaj wstawiamy bramy w formacie: 
		// DodajBrame(fobiekt, Float:fx1, Float:fy1, Float:fz1, Float:frx1, Float:fry1, Float:frz1, Float:fx2, Float:fy2, Float:fz2, Float:frx2, Float:fry2, Float:frz2, Float:fspeed, Float:frange, fuprtyp=0, fuprval=0)
		// fuprtyp - TYPY UPRAWNIEÑ:
			//0 - BRAK
			//1 - FRAKCJA
			//2 - RODZINA
		// fuprval - numer frakcji/rodziny
	
	
	//Tutaj wstawiamy bramy w formacie (NOWY, JESZCZE NIE ZROBIONY):
	//AddGate(friendlyName[128], ownerType, gateowner, gatemodel, Float:X, Float: Y, Float: Z, Float: rX, Float: rY, Float: rZ, Float:Ox, Float:Oy, Float:Oz, Float:Orx, Float:Ory, Float:Orz, opis[128], Float:openRange, Float:moveSpeed = 5.0, vw = 0, int = 0);
	//ownerType:
		//GATE_OWNER_FRAKCJA
		//GATE_OWNER_RODZINA
		//GATE_OWNER_PRACA
		//GATE_OWNER_GRACZ
	return 1;
}

static StworzBudynki()
{
	//Tutaj wstawiamy wejœcia w formacie:
	//DodajWejscie(Float:fx1, Float:fy1, Float:fz1, Float:fx2, Float:fy2, Float:fz2, vw1=0, int1=0, vw2=0, int2=0, nazwain[]="", nazwaout[]="")
	
	//Lub wstawiamy budynki, pomieszczenia i drzwi w formacie (NOWY, JESZCZE NIE ZROBIONY):
	//StworzBudynek(id, nazwa[], typ, wlasciciel, vw, playerid=-1);
	//StworzPomieszczenie(id, nazwa[], budynek, interior, czas, pogoda, muzyka[]="", playerid=-1);
	//StworzDrzwi(id, nazwa[], Float:ix, Float:iy, Float:iz, Float:ia, itext3d[], ipickup, ipomieszczenie, Float:ox, Float:oy, Float:oz, Float:oa, otext3d[], opickup, opomieszczenie, bool:lockvalue=false, playerid=-1);
	return 1;
}

static UsunObiekty()
{
	//Tutaj wstawiamy usuwanie obiektów z mapy GTA w formacie:
	//RemoveBuildingForPlayer(playerid, modelid, Float:fX, Float:fY, Float:fZ, Float:fRadius);
	return 1;
}