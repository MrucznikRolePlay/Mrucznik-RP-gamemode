/*
 Homers stupid functions xD
*/

/*
            PlayerIP - 
You can get Player's IP
*/

stock PlayerIP(playerid)
{
    new pIP[24];
    GetPlayerIp(playerid, pIP, sizeof(pIP));
    return pIP;
}

/*
            PlayerName - 
You can get Player's name
*/

stock PlayerName(playerid)
{
    new pName[24];
    GetPlayerName(playerid, pName, 24);
    return pName;
}

/*
            PlayerPing - 
You can get Player's ping
*/

stock PlayerPing(playerid)
{
    new pPing[24];
    GetPlayerPing(playerid, pPing, 24);
    return pPing;
}

/*
            CheckValidWeapon - 
Is your gived weapon valid? If no - Lets crash, so this function is cool xP
Usage? Example:
if(!CheckValidWeapon(wep))
{
SendClientMessage(playerid,COLOUR_***,"[ ! ] Invalid weapon!");
    return 1;
}
*/

stock CheckValidWeapon(wepid)
{
   if (wepid > 0 && wepid< 19 || wepid > 21 && wepid < 47)
   {
       return 1;
   }
    return 0;
}

/*
            CheckValidWeather- 
Is server weather valid? If no - Server will crash, or all players will get "matrix"...
Usage? Example:
if(!CheckValidWeather(weatherid))
{
SendClientMessage(playerid,COLOUR_***,"[ ! ] Invalid weather ID!");
    return 1;
}
*/

stock CheckValidWeather(wid)
{
   if (wid > 0 && wid < 50)
   {
       return 1;
   }
    return 0;
}

/*
            CheckValidTime - 
Is server time valid?
Usage? Example:
if(!CheckValidTime(timeid))
{
SendClientMessage(playerid,COLOUR_***,"[ ! ] Invalid time!");
    return 1;
}
*/

stock CheckValidTime(timeid)
{
   if (timeid > 1 && timeid < 24)
   {
       return 1;
   }
    return 0;
}

/*
            CheckValidHealth - 
Is player health valid? If no - He will get deathlessnes...
Usage? Example:
[command /sethp]
if(!CheckValidHealth(playerid))
{
SendClientMessage(playerid,COLOUR_***,"[ ! ] Invalid health amount!");
    return 1;
}
*/

stock CheckValidHealth(playerid,hp)
{
   if (hp => 0 && hp <= 100)
   {
       return 1;
   }
    return 0;
}

/*
            CheckValidArmour - 
Is player armour valid? If no - He will get deathlessnes...
Usage? Example:
[command /setarm]
if(!CheckValidArmour(playerid))
{
SendClientMessage(playerid,COLOUR_***,"[ ! ] Invalid armour amount!");
    return 1;
}
*/

stock CheckValidArmour(playerid,arm)
{
   if (arm => 0 && arm <= 100)
   {
       return 1;
   }
    return 0;
}

/*
            CheckValidSkin - 
Is Player's skin valid? If no - Let's crash all players...
Usage? Example:
[command /setskin]
if(!CheckValidSkin(playerid))
{
SendClientMessage(playerid,COLOUR_***,"[ ! ] Invalid Skin ID!");
    return 1;
}
*/

stock CheckValidSkin(playerid,SkinID)
{
    if((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID    <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >=    150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID    <= 299))
   {
       return 1;
   }
   return 0;
}


//Not My Script
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}