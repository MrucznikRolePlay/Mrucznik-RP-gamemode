//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  graffiti                                                 //
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
// Autor: Sanda³
// Data utworzenia: 01.02.2020
//Opis:
/*
	System graffiti


	/graffiti stworz (na strefie przejêtej/nieprzejêtej - na SC & tylko dla gangów - na koniec do dodania) tworzy dialog
	w którym wpisujemy tekst i wybieramy kolor podstawowy (mozna zmieniac kolory w trakcie, np {f0f0f0}tekst)
	Po tym ustawiamy odpowiednie koordy naszego napisu===(do tego punktu gotowe)===, zapisuje sie w bazie danych:
	x,y,z,xy,yy,zy,graffiti_id,graffti_tekst[128],graffiti_kolor = 0xFF+KOLOR

	Nastêpnie od razu te graffiti siê usuwa i tworzy od nowa poleceniem graffiti_Load(id) aby zaaplikowaæ "\n" w tekœcie.
	To samo z edycj¹ graffiti, po edycji wszystko zapisujemy oraz usuwamy + tworzymy od nowa funkcj¹ load_mysql.

	Admin ma dostêp do komendy(1@lvl>) /graffiti sprawdz - wysy³a mu ID najblizszego graffiti (inRange 200-300)
	Pozniej ma dostep do /graffiti edytuj <ID_graffiti> w którym otwiera sie dialog taki sam jak u gracza
	czyli: mozliwosc zmiany tekstu, koloru, edycji po³o¿enia lub usuniêcia. Admin moze edytowac kazdego gracza graffiti
	Gracz moze edytowac tylko swoje, na dodatek musi byc w poblizu (tzn. inrangeofpoint <= 5)
	Admin moze edytowac na calej mapie, moze sie teleportowac /graffiti tp <id_graffiti>

	Po stworzeniu graffiti, wysy³a siê ono na @czat oraz do logów<robota dla kogos innego, mrucznik pls>
	Edycja tekstu - logi
	Admin usuna³ graffiti - @czat

	Do dodania jest tak¿e rozpuszczalnik za X$ w 24/7, pozwoli to PD/mechanikom usuwaæ graffiti, mechanicy dostan¹ np. 3-4k$ za ka¿de usuniêcie,
	po usuniêciu musz¹ przeczekaæ payday aby usun¹æ nastêpne(¿eby nie wyczyœcili ca³ego SC z graffiti na raz)
	
	Limit dla gracza to 3 graffiti, limit na ca³e SC - 75-100 graffiti
*/


#include <YSI\y_hooks>
#include "graffiti_dialogs.pwn"
hook OnPlayerConnect(playerid)
{
    graffiti_ZerujZmienne(playerid);
}


public OPEDO(playerid, objectid, response, x, y, z, rx, ry, rz)
{
    CallRemoteFunction("OnPlayerEditDynamicObject", "iisffffff", playerid, objectid, response, x, y, z, rx, ry, rz);
}

hook OPEDO(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
 	if( response == EDIT_RESPONSE_FINAL )
    {
        if( GetPVarInt(playerid, "GraffitiCreating") == 1 )
        {
			new f = GetPVarInt(playerid, "GraffitiID");
			GraffitiInfo[f][grafXpos] = x;
			GraffitiInfo[f][grafYpos] = y;
			GraffitiInfo[f][grafZpos] = z;
			GraffitiInfo[f][grafXYpos] = rx;
			GraffitiInfo[f][grafYYpos] = ry;
			GraffitiInfo[f][grafZYpos] = rz;
            GameTextForPlayer(playerid, "~g~Stworzono.",2000, 5);
			graffiti_SaveMySQL(f, playerid);
			graffiti_ReloadForPlayers(f);
			DeletePVar(playerid,"GraffitiCreating");
			graffiti_ZerujZmienne(playerid);
        }
    }
    if( response == EDIT_RESPONSE_CANCEL )
    {
        if( GetPVarInt(playerid, "GraffitiCreating") == 1 )
        {
            DestroyDynamicObject(pGraffiti[playerid]);
			GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
			DeletePVar(playerid,"GraffitiCreating");
        }
    }
    return 1;
}
//-----------------<[ Funkcje: ]>-------------------
GrafExist(value)
{
	if(GraffitiInfo[value][grafXpos] != 0)
	{
		return true;
	}
	return false; 
}
stock graffiti_GetNewID()
{
	for(new i; i <= GRAFFITI_MAX; i++)
	{
		if(!GrafExist(i))
		{
			return i; 
		}
	} 
	return INVALID_GRAFID;
}
graffiti_ReloadForPlayers(id)
{
	DestroyDynamicObject(GraffitiInfo[id][gID]);
	graffiti_LoadMySQL(id);
	return 1;
}
graffiti_CreateGraffiti(playerid)
{
	new f = graffiti_GetNewID();
	SetPVarInt(playerid, "GraffitiID", f);
	GetPlayerPos(playerid, PlayerPos[playerid][0], PlayerPos[playerid][1], PlayerPos[playerid][2]);
	GraffitiInfo[f][grafXpos] = PlayerPos[playerid][0];
	GraffitiInfo[f][grafYpos] = PlayerPos[playerid][1];
	GraffitiInfo[f][grafZpos] = PlayerPos[playerid][2];
	GraffitiInfo[f][grafXYpos] = 0.0;
	GraffitiInfo[f][grafYYpos] = 0.0;
	GraffitiInfo[f][grafZYpos] = 0.0;
	GraffitiInfo[f][grafText] = Graffiti_Text[playerid];
	GraffitiInfo[f][gColor] = Graffiti_Color[playerid];
	graffiti_SaveMySQL(f, playerid);
	switch(GraffitiInfo[f][gColor])
	{
		case 0: GraffitiInfo[f][gColor] = GRAFFITI_CZARNY;// CZARNY
 
        case 1: GraffitiInfo[f][gColor] = GRAFFITI_BIALY; // BIALY
 
        case 2: GraffitiInfo[f][gColor] = GRAFFITI_CZERWONY; // CZERWONY
 
        case 3: GraffitiInfo[f][gColor] = GRAFFITI_ZIELONY; // ZIELONY
 
        case 4: GraffitiInfo[f][gColor] = GRAFFITI_NIEBIESKI; // NIEBIESKI
 
        case 5: GraffitiInfo[f][gColor] = GRAFFITI_SZARY;  // SZARY
	}
	SetPVarInt(playerid, "GraffitiCreating", 1);
	graffiti_ReloadForPlayers(f);
	EditDynamicObject(playerid, GraffitiInfo[f][gID]);
	return 1;
}
graffiti_ZerujZmienne(playerid)
{
	pGraffiti[playerid] = -1;
	Graffiti_Color[playerid] = 0;
	Graffiti_Text[playerid] = "";
}
//end
