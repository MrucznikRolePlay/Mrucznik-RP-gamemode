//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  discord                                                  //
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
// Autor: skTom
// Data utworzenia: 04.05.2019
//Opis:
/*
	Modu³ ³¹cz¹cy gamemod z Mrucznikowym Discordem.
*/

//

//-----------------<[ Callbacki: ]>-----------------
//-----------------<[ Funkcje: ]>-------------------
DiscordConnectInit()
{
	g_SanNewsChannelId=DCC_FindChannelById("696491963582513272"); //ig-san-news
	g_AdminChannelId=DCC_FindChannelById("696501357208797214"); //ig-admin
	g_ReportChannelId=DCC_FindChannelById("697009695495422012"); //ig-report

	g_FracChannel[1]=DCC_FindChannelById("696503084230246441"); //lspd
	g_FracChannel[2]=DCC_FindChannelById("696502567944847410"); //fbi
	g_FracChannel[3]=DCC_FindChannelById("696506775708368998"); //ng/szeryfy
	g_FracChannel[4]=DCC_FindChannelById("696502406246301796"); //ers
	g_FracChannel[5]=DCC_FindChannelById("696503755629396029"); //bahamas (lcn)
	g_FracChannel[6]=DCC_FindChannelById("696502831850455061"); //ykz
	g_FracChannel[7]=DCC_FindChannelById("696502330350108732"); //usss
	g_FracChannel[8]=DCC_FindChannelById("696503652399185921"); //ha
	g_FracChannel[9]=DCC_FindChannelById("696503843168583721"); //san
	g_FracChannel[10]=DCC_FindChannelById("696503261557162095"); //kt
	g_FracChannel[11]=DCC_FindChannelById("696503517099065434"); //dmv
	g_FracChannel[12]=DCC_FindChannelById("696502501377310750"); //groove
	g_FracChannel[13]=DCC_FindChannelById("696840092404154418"); //89-border society (crackville)
	g_FracChannel[14]=DCC_FindChannelById("696506988313444402"); //northenos
	g_FracChannel[15]=DCC_FindChannelById("696506868050165810"); //nightmare adrenaline
	g_FracChannel[16]=DCC_FindChannelById("696502619505426454"); //sanreich
	g_FracChannel[17]=DCC_FindChannelById("696506926825078864"); //wps? puste
	g_OrgChannel[1]=DCC_FindChannelById("696507102503632906"); //s¹d
	g_OrgChannel[3]=DCC_FindChannelById("697175866547109899 "); //rodzin 


	return 1;
}
SendDiscordMessage(channel, message[])
{
	new dest[512];
	utf8encode(dest, message);
	switch(channel)
	{
		case 0:
		{
			DCC_SendChannelMessage(g_SanNewsChannelId, dest); // #ig-san-newsxd
		}
		case 1:
		{
			DCC_SendChannelMessage(g_AdminChannelId, dest); // #ig-admin-chat
		}
		case 2:
		{
			DCC_SendChannelMessage(g_ReportChannelId, dest); // #ig-report
		}
	}
	return 1;
}

SendDiscordFracMessage(fractionid, message[])
{
	new dest[512];
	utf8encode(dest, message);
	DCC_SendChannelMessage(g_FracChannel[fractionid], dest);

	return 1;
}
SendDiscordOrgMessage(orgid, message[])
{
	if(_:g_OrgChannel[orgid] == 0) return 1;

	new dest[512];
	utf8encode(dest, message);
	DCC_SendChannelMessage(g_OrgChannel[orgid], dest);

	return 1;
}
public DCC_OnChannelMessage(DCC_Channel:channel, DCC_User:author, const message[])
{
	new bool:IsBot;
	DCC_IsUserBot(author, IsBot);
	if(channel == g_AdminChannelId && IsBot == false)
	{
		new user_name[32 + 1],str[128], dest[128];
		DCC_GetUserName(author, user_name);
		format(str,sizeof(str), "[DISCORD] %s: %s",user_name, message);
		utf8decode(dest, str);
		strreplace(dest,"%","#");
		SendAdminMessage(0xFFC0CB, dest);

		return 1;
	}
	else if(channel == g_OrgChannel[1] && IsBot == false)
	{
		new user_name[32 + 1],str[128], dest[128];
		DCC_GetUserName(author, user_name);
		format(str,sizeof(str), "[DISCORD] %s: %s",user_name, message);
		utf8decode(dest, str);
		strreplace(dest,"%","#");
		SendNewFamilyMessage(1, TEAM_AZTECAS_COLOR, dest);
		return 1;
	}
	for(new i=0;i<MAX_FRAC;i++)
	{
		if(channel == g_FracChannel[i] && IsBot == false) 
		{
			new user_name[32 + 1],str[128],dest[128];
			DCC_GetUserName(author, user_name);
			format(str,sizeof(str), "[DISCORD] %s: %s",user_name, message);
			utf8decode(dest, str);
			strreplace(dest,"%","#");
			if(0 < i <= 4 || i == 11 || i == 7 || i == 17)
			{
				SendRadioMessage(i, TEAM_BLUE_COLOR, dest);
			}
			else 
			{
				SendFamilyMessage(i, TEAM_AZTECAS_COLOR, dest);
			}
			return 1;
		}
	}
	return 0;
}


//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end