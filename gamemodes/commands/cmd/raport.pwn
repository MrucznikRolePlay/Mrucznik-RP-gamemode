//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ raport ]------------------------------------------------//
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

YCMD:raport(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 1)
        {
            if(GetPVarInt(playerid, "wyreportowany") > 1)
            {
                sendTipMessageFormat(playerid, "Odczekaj %d sekund", GetPVarInt(playerid, "wyreportowany"));
                return 1;
            }
	        GetPlayerName(playerid, sendername, sizeof(sendername));
			if(isnull(params))
			{
                SendClientMessage(playerid, 0x008000AA,"** Komenda {ADFF2F}/report{FFFFFF} s³u¿y tylko i wy³¹cznie do zg³aszania spraw dla Administracji... **");
                SendClientMessage(playerid, 0x008000AA,"** ...korzystamy z niego wtedy gdy dany gracz ³amie regulamin serwera (LKiZ) **");
                SendClientMessage(playerid, 0x008000AA,"** Forma poprawnego zg³oszenia: {ADFF2F}/report 0 DM LUB /report 0 Cheater{FFFFFF} **");
				return 1;
			}
            SetPVarInt(playerid, "wyreportowany", 15);
            if(strfind(params, "@here", true) != -1 || strfind(params, "@everyone", true) != -1 || strfind(params, "<@", true) != -1) {
                SendClientMessage(playerid, COLOR_LIGHTRED, "Twój report nie zosta³ wys³any do administracji!");
                SendClientMessage(playerid, COLOR_GRAD2, "Zawiera on niedozwolone znaki z symbolem @");
                SendClientMessage(playerid, COLOR_GRAD2, "Popraw swój raport i napisz go ponownie za 15 sekund.");
                return 1;
            }
            SendClientMessage(playerid, 0x008000AA, "Twój report zosta³ wys³any do administracji, oczekuj na reakcjê zanim napiszesz kolejny!");//By: Dawid
            SendClientMessage(playerid, COLOR_GRAD2, "Je¿eli Administracja nie reaguje na Twój report, oznacza to, ¿e...");//By: Dawid
            SendClientMessage(playerid, COLOR_GRAD2, "...jest on Ÿle sformu³owany i Administracja nie rozpatrzy tego zg³oszenia.");//By: Dawid
			//AntySpam[playerid] = 1;
			//SetTimerEx("AntySpamTimer",15000,0,"d",playerid);
            format(string, sizeof(string), "» Report od %s [%d]: {FFFFFF}%s", sendername, playerid, params);
			SendMessageToAdminEx(string, COLOR_YELLOW, 1);
			format(string, sizeof(string), "? Report od %s [%d]: %s", sendername, playerid, params);
			SendDiscordMessage(DISCORD_REPORT, string);
            
		}
    }
    return 1;
}
