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
// Autor: Sanda�
// Data utworzenia: 01.02.2020
//Opis:
/*
	System graffiti

	/graffiti stworz (na strefie przej�tej/nieprzej�tej - na SC & tylko dla gang�w - na koniec do dodania) tworzy dialog
	w kt�rym wpisujemy tekst i wybieramy kolor podstawowy (mozna zmieniac kolory w trakcie, np {f0f0f0}tekst)
	Po tym ustawiamy odpowiednie koordy naszego napisu===(do tego punktu gotowe)===, zapisuje sie w bazie danych:
	x,y,z,xy,yy,zy,graffiti_id,graffti_tekst[128],graffiti_kolor = 0xFF+KOLOR

	Nast�pnie od razu te graffiti si� usuwa i tworzy od nowa poleceniem graffiti_Load(id) aby zaaplikowa� "\n" w tek�cie.
	To samo z edycj� graffiti, po edycji wszystko zapisujemy oraz usuwamy + tworzymy od nowa funkcj� load_mysql.

	Admin ma dost�p do komendy(1@lvl>) /graffiti sprawdz - wysy�a mu ID najblizszego graffiti (inRange 200-300)
	Pozniej ma dostep do /graffiti edytuj <ID_graffiti> w kt�rym otwiera sie dialog taki sam jak u gracza
	czyli: mozliwosc zmiany tekstu, koloru, edycji po�o�enia lub usuni�cia. Admin moze edytowac kazdego gracza graffiti
	Gracz moze edytowac tylko swoje, na dodatek musi byc w poblizu (tzn. inrangeofpoint <= 5)
	Admin moze edytowac na calej mapie, moze sie teleportowac /graffiti tp <id_graffiti>

	Po stworzeniu graffiti, wysy�a si� ono na @czat oraz do log�w<robota dla kogos innego, mrucznik pls>
	Edycja tekstu - logi
	Admin usuna� graffiti - @czat

	Do dodania jest tak�e rozpuszczalnik za X$ w 24/7, pozwoli to PD/mechanikom usuwa� graffiti, mechanicy dostan� np. 3-4k$ za ka�de usuni�cie,
	po usuni�ciu musz� przeczeka� payday aby usun�� nast�pne(�eby nie wyczy�cili ca�ego SC z graffiti na raz)
	
	Limit dla gracza to 3 graffiti, limit na ca�e SC - 75-100 graffiti
*/


#include <YSI\y_hooks>
#include "graffiti_dialogs.pwn"
hook OnPlayerConnect(playerid)
{
    graffiti_ZerujZmienne(playerid);
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
	for(new i; i < GRAFFITI_MAX; i++)
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
graffiti_CountGraffs(playerid)
{
	Graffiti_Amount[playerid] = 0;
	for(new i; i < GRAFFITI_MAX; i++)
	{
		if(strcmp(GraffitiInfo[i][pOwner],GetNickEx(playerid),true) == 0)
		{
			Graffiti_Amount[playerid]++;
		}
	}
}
graffiti_GetGraffitiIDs(playerid)
{
	new licznik = 0;
	graffiti_ZerujListe(playerid);
	for(new i; i < GRAFFITI_MAX; i++)
	{
		if(strcmp(GraffitiInfo[i][pOwner],GetNickEx(playerid),true) == 0)
		{
			Graffiti_PlayerList[playerid][licznik] = i;
			licznik++;
		}
	}
}
graffiti_DefineColor(GRAF_ID)
{
	new f = GRAF_ID;
	switch(GraffitiInfo[f][gColor])
	{
		case 0: GraffitiInfo[f][gColor] = GRAFFITI_CZARNY;
 
        case 1: GraffitiInfo[f][gColor] = GRAFFITI_BIALY;
 
        case 2: GraffitiInfo[f][gColor] = GRAFFITI_CZERWONY;
 
        case 3: GraffitiInfo[f][gColor] = GRAFFITI_ZIELONY;
 
        case 4: GraffitiInfo[f][gColor] = GRAFFITI_NIEBIESKI;
 
        case 5: GraffitiInfo[f][gColor] = GRAFFITI_SZARY;

		case 6: GraffitiInfo[f][gColor] = GRAFFITI_POMARANCZOWY;

		case 7: GraffitiInfo[f][gColor] = GRAFFITI_ZOLTY;

		case 8: GraffitiInfo[f][gColor] = GRAFFITI_FIOLETOWY;

		case 9: GraffitiInfo[f][gColor] = GRAFFITI_ROZOWY;
	}
}
graffiti_Zeruj(f)
{
	GraffitiInfo[f][grafXpos] = 0;
	GraffitiInfo[f][grafYpos] = 0;
	GraffitiInfo[f][grafZpos] = 0;
	GraffitiInfo[f][grafXYpos] = 0.0;
	GraffitiInfo[f][grafYYpos] = 0.0;
	GraffitiInfo[f][grafZYpos] = 0.0;
	format(GraffitiInfo[f][pOwner], MAX_PLAYER_NAME, "");
	GraffitiInfo[f][gColor] = -1;
}
graffiti_EditGraffiti(playerid, f)
{
	DestroyDynamicObject(GraffitiInfo[f][gID]);
	GraffitiInfo[f][grafText] = Graffiti_Text[playerid];
	GraffitiInfo[f][gColor] = Graffiti_Color[playerid];
	graffiti_UpdateMySQL(f, 2);
	graffiti_ReloadForPlayers(f);
	SetPVarInt(playerid, "GraffitiID", f);
	SetPVarInt(playerid, "CreatingGraff", 1);
	Log(serverLog, INFO, "Gracz %s zaaktualizowa� graffiti. Tekst:%s", GetPlayerLogName(playerid), GraffitiInfo[f][grafText]);
	EditDynamicObject(playerid, GraffitiInfo[f][gID]);
}
graffiti_CreateGraffiti(playerid)
{
	new f = graffiti_GetNewID();
	new Float:Angle;
	GetPlayerFacingAngle(playerid, Angle);
	if(f == INVALID_GRAFID) 
	{
		sendTipMessage(playerid, "Wykorzystano limit graffiti(100) na map�.");
		return 1;
	}
	SetPVarInt(playerid, "GraffitiID", f);
	SetPVarInt(playerid, "CreatingGraff", 1);
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
	graffiti_DefineColor(f);
	graffiti_ReloadForPlayers(f);
	EditDynamicObject(playerid, GraffitiInfo[f][gID]);
	return 1;
}
graffiti_ZerujListe(playerid)
{
	Graffiti_PlayerList[playerid][0] = INVALID_GRAFID;
	Graffiti_PlayerList[playerid][1] = INVALID_GRAFID;
	Graffiti_PlayerList[playerid][2] = INVALID_GRAFID;
}
graffiti_ZerujZmienne(playerid)
{
	Graffiti_Color[playerid] = -1;
	Graffiti_Text[playerid] = "";
	Graffiti_Amount[playerid] = 0;
	graffiti_ZerujListe(playerid);
	DeletePVar(playerid, "CreatingGraff");
	DeletePVar(playerid, "GraffitiID");
}

graffiti_FindNearest(playerid)
{
	for(new i; i < GRAFFITI_MAX; i++)
	{
		if(GrafExist(i))
		{
			new Float:ox, Float:oy, Float:oz;
			GetDynamicObjectPos(GraffitiInfo[i][gID], ox, oy, oz);
			if(IsPlayerInRangeOfPoint(playerid, 1.5, ox, oy, oz))
			{
				return i;
			}
		}
	}
	return INVALID_GRAFID;
}
//end
