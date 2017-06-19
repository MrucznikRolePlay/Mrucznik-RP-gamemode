//nowe_obiekty.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//--------------------------------------[ Obiekty: nowe_obiekty.pwn ]----------------------------------------//
//Opis:
/*
	Plik zawieraj¹cy do³¹czenia wszystkich obiektów w nowym formacie
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

//TODO: USUN¥Æ TO	
#define SetDynamicObjectMaterialText_Kolejnosc(%0,%1,%2,%3,%4,%5,%6,%7,%8,%9) SetDynamicObjectMaterialText(%0,%2,%1,%3,%4,%5,%6,%7,%8,%9)

//-----------------<[ Include: ]>-------------------
#if defined EXAMPLE_SCRIPT
	#include "..\nowe\CentralBank\centralBank.pwn"
	#include "..\nowe\SiedzibaMechanikow\siedzibaMechanikow.pwn"
	#include "..\nowe\Bluberry\RadaMiasta\radaMiasta.pwn"
	#include "..\nowe\CassinoAutoService\cassinoAutoService.pwn"
	#include "..\nowe\Dillimore\BarierkiDillimore\barierkiDillimore.pwn"
	#include "..\nowe\DMV\DMV.pwn"
	#include "..\nowe\FBI\FBI.pwn"
	#include "..\nowe\GSA\centralaGSA.pwn" //TODO: Rozdziel
	#include "..\nowe\Globalne\ObiektyCiekawostki\obiektyCiekawostki.pwn"
	#include "..\nowe\Globalne\PoprawkiRockstar\poprawkiRockstar.pwn" 
	#include "..\nowe\NG\bazaNG.pwn" //TODO: Rozdziel
	#include "..\nowe\GlobalneLS\Pomnik\pomnik.pwn"
	#include "..\nowe\GlobalneLS\SkracaneZakrety\skracaneZakrety.pwn"
	#include "..\nowe\GlobalneLS\ZnakiUpiekszenia\znakiUpiekszenia.pwn"
	#include "..\nowe\CentrumRozrywkiLS\centrumRozrywkiLS.pwn"
	#include "..\nowe\GunShop\gunShop.pwn"
	#include "..\nowe\ParkingObokSzpitala\parkingObokSzpitala.pwn"
	#include "..\nowe\MountChiliad\mountChiliad.pwn"
	#include "..\nowe\MoneyMakers\moneyMakers.pwn"
	#include "..\nowe\LowFolow\lowFolow.pwn"
	#include "..\nowe\KomisariatLS\komisariatLS.pwn"
#else //Mrucznik-RP gamemode
	#include "modules\obiekty\nowe\CentralBank\centralBank.pwn"
	#include "modules\obiekty\nowe\SiedzibaMechanikow\siedzibaMechanikow.pwn"
	#include "modules\obiekty\nowe\Bluberry\RadaMiasta\radaMiasta.pwn"
	#include "modules\obiekty\nowe\CassinoAutoService\cassinoAutoService.pwn"
	#include "modules\obiekty\nowe\Dillimore\BarierkiDillimore\barierkiDillimore.pwn"
	#include "modules\obiekty\nowe\DMV\DMV.pwn"
	#include "modules\obiekty\nowe\FBI\FBI.pwn"
	#include "modules\obiekty\nowe\GSA\centralaGSA.pwn" //TODO: Rozdziel
	#include "modules\obiekty\nowe\Globalne\ObiektyCiekawostki\obiektyCiekawostki.pwn"
	#include "modules\obiekty\nowe\Globalne\PoprawkiRockstar\poprawkiRockstar.pwn"
	#include "modules\obiekty\nowe\NG\bazaNG.pwn"  //TODO: Rozdziel
	#include "modules\obiekty\nowe\GlobalneLS\Pomnik\pomnik.pwn" 
	#include "modules\obiekty\nowe\GlobalneLS\SkracaneZakrety\skracaneZakrety.pwn" 
	#include "modules\obiekty\nowe\GlobalneLS\ZnakiUpiekszenia\znakiUpiekszenia.pwn" 
	#include "modules\obiekty\nowe\CentrumRozrywkiLS\centrumRozrywkiLS.pwn" 
	#include "modules\obiekty\nowe\GunShop\gunShop.pwn" 
	#include "modules\obiekty\nowe\ParkingObokSzpitala\parkingObokSzpitala.pwn" 
	#include "modules\obiekty\nowe\MountChiliad\mountChiliad.pwn" 
	#include "modules\obiekty\nowe\MoneyMakers\moneyMakers.pwn" 
	#include "modules\obiekty\nowe\LowFolow\lowFolow.pwn" 
	#include "modules\obiekty\nowe\KomisariatLS\komisariatLS.pwn" 
#endif

//-----------------<[ Funkcje: ]>-------------------
obiekty_OnGameModeInit()
{
	//exampleObjects_Init();
	//template_Init();
	
	centralBank_Init();
	siedzibaMechanikow_Init();
	radaMiasta_Init();
	cassinoAutoService_Init();
	barierkiDillimore_Init();
	DMV_Init();
	FBI_Init();
	centralaGSA_Init();
	obiektyCiekawostki_Init();
	poprawkiRockstar_Init();
	bazaNG_Init();
	pomnik_Init();
	skracaneZakrety_Init();
	znakiUpiekszenia_Init();
	centrumRozrywkiLS_Init();
	gunShop_Init();
	parkingObokSzpitala_Init();
	mountChiliad_Init();
	moneyMakers_Init();
	lowFolow_Init();
	komisariatLS_Init();
	centralBank_Init();
	return 1;
}

obiekty_OnPlayerConnect(playerid)
{
	//exampleObjects_Connect(playerid);
	//template_Connect(playerid);
	
	centralBank_Connect(playerid);
	siedzibaMechanikow_Connect(playerid);
	radaMiasta_Connect(playerid);
	DMV_Connect(playerid);
	centralaGSA_Connect(playerid);
	bazaNG_Connect(playerid);
	pomnik_Connect(playerid);
	skracaneZakrety_Connect(playerid);
	znakiUpiekszenia_Connect(playerid);
	mountChiliad_Connect(playerid);
	komisariatLS_Connect(playerid);
	parkingObokSzpitala_Connect(playerid);
	
	return 1;
}