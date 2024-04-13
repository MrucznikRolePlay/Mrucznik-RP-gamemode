//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                  vicecity                                                 //
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
// Autor: Roger Costa '[Ds]NikO', edited by mrucznik
// Data utworzenia: 13.04.2024
//Opis:
/*
	Vice City
*/

//

//-----------------<[ Timery: ]>-------------------
ViceCity_JednaSekundaTimer()
{
	foreach(new i : Player) 
	{
		if(IsPlayerConnected(i)) 
		{
	        if(ViewingMap[i]) 
			{
                new Float:pos[3], Float:screen_pos[2];

				GetPlayerPos(i, pos[0], pos[1], pos[2]);
                GetXYForScreenMap(pos[0], pos[1], screen_pos[0], screen_pos[1]);
                PlayerTextDrawHide(i, screenArrow[i]);
                PlayerTextDrawDestroy(i, screenArrow[i]);
                screenArrow[i] = CreatePlayerTextDraw(i, screen_pos[0]-10.0, screen_pos[1], "hud:arrow");
                PlayerTextDrawFont(i, screenArrow[i], 4);
                PlayerTextDrawLetterSize(i, screenArrow[i], 0.500000, 1.000000);
                PlayerTextDrawSetProportional(i, screenArrow[i], 1);
                PlayerTextDrawUseBox(i, screenArrow[i], 1);
                PlayerTextDrawTextSize(i, screenArrow[i], 10.000000, 10.000000);
                PlayerTextDrawShow(i, screenArrow[i]);
	        }
		}
	}
}

//end