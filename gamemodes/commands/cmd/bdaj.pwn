//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ bdaj ]-------------------------------------------------//
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

CMD:bdaj(playerid, params[])
{
    if(IsAHeadAdmin(playerid))
	{
	    new giveplayerid, level;
		if( sscanf(params, "k<fix>d", giveplayerid, level))
		{
			sendTipMessage(playerid, "U¿yj /bdaj [id gracza] [id broni] [naboje]");
			return 1;
		}

		if(PlayerInfo[playerid][pLevel] >= 1)
		{
		    SetPlayerArmedWeapon(giveplayerid, level);
		}
	}
	return 1;
}



/*CMD:starttimer(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 5000)
    {
        new level;
		if( sscanf(params, "d", level))
		{
			SendClientMessage(playerid, COLOR_WHITE, "/starttimer [id timera]");
			return 1;
		}


		if(level == 1)
		{
        	jednasek = SetTimer("JednaSekundaTimer", 1000, true);//1 sekunda timer
        	SendClientMessage(playerid, COLOR_PANICRED, "Timer \" JednaSekundaTimer \" w³¹czony!");
        }
        else if(level == 2)
        {
            synctimer = SetTimer("SyncUp", 60000, 1);//1min
            SendClientMessage(playerid, COLOR_PANICRED, "Timer \" SyncUp 1min \" w³¹czony!");
        }
		else if(level == 3)
        {
            unjailtimer = SetTimer("SetPlayerUnjail", 1000, 1);//1sek
            SendClientMessage(playerid, COLOR_PANICRED, "Timer \" SetPlayerUnjail 1sek \" w³¹czony!");
        }
		else if(level == 4)
        {
            //othtimer = SetTimer("OtherTimer", 1000, 1);//1sek
            //SendClientMessage(playerid, COLOR_PANICRED, "Timer \" OtherTimer 1sek \" w³¹czony!");
        }
		else if(level == 5)
        {
            cartimer = SetTimer("CarCheck", 30000, 1);//30sek
            SendClientMessage(playerid, COLOR_PANICRED, "Timer \" CarCheck 30sek \" w³¹czony!");
        }
		else if(level == 6)
        {
            pickuptimer = SetTimer("CustomPickups", 2000, 1);//2sek
            SendClientMessage(playerid, COLOR_PANICRED, "Timer \" CustomPickups 2sek \" w³¹czony!");
        }
		else if(level == 7)
        {
            spectatetimer = SetTimer("Spectator", 2000, 1);//2sek
            SendClientMessage(playerid, COLOR_PANICRED, "Timer \" Spectator 2sek \" w³¹czony!");
        }
		else if(level == 8)
        {
            idletimer = SetTimer("IdleKick", idletime, 1);//ildetime sek
            SendClientMessage(playerid, COLOR_PANICRED, "Timer \" IdleKick 10min \" w³¹czony!");
        }
        else if(level == 9)
        {
            productiontimer = SetTimer("Production", 300000, 1); //5 mins (300 000)
            SendClientMessage(playerid, COLOR_PANICRED, "Timer \" Production 5min \" w³¹czony!");
        }
		else if(level == 10)
        {
            accountstimer = SetTimer("SaveAccounts", 1800000, 1); //30 mins every account saved
            SendClientMessage(playerid, COLOR_PANICRED, "Timer \" SaveAccounts 30min \" w³¹czony!");
        }
		else if(level == 11)
        {
            checkgastimer = SetTimer("CheckGas", RunOutTime, 1);//RunOutTime sek
            SendClientMessage(playerid, COLOR_PANICRED, "Timer \" CheckGas 15sek \" w³¹czony!");
        }
		else if(level == 12)
        {
            stoppedvehtimer = SetTimer("StoppedVehicle", RunOutTime, 1);//RunOutTime sek
            SendClientMessage(playerid, COLOR_PANICRED, "Timer \" StoppedVehicle 15sek \" w³¹czony!");
        }
		else
		{
		    SendClientMessage(playerid, COLOR_PANICRED, "Timer od 1 do 12!");
		}
    }
	return 1;
}*/

/*CMD:startalltimer(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 5000)
    {
        jednasek = SetTimer("JednaSekundaTimer", 1000, true);//1 sekunda timer
		synctimer = SetTimer("SyncUp", 60000, 1);//1min
		unjailtimer = SetTimer("SetPlayerUnjail", 1000, 1);//1sek
		//othtimer = SetTimer("OtherTimer", 1000, 1);//1sek
		cartimer = SetTimer("CarCheck", 30000, 1);//30sek
		pickuptimer = SetTimer("CustomPickups", 2000, 1);//1sek
		spectatetimer = SetTimer("Spectator", 2000, 1);//2sek
		idletimer = SetTimer("IdleKick", idletime, 1);//ildetime sek
		productiontimer = SetTimer("Production", 300000, 1); //5 mins (300 000)
		accountstimer = SetTimer("SaveAccounts", 1800000, 1); //30 mins every account saved
		checkgastimer = SetTimer("CheckGas", RunOutTime, 1);//RunOutTime sek
	    //stoppedvehtimer = SetTimer("StoppedVehicle", RunOutTime, 1);//RunOutTime sek
	    SendClientMessage(playerid, COLOR_PANICRED, "Wszystkie timery w³¹czone!");
    }
	return 1;
}

