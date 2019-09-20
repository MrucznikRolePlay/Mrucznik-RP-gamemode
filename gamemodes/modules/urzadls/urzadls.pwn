//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  urzadls                                                  //
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
// Autor: Simeone
// Data utworzenia: 20.09.2019
//Opis:
/*
	Automatyzacja Urzêdu Miasta w Los Santos - boty, skrypt botów, prawa jazdy [..] .
*/

//

//-----------------<[ Funkcje: ]>-------------------
PlayerInDmvPoint(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0215,-1792.1661,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0216,-1795.3773,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0219,-1798.5234,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0416,-1801.7599,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9628,-1791.4224,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9757,-1794.6508,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9752,-1797.7997,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9729,-1800.9788,77.9453))
	{
		return true;
	}
	return false;
}
//end