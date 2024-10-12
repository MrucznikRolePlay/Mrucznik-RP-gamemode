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
command_poddajesie_Impl(playerid)
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

	new reward = PoziomPoszukiwania[playerid] * 10000;
	new punishment = PoziomPoszukiwania[playerid] * 1000;
	new bail = PoziomPoszukiwania[playerid] * 16000;

    if(IsPlayerConnected(playerid))
    {
        if(poddaje[playerid] == 1)
        {
            if(PoziomPoszukiwania[playerid] >= 2)
            {
	            GetPlayerName(playerid, sendername, sizeof(sendername));
  				GetPlayerName(lowcap[playerid], giveplayer, sizeof(giveplayer));
		        format(string, sizeof(string), "* Podda³eœ siê £owcy Nagród %s idziesz do celi i tracisz %d, kaucja: %d$",giveplayer, punishment, bail);
		        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		        ZabierzKase(playerid, punishment);
				PlayerInfo[playerid][pJailed] = 1;
			    PlayerInfo[playerid][pJailTime] = (PoziomPoszukiwania[playerid])*(200);
				JailPrice[playerid] = bail;
				WantLawyer[playerid] = 1;
				TogglePlayerControllable(playerid, 0);
				SetPlayerArrestPos(playerid);
				format(string, sizeof(string), "* %s podda³ siê, dostajesz %d nagrody za z³apanie ¿ywego przestêpcy",sendername, reward);
		        SendClientMessage(lowcap[playerid], COLOR_LIGHTBLUE, string);
		        SendClientMessage(lowcap[playerid], COLOR_GRAD3, "Skill + 4");
                PoziomPoszukiwania[playerid] = 0;
				SetPlayerWantedLevel(playerid, 0);
		        PlayerInfo[lowcap[playerid]][pDetSkill]+=4;
		        DajKase(lowcap[playerid], reward);
				poddaje[playerid] = 0;
				lowcap[playerid] = 0;
			}
			else
			{
				sendTipMessage(playerid, "Nie jesteœ poszukiwany - nie mo¿esz siê poddaæ!", COLOR_LIGHTBLUE);
			}
		}
	}
	return 1;
}

//end
