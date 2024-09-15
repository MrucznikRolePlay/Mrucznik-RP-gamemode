//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_opispomoc_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
	{
		SendClientMessage(playerid, COLOR_P@,"|___________ Jak u¿ywaæ komendy {CC0033}/opis{99CC00}___________|");
		SendClientMessage(playerid, COLOR_WHITE,"----> 1. Zamieszczaj tylko to czego 'nie widaæ'");
		SendClientMessage(playerid, COLOR_WHITE,"         Przyk³ad 1: {99CC00}Nosi za pasem klucz francuski.");
		SendClientMessage(playerid, COLOR_WHITE,"----> 2. NIE zamieszczaj reklam ani informacji o zawodzie czy skillu");
		SendClientMessage(playerid, COLOR_WHITE,"Opis jest czatem globalnym IC. Je¿eli bêdziesz go u¿ywa³ Ÿle mo¿esz otrzymaæ blokadê tej komendy.");
		SendClientMessage(playerid, COLOR_P@,"{99CC00}|___________ >>> Wiêcej pomocy na Mrucznik-RP.pl <<< ___________|");
	}
	return 1;
}

//end
