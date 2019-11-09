//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                   convoy                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 20.10.2019
//Opis:
/*
	System konwojów.
*/

//

//-----------------<[ Timery: ]>-------------------
task ConvoyTimer[100]()
{
	if(convoyCar != -1)
	{
		new Float:health;
		GetVehicleHealth(convoyCar, Float:health);

		//utrata hp przez pojazd konwojowy
		if(health < CONVOY_HP_DROP_LIMIT && health < convoyCarHP)
		{
			convoyCarHPAcc += convoyCarHP - health;
			convoyCarHP = health;
		}

		new Float:hp_dif = CONVOY_HP_PER_PACKAGE;
		if(convoyCarHPAcc >= hp_dif)
		{
			convoyCarHPAcc -= hp_dif;
			DropBoxFromCar(convoyCar);
		}

		//zniszczenie pojazdu konwojowego
		if(health < 350) {
			StopConvoy(CONVOY_STOP_VEHICLE_DESTROYED);
		}
	}
}

timer ConvoyDelay[10800]()
{
	convoyDelayed = false;
	foreach(new i : Player)
	{
		if(IsInAConvoyTeam(i))
		{
			SendClientMessage(i, COLOR_LFBI, "HQ: Kolejny konwój z towarem czeka na zorganizowanie.");
		}
	}
}

//end