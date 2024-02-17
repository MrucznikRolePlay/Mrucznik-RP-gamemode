//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ poddajesie ]----------------------------------------------//
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

YCMD:poddajesie(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(poddaje[playerid] == 1)
        {
            if(PoziomPoszukiwania[playerid] >= 2)
            {
	            GetPlayerName(playerid, sendername, sizeof(sendername));
  				GetPlayerName(lowcap[playerid], giveplayer, sizeof(giveplayer));
		        format(string, sizeof(string), "* Podda³eœ siê £owcy Nagród %s idziesz do celi i tracisz %d, kaucja: %d$",giveplayer, PoziomPoszukiwania[playerid]*100, PoziomPoszukiwania[lowcap[playerid]]*16000);
		        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		        ZabierzKase(playerid, PoziomPoszukiwania[playerid]*100);
				PlayerInfo[playerid][pJailed] = 1;
			    PlayerInfo[playerid][pJailTime] = (PoziomPoszukiwania[playerid])*(200);
			    new lowcak = PoziomPoszukiwania[playerid] * 2500;
				SetPlayerVirtualWorld(playerid, 29);
				JailPrice[playerid] = PoziomPoszukiwania[lowcap[playerid]]*16000;
				WantLawyer[playerid] = 1;
				new losuj= random(sizeof(Cela));
				SetPlayerPos(playerid, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
				TogglePlayerControllable(playerid, 0);
                Wchodzenie(playerid);
				format(string, sizeof(string), "* %s podda³ siê, dostajesz %d nagrody za z³apanie ¿ywego przestêpcy",sendername, lowcak);
		        SendClientMessage(lowcap[playerid], COLOR_LIGHTBLUE, string);
		        SendClientMessage(lowcap[playerid], COLOR_GRAD3, "Skill + 4");
                PoziomPoszukiwania[playerid] = 0;
				SetPlayerWantedLevel(playerid, 0);
		        PlayerInfo[lowcap[playerid]][pDetSkill]+=4;
		        DajKase(lowcap[playerid], lowcak);
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
