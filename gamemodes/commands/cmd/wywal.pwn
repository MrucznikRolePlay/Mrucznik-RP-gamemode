//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wywal ]-------------------------------------------------//
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

YCMD:wywal(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
        new State;
        if(IsPlayerInAnyVehicle(playerid))
        {
     		State=GetPlayerState(playerid);
	        if(State!=PLAYER_STATE_DRIVER)
	        {
	        	sendTipMessageEx(playerid,COLOR_GREY,"Nie mo¿esz wywalaæ ludzi kieruj¹cych pojazdem !");
	            return 1;
	        }
			new playa;
			if( sscanf(params, "k<fix>", playa))
			{
				sendTipMessage(playerid, "U¿yj /wywal [playerid/CzêœæNicku] (wywala z pojazdu)");
				return 1;
			}


			new test;
			test = GetPlayerVehicleID(playerid);
			if(IsPlayerConnected(playa))
			{
			    if(playa != INVALID_PLAYER_ID)
			    {
			        if(playa == playerid) { SendClientMessage(playerid, COLOR_GREY, "Nie mo¿esz wywaliæ samego siebie!"); return 1; }
			        if(IsPlayerInVehicle(playa,test))
			        {
						new PName[MAX_PLAYER_NAME];
						GetPlayerName(playerid,PName,sizeof(PName));
						GetPlayerName(playa, giveplayer, sizeof(giveplayer));
						format(string, sizeof(string), "* Wywali³eœ %s z pojazdu!", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Zosta³eœ wywalony z pojazdu przez %s !", PName);
						SendClientMessage(playa, COLOR_LIGHTBLUE, string);
						RemovePlayerFromVehicleEx(playa);
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest w twoim wozie !");
					    return 1;
					}
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie ma takiego gracza!");
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Musisz byæ w wozie aby tego u¿ywaæ !");
		}
	}
	return 1;
}
