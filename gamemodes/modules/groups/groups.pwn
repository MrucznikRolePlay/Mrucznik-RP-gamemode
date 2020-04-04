//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  groups                                                   //
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
// Autor: Creative
// Data utworzenia: 22.03.2020
//Opis:
/*
	System grup.
*/

//-----------------<[ Funkcje: ]>-------------------
stock ShowGroupsForPlayer(playerid)
{
	if(PlayerInfo[playerid][pGroupsShow] == 0)
	{
		if(PlayerInfo[playerid][pGroup])
		{
			PlayerTextDrawShow(playerid, Textdraw0[playerid]);
			SelectTextDraw(playerid, 0xD4C598AA);

			new str[64];
			format(str, sizeof(str), "1  %s", GroupInfo[PlayerInfo[playerid][pGroup]][gName]);
			PlayerTextDrawSetString(playerid, Textdraw1[playerid], str);
			PlayerTextDrawShow(playerid, Textdraw1[playerid]);
			PlayerTextDrawShow(playerid, Textdraw4[playerid]);
			PlayerTextDrawShow(playerid, Textdraw7[playerid]);
			PlayerTextDrawShow(playerid, Textdraw10[playerid]);
			PlayerTextDrawShow(playerid, Textdraw13[playerid]);
			PlayerInfo[playerid][pGroupsShow] = 1;
		}
		else
		{
  			GameTextForPlayer(playerid, "~w~Nie nalezysz do ~r~zadnej ~w~grupy!", 3000, 4);
		}
	}
	else
	{
		PlayerInfo[playerid][pGroupsShow] = 0;
		CancelSelectTextDraw(playerid);
		PlayerTextDrawHide(playerid, Textdraw0[playerid]);
		PlayerTextDrawHide(playerid, Textdraw1[playerid]);
		PlayerTextDrawHide(playerid, Textdraw4[playerid]);
		PlayerTextDrawHide(playerid, Textdraw7[playerid]);
		PlayerTextDrawHide(playerid, Textdraw10[playerid]);
		PlayerTextDrawHide(playerid, Textdraw13[playerid]);
	}
	return 1;
}

SetPlayerGroup(playerid, uid)
{
	PlayerInfo[playerid][pGroup] = uid;
	PlayerInfo[playerid][pRank] = 0;
	PlayerInfo[playerid][pUniform] = 0;
	return 1;
}

stock ShowOnlineGroupPlayers(playerid)
{
	new big_str[1024], strNick[128], plrs, header[144];
	foreach(new i : Player)
	{
		if(PlayerInfo[playerid][pGroup] == PlayerInfo[i][pGroup])
		{
			format(strNick, sizeof(strNick), "%d\t%s",i, GetNick(i));
			format(big_str, sizeof(big_str), "%s%s\n", big_str, strNick);
			plrs++;
		}
	}
	format(header, sizeof(header), "Pracownicy (%s)", GroupInfo[PlayerInfo[playerid][pGroup]][gName]);
	if(plrs) ShowPlayerDialogEx(playerid, DIALOG_EMPTY_SC, DIALOG_STYLE_LIST, header, big_str, "OK", "");
	else ShowPlayerDialogEx(playerid, DIALOG_EMPTY_SC, DIALOG_STYLE_LIST, header, "Nie ma nikogo online z tej grupy.", "OK", "");
	return 1;
}

stock InvitePlayerToGroup(playerid, giveid)
{
	if(PlayerInfo[giveid][pGroup] == 0)
	{
		//PlayerInfo[giveid][pGroup] = PlayerInfo[playerid][pGroup];
		SetPVarInt(giveid, "groups_invite_author", playerid);
		new str[126];
		format(str, sizeof(str), "Zosta³eœ zaproszony do grupy %s [%d] przez %s [%d].", GroupInfo[PlayerInfo[playerid][pGroup]][gName], GroupInfo[PlayerInfo[playerid][pGroup]][gUID], GetNick(playerid), playerid);
		ShowPlayerDialogEx(giveid, DIALOG_GROUPS_INVITE, DIALOG_STYLE_MSGBOX, "Zaproszenie do grupy", str, "Akceptuj", "Odrzuæ");
		ShowPlayerDialogEx(playerid, DIALOG_EMPTY_SC, DIALOG_STYLE_MSGBOX, "Wys³ano zaproszenie", "Zaprosi³eœ gracza do grupy.", "OK", "");
	}
	else
	{
		ShowPlayerDialogEx(playerid, DIALOG_EMPTY_SC, DIALOG_STYLE_MSGBOX, "Zaproszenie do grupy", "Gracz posiada maksymaln¹ iloœæ grup.", "OK", "");
	}
	return 1;
}

forward gGPS(playerid);
public gGPS(playerid)
{
	if(PlayerInfo[playerid][pGPS] == 1)
	{
		new Float:PlayerPosX[MAX_PLAYERS], Float:PlayerPosY[MAX_PLAYERS], Float:PlayerPosZ[MAX_PLAYERS];
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pGroup] == PlayerInfo[playerid][pGroup] && PlayerInfo[i][pGroupDuty])
			{
				GetPlayerPos(i, PlayerPosX[i], PlayerPosY[i], PlayerPosZ[i]);
				SetPlayerMapIcon(playerid, i, PlayerPosX[i], PlayerPosY[i], PlayerPosZ[i], 30, 0xFFFFFFFF, MAPICON_GLOBAL);
			}
		}
	}
	return 1;
}

groups_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused listitem
	#pragma unused inputtext
	if(dialogid == DIALOG_GROUPS_INVITE)
	{
		new inviter = GetPVarInt(playerid, "groups_invite_author");
		if(response)
		{
			PlayerInfo[playerid][pGroup] = PlayerInfo[inviter][pGroup];
        	ProxDetector(60.0, playerid, sprintf("* %s podpisuje umowê.", GetNick(playerid)), COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			SendClientMessage(playerid, COLOR_GREY, "TIP: /g [info/online/v/zapros/zadania/wypros/kolor/wplac/wyplac]");
			return 1;
		}
		else 
		{
			return sendErrorMessage(inviter, sprintf("%s odrzuci³ zaproszenie do grupy.", GetNick(playerid)));
		}
	}
	return 1;
}


//end