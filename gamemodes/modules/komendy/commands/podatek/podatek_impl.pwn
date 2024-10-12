//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_podatek_Impl(playerid, params[256])
{
    new string[64];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pLider] != 11)
        {
			SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ burmistrzem!");
			return 1;
        }
        new moneys;
        if( sscanf(params, "d", moneys))
		{
			sendTipMessage(playerid, "U¿yj /podatek [iloœæ]");
			return 1;
		}

		if(moneys < 1 || moneys > 5000) { SendClientMessage(playerid, COLOR_GREY, "   Kwota podatku od 1 do 5000 !"); return 1; }
		Tax = moneys;
		SaveStuff();
		format(string, sizeof(string), "* Podatek to teraz $%d na gracza.", Tax);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    }
    return 1;
}

//end
