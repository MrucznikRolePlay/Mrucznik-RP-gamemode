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
command_slap_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if(sscanf(params, "k<fix>", playa))
		{
			return sendTipMessage(playerid, "U¿yj /slap [playerid/CzêœæNicku]");
		}

		if (PlayerInfo[playerid][pAdmin] >=1 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3 || Zaufany(playerid) || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {			
					new Float:shealth;
					new Float:slx, Float:sly, Float:slz;
			        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerHealth(playa, shealth);
					SetPlayerHealth(playa, shealth-5);
					GetPlayerPos(playa, slx, sly, slz);
					SetPlayerPos(playa, slx, sly, slz+5);
					PlayerPlaySound(playa, 1130, slx, sly, slz+5);
        			Log(punishmentLog, INFO, "Admin %s da³ slapa %s", GetPlayerLogName(playerid), GetPlayerLogName(playa));
					format(string, sizeof(string), "AdmCmd: %s da³ klapsa w dupsko %s",GetNickEx(playerid), giveplayer);
					ABroadCast(COLOR_LIGHTRED,string,1);
					format(string, sizeof(string), "Dosta³eœ klapsa w dupsko od administratora %s, widocznie zrobi³eœ coœ z³ego :)", GetNickEx(playerid));
					SendClientMessage(playa, COLOR_PANICRED, string);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}

//end
