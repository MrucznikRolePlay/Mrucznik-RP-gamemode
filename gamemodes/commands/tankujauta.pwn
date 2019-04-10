//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ tankujauta ]----------------------------------------------//
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

CMD:fuelcars(playerid) return cmd_tankujauta(playerid);
CMD:tankujauta(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 35)
        {
            for(new c=0;c<CAR_AMOUNT;c++)
			{
				Gas[c] = GasMax;
			}
			
			new string[64];
			format(string, sizeof(string), "AdmCmd: %s zatankowa³ wszystkie pojazdy.", GetNick(playerid));
			SendPunishMessage(string, playerid);
			KickLog(string);
			SendClientMessage(playerid, COLOR_GREY, "Wszystkie pojazdy zatankowane ! ");
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
        }
        else
        {
            noAccessMessage(playerid);
            return 1;
        }
    }
    return 1;
}
