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

//Opis:
/*
	Plik do³¹czaj¹cy obiekty z folderów do mapy
*/

#define SetDynamicObjectMaterialText_Kolejnosc(%0,%1,%2,%3,%4,%5,%6,%7,%8,%9) SetDynamicObjectMaterialText(%0,%2,%1,%3,%4,%5,%6,%7,%8,%9)
#define ObiektyCiekawostki:: O_OCi_
#define PodziemnyParkingFBI:: O_PFBI_
#define SiedzibaMechanikow:: O_SMech_
#define SkracaneZakrety:: O_SkrZ_
#define PomnikLS:: O_PomLS_
#define OPDillimore:: O_DilOP_
#define OPBlueberry:: O_BluOP_
#define ObiektyPrzedDMV:: O_DMVOP_
#define CentralaGSA:: O_CGSA_
#define BazaNG:: BazaNG_
#define PoprawkiRockstar:: O_PRs_

#include "modules\Obiekty\nowe\2.5.7\BazaNG.pwn"
#include "modules\Obiekty\nowe\2.5.7\CentralaGSA.pwn"
#include "modules\Obiekty\nowe\2.5.7\ObiektyCiekawostki.pwn"
#include "modules\Obiekty\nowe\2.5.7\ObiektyPrzedDMV.pwn"
#include "modules\Obiekty\nowe\2.5.7\OPBlueberry.pwn"
#include "modules\Obiekty\nowe\2.5.7\OPDillimore.pwn"
#include "modules\Obiekty\nowe\2.5.7\PodziemnyParkingFBI.pwn"
#include "modules\Obiekty\nowe\2.5.7\PomnikLS.pwn"
#include "modules\Obiekty\nowe\2.5.7\PoprawkiRockstar.pwn"
#include "modules\Obiekty\nowe\2.5.7\SiedzibaMechanikow.pwn"
#include "modules\Obiekty\nowe\2.5.7\SkracaneZakrety.pwn"


Obiekty257_LoadObjects()
{
	BazaNG::LoadObjects();
	CentralaGSA::LoadObjects();
	ObiektyCiekawostki::LoadObjects();
	ObiektyPrzedDMV::LoadObjects();
	OPBlueberry::LoadObjects();
	OPDillimore::LoadObjects();
	PodziemnyParkingFBI::LoadObjects();
	PomnikLS::LoadObjects();
	PoprawkiRockstar::LoadObjects();
	SiedzibaMechanikow::LoadObjects();
	SkracaneZakrety::LoadObjects();
	return 1;
}

Obiekty257_Load3DTexts()
{
	BazaNG::Load3DTexts();
	CentralaGSA::Load3DTexts();
	return 1;
}

Obiekty257_RemoveBuildings(playerid)
{
	BazaNG::RemoveBuildings(playerid);
	CentralaGSA::RemoveBuildings(playerid);
	ObiektyPrzedDMV::RemoveBuildings(playerid);
	OPBlueberry::RemoveBuildings(playerid);
	PomnikLS::RemoveBuildings(playerid);
	SkracaneZakrety::RemoveBuildings(playerid);
	return 1;
}

Obiekty257_LoadDoors()
{
	CentralaGSA::LoadDoors();
	OPBlueberry::LoadDoors();
	SiedzibaMechanikow::LoadDoors();
	return 1;
}

Obiekty257_LoadGates()
{
	BazaNG::LoadGates();
	return 1;
}