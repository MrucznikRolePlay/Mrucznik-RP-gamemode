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
command_teleturniej_Impl(playerid, params[256])
{
    if(!(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)) return 1;
	new Zawodnik1,Zawodnik2,Zawodnik3;
	if(sscanf(params,"k<fix>k<fix>k<fix>",Zawodnik1,Zawodnik2,Zawodnik3)) return SendClientMessage(playerid,0x4c4c4cff,"UZYJ: /teleturniej [ID-Gracza] [ID-Gracza] [ID-Gracza]");
	else
	if(IsPlayerInRangeOfPoint(playerid,2,675.6801, -1339.5690, 30.3864))
	{
	    new ImieGracza[MAX_PLAYER_NAME+1],string[80];
		GetPlayerName(playerid, ImieGracza, sizeof(ImieGracza));
		for(new i=0; i< MAX_PLAYERS; i++)
		{
			if(GetPlayerVirtualWorld(i) == 21 && IsPlayerInRangeOfPoint(i, 50.0, 675.6801, -1339.5690, 30.3864))
			{
				format(string, sizeof(string), "* %s zadaj¹c pytanie rozpoczyna teleturniej",ImieGracza);
    			SendClientMessage(i,COLOR_PURPLE,string);
				new Imie1[MAX_PLAYER_NAME];
				new Imie2[MAX_PLAYER_NAME];
				new Imie3[MAX_PLAYER_NAME];
				GetPlayerName(Zawodnik1,Imie1,sizeof(Imie1));
				GetPlayerName(Zawodnik2,Imie2,sizeof(Imie2));
				GetPlayerName(Zawodnik3,Imie3,sizeof(Imie3));
				new string2[50],string3[50],string4[50];
				SendClientMessage(i,0x4c4c4cff,"_________________________");
				SendClientMessage(i,0x4c4c4cff,"Uczestnicy:");
				format(string2,sizeof(string2),"%s",Imie1);
				SendClientMessage(i,0x4c4c4cff,string2);
				format(string3,sizeof(string3),"%s",Imie2);
				SendClientMessage(i,0x4c4c4cff,string3);
				format(string4,sizeof(string4),"%s",Imie3);
				SendClientMessage(i,0x4c4c4cff,string4);
				SendClientMessage(i,0x4c4c4cff,"_________________________");
			}
		}
		Teleturniejstart = 1;
		grajacy[Zawodnik1] = 1;
		grajacy[Zawodnik2] = 1;
		grajacy[Zawodnik3] = 1;
	}
	return 1;
}

//end
