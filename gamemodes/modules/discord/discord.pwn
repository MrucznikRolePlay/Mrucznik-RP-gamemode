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
	g_SanNewsChannelId=DCC_FindChannelById("604719827608797240");
	g_AdminChannelId=DCC_FindChannelById("604719840720191522");
	g_ReportChannelId=DCC_FindChannelById("604719842020294666");

	g_FracChannel[1]=DCC_FindChannelById("604719843295625226");
	g_FracChannel[2]=DCC_FindChannelById("604719853823066150");
	g_FracChannel[3]=DCC_FindChannelById("604719856847421471");
	g_FracChannel[4]=DCC_FindChannelById("604719860517437448");
	g_FracChannel[5]=DCC_FindChannelById("604719863713234986");
	g_FracChannel[6]=DCC_FindChannelById("604719865579962418");
	g_FracChannel[7]=DCC_FindChannelById("604719866955431946");
	g_FracChannel[8]=DCC_FindChannelById("604719868251602977");
	g_FracChannel[9]=DCC_FindChannelById("604719869505830932");
	g_FracChannel[10]=DCC_FindChannelById("604719870957060097");
	g_FracChannel[11]=DCC_FindChannelById("604719872341049354");
	g_FracChannel[12]=DCC_FindChannelById("604719873393819659");
	g_FracChannel[13]=DCC_FindChannelById("604719874958426122");
	g_FracChannel[14]=DCC_FindChannelById("604719876371775595");
	g_FracChannel[15]=DCC_FindChannelById("604719877957222422");
	g_FracChannel[16]=DCC_FindChannelById("604719879261650994");
	g_FracChannel[17]=DCC_FindChannelById("604719880423342091");
	g_OrgChannel[1]=DCC_FindChannelById("604719882147201036");


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