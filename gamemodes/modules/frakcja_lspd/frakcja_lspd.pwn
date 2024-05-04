//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                frakcja_lspd                                               //
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
// Data utworzenia: 07.04.2024
//Opis:
/*
	Modu³ frakcji LSPD
*/

//

//-----------------<[ Funkcje: ]>-------------------
IsAtDutyPlace(playerid)
{
	if( PlayerToPoint(3, playerid,255.3,77.4,1003.6)
            || PlayerToPoint(5, playerid, 266.7904,118.9303,1004.6172)
            || PlayerToPoint(3, playerid, 1579.6711,-1635.4512,13.5609) //STARE DUTY
            || PlayerToPoint(3, playerid, -2614.1667,2264.6279,8.2109)
            || PlayerToPoint(3, playerid, 2425.6,117.69,26.5)//nowe domy
            || PlayerToPoint(3, playerid, -1645.3046,895.2336,-45.4141)
			|| PlayerToPoint(3, playerid, 2522.8916,-2441.6270,13.6435)
            || (PlayerToPoint(4,playerid, 1562.0536,-1649.9120,28.5040) && GetPlayerVirtualWorld(playerid) == 27)) //nowe komi by charlie)//nowe komi by dywan
	{
		return 1; // duty PD	
	}

	if((GetPlayerVirtualWorld(playerid) == 2 && PlayerToPoint(3.5, playerid,592.5598,-1477.5116,82.4736)) //nowe FBI by Ubunteq
            || (GetPlayerVirtualWorld(playerid) == 2 && PlayerToPoint(5, playerid, 185.3000488281,-1571.0999755859,-54.5))//nowe domy
            || (GetPlayerVirtualWorld(playerid) == 2 && PlayerToPoint(5, playerid, 1189.5999755859,-1574.6999511719,-54.5))//nowe domy /duty w domu
            || (GetPlayerVirtualWorld(playerid) == 0 && PlayerToPoint(2, playerid, 596.5255, -1489.2544, 15.3587)))// winda fbi
	{
		return 1; // duty FBI
	}

	if(IsPlayerInRangeOfPoint(playerid, 5.0, 254.1888,77.0841,1003.6406) || IsPlayerInRangeOfPoint(playerid, 5.0, 609.0364,-555.1090,19.4573) ) //PlayerToPoint(3, playerid,255.3,77.4,1003.6) || PlayerToPoint(3,playerid,266.7904,118.9303,1004.6172) || PlayerToPoint(10.0,playerid, 2515.0200, -2459.5896, 13.8187))
	{
		return 1;
	}
	return 0;
}

//end