//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ telefonpomoc ]---------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:telefonpomoc(playerid, params[], help)
{
	SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	if (PlayerInfo[playerid][pPnumber] > 0)
	{
		SendClientMessage(playerid, COLOR_WHITE,"*** POMOC *** wpisz komende aby uzyskaæ wiêcej pomocy");
		SendClientMessage(playerid, COLOR_GRAD3,"*** TELEFON *** /dzwon | na policje:'/dzwon 911' | /sms /resms (/p)odnies (/z)akoncz /numer /wizytowka /kontakty");
		SendClientMessage(playerid, COLOR_GRAD6,"*** INNE *** /pomoc /dompomoc /wynajempomoc /bizpomoc /liderpomoc /rybypomoc /ircpomoc");
	}
	else
	{
		sendTipMessageEx(playerid, COLOR_WHITE,"Mo¿esz kupiæ telefon w 24/7");
	}
	return 1;
}
