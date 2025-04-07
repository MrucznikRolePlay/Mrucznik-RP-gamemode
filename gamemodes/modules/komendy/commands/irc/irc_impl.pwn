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
command_irc_Impl(playerid, params[256])
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new x_nr[16];
        new channel, password[32];
        if( sscanf(params, "s[16]D(0)S(brak)[32]", x_nr, channel, password))
        {
            sendTipMessage(playerid, "Pomoc: (/irc join [nrkana�u]   /irc join [nrkana�u] [password])  (/irc Leave)  (/irc Admins)");
            sendTipMessage(playerid, "Pomoc: /irc [name] [nrkana�u]");
            sendTipMessage(playerid, "Dost�pne nazwy: MOTD, Password, NeedPass, Lock, Kick, Status");
            return 1;
        }
        if(strcmp(x_nr,"join",true) == 0)
        {
            if(channel < 1 || channel > 10) { sendTipMessageEx(playerid, COLOR_GREY, "Numer kana�u od 1 do 10 !"); return 1; }
            channel -= 1;
            if(IRCInfo[channel][iLock] == 0)
            {
                if(IRCInfo[channel][iNeedPass] == 0)
                {
                    JoinChannelNr(playerid, channel);
                } else
                {

                    if(!strlen(password))
                    {
                        sendTipMessageEx(playerid, COLOR_WHITE, "Aby do��czy� do tego kana�u musisz zna� has�o.");
                        sendTipMessageEx(playerid, COLOR_WHITE, "U�ycie /irc join [nrkana�u] [has�o]");
                        return 1;
                    }
                    JoinChannel(playerid,channel,password);
                }
            } else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Ten kana� jest zablokowany, wybierz inny!");
                return 1;
            }
        } else if(strcmp(x_nr,"status",true) == 0)
        {
            for(new i = 0; i < sizeof(IRCInfo); i++)
            {
                format(string, sizeof(string), "Kana� %d: %d Graczy na kanale.",i + 1, IRCInfo[i][iPlayers]);
                SendClientMessage(playerid, COLOR_WHITE, string);
            }
            return 1;
        } else if(strcmp(x_nr,"password",true) == 0)
        {
            if(channel < 1 || channel > 10) { sendTipMessageEx(playerid, COLOR_GREY, "Numer kana�u od 1 do 10 !"); return 1; }
            channel -= 1;
            new wstring[128];
            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string), "%s", sendername);
            strmid(wstring, string, 0, strlen(string));
            if(strcmp(IRCInfo[channel][iAdmin],wstring, true ) == 0 )
            {

                if(!strlen(password))
                {
                    sendTipMessage(playerid, "U�yj /irc password [nrkana�u] [has�o]");
                    return 1;
                }
                strmid(IRCInfo[channel][iPassword], password, 0, strlen(password));
                format(string, sizeof(string), "Zmini�e� has�o kana�u IRC na: %s.",IRCInfo[channel][iPassword]);
                SendClientMessage(playerid, COLOR_YELLOW, string);
                SaveIRC();
                return 1;
            } else
            {
                noAccessMessage(playerid);
                return 1;
            }
        } else if(strcmp(x_nr,"needpass",true) == 0)
        {
            if(channel < 1 || channel > 10) { sendTipMessageEx(playerid, COLOR_GREY, "Numer kana�u od 1 do 10 !"); return 1; }
            channel -= 1;
            new wstring[128];
            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string), "%s", sendername);
            strmid(wstring, string, 0, strlen(string));
            if(strcmp(IRCInfo[channel][iAdmin],wstring, true ) == 0 )
            {
                if(IRCInfo[channel][iNeedPass] != 0)
                {
                    IRCInfo[channel][iNeedPass] = 0;
                    sendTipMessageEx(playerid, COLOR_YELLOW, "Teraz gracze nie bed� potrzebowa� has�a aby wej��.");
                } else
                {
                    IRCInfo[channel][iNeedPass] = 1;
                    sendTipMessageEx(playerid, COLOR_YELLOW, "Teraz gracze b�d� musieli zna� has�o aby do��czy�.");
                }
                SaveIRC();
                return 1;
            } else
            {
                noAccessMessage(playerid);
                return 1;
            }
        } else if(strcmp(x_nr,"lock",true) == 0)
        {
            if(channel < 1 || channel > 10) { sendTipMessageEx(playerid, COLOR_GREY, "Numer kana�u od 1 do 10 !"); return 1; }
            channel -= 1;
            new wstring[128];
            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string), "%s", sendername);
            strmid(wstring, string, 0, strlen(string));
            if(strcmp(IRCInfo[channel][iAdmin],wstring, true ) == 0 )
            {
                if(IRCInfo[channel][iLock] != 0)
                {
                    IRCInfo[channel][iLock] = 0;
                    sendTipMessageEx(playerid, COLOR_YELLOW, "Odblokowa�e� kana� IRC.");
                } else
                {
                    IRCInfo[channel][iLock] = 1;
                    sendTipMessageEx(playerid, COLOR_YELLOW, "Zablokowa�e� kana� IRC.");
                }
                SaveIRC();
                return 1;
            } else
            {
                noAccessMessage(playerid);
                return 1;
            }
        } else if(strcmp(x_nr,"motd",true) == 0)
        {
            if(channel < 1 || channel > 10) { sendTipMessageEx(playerid, COLOR_GREY, "Numer kana�u od 1 do 10 !"); return 1; }
            channel -= 1;
            new wstring[128];
            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string), "%s", sendername);
            strmid(wstring, string, 0, strlen(string));
            if(strcmp(IRCInfo[channel][iAdmin],wstring, true ) == 0 )
            {
                if(!strlen(password))
                {
                    sendTipMessage(playerid, "U�yj /irc motd [motdtext]");
                    return 1;
                }
                strmid(IRCInfo[channel][iMOTD], password, 0, strlen(password));
                sendTipMessageEx(playerid, COLOR_YELLOW, "Zmieni�e� MOTD kana�u IRC.");
                SaveIRC();
                return 1;
            } else
            {
                noAccessMessage(playerid);
                return 1;
            }
        } else if(strcmp(x_nr,"leave",true) == 0)
        {
            if(PlayersChannel[playerid] < 999)
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                format(string, sizeof(string), "* %s opu�ci� kana�.", sendername);
                SendIRCMessage(PlayersChannel[playerid], COLOR_GREEN, string);
                IRCInfo[PlayersChannel[playerid]][iPlayers] -= 1;
                PlayersChannel[playerid] = 999;
                return 1;
            } else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� na �adnym kanale IRC !");
                return 1;
            }
        } else if(strcmp(x_nr,"admins",true) == 0)
        {
            for(new i = 0; i < sizeof(IRCInfo); i++)
            {
                format(string, sizeof(string), "Kana� %d: %s.", i + 1, IRCInfo[i][iAdmin]);
                SendClientMessage(playerid, COLOR_WHITE, string);
            }
            return 1;
        } else if(strcmp(x_nr,"kick",true) == 0)
        {
            if(PlayersChannel[playerid] == 999)
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� na kanale IRC !");
                return 1;
            }
            new wstring[128];
            GetPlayerName(playerid, sendername, sizeof(sendername));
            format(string, sizeof(string), "%s", sendername);
            strmid(wstring, string, 0, strlen(string));
            if(strcmp(IRCInfo[PlayersChannel[playerid]][iAdmin],wstring, true ) == 0 )
            {

                if(!strlen(password))
                {
                    sendTipMessage(playerid, "U�yj /irc kick [playerid/Cz��Nicku]");
                    return 1;
                }

                new giveplayerid;
                sscanf(password, "k<fix>", giveplayerid);

                if(IsPlayerConnected(giveplayerid))
                {
                    if(giveplayerid != INVALID_PLAYER_ID)
                    {
                        if(PlayersChannel[giveplayerid] == PlayersChannel[playerid])
                        {
                            GetPlayerName(playerid, sendername, sizeof(sendername));
                            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                            format(string, sizeof(string), "* Zkickowa�e� %s z kana�u IRC.",giveplayer);
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            format(string, sizeof(string), "* Zosta�e� zkickowany z kana�u IRC przez admina: %s.",sendername);
                            SendClientMessage(giveplayerid, COLOR_YELLOW, string);
                            format(string, sizeof(string), "* %s opu�ci� kana� (kick).", sendername);
                            SendIRCMessage(PlayersChannel[playerid], COLOR_GREEN, string);
                            IRCInfo[PlayersChannel[giveplayerid]][iPlayers] -= 1;
                            PlayersChannel[giveplayerid] = 999;
                        } else
                        {
                            SendClientMessage(playerid, COLOR_GREY, "Ten gracz nie jest na twoim kanale IRC !");
                            return 1;
                        }
                    }
                } else
                {
                    sendErrorMessage(playerid, "Nie ma takiego gracza!");
                    return 1;
                }
            } else
            {
                noAccessMessage(playerid);
                return 1;
            }
        } else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Z�y kod IRC!");
            return 1;
        }
    }
    return 1;
}

//end
