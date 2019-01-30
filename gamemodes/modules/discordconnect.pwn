stock DiscordConnectInit()
{
	g_SanNewsChannelId=DCC_FindChannelById("538403089263362098");
	g_AdminChannelId=DCC_FindChannelById("538403269077106725");
	g_ReportChannelId=DCC_FindChannelById("538403303550091264");

	return 1;
}
stock SendDiscordMessage(channel, message[])
{
switch(channel)
	{
	// #ig-san-news
	case 0:
	{
    DCC_SendChannelMessage(g_SanNewsChannelId, message);
	}
	// #ig-admin-chat
	case 1:
	{
    DCC_SendChannelMessage(g_AdminChannelId, message);
	}
	// #ig-report
	case 2:
	{
    DCC_SendChannelMessage(g_ReportChannelId, message);
	}
	}
return 1;
}
public DCC_OnChannelMessage(DCC_Channel:channel, DCC_User:author, const message[])
{
	new bool:IsBot;
	DCC_IsUserBot(author, IsBot);
	if(channel == g_AdminChannelId && IsBot == false)
	{
		new user_name[32 + 1],str[128];
		DCC_GetUserName(author, user_name);
		format(str,sizeof(str), "[DISCORD-@] %s: %s",user_name, message);
		SendAdminMessage(0xFFC0CB, str);
	}

	return 1;
}
