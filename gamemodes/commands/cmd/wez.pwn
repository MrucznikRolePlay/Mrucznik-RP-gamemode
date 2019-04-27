//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ wez ]--------------------------------------------------//
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


CMD:wez(playerid, params[])
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new x_job[16];
		new ammount=0;
		if( sscanf(params, "s[16]D", x_job, ammount))
		{
			SendClientMessage(playerid, COLOR_WHITE, "|__________________ Get __________________|");
			SendClientMessage(playerid, COLOR_WHITE, "U¿yj /wez [nazwa]");
	  		SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: Dragi, Kanister");
			SendClientMessage(playerid, COLOR_GREEN, "|_________________________________________|");
			return 1;
		}

	    if(strcmp(x_job,"drugs",true) == 0 || strcmp(x_job,"dragi",true) == 0)
		{
			if(ammount == 0)
			{
				sendTipMessage(playerid, "U¿yj /wez dragi [ilosc]");
			}
	        if(PlayerInfo[playerid][pDrugs] > 15)
	        {
	            format(string, sizeof(string), "Posiadasz %d gramów przy sobie, najpierw je sprzedaj !", PlayerInfo[playerid][pDrugs]);
				sendTipMessageEx(playerid, COLOR_GREY, string);
	            return 1;
	        }
	        new tel;
		    new price;
			new level = PlayerInfo[playerid][pDrugsSkill];

			if(level >= 0 && level <= 50)
			{ tel = 200; if(ammount < 1 || ammount > 6) { sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz braæ od 1 do 6g przy tym poziomie Dilera Dragów!"); return 1; } }
			else if(level >= 51 && level <= 100)
			{ tel = 150; if(ammount < 1 || ammount > 12) { sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz braæ od 1 do 12g przy tym poziomie Dilera Dragów!"); return 1; } }
			else if(level >= 101 && level <= 200)
			{ tel = 100; if(ammount < 1 || ammount > 20) { sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz braæ od 1 do 20g przy tym poziomie Dilera Dragów!"); return 1; } }
			else if(level >= 201 && level <= 400)
			{ tel = 50; if(ammount < 1 || ammount > 30) { sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz braæ od 1 do 30g przy tym poziomie Dilera Dragów!"); return 1; } }
			else if(level >= 401)
			{ tel = 10; if(ammount < 1 || ammount > 99) { sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz braæ od 1 do 99g przy tym poziomie Dilera Dragów!"); return 1; } }
		    if (PlayerInfo[playerid][pJob] == 4 && PlayerToPoint(5.0, playerid, 322.6724,1117.9385,1083.8828) || PlayerInfo[playerid][pJob] == 4 && PlayerToPoint(5.0, playerid, -1022.34930420,-2158.46484375,33.91813278))
			{
			    price = ammount * tel;
			    if(kaska[playerid] > price)
			    {
			        format(string, sizeof(string), "* Kupi³eœ %d gram dragów za $%d.", ammount, price);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			        ZabierzKase(playerid, price);
					PlayerInfo[playerid][pDrugs] = ammount;
			    }
			    else
			    {
			        sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz kupiæ dragów !");
			        return 1;
			    }
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ Dilerem Dragów albo nie jesteœ w melinie !");
			    return 1;
			}
		}
		else if(strcmp(x_job,"fuel",true) == 0 || strcmp(x_job,"kanister",true) == 0 || strcmp(x_job,"paliwo",true) == 0)
		{
		    if(IsAtGasStation(playerid))
			{
			    new price = 20 * 120;
			    format(string, sizeof(string), "* Wzi¹³eœ kanister z 20% paliwa za $%d",price);
			    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			    PlayerInfo[playerid][pFuel] = 20;
				ZabierzKase(playerid, price);
				return 1;
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY," Nie jesteœ na stacji benzynowej!");
				return 1;
			}
		}
		else { return 1; }
	}//not connected
	return 1;
}

