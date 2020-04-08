//------------------------------------------------<< Dialog >>-----------------------------------------------//
//-----------------------------------------------[ ibiza_dialogs ]----------------------------------------------//
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
// Autor: Sanda³
// Data utworzenia: 1.02.2020

// Opis:
/*

*/

ibiza_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 6041){
		if(response){
			switch(listitem){
				case 0:{
					if(kaska[playerid] >= ibiza_priceNormal){
						ZabierzKase(playerid, ibiza_priceNormal);
						IbizaTicket[playerid] = IBIZA_NORMAL;
						SetPlayerWeather(playerid, 27);
						SendClientMessage(playerid, -1, "Kasjerka mówi: Dziêkujemy za zakup biletu!");
						SejfR_Add(FAMILY_IBIZA, ibiza_priceNormal);
					}else{
						SendClientMessage(playerid, -1, "Nie masz wystarczaj¹cej iloœci pieniêdzy!");
					}
				}
				case 1:{
					if(kaska[playerid] >= ibiza_priceVIP){
						ZabierzKase(playerid, ibiza_priceVIP);
						IbizaTicket[playerid] = IBIZA_VIP;
						SetPlayerWeather(playerid, 27);
						SendClientMessage(playerid, -1, "Kasjerka mówi: Dziêkujemy za zakup biletu VIP!");
						SejfR_Add(FAMILY_IBIZA, ibiza_priceVIP);
					}else{
						SendClientMessage(playerid, -1, "Nie masz wystarczaj¹cej iloœci pieniêdzy!");
					}
				}
				
			}
		}
	}
	if(dialogid == 6042){
		if(response){
			switch(listitem){
				case 0 :{
					if(ibizaStrobes == false){
						ibizaStrobes = true;
						IbizaStrobesOn();
					}else{
						ibizaStrobes = false;
						IbizaStrobesOff();
					}
				}
				case 1 :{
					if(ibizaNeons == false){
						ibizaNeons = true;
						IbizaNeonsOn();
					}else{
						ibizaNeons = false;
						IbizaNeonsOff();
					}
				}
				case 2 :{
					if(ibizaLights == false){
						ibizaLights = true;
						IbizaLightsOn();
					}else{
						ibizaLights = false;
						IbizaLightsOff();
					}
				}
				case 3 :{
					if(ibizaSmokes == false){
						ibizaSmokes = true;
						IbizaSmokesOn();
					}else{
						ibizaSmokes = false;
						IbizaSmokesOff();
					}
				}
				case 4:{
					if(ibizaTextOne == false){
						ibizaTextOne = true;
						ShowPlayerDialogEx(playerid, 6045, DIALOG_STYLE_INPUT, "IbizaClub - Ustaw tekst #1", "Wpisz tekst", "ZatwierdŸ", "Anuluj");
					}else{
						ibizaTextOne = false;
						ibizaTextOneOff();
					}
				}
				case 5:{
					if(ibizaTextTwo == false){
						ibizaTextTwo = true;
						ShowPlayerDialogEx(playerid, 6046, DIALOG_STYLE_INPUT, "IbizaClub - Ustaw tekst #2", "Wpisz tekst", "ZatwierdŸ", "Anuluj");
					}else{
						ibizaTextTwo = false;
						ibizaTextTwoOff();
					}
				}
				case 6:{
					ShowPlayerDialogEx(playerid, 6043, DIALOG_STYLE_INPUT, "IbizaClub - Normalny bilet", "Wpisz cenê biletu normalnego\nMax 250000 $", "ZatwierdŸ", "Anuluj");
				}
				case 7:{
					ShowPlayerDialogEx(playerid, 6044, DIALOG_STYLE_INPUT, "IbizaClub - Normalny bilet", "Wpisz cenê biletu VIP\nMax 500000 $", "ZatwierdŸ", "Anuluj");
				}
			}
		}
	}
	if(dialogid == 6043){
		if(response){
			ibiza_priceNormal = strval(inputtext);
            if(ibiza_priceNormal < 0)
            {
                ibiza_priceNormal = 0;
            }
		}
	}
	if(dialogid == 6044){
		if(response){
			ibiza_priceVIP = strval(inputtext);
            if(ibiza_priceVIP < 0)
            {
                ibiza_priceVIP = 0;
            }
		}
	}
	if(dialogid == 6045){
		if(response){
			ibizaTextOneText = CreateDynamicObject(19328, 410.189453, -1830.978637, -64.220527, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00); 
			SetDynamicObjectMaterialText(ibizaTextOneText, 0, inputtext, 140, "Ariel", 60, 0, 0xFF000000, 0x00000000, 1);
		}
	}
	if(dialogid == 6046){
		if(response){
			ibizaTextTwoText = CreateDynamicObject(4731, 430.835357, -1845.524658, -62.950248, 0.000000, 0.000000, -59.699989, -1, -1, -1, 300.00, 300.00); 
			SetDynamicObjectMaterialText(ibizaTextTwoText, 0, inputtext, 120, "Fixedsys", 20, 0, 0xFFFFFFFF, 0x00000000, 1);
		}
	}
    if(dialogid == 6047)
    {
        if(!response) return 1;
        if(strlen(inputtext) < 10) return 1;

        foreach(new i : Player)
        {
            if(IsPlayerInRangeOfPoint(i, IbizaAudioPos[3],IbizaAudioPos[0],IbizaAudioPos[1],IbizaAudioPos[2]) && (GetPlayerVirtualWorld(i) == 21 || GetPlayerVirtualWorld(i) == 22 || GetPlayerVirtualWorld(i) == 23 || GetPlayerVirtualWorld(i) == 24 || GetPlayerVirtualWorld(i) == 26 || GetPlayerVirtualWorld(i) == 27))
            {
                PlayAudioStreamForPlayer(i, inputtext,IbizaAudioPos[0],IbizaAudioPos[1],IbizaAudioPos[2], IbizaAudioPos[3], 1);
            }
        }
        format(IBIZA_Stream, 128, "%s",inputtext);
    }
    return 1;
}