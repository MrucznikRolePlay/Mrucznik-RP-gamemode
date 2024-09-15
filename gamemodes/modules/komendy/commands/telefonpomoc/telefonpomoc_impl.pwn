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
command_telefonpomoc_Impl(playerid, params[256])
{
    SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	if (PlayerInfo[playerid][pPnumber] > 0)
	{
		SendClientMessage(playerid, COLOR_WHITE,"*** POMOC *** wpisz komende aby uzyskaæ wiêcej pomocy");
		SendClientMessage(playerid, COLOR_GRAD3,"*** TELEFON *** /dzwon | na policje:'/dzwon 911' | /sms /resms (/od)bierz (/z)akoncz /numer /wizytowka /kontakty");
		SendClientMessage(playerid, COLOR_GRAD6,"*** INNE *** /pomoc /dompomoc /wynajempomoc /bizpomoc /liderpomoc /rybypomoc /ircpomoc");
	}
	else
	{
		sendTipMessageEx(playerid, COLOR_WHITE,"Mo¿esz kupiæ telefon w 24/7");
	}
	return 1;
}

//end
