//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wplac ]-------------------------------------------------//
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



CMD:wplac(playerid, params[])
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 1)
        {
	        if(PlayerInfo[playerid][pLocal] != 103 && !GraczBankomat(playerid))
	        {
          		sendTipMessage(playerid, "Nie jesteœ w Banku ani przy bankomacie !");
	            return 1;
	        }
			new cashdeposit, depo2 = 0;
			if( sscanf(params, "s[32]", string))
			{
				sendTipMessage(playerid, "U¿yj /wplac [kwota]");
				format(string, sizeof(string), "Masz teraz $%d na swoim koncie.", PlayerInfo[playerid][pAccount]);
				sendTipMessage(playerid, string);
                if(GraczBankomat(playerid)) {
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
			if(PlayerInfo[playerid][pAccount]+cashdeposit >=100000000)
			{
				sendTipMessage(playerid, "Maksymalnie w banku mo¿esz trzymaæ 100 milionów!"); 
				return 1;
			}
			DajKase(playerid,-cashdeposit);
            //new poprowizji = $l * (1-$p*.01);
			new curfunds = PlayerInfo[playerid][pAccount];
            if(GraczBankomat(playerid)) depo2 = floatround(((cashdeposit/100) * 6), floatround_round);
			PlayerInfo[playerid][pAccount]=(cashdeposit-depo2)+PlayerInfo[playerid][pAccount];
            if(GraczBankomat(playerid)) {
                format(string, sizeof(string), "Wp³aci³eœ $%d na swoje konto, obecny stan to: $%d ", cashdeposit-depo2,PlayerInfo[playerid][pAccount]);
                SendClientMessage(playerid, COLOR_YELLOW, string);
				format(string, sizeof(string), "[BANKOMAT] %s wp³aci³ na swoje konto %d$. Nowy stan: %d$", GetNick(playerid), cashdeposit-depo2, PlayerInfo[playerid][pAccount]);
				BankomatLog(string);
            } else {
                SendClientMessage(playerid, COLOR_WHITE, "|___ STAN KONTA ___|");
                format(string, sizeof(string), "  Poprzedni stan: $%d", curfunds);
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


