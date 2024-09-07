//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wyplac ]------------------------------------------------//
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

YCMD:wyplac(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(IsAtBank(playerid) || IsAtBankomat(playerid))
        {
			new cashdeposit;
			if( sscanf(params, "s[32]", string))
			{
				sendTipMessage(playerid, "U¿yj /wyplac [kwota]");
				format(string, sizeof(string), "Masz teraz $%d na swoim koncie.", PlayerInfo[playerid][pAccount]);
				sendTipMessage(playerid, string);
				return 1;
			}
			cashdeposit = FunkcjaK(string);

			if (cashdeposit > PlayerInfo[playerid][pAccount] || cashdeposit < 1)
			{
				sendTipMessage(playerid, "Nie masz tyle !");
				return 1;
			}
			DajKase(playerid,cashdeposit);
			PlayerInfo[playerid][pAccount]=PlayerInfo[playerid][pAccount]-cashdeposit;
			format(string, sizeof(string), "Wyp³aci³eœ $%d ze swojego konta, obecny stan to: $%d ", cashdeposit,PlayerInfo[playerid][pAccount]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
			Log(payLog, INFO, "%s wyp³aci³ ze swojego konta %d$. Nowu stan: %d$", GetPlayerLogName(playerid), cashdeposit, PlayerInfo[playerid][pAccount]);
			return 1;
		}
		else
		{
			sendTipMessage(playerid, "Nie jesteœ w Banku ani przy bankomacie !");
            return 1;
        }
	}
	return 1;
}
