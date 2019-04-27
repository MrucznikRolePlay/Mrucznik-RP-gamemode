//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ innyspawn ]-----------------------------------------------//
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

CMD:spawnchange(playerid) return cmd_innyspawn(playerid);
CMD:zmianaspawnu(playerid) return cmd_innyspawn(playerid);
CMD:zmienspawn(playerid) return cmd_innyspawn(playerid);
CMD:innyspawn(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pDom] != 0)
        {
            if(PlayerInfo[playerid][pSpawn])
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Bêdziesz siê teraz spawnowa³ w normalnym miejscu !");
                PlayerInfo[playerid][pSpawn] = 0;
                if(IsAnInstructor(playerid))
	            {
	                if(SchoolSpawn[playerid] == 0)
	                {
	                    SchoolSpawn[playerid] = 1;
	                    sendTipMessageEx(playerid, COLOR_GREY, "Bêdziesz siê teraz spawnowa³ w Szkole Latania !");
	                }
	                else if(SchoolSpawn[playerid] == 1)
	                {
	                    SchoolSpawn[playerid] = 0;
	                    sendTipMessageEx(playerid, COLOR_GREY, "Bêdziesz siê teraz spawnowa³ w Szkole Jazdy !");
	                }
	            }
            }
            else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Bêdziesz siê teraz spawnowa³ w swoim/wynajmowanym domu !");
                PlayerInfo[playerid][pSpawn] = 1;
            }
        }
        else
        {
            if(IsAnInstructor(playerid))
            {
                if(SchoolSpawn[playerid] == 0)
                {
                    SchoolSpawn[playerid] = 1;
                    sendTipMessageEx(playerid, COLOR_GREY, "Bêdziesz siê teraz spawnowa³ w Szkole Latania !");
                }
                else if(SchoolSpawn[playerid] == 1)
                {
                    SchoolSpawn[playerid] = 0;
                    sendTipMessageEx(playerid, COLOR_GREY, "Bêdziesz siê teraz spawnowa³ w Szkole Jazdy !");
                }
            }
            else
            {
	            sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz/wynajmujesz domu !");
	            return 1;
            }
        }
    }
    return 1;
}


