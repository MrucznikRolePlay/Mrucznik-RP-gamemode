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
// LoadDiscordChannels()
// {
//     new query[512], type, org_id, channel_id[64];
//     mysql_query("SELECT `type`, `org_id`, `channel_id` FROM `mru_discord` ORDER BY `id` ASC");
//     mysql_store_result();

//     while(mysql_fetch_row_format(query, "|"))
//     {
//         sscanf(query, "p<|>dds[64]", type, org_id, channel_id);
//         if(type == 1) //frakcja
//         {
// 			g_FracChannel[org_id] = DCC_FindChannelById(channel_id);
//         }
//         else //rodzina
//         {
//             g_OrgChannel[org_id] = DCC_FindChannelById(channel_id);
//         }
//     }
//     mysql_free_result();
//     print("Wczytano kana³y discord");
// }

// DiscordConnectInit()
// {
// 	g_GSLSLOGChannelId=DCC_FindChannelById("723216208165601321"); // GS Los Santos log
// 	g_GSCMLOGChannelId=DCC_FindChannelById("723216292081041408"); // GS Commerce log
// 	g_GSWFLOGChannelId=DCC_FindChannelById("723216357835145376"); // GS Willowfield log
// 	g_SanNewsChannelId=DCC_FindChannelById("696491963582513272"); //ig-san-news
// 	g_AdminChannelIdDefault = DCC_FindChannelById("696501357208797214");
// 	g_AdminChannelId[0]=DCC_FindChannelById("721817402131742790"); //ig-admin
// 	g_AdminChannelId[1]=DCC_FindChannelById("721817372008120370"); //ig-admin
// 	g_AdminChannelId[2]=DCC_FindChannelById("721817343629721640"); //ig-admin
// 	g_AdminChannelId[3]=DCC_FindChannelById("721817226667229264"); //ig-admin
// 	g_AdminChannelId[4]=DCC_FindChannelById("721817199156920340"); //ig-admin
// 	g_AdminChannelId[5]=DCC_FindChannelById("721817165417676963"); //ig-admin
// 	g_AdminChannelId[6]=DCC_FindChannelById("721817080856444938"); //ig-admin
// 	g_AdminChannelId[7]=DCC_FindChannelById("721817054059036794"); //ig-admin
// 	g_AdminChannelId[8]=DCC_FindChannelById("721817029211979806"); //ig-admin
// 	g_AdminChannelId[9]=DCC_FindChannelById("721817002410377326"); //ig-admin
// 	g_AdminChannelId[10]=DCC_FindChannelById("721816976300965909"); //ig-admin
// 	g_AdminChannelId[11]=DCC_FindChannelById("721816940020236289"); //ig-admin
// 	g_AdminChannelId[12]=DCC_FindChannelById("721816915441352815"); //ig-admin
// 	g_AdminChannelId[13]=DCC_FindChannelById("721816882734432397"); //ig-admin
// 	g_AdminChannelId[14]=DCC_FindChannelById("721816850471846089"); //ig-admin
// 	g_AdminChannelId[15]=DCC_FindChannelById("721816814094647418"); //ig-admin
// 	g_AdminChannelId[16]=DCC_FindChannelById("721816785631838208"); //ig-admin
// 	g_ReportChannelId=DCC_FindChannelById("697009695495422012"); //ig-report

// 	LoadDiscordChannels();
// 	return 1;
// }

SendDiscordMessage(channel, message[])
{
	// TODO: make discord plugin coexists with requests plugin and enable it
	#pragma unused channel, message
	// new dest[512];
	// utf8encode(dest, message);
	// switch(channel)
	// {
	// 	case 0:
	// 	{
	// 		DCC_SendChannelMessage(g_SanNewsChannelId, dest); // #ig-san-newsxd
	// 	}
	// 	case 1:
	// 	{
	// 		DCC_SendChannelMessage(g_AdminChannelIdDefault, dest);
	// 		for(new i; i<17; i++)
	// 			DCC_SendChannelMessage(g_AdminChannelId[i], dest); // #ig-admin-chat
	// 	}
	// 	case 2:
	// 	{
	// 		DCC_SendChannelMessage(g_ReportChannelId, dest); // #ig-report
	// 	}
	// 	case 3:
	// 	{
	// 		DCC_SendChannelMessage(g_GSLSLOGChannelId, dest); // #gunshop-los-santos
	// 	}
	// 	case 4:
	// 	{
	// 		DCC_SendChannelMessage(g_GSCMLOGChannelId, dest); // #gunshop-commerce
	// 	}
	// 	case 5:
	// 	{
	// 		DCC_SendChannelMessage(g_GSWFLOGChannelId, dest); // #gunshop-willowfield
	// 	}
	// }
	return 1;
}

SendDiscordFracMessage(fractionid, message[])
{
	// TODO: make discord plugin coexists with requests plugin and enable it
	#pragma unused fractionid, message
	// new dest[512];
	// utf8encode(dest, message);
	// DCC_SendChannelMessage(g_FracChannel[fractionid], dest);

	return 1;
}
SendDiscordOrgMessage(orgid, message[])
{
	// TODO: make discord plugin coexists with requests plugin and enable it
	#pragma unused orgid, message
	// if(_:g_OrgChannel[orgid] == 0) return 1;

	// new dest[512];
	// utf8encode(dest, message);
	// DCC_SendChannelMessage(g_OrgChannel[orgid], dest);

	return 1;
}

// public DCC_OnMessageCreate(DCC_Message:message)
// {
// 	new textMsg[MAX_MESSAGE_LENGTH];
//     DCC_GetMessageContent(message, textMsg, MAX_MESSAGE_LENGTH);
//     new DCC_Channel:channel;
//     DCC_GetMessageChannel(message, channel);
//     new DCC_User:author;
//     DCC_GetMessageAuthor(message, author);
// 	new bool:IsBot;
// 	DCC_IsUserBot(author, IsBot);
// 	for(new i; i<17; i++)
// 	{
// 		if(channel == g_AdminChannelId[i] && IsBot == false)
// 		{
// 			new user_name[32 + 1],str[MAX_MESSAGE_LENGTH], dest[MAX_MESSAGE_LENGTH];
// 			DCC_GetUserName(author, user_name);
// 			format(str,sizeof(str), "[DISCORD] %s: %s",user_name, textMsg);
// 			utf8decode(dest, str);
// 			strreplace(dest,"%","#");
// 			SendAdminMessage(0xFFC0CB, dest);
// 			return 1;
// 		}
// 	}
// 	if(channel == g_AdminChannelIdDefault && IsBot == false)
// 	{
// 		new user_name[32 + 1],str[MAX_MESSAGE_LENGTH], dest[MAX_MESSAGE_LENGTH];
// 		DCC_GetUserName(author, user_name);
// 		format(str,sizeof(str), "[DISCORD] %s: %s",user_name, textMsg);
// 		utf8decode(dest, str);
// 		strreplace(dest,"%","#");
// 		SendAdminMessage(0xFFC0CB, dest);
// 		return 1;
// 	}
	
// 	for(new i=0;i<MAX_ORG;i++)
//     {
// 		if(channel == g_OrgChannel[i] && IsBot == false) 
// 		{
// 			new user_name[32 + 1],str[MAX_MESSAGE_LENGTH],dest[MAX_MESSAGE_LENGTH];
// 			DCC_GetUserName(author, user_name);
// 			format(str,sizeof(str), "[DISCORD] %s: %s",user_name, textMsg);
// 			utf8decode(dest, str);
// 			strreplace(dest,"%","#");
// 			SendNewFamilyMessage(i, TEAM_AZTECAS_COLOR, dest);
// 			return 1;
// 		}
//     }
// 	for(new i=0;i<MAX_FRAC;i++)
// 	{
// 		if(channel == g_FracChannel[i] && IsBot == false) 
// 		{
// 			new user_name[32 + 1],str[MAX_MESSAGE_LENGTH],dest[MAX_MESSAGE_LENGTH];
// 			DCC_GetUserName(author, user_name);
// 			format(str,sizeof(str), "[DISCORD] %s: %s",user_name, textMsg);
// 			utf8decode(dest, str);
// 			strreplace(dest,"%","#");
// 			if(0 < i <= 4 || i == 11 || i == 7 || i == 17)
// 			{
// 				SendRadioMessage(i, TEAM_BLUE_COLOR, dest);
// 			}
// 			else 
// 			{
// 				SendFamilyMessage(i, TEAM_AZTECAS_COLOR, dest);
// 			}
// 			return 1;
// 		}
// 	}
// 	return 0;
// }


//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end