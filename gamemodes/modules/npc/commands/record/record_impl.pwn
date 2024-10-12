//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   record                                                  //
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
// Data utworzenia: 30.08.2024


//

//------------------<[ Implementacja: ]>-------------------
command_record_Impl(playerid, giveplayerid, type, filename[64])
{
	if(PlayerInfo[playerid][pAdmin] <= 0)
	{
		noAccessMessage(playerid);
		return 1;
	}

    if(type == PLAYER_RECORDING_TYPE_DRIVER)
    {
        if(!IsPlayerInAnyVehicle(giveplayerid))
        {
            MruMessageFail(playerid, "Gracz musi byæ w pojeŸdzie, jeœli chcesz nagrywaæ jego ruch jako kierowcy.");
            return 1;
        }
    }
    else if(type == PLAYER_RECORDING_TYPE_ONFOOT)
    {
        if(IsPlayerInAnyVehicle(giveplayerid))
        {
            MruMessageFail(playerid, "Gracz musi byæ na pieszo, jeœli chcesz nagrywaæ jego ruch jako pieszy.");
            return 1;
        }
    }
    else
    {
        MruMessageFail(playerid, "Nie rozpoznano typu nagrania, dostêpne typy: 1 - kierowca, 2 - pieszy.");
        return 1;
    }

    StartRecordingPlayerData(giveplayerid, type, filename);
    MruMessageGoodInfoF(playerid, "Nagrywasz gracza %s, plik z nagraniem zostanie zapisany jako %s.rec", GetNick(giveplayerid), filename);
    MruMessageGoodInfo(playerid, "Aby zakoñczyæ nagrywanie, wpisz /stoprec");
    return 1;
}

//end