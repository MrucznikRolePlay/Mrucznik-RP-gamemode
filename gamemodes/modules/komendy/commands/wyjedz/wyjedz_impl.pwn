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
command_wyjedz_Impl(playerid, params[256])
{
    if(GetPVarInt(playerid, "Lockdown-izolacja") != 0) return sendTipMessageEx(playerid, COLOR_PANICRED, "Nie mo¿esz u¿ywaæ tej komendy w trakcie weryfikacji.");
	if(GetPVarInt(playerid, "JestPodczasWjezdzania") == 1)
	{
		sendTipMessage(playerid, "Jesteœ podczas wje¿d¿ania!"); 
		return 1;
	}
	if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
	{
		sendErrorMessage(playerid, "Jesteœ podczas wsiadania - odczekaj chwile."); 
		return 1;
	}	
	SetAntyCheatForPlayer(playerid, 4); 
	if(SprawdzWjazdy(playerid))
	{
	
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ w obszarze, w którym mo¿na wjechaæ"); 
	}
	return 1;
}

//end
