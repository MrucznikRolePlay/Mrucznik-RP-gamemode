//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  ircpomoc                                                 //
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
// Data utworzenia: 17.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_ircpomoc_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "_______________________IRC POMOC_______________________");
    SendClientMessage(playerid, COLOR_WHITE, "*** Wpisz komendê, aby uzyskaæ wiêcej pomocy.");
    SendClientMessage(playerid, COLOR_WHITE, "** IRC ** (/irc join [nrkana³u] or /irc join [nrkana³u] [password]) (/irc leave)");
    SendClientMessage(playerid, COLOR_WHITE, "** IRC ** (/irc Password [nrkana³u])  (/irc NeedPass [nrkana³u])  (/irc Lock [nrkana³u])");
    SendClientMessage(playerid, COLOR_WHITE, "** IRC ** (/irc Admins)  (/irc MOTD [motdtext]) (/irc status [nrkana³u]) (/i [text])");
    ShowHelpCommands(playerid, COLOR_WHITE, "/ircpomoc");
    SendClientMessage(playerid, COLOR_GREEN, "_______________________________________________________");
    return 1;
}

//end