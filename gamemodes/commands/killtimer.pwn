//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ killtimer ]-----------------------------------------------//
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

CMD:killtimer(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 5000)
    {
        new level;
		if( sscanf(params, "d", level))
		{
			SendClientMessage(playerid, COLOR_WHITE, "/killtimer [id timera]");
			return 1;
		}


		if(level == 1)
		{
		    KillTimer(jednasek);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" JednaSekundaTimer 1sek \" OFF!");
        }
        else if(level == 2)
        {
            KillTimer(synctimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" SyncUp 1min \" OFF!");
        }
		else if(level == 3)
        {
            KillTimer(unjailtimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" SetPlayerUnjail 1sek \" OFF!");
        }
		else if(level == 4)
        {
            KillTimer(othtimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" OtherTimer 1sek \" OFF!");
        }
		else if(level == 5)
		{
		    KillTimer(cartimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" CarCheck 30sek \" OFF!");
        }
		else if(level == 6)
        {
            KillTimer(pickuptimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" CustomPickups 2sek \" OFF!");
        }
		else if(level == 7)
        {
            KillTimer(spectatetimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" Spectator 2sek \" OFF!");
        }
		else if(level == 8)
        {
            KillTimer(idletimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" IdleKick 10min \" OFF!");
        }
        else if(level == 9)
        {
            KillTimer(productiontimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" Production 5min \" OFF!");
        }
		else if(level == 10)
        {
            KillTimer(accountstimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" SaveAccounts 30min \" OFF!");
        }
		else if(level == 11)
        {
            KillTimer(checkgastimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" CheckGas 15sek \" OFF!");
        }
		else if(level == 12)
        {
            KillTimer(stoppedvehtimer);
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer \" StoppedVehicle 15sek \" OFF!");
        }
		else
		{
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer od 1 do 12!");
		}
    }
	return 1;
}

