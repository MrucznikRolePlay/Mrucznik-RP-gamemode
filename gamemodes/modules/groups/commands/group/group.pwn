//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   group                                                   //
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
// Kod wygenerowany automatycznie narzêdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN¥ NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------
#include "group_impl.pwn"

//-------<[ initialize ]>-------
command_group()
{
    new command = Command_GetID("grupa");

	//aliases
	Command_AddAlt(command, "g");
    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:grupa(playerid, params[], help)
{
	new sub[32], rest[126];
	if(sscanf(params, "s[32]S()[126]", sub, rest))
	{
		ShowGroupsForPlayer(playerid);
		SendClientMessage(playerid, COLOR_GREY, "TIP: /g [info/online/v/zapros/zadania/wypros/kolor/wplac/wyplac]");
		return 1;
	}
    if(PlayerInfo[playerid][pGroup] == 0) return SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ w ¿adnej grupie.");

	return command_group_Impl(playerid, sub, rest);
}