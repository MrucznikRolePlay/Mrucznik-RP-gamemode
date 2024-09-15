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
command_dajpodatek_Impl(playerid)
{
    new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pLider] != 11)
        {
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ burmistrzem !");
			return 1;
        }
        if(Tax < 1)
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie ma pieniêdzy w funduszach !");
			return 1;
		}
		new Cops = 0;
		foreach(new i : Player)
		{
		    if(IsPlayerConnected(i))
		    {
		        if(PlayerInfo[i][pMember] == 1)
		        {
		            Cops += 1;
		        }
		    }
		}
		if(Cops >= 1)
		{
		    new valuex = Tax / 2;
		    new price = valuex / Cops;
		    foreach(new i : Player)
			{
			    if(IsPlayerConnected(i))
			    {
			        if(PlayerInfo[i][pMember] == 1)
			        {
			            format(string, sizeof(string), "* Odebra³eœ $%d z funduszu podatkowego od Burmistrza.",price);
						SendClientMessage(i, COLOR_LIGHTBLUE, string);
						DajKase(i, price);
						Tax -= price;
			        }
			    }
			}
			SaveStuff();
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "W tym momencie nie ma policjantów na serwerze!");
			return 1;
		}
	}
	return 1;
}

//end
