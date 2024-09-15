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
command_ircpomoc_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
    SendClientMessage(playerid, COLOR_WHITE,"*** IRC POMOC *** wpisz komende aby uzyskaæ wiêcej pomocy");
    SendClientMessage(playerid, COLOR_WHITE,"*** IRC *** (/irc join [nrkana³u] or /irc join [nrkana³u] [password])  (/irc leave)");
    SendClientMessage(playerid, COLOR_WHITE,"*** IRC *** (/irc Password [nrkana³u])  (/irc NeedPass [nrkana³u])  (/irc Lock [nrkana³u])");
    SendClientMessage(playerid, COLOR_WHITE,"*** IRC *** (/irc Admins)  (/irc MOTD [motdtext])  (/irc status [nrkana³u])  (/i [text])");
    return 1;
}

//end
