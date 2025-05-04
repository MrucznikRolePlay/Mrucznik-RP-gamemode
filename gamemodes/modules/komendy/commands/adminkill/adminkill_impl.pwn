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
command_adminkill_Impl(playerid, params[256])
{
    new giveplayer[MAX_PLAYER_NAME];
	

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U�yj /adminkill [ID/Imie_Nazwisko]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAZasluzony(playerid) || IsAZaufanyGracz(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {		
					SetPVarInt(playerid, "skip_bw", 1);
					GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					SetPlayerHealth(playa, 0);
					Log(adminLog, INFO, "Admin %s zabi� %s komend� /adminkill", GetPlayerLogName(playerid), GetPlayerLogName(playa));

					_MruAdmin(playerid, sprintf("Zabi�e� gracza %s [%d] za pomoc� komendy", GetNick(playa), playa));
					if(playerid != playa) _MruAdmin(playa, sprintf("Zosta�e� zabity przez admina %s [%d]", GetNick(playerid), playerid));

					SendCommandLogMessage(sprintf("Admin %s [%d] da� /adminkill graczowi %s [%d]", GetNickEx(playerid), playerid, GetNick(playa), playa));
					
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

//end
