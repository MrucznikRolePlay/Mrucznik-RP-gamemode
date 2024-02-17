//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                sprzedajrybe                                               //
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
// Data utworzenia: 03.03.2020


//

//------------------<[ Implementacja: ]>-------------------
command_sprzedajrybe_Impl(playerid, fishid)
{
    if (!PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))//centerpoint 24-7
    {
        SendClientMessage(playerid, COLOR_WHITE, "Rybê mo¿esz sprzedaæ tylko w 24/7!");
        return 1;
    }
    if(FishGood[playerid] == 1)
    {
        SendPunishMessage(sprintf("AdmCmd: %s zostal zkickowany przez Admina: Marcepan_Marks, powód: teleport (ryby)", GetNickEx(playerid)), playerid);
        Log(punishmentLog, INFO, "%s dosta³ kicka od antycheata, powód: teleport (ryby)");
        KickEx(playerid);
        return 1;
    }

    switch(fishid)
    {
        case 1..5:
        {
            SprzedajeRybe(playerid, fishid);
        }
        default:
        {
            return sendTipMessageEx(playerid, COLOR_GREY, "Numer ryby od 1 do 5 !"); 
        }
    }
    return 1;
}

SprzedajeRybe(playerid, fishid = 0)
{
	if(!fishid) return 0;
	new FishWeight, FishName[20];
	if(fishid == 1)
	{
		FishWeight = Fishes[playerid][pWeight1];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish1]);
	}
	else if(fishid == 2)
	{
		FishWeight = Fishes[playerid][pWeight2];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish2]);
	}
	else if(fishid == 3)
	{
		FishWeight = Fishes[playerid][pWeight3];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish3]);
	}
	else if(fishid == 4)
	{
		FishWeight = Fishes[playerid][pWeight4];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish4]);
	}
	else if(fishid == 5)
	{
		FishWeight = Fishes[playerid][pWeight5];
		format(FishName, sizeof(FishName), Fishes[playerid][pFish5]);
	}

	if(FishWeight < 1) {
		return SendClientMessage(playerid, COLOR_GREY, sprintf("** Nie z³owi³eœ ¿adnej ryby pod numerem [%d] !", fishid)); 
	}
	const moneyPerKg = 15;
	SendClientMessage(playerid, COLOR_GREY, sprintf("** Sprzeda³eœ rybê numer [%d]!", fishid));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Sprzeda³eœ rybê: %s, wa¿¹c¹ %d kg. Otrzymujesz %d$.", FishName, FishWeight, FishWeight * moneyPerKg));
	DajKase(playerid, FishWeight * moneyPerKg);
	ClearFishID(playerid, fishid);
	Fishes[playerid][pLastFish] = 0;
	Fishes[playerid][pFishID] = 0;
	FishGood[playerid] = 0;

	if(IsPlayerSick(playerid, FANATYK_WEDKARSTWA))
	{
		if(random(100) <= 5)
		{
			CurePlayer(playerid, FANATYK_WEDKARSTWA);
		}
	}
	return 1;
}

//end