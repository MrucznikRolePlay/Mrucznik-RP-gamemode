//siedzibaMechanikow.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//----------------------------------------[ Obiekty: siedzibaMechanikow.pwn ]------------------------------------------//
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

#define SiedzibaMechanikow:: O_SMech_

#if defined EXAMPLE_SCRIPT
	#include "..\nowe\SiedzibaMechanikow\interior.pwn"
	#include "..\nowe\SiedzibaMechanikow\exterior.pwn"
#else
	#include "modules\obiekty\nowe\SiedzibaMechanikow\interior.pwn"
	#include "modules\obiekty\nowe\SiedzibaMechanikow\exterior.pwn"
#endif
	
//-----------------<[ G³ówne funkcje: ]>-------------------
siedzibaMechanikow_Init()
{
	SiedzibaMechanikow::interior_Init();
	return 1;
}

siedzibaMechanikow_Connect(playerid)
{
	#pragma unused playerid
	return 1;
}