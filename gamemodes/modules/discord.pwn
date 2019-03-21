stock DiscordConnectInit()
{
	g_SanNewsChannelId=DCC_FindChannelById("538403089263362098");
	g_AdminChannelId=DCC_FindChannelById("538403269077106725");
	g_ReportChannelId=DCC_FindChannelById("538403303550091264");
	
	g_FracChannel[1]=DCC_FindChannelById("545045344652886056");
	g_FracChannel[2]=DCC_FindChannelById("545620322423144459");
	g_FracChannel[4]=DCC_FindChannelById("545619975151288321");
	g_FracChannel[5]=DCC_FindChannelById("545625556578992128");
	g_FracChannel[7]=DCC_FindChannelById("545626921950511104");
	g_FracChannel[9]=DCC_FindChannelById("545621434098253824");
	g_FracChannel[10]=DCC_FindChannelById("545622580246347776");
	g_FracChannel[11]=DCC_FindChannelById("545622546939117569");
	g_FracChannel[12]=DCC_FindChannelById("545642957106053123");
	g_FracChannel[13]=DCC_FindChannelById("557567568198631441");
	g_FracChannel[15]=DCC_FindChannelById("545643012437311491");
	g_FracChannel[16]=DCC_FindChannelById("545643300736991235");
	g_FracChannel[17]=DCC_FindChannelById("545619305832775700");
	g_OrgChannel[1]=DCC_FindChannelById("545643431112867841");
	
	
	return 1;
}
stock SendDiscordMessage(channel, message[])
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

stock SendDiscordFracMessage(fractionid, message[])
{
	new dest[512];
	utf8encode(dest, message);
	DCC_SendChannelMessage(g_FracChannel[fractionid], dest);

	return 1;
}
stock SendDiscordOrgMessage(orgid, message[])
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
		SendAdminMessage(0xFFC0CB, dest);
		
		return 1;
	}
	else if(channel == g_OrgChannel[1] && IsBot == false)
	{
		new user_name[32 + 1],str[128], dest[128];
		DCC_GetUserName(author, user_name);
		format(str,sizeof(str), "[DISCORD] %s: %s",user_name, message);
		utf8decode(dest, str);
		SendNewFamilyMessage(1, TEAM_AZTECAS_COLOR, dest);
		return 1;
	}
	for(new i=0;i<MAX_ORG;i++)
	{
		if(channel == g_FracChannel[i] && IsBot == false) 
		{
			new user_name[32 + 1],str[128],dest[128];
			DCC_GetUserName(author, user_name);
			format(str,sizeof(str), "[DISCORD] %s: %s",user_name, message);
			utf8decode(dest, str);
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

