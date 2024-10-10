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
command_mp3_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) != 0)
        {
            MruMessageFail(playerid, "Nie mo¿esz zmieniaæ radia jako pasa¿er!");
            return 1;
        }

        if(PlayerInfo[playerid][pCDPlayer])
        {
			ShowPlayerDialogEx(playerid, DIALOGID_MUZYKA, DIALOG_STYLE_LIST, "Odtwarzacz MP3.","Mrucznik Radio\nVice City Radio\n""SAN Radio kana³ 1\n""SAN Radio kana³ 2\n""Radio ZET\n""RMF FM\n""RMF MAXXX\n""Radio ESKA\n""Lepa Station\n""W³asny stream\n""MP3 OFF","Start",""); //zmieñ dialogid
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz odtwarzacza mp3!");
		}
    }
    return 1;
}

//end
