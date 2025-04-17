//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  dajbilet                                                 //
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


//

//------------------<[ Implementacja: ]>-------------------
command_dajbilet_Impl(playerid, giveplayerid, klub[16], opcja[24]="1")
{
    if(PlayerInfo[playerid][pRank] >= 6) 
    {
        if (!strcmp(klub, "ibiza", true)) {
            if (!IsFrontBusinnesOwnedByPlayerOrg(playerid, 39)) {
                noAccessMessage(playerid);
                return 1;
            }
            if(strcmp(opcja,"1",true) == 0 || strcmp(opcja,"normal",true) == 0) IbizaNadajBilet(playerid, giveplayerid, 1);
            else if(strcmp(opcja,"2",true) == 0 || strcmp(opcja,"vip",true) == 0) IbizaNadajBilet(playerid, giveplayerid, 2);
            else if(strcmp(opcja,"3",true) == 0 || strcmp(opcja,"supervip",true) == 0 || strcmp(opcja,"svip",true) == 0) IbizaNadajBilet(playerid, giveplayerid, 3);
            else MruMessageFail(playerid, "Niepoprawna nazwa biletu. Dostêpne: 1. normal, 2. vip 3. supervip");
            return 1;
        }
        if (!strcmp(klub, "vinyl", true))  {
            if (!IsFrontBusinnesOwnedByPlayerOrg(playerid, 40)) {
                noAccessMessage(playerid);
                return 1;
            }
            if(strcmp(opcja,"1",true) == 0 || strcmp(opcja,"normal",true) == 0) VinylNadajBilet(playerid, giveplayerid, 1);
            else if(strcmp(opcja,"2",true) == 0 || strcmp(opcja,"vip",true) == 0) VinylNadajBilet(playerid, giveplayerid, 2);
            else MruMessageFail(playerid, "Niepoprawna nazwa biletu. Dostêpne: 1. normal, 2. vip");
            return 1;
        }
        MruMessageFail(playerid, "Niepoprawna nazwa klubu");
    }
    else
    {
        noAccessMessage(playerid);
    }
    return 1;
}

//end