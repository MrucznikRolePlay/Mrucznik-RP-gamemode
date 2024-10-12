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
command_wplac_Impl(playerid, params[256])
{
    new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 1)
        {
	        if(!IsAtBank(playerid) && !IsAtBankomat(playerid))
	        {
          		sendTipMessage(playerid, "Nie jesteœ w Banku ani przy bankomacie !");
	            return 1;
	        }
			new cashdeposit, bankomat_fee = 0;
			if( sscanf(params, "s[32]", string))
			{
				sendTipMessage(playerid, "U¿yj /wplac [kwota]");
				format(string, sizeof(string), "Masz teraz $%d na swoim koncie.", PlayerInfo[playerid][pAccount]);
				sendTipMessage(playerid, string);
                if(IsAtBankomat(playerid)) {
                    sendTipMessage(playerid, "UWAGA! Przy wp³atach przez bankomat prowizja to 6 procent!", COLOR_LIGHTBLUE);
                }
				return 1;
			}

			cashdeposit = FunkcjaK(string);

			if (cashdeposit > kaska[playerid] || cashdeposit < 1)
			{
				sendTipMessage(playerid, "Nie masz tyle");
				return 1;
			}

			if(PlayerInfo[playerid][pAccount] + cashdeposit >=100000000)
			{
				sendTipMessage(playerid, "Maksymalnie w banku mo¿esz trzymaæ 100 milionów!"); 
				return 1;
			}

			if(IsAtBankomat(playerid)) {
				bankomat_fee = floatround(((cashdeposit/100) * 6), floatround_round);
			}

			new oldaccount = PlayerInfo[playerid][pAccount];
			ZabierzKase(playerid, cashdeposit);
            PlayerInfo[playerid][pAccount] += (cashdeposit - bankomat_fee);

			Log(payLog, INFO, "%s wp³aci³ na swoje konto %d$. Koszt wp³aty %d, nowy stan %d$.", GetPlayerLogName(playerid), cashdeposit-bankomat_fee, bankomat_fee, PlayerInfo[playerid][pAccount]);

            if(IsAtBankomat(playerid)) {
                format(string, sizeof(string), "Wp³aci³eœ $%d na swoje konto (prowizja %d), obecny stan to: $%d ", cashdeposit-bankomat_fee, bankomat_fee, PlayerInfo[playerid][pAccount]);
                SendClientMessage(playerid, COLOR_YELLOW, string);
            } else {
                SendClientMessage(playerid, COLOR_WHITE, "|___ STAN KONTA ___|");
                format(string, sizeof(string), "  Poprzedni stan: $%d", oldaccount);
                SendClientMessage(playerid, COLOR_GRAD2, string);
                format(string, sizeof(string), "  Depozyt: $%d", cashdeposit);
                SendClientMessage(playerid, COLOR_GRAD4, string);
                SendClientMessage(playerid, COLOR_GRAD6, "|-----------------------------------------|");
                format(string, sizeof(string), "  Nowy stan: $%d", PlayerInfo[playerid][pAccount]);
                SendClientMessage(playerid, COLOR_WHITE, string);
            }
			return 1;
		}
	}
	return 1;
}

//end
