//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   pomoc                                                   //
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
//Opis:
/*
	Tutoriale oraz pomoce dla gracza.
*/

//

//-----------------<[ Funkcje: ]>-------------------
ShowHelpCommands(playerid, color, command[])
{
	new string[MAX_MESSAGE_LENGTH];
	new commandWithSpace[64];
	format(commandWithSpace, sizeof(commandWithSpace), "%s ", command);
	format(string, sizeof(string), " *** POMOC *** /autopomoc /bizpomoc /dompomoc /ircpomoc /liderpomoc /opispomoc /rybypomoc /telefonpomoc ");
	strreplace(string, commandWithSpace, "");
	SendClientMessage(playerid, color, string);

    format(string, sizeof(string), " *** POMOC *** /orgpomoc /pracapomoc /vopispomoc /wynajempomoc /samppomoc ");
	strreplace(string, commandWithSpace, "");
	SendClientMessage(playerid, color, string);
}

//end