//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                checkpremium                                               //
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
// Autor: Mrucznik
// Data utworzenia: 09.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_checkpremium_Impl(playerid, giveplayerid)
{
    if(!IsAKox(playerid))
	{
        return noAccessMessage(playerid);
    }

    _MruAdmin(playerid, sprintf("Us³ugi premium gracza %s:", GetNick(giveplayerid)));
    if(PremiumInfo[giveplayerid][pKP])
    {
        new expirationTime = PremiumInfo[giveplayerid][pExpires]-gettime();
        _MruAdmin(playerid, sprintf("- KP wygasa za %d dni i %d godzin (timestamp: %d)", 
						floatround(floatdiv(expirationTime, 86400), floatround_floor), 
						floatround(floatdiv(expirationTime, 3600), floatround_floor)%24,
                        expirationTime)
        );
    }
    else
    {
        _MruAdmin(playerid, "- Brak KP");
    }
    _MruAdmin(playerid, sprintf("- stan MC: %d", PremiumInfo[giveplayerid][pMC]));
    
    //TODO: wiêcej informacji w /checkpremium
    // _MruAdmin(playerid, "- Skiny premium:");
    // for(new i; i<MAX_PREMIUM_SKINS; i++)
    // {
    //     _MruAdmin(playerid, sprintf("    - %d", ));
    // }
    // _MruAdmin(playerid, "- Pojazdy premium:");
    // for(new i; i<MAX_; i++)
    // {
    //     _MruAdmin(playerid, sprintf("    - %s", ));
    // }
    // _MruAdmin(playerid, "- Przedmioty premium:");
    // for(new i; i<MAX_PREMIUM_ITEMS; i++)
    // {
    //     _MruAdmin(playerid, sprintf("    - %d", ));
    // }

    return 1;
}

//end