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
command_admindutycmd_Impl(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1)
	{	
		if(GetPlayerAdminDutyStatus(playerid) == 0)
		{
			if(OnDuty[playerid] == 1 || OnDutyCD[playerid] == 1)
			{
				sendErrorMessage(playerid, "Jesteœ na s³u¿bie IC, graj IC!");  
				return 1;
			}

			new nick[24];
			if(GetPVarString(playerid, "maska_nick", nick, 24))
			{
				SendClientMessage(playerid, COLOR_GREY, " Musisz œci¹gn¹æ maskê z twarzy! (/maska).");
				return 1;
			}
			AdminDutyPlayer(playerid, 1); 
				
			return 1;	
		}
		else if(GetPlayerAdminDutyStatus(playerid) == 1)//Wykonuje zejœcie z duty
		{	
			AdminDutyPlayer(playerid, 0); 
			return 1;
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ administratorem, wiêc nie mo¿esz tego u¿yæ!"); 
		MSGBOX_Show(playerid, "Nie masz uprawnien!", MSGBOX_ICON_TYPE_ERROR);
		return 1; 
	}

	return 1;
}

//end
