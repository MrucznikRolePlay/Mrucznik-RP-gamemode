//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ wezpizze ]-----------------------------------------------//
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

YCMD:wezpizze(playerid, params[], help)
{
    if(PlayerInfo[playerid][Job] == JOB_PIZZA)
    {
        new veh = GetPlayerVehicleID(playerid);
        if(veh == 0) return sendTipMessage(playerid, "Musisz byæ w pojeŸdzie firmowym.");
        if(Car_GetOwnerType(veh) != CAR_OWNER_JOB || Car_GetOwner(veh) != JOB_PIZZA) return sendTipMessage(playerid, "Musisz byæ w pojeŸdzie firmowym.");
        if(!PlayerToPoint(5.0,playerid,2103.8123,-1798.7085,13.6504)) return sendTipMessage(playerid, "W tym miejscu nie mo¿esz wzi¹æ zlecenia.");
		//if(GetVehicleModel(veh) != 578) return sendErrorMessage(playerid, " Tym pojazdem nie weŸmiesz zlecenia.");

        if(PizzaJob[playerid] == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Przyj¹³eœ zlecenie! Musisz dostarczyæ pizzê pod wskazany adres!");
            SendClientMessage(playerid, COLOR_GREEN, "GPS: Na mapie wyœwietlono miejsce, do którego musisz siê udaæ!");
            SendClientMessage(playerid, COLOR_WHITE, "Pospiesz siê! Im szybciej dostarczysz pizzê, tym wiêkszy napiwek dostaniesz! Masz 2 minuty!");
			new randpizza = random(1);
			if(randpizza == 0)
			{
				Actor01 = CreateActor(235,2151.0234,-1294.7612,23.9795,180.0);
				SetPlayerCheckpoint(playerid, 2151.0444,-1298.7473,23.8281, 3.0);
				randpizza = 1;
				PizzaJob[playerid] = 1;
			}
			else if(randpizza == 1)
			{
				Actor01 = CreateActor(235,2151.0234,-1294.7612,23.9795,180.0);
				SetPlayerCheckpoint(playerid, 2151.0444,-1298.7473,23.8281, 3.0);
				randpizza = 1;
				PizzaJob[playerid] = 1;
			}
        }
        else return sendErrorMessage(playerid, "Masz ju¿ zlecenie.");
        return 1;
    }
	return 1;
}
