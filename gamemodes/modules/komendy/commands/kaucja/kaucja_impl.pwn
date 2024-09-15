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
command_kaucja_Impl(playerid, params[256])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
		if(PlayerInfo[playerid][pJailed]==1)
		{
		    if(JailPrice[playerid] > 0)
		    {
		        if(kaska[playerid] > JailPrice[playerid])
		        {
                    GetPlayerName(playerid, sendername, sizeof(sendername));
		            format(string, sizeof(string), "Wp³aci³eœ za siebie kaucje $%d", JailPrice[playerid]);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "%s wp³aci³ za siebie kaucjê %d", sendername, JailPrice[playerid]);
					SendTeamMessage(3, COLOR_ALLDEPT, string);
					SendTeamMessage(2, COLOR_ALLDEPT, string);
					SendTeamMessage(1, COLOR_ALLDEPT, string);
					//SendTeamMessage(18, COLOR_ALLDEPT, string);
					ZabierzKase(playerid, JailPrice[playerid]);
                    new komuPlaci = GetPVarInt(playerid, "kaucja-dlaKogo");
                    Sejf_Add(komuPlaci, JailPrice[playerid]);
					JailPrice[playerid] = 0;
					WantLawyer[playerid] = 0; CallLawyer[playerid] = 0;
					PlayerInfo[playerid][pJailTime] = 1;
		        }
		        else
		        {
		            sendTipMessageEx(playerid, COLOR_GRAD1, "Kaucja jest zbyt wysoka, nie staæ ciê !");
		        }
		    }
		    else
		    {
		        sendTipMessageEx(playerid, COLOR_GRAD1, "Nie dano ci mo¿liwoœci wp³acenia kaucji !");
		    }
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GRAD1, "Nie jesteœ w wiêzieniu !");
		}
	}//not connected
	return 1;
}

//end
