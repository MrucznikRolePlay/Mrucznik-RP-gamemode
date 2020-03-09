//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   ibiza                                                   //
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
// Data utworzenia: 01.02.2020
//Opis:
/*
	Skrypt ibizy
*/

//
#include "ibiza_dialogs.pwn"
//-----------------<[ Funkcje: ]>-------------------
ibiza_clearCache(playerid)
{
	IbizaTicket[playerid] = 0;
}
stock IbizaStrobesOn(){
	ibizaStrobe1 = CreateDynamicObject(354, 431.875701, -1841.316772, -66.600242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaStrobe2 = CreateDynamicObject(354, 431.875701, -1849.897216, -66.600242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaStrobe3 = CreateDynamicObject(354, 431.875701, -1841.316772, -62.600242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaStrobe4 = CreateDynamicObject(354, 431.875701, -1849.897216, -62.600242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaStrobes = true;
	return 1;
}
stock IbizaStrobesOff(){
	DestroyDynamicObject(ibizaStrobe1);
	DestroyDynamicObject(ibizaStrobe2);
	DestroyDynamicObject(ibizaStrobe3);
	DestroyDynamicObject(ibizaStrobe4);
	ibizaStrobes = false;
	return 1;
}
stock IbizaNeonsOn(){
	ibizaNeon1 = CreateDynamicObject(18651, 424.107177, -1859.817871, -63.150581, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon2 = CreateDynamicObject(18651, 410.256896, -1859.817871, -63.150581, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon3 = CreateDynamicObject(18651, 410.256896, -1830.967895, -63.150581, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon4 = CreateDynamicObject(18651, 424.107177, -1830.967895, -63.150581, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon5 = CreateDynamicObject(18651, 402.966705, -1852.517333, -63.150581, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon6 = CreateDynamicObject(18651, 402.966705, -1837.375976, -63.150581, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon7 = CreateDynamicObject(18651, 411.296813, -1839.948120, -62.930603, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon8 = CreateDynamicObject(18651, 414.346588, -1839.948120, -62.930603, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon9 = CreateDynamicObject(18651, 412.876586, -1839.948120, -62.930603, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon10 = CreateDynamicObject(18651, 417.356689, -1839.948120, -62.930603, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaNeon11 = CreateDynamicObject(18651, 419.336639, -1839.948120, -62.930603, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
	ibizaNeons = true;
	return 1;
}
stock IbizaNeonsOff(){
	DestroyDynamicObject(ibizaNeon1);
	DestroyDynamicObject(ibizaNeon2);
	DestroyDynamicObject(ibizaNeon3);
	DestroyDynamicObject(ibizaNeon4);
	DestroyDynamicObject(ibizaNeon5);
	DestroyDynamicObject(ibizaNeon6);
	DestroyDynamicObject(ibizaNeon7);
	DestroyDynamicObject(ibizaNeon8);
	DestroyDynamicObject(ibizaNeon9);
	DestroyDynamicObject(ibizaNeon10);
	DestroyDynamicObject(ibizaNeon11);
	return 1;
}
stock IbizaSmokesOn(){
	ibizaSmoke1 = CreateDynamicObject(18727, 431.738006, -1843.064208, -65.366447, -90.599967, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaSmoke2 = CreateDynamicObject(18727, 431.738006, -1848.024169, -65.366447, -90.599967, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	ibizaSmokes = true;
	return 1;
}
stock IbizaSmokesOff(){
	DestroyDynamicObject(ibizaSmoke1);
	DestroyDynamicObject(ibizaSmoke2);
	ibizaSmokes = false;
	return 1;
}
stock IbizaLightsOn(){
	ibizaLight1 = CreateDynamicObject(19608, 433.696594, -1845.469360, -68.420249, 0.000000, 0.000000, -90.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(ibizaLight1, 2, 10765, "airportgnd_sfse", "white", 0xFF202020);
	ibizaLight2 = CreateDynamicObject(14793, 427.333282, -1845.270874, -61.115303, 0.000000, 20.499998, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(ibizaLight2, 0, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	ibizaLight3 = CreateDynamicObject(14793, 418.892333, -1845.270874, -58.963237, 0.000000, 9.699994, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(ibizaLight3, 0, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	ibizaLight4 = CreateDynamicObject(14793, 412.500732, -1845.270874, -58.641696, 0.000000, 2.499991, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(ibizaLight4, 0, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	ibizaLight5 = CreateDynamicObject(14793, 409.309570, -1845.270874, -59.566371, 0.000000, -9.600010, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(ibizaLight5, 0, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
	ibizaLights = true;
	return 1;
}
stock IbizaLightsOff(){
	DestroyDynamicObject(ibizaLight1);
	DestroyDynamicObject(ibizaLight2);
	DestroyDynamicObject(ibizaLight3);
	DestroyDynamicObject(ibizaLight4);
	DestroyDynamicObject(ibizaLight5);
	ibizaLights = false;
	return 1;
}
stock ibizaTextOneOff(){
	DestroyDynamicObject(ibizaTextOneText);
	return 1;
}
stock ibizaTextTwoOff(){
	DestroyDynamicObject(ibizaTextTwoText);
	return 1;
}
stock IbizaPanelCheck(){
	new txt_ibiza_strobes[128], txt_ibiza_neons[128], txt_ibiza_lights[128], txt_ibiza_smokes[128];
	new txt_ibiza_txtOne[128], txt_ibiza_txtTwo[128];
	new txt_ibiza_normalTicketCost[128], txt_ibiza_VIPTicketCost[128];
	if(ibizaStrobes == false){
		format(txt_ibiza_strobes, 128, "{FFFFFF}Stroboskopy: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_strobes, 128, "{FFFFFF}Stroboskopy: \t{00FF00}W³¹czone\n");
	}
	if(ibizaNeons == false){
		format(txt_ibiza_neons, 128, "{FFFFFF}Neony: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_neons, 128, "{FFFFFF}Neony: \t{00FF00}W³¹czone\n");
	}
	if(ibizaLights == false){
		format(txt_ibiza_lights, 128, "{FFFFFF}Oœwietlenie: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_lights, 128, "{FFFFFF}Oœwietlenie: \t{00FF00}W³¹czone\n");
	}
	if(ibizaSmokes == false){
		format(txt_ibiza_smokes, 128, "{FFFFFF}Dym: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_smokes, 128, "{FFFFFF}Dym: \t{00FF00}W³¹czone\n");
	}
	if(ibizaTextOne == false){
		format(txt_ibiza_txtOne, 128, "{FFFFFF}Tekst #1: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_txtOne, 128, "{FFFFFF}Tekst #1: \t{00FF00}W³¹czone\n");
	}
	if(ibizaTextTwo == false){
		format(txt_ibiza_txtTwo, 128, "{FFFFFF}Tekst #2: \t{FF0000}Wy³¹czone\n");
	}else{
		format(txt_ibiza_txtTwo, 128, "{FFFFFF}Tekst #2: \t{00FF00}W³¹czone\n");
	}
	format(txt_ibiza_normalTicketCost, 128, "{FFFFFF}Bilet normalny: \t{00FF00}%d \n", ibiza_priceNormal);
	format(txt_ibiza_VIPTicketCost, 128, "{FFFFFF}Bilet VIP: \t{00FF00}%d", ibiza_priceVIP);
	
	format(txt_ibiza_klub, 512, "%s %s %s %s %s %s %s %s", txt_ibiza_strobes, txt_ibiza_neons, txt_ibiza_lights, txt_ibiza_smokes, txt_ibiza_txtOne, txt_ibiza_txtTwo, txt_ibiza_normalTicketCost, txt_ibiza_VIPTicketCost);
	return 1;
}
stock IbizaTicketsCostCheck(){
	format(txt_ibiza_tickets, 128, "{FFFFFF}Rodzaj\tCena\nZwyk³y\t{00FF00}%d\n{FFFFFF}VIP\t{00FF00}%d", ibiza_priceNormal, ibiza_priceVIP);
	return 1;
}

stock IbizaNadajBilet(playerid, giveplayerid, bilet)
{
	new nazwa_biletu[24];
	new var[128];
	new Float:x, Float:y, Float:z;
	GetPlayerPos(giveplayerid, x, y, z);
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
	{
		sendTipMessage(playerid, "Jesteœ za daleko.");
		return 1;
	}
	if(bilet == 1) nazwa_biletu = "NORMAL";
	if(bilet == 2) nazwa_biletu = "VIP";
	if(bilet == 3) nazwa_biletu = "SUPERVIP";
	format(var, sizeof(var), "Da³eœ bilet %s dla %s", nazwa_biletu, GetNick(giveplayerid));
    sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
    format(var, sizeof(var), "Otrzyma³eœ bilet %s od %s", nazwa_biletu, GetNick(playerid));
    sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, var);
    format(var, sizeof(var), "** %s podaje bilet Ibiza|[%s] %s.", GetNick(playerid), nazwa_biletu, GetNick(giveplayerid));
    ProxDetector(15.0, playerid, var, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    if(bilet == 1) IbizaTicket[giveplayerid] = IBIZA_NORMAL;
	if(bilet == 2) IbizaTicket[giveplayerid] = IBIZA_VIP;
	if(bilet == 3) IbizaTicket[giveplayerid] = IBIZA_SUPERVIP;
	return 1;
}
//end