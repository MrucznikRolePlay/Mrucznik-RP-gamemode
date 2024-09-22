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
command_anuluj_Impl(playerid, params[256])
{
    new x_job[16];
	if( sscanf(params, "s[16]", x_job))
	{
		SendClientMessage(playerid, COLOR_WHITE, "|__________________ Cancel __________________|");
		SendClientMessage(playerid, COLOR_WHITE, "U¿yj: /anuluj [nazwa]");
		SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: sex, dragi, naprawa, prawnik, pancerz, wywiad, tankowanie, auto, boks, kontrakt");
		SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: taxi, bus, medyk, mechanik, mandat, swiadek, slub, rozwod, taxicall");
		SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________|");
		return 1;
	}
	if(strcmp(x_job,"sex",true) == 0) {	SexOffer[playerid] = 999; SexPrice[playerid] = 0; }
	else if(strcmp(x_job,"dragi",true) == 0) { DrugOffer[playerid] = 999; DrugPrice[playerid] = 0; DrugGram[playerid] = 0; }
	else if(strcmp(x_job,"kontrabanda",true) == 0) { ContrabandOffer[playerid] = 999; ContrabandPrice[playerid] = 0; ContrabandCount[playerid] = 0; }
	else if(strcmp(x_job,"naprawa",true) == 0) {	RepairOffer[playerid] = 999; RepairPrice[playerid] = 0; RepairCar[playerid] = 0; }
	else if(strcmp(x_job,"prawnik",true) == 0) { WantLawyer[playerid] = 0; CallLawyer[playerid] = 0; }
	else if(strcmp(x_job,"przemyt",true) == 0 || strcmp(x_job,"pancerz",true) == 0) 
	{ 
		SmugglingOffer[playerid] = 999; SmugglingOfferPrice[playerid] = 0; 
	}
	else if(strcmp(x_job,"akcjaprzemyt",true) == 0) 
	{
		new actionID = GetPlayerSmugglingActionID(playerid);
		if(actionID != -1)
		{
			Group_SetPlayer(SmugglingAction[actionID][s_crewGroup], playerid, false);
			Redis_Delete(sprintf("player:%d:smuggling", PlayerInfo[playerid][pUID]));
			Redis_Delete(sprintf("player:%d:smuggling:role", PlayerInfo[playerid][pUID]));
			DisablePlayerCheckpoint(playerid);
		}
	}
	else if(strcmp(x_job,"wywiad",true) == 0) { LiveOffer[playerid] = 999; }
	else if(strcmp(x_job,"tankowanie",true) == 0) { RefillOffer[playerid] = 999; RefillPrice[playerid] = 0; }
	else if(strcmp(x_job,"auto",true) == 0) { CarOffer[playerid] = 999; CarID[playerid] = 0; }
	else if(strcmp(x_job,"boks",true) == 0) { BoxOffer[playerid] = 999; }
	else if(strcmp(x_job,"swiadek",true) == 0) { MarryWitnessOffer[playerid] = 999; }
	else if(strcmp(x_job,"slub",true) == 0) { ProposeOffer[playerid] = 999; }
	else if(strcmp(x_job,"rozwod",true) == 0) { DivorceOffer[playerid] = 999; }
	else if(strcmp(x_job,"mandat",true) == 0) { SendClientMessage(TicketOffer[playerid], COLOR_PANICRED, "Podejrzany nie zgodzi³ siê zap³aciæ mandatu, jedŸ z nim na komisariat" ); TicketOffer[playerid] = 999; TicketMoney[playerid] = 0; }
	else if(strcmp(x_job,"medyk",true) == 0) { if(IsPlayerConnected(MedicCall)) { if(MedicCall == playerid) { MedicCall = 999; } else { SendClientMessage(playerid, COLOR_GREY, "   Nie zamawia³eœ medyka !"); return 1; } } }
	else if(strcmp(x_job,"mechanik",true) == 0) { if(IsPlayerConnected(MechanicCall)) { if(MechanicCall == playerid) { MechanicCall = 999; } else { SendClientMessage(playerid, COLOR_GREY, "   Nie zamawia³eœ  mechanika !"); return 1; } } }
	else if(strcmp(x_job,"taxi",true) == 0)
	{
	    anuluj_taxi(playerid);
	}
	else if(strcmp(x_job,"taxicall",true) == 0)
	{
		anuluj_taxicall(playerid);
   	}
	else if(strcmp(x_job,"kontrakt",true) == 0)
	{
		if(PlayerInfo[playerid][pMember]==8 || PlayerInfo[playerid][pLider]==8)
 		{
   			if(GoChase[playerid] < 999)
      		{
				SendFamilyMessage(8, COLOR_YELLOW, sprintf("Kontrakt na %s, nagroda za wykonanie $%d.", GetNickEx(GoChase[playerid]), PlayerInfo[GoChase[playerid]][pHeadValue]));
				GotHit[playerid] = 0;
				GetChased[GoChase[playerid]] = 999;
				GoChase[playerid] = 999;
				GameTextForPlayer(playerid, "~w~Anulowano~n~~r~kontrakt", 5000, 1);
   			}
   			else
   			{
	           sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ z HA !");
   			}
   		}
   	}
	else if(strcmp(x_job,"bus",true) == 0)
	{
	    anuluj_bus(playerid);
	}
	else
	{ return 1; }
	new string[32];
	format(string, sizeof(string), "* Anulowa³eœ: %s.", x_job);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	return 1;
}

//end
