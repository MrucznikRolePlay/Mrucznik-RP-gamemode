//-------------------------------------------------------------------------------

stock GetPlayerId(playername[]) //By Alex "Y_Less" Cole (Edited by Sacky && Smugller)
{
 for (new i = 0; i < MAX_PLAYERS; i++)
 {
  if (IsPlayerConnected(i))
  {
   if(strcmp(playername,Player(i),true)==0)
   {
    return i;
   }
  }
 }
 return  INVALID_PLAYER_ID;
}
native GetPlayerId(playername[]);

//-------------------------------------------------------------------------------

stock GetMatchingID(string[]) //by Xtreme
{
  new name[24], id;
  for(new i = 0; i < MAX_PLAYERS; i++)
  {
   if(IsPlayerConnected(i))
   {
    GetPlayerName(i,name,sizeof(name));
    new found = strfind(name,string,true);
    if(found != -1)
    {
     id = i;
     break;  // Exit the loop to stop searching and continue the rest of the statement. (return)
    }
   }
  }
 return id;
}
native GetMatchingID(string[]);

//-------------------------------------------------------------------------------

stock Float:GetPlayerArmourEx(playerid) //by Luby (Edited by Smugller)
{
 new Float:a;
 GetPlayerArmour(playerid, a);
 return a;
}
native Float:GetPlayerArmourEx(playerid);

//-------------------------------------------------------------------------------

stock ReturnPlayerName(playerid) //By Alex "Y_Less" Cole
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof (pname));
	return pname;
}
native ReturnPlayerName(playerid);

//-------------------------------------------------------------------------------

stock Player(playerid) //by Smugller (based by original ReturnPlayerName(playerid) by Alex "Y_Less" Cole )
{
	new player[MAX_PLAYER_NAME];
	GetPlayerName(playerid, player, sizeof(player));
	return player;
}
native Player(playerid);

//-------------------------------------------------------------------------------

stock Killer(killerid) //by Smugller (based by original ReturnPlayerName(playerid) by Alex "Y_Less" Cole )
{
new killer[MAX_PLAYER_NAME];
GetPlayerName(killerid, killer, sizeof(killer));
 return killer;
}
native Killer(killerid);

//-------------------------------------------------------------------------------

stock ReturnUser(text[], playerid = INVALID_PLAYER_ID) //by Y_Less
{
new pos = 0;
while (text[pos] < 0x21) // Strip out leading spaces
{
if (text[pos] == 0) return INVALID_PLAYER_ID; // No passed text
pos++;
}
new userid = INVALID_PLAYER_ID;
if (IsNumeric(text[pos])) // Check whole passed string
{
// If they have a numeric name you have a problem (although names are checked on id failure)
userid = strval(text[pos]);
if (userid >=0 && userid < MAX_PLAYERS)
{
if(!IsPlayerConnected(userid))
{
/*if (playerid != INVALID_PLAYER_ID)
{
SendClientMessage(playerid, 0xFF0000AA, "User not connected");
}*/
userid = INVALID_PLAYER_ID;
}
else
{
return userid; // A player was found
}
}
/*else
{
if (playerid != INVALID_PLAYER_ID)
{
SendClientMessage(playerid, 0xFF0000AA, "Invalid user ID");
}
userid = INVALID_PLAYER_ID;
}
return userid;*/
// Removed for fallthrough code
}
// They entered [part of] a name or the id search failed (check names just incase)
new len = strlen(text[pos]);
new count = 0;
new name[MAX_PLAYER_NAME];
for (new i = 0; i < MAX_PLAYERS; i++)
{
if (IsPlayerConnected(i))
{
GetPlayerName(i, name, sizeof (name));
if (strcmp(name, text[pos], true, len) == 0) // Check segment of name
{
if (len == strlen(name)) // Exact match
{
return i; // Return the exact player on an exact match
// Otherwise if there are two players:
// Me and MeYou any time you entered Me it would find both
// And never be able to return just Me's id
}
else // Partial match
{
count++;
userid = i;
}
}
}
}
if (count != 1)
{
if (playerid != INVALID_PLAYER_ID)
{
if (count)
{
SendClientMessage(playerid, 0xFF0000AA, "Multiple users found, please narrow earch");
}
else
{
SendClientMessage(playerid, 0xFF0000AA, "No matching user found");
}
}
userid = INVALID_PLAYER_ID;
}
return userid; // INVALID_USER_ID for bad return
}
native ReturnUser(text[], playerid = INVALID_PLAYER_ID);

//-------------------------------------------------------------------------------

stock ReturnUserEx(text[], id = INVALID_PLAYER_ID) //by !damo!spiderman
{
	for(new i =0; i < MAX_PLAYERS;i++)
 {
  if(IsPlayerConnected(i))
  {
		 new pName[MAX_PLAYER_NAME];
	 	GetPlayerName(i,pName,MAX_PLAYER_NAME);
			if (strfind(pName,text,true)==0)
			{
				return i;
			}
	 }
	else
	id = INVALID_PLAYER_ID;
	return id;
	}
 return 1;
}
native ReturnUserEx(text[], id = INVALID_PLAYER_ID);

//-------------------------------------------------------------------------------

stock SetPlayerMoney(playerid, money) //By Jan "DracoBlue" Schütze (Edited by Sacky)
{
 GivePlayerMoney(playerid,money-GetPlayerMoney(playerid));
}
native SetPlayerMoney(playerid,money);

//-------------------------------------------------------------------------------

stock PlayerID(partofname[]) //By Jan "DracoBlue" Schütze
{
   new i;
   new playername[MAX_STRING];
   for (i=0;i<MAX_PLAYERS;i++) {
     if (IsPlayerConnected(i)) {
       GetPlayerName(i,playername,MAX_STRING);
       if (strcmp(playername,partofname,true)==0) {
         return i;
       }
     }
   }
    new correctsigns_userid=-1;
    new tmpuname[MAX_STRING];
    new hasmultiple=-1;
    for (i=0;i<MAX_PLAYERS;i++) {
        if (IsPlayerConnected(i)) {
          GetPlayerName(i,tmpuname,MAX_STRING);
	  if (strfind(tmpuname,partofname,true)==0) {
	    hasmultiple++;
	    correctsigns_userid=i;
          }
	  if (hasmultiple>0) {
            return -2;
          }
       }
    }
  return correctsigns_userid;
}
native PlayerID(partofname[]);

//-------------------------------------------------------------------------------

stock IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy) //By Alex "Y_Less" Cole
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy) return 1;
	return 0;
}
native IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy);

//-------------------------------------------------------------------------------

stock IsPlayerIn2DArea(playerid, Float:data[4]) // by Betamaster
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	if(pos[0] >= data[0] && pos[0] <= data[2] && pos[1] >= data[1] && pos[1] <= data[3]) return 1;
	return 0;
}
native IsPlayerIn2DArea(playerid, Float:data[4]);

//-------------------------------------------------------------------------------

stock IsPlayerInCube(playerid, xmin, ymin, zmin, xmax, ymax, zmax) //By 50p
{
   new Float:x, Float:y, Float:z;
   GetPlayerPos(playerid, x, y, z);
   if( x > xmin && y > ymin && z > zmin && x < xmax && y < ymax && z < zmax) return 1;
   return 0;
}
native IsPlayerInCube(playerid, xmin, ymin, zmin, xmax, ymax, zmax);

//-------------------------------------------------------------------------------

stock IsPlayerIn3DArea(playerid, Float:data[6]) // By Betamaster
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	if(pos[0] >= data[0] && pos[0] <= data[3] && pos[1] >= data[1] && pos[1] <= data[4] && pos[2] >= data[2] && pos[2] <= data[5]) return 1;
	return 0;
}
native IsPlayerIn3DArea(playerid, Float:data[6]);

//-------------------------------------------------------------------------------

stock IsPlayerInAreaEx(playerid, Float:...) //By kool
{
        new Count = numargs();
        new Float:xe[255], Float:ye[255];
        new j=0;
        for(new i=1; i<Count; i+=2)
        {
                xe[j] = Float:getarg(i);
                ye[j] = Float:getarg(i+1);
                j++;
        }
        xe[j] = xe[0];
        ye[j] = ye[0];
        new Lines;
        new Float:xcut;
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        for(new i=0; i<j; i++)
        {
                xcut = xe[i]+((y-ye[i])*(xe[i+1]-xe[i])/(ye[i+1]-ye[i]));
                if(((y >= ye[i] && y <= ye[i+1]) || (y >= ye[i+1] && y <= ye[i])) && xcut < x)
                        Lines++;
        }
        if(Lines%2 == 1)
                return 1;
        return 0;
}
native IsPlayerInAreaEx(playerid, Float:...);

//-------------------------------------------------------------------------------

stock IsPlayerInRange(playerid, Float: Range, Float: Z_Range, Float:tar_x, Float:tar_y, Float:tar_z) //By Simon
{
new Float:player_x, Float:player_y, Float:player_z;
GetPlayerPos(playerid, player_x, player_y, player_z);
 if(player_x - tar_x <= Range && player_x - tar_x >= (0.0 - Range) && player_y - tar_y <= Range && player_y - tar_y >= (0.0 - Range) && player_z - tar_z <= Z_Range && player_z - tar_z >= (0.0 - Z_Range))
 {
  return 1;
 }
 return 0;
}
native IsPlayerInRange(playerid, Float: Range, Float: Z_Range, Float:tar_x, Float:tar_y, Float:tar_z);

//-------------------------------------------------------------------------------

stock GetDistanceBetweenPlayers(playerid, playerid2) //By Slick (Edited by Smugller thx for Y_Less )
{
new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
new Float:dis;
GetPlayerPos(playerid,x1,y1,z1);
GetPlayerPos(playerid2,x2,y2,z2);
dis = floatsqroot((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1));
return floatround(dis);
}
native GetDistanceBetweenPlayers(playerid, playerid2);

//-------------------------------------------------------------------------------

stock GetClosestPlayer(playerid) //By Slick
{
new x,Float:dis,Float:dis2,player;
new pteam[MAX_PLAYERS];
player = -1;
dis = 99999.99;
for (x=0;x<MAX_PLAYERS;x++){
if (x != playerid){
dis2 = GetDistanceBetweenPlayers(x,playerid);
if (dis2 < dis && dis2 != -1.00 && pteam[x] == pteam[playerid]){
dis = dis2;
player = x;
}
}
}
return player;
}
native GetClosestPlayer(playerid);

//-------------------------------------------------------------------------------

stock GetDistanceToCar(playerid,vehicleid) //By Darkrealm (Edited by Smugller)
{
	new Float:dis;
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	GetPlayerPos(playerid,x1,y1,z1);
	GetVehiclePos(vehicleid,x2,y2,z2);
	dis = floatsqroot((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1));
	return floatround(dis);
}
native GetDistanceToCar(playerid,vehicleid);

//-------------------------------------------------------------------------------

stock GetClosestCar(playerid) //By Darkrealm
{
	if (!IsPlayerConnected(playerid)) {
	    return -1;
	}
	new Float:prevdist = 100000.000;
	new prevcar;
	for (new carid = 0; carid < MAX_VEHICLES; carid++) {
                 new Float:dist = GetDistanceToCar(playerid,carid);
	    if ((dist < prevdist)) {
	         prevdist = dist;
	         prevcar = carid;
                 }
	}
	return prevcar;
}

//-------------------------------------------------------------------------------

stock GetPlayerDistanceToPoint(playerid,Float:x,Float:y) //By Sacky (Edited by Smugller)
{
new Float:x1,Float:y1,Float:z1;
new Float:dis;
GetPlayerPos(playerid,x1,y1,z1);
dis = floatsqroot((x-x1)*(x-x1)+(y-y1)*(y-y1));
return floatround(dis);
}
native GetPlayerDistanceToPoint(playerid,Float:x,Float:y);

//-------------------------------------------------------------------------------

stock GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z) //By Sacky (Edited by Smugller)
{
new Float:x1,Float:y1,Float:z1;
new Float:dis;
GetPlayerPos(playerid,x1,y1,z1);
dis = floatsqroot((x-x1)*(x-x1)+(y-y1)*(y-y1)+(z-z1)*(z-z1));
return floatround(dis);
}
native GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z);

//-------------------------------------------------------------------------------

stock IsPlayerInCircle(playerid,Float:x,Float:y,radius) //By Sacky
{
 if(GetPlayerDistanceToPoint(playerid,x,y) < radius)
 {
  return 1;
 }
 return 0;
}
native IsPlayerInCircle(playerid,Float:x,Float:y,radius);

//-------------------------------------------------------------------------------

stock IsPlayerInSphere(playerid,Float:x,Float:y,Float:z,radius) //By Sacky
{
 if(GetPlayerDistanceToPointEx(playerid,x,y,z) < radius)
 {
  return 1;
 }
 return 0;
}
native IsPlayerInSphere(playerid,Float:x,Float:y,Float:z,radius);

//-------------------------------------------------------------------------------

stock GetPointDistanceToPoint(Float:x,Float:y,Float:x2,Float:y2) //By Sacky (Edited by Smugller)
{
new Float:dis;
dis = floatsqroot((x-x2)*(x-x2)+(y-y2)*(y-y2));
return floatround(dis);
}
native GetPointDistanceToPoint(Float:x,Float:y,Float:x2,Float:y2);

//-------------------------------------------------------------------------------

stock GetPointDistanceToPointEx(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2) //By Sacky (Edited by Smugller)
{
new Float:dis;
dis = floatsqroot((x-x2)*(x-x2)+(y-y2)*(y-y2)+(z-z2)*(z-z2));
return floatround(dis);
}
native GetPointDistanceToPointEx(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2);

//-------------------------------------------------------------------------------

stock GetDistancePointToPoint(Float:pos1[2], Float:pos2[2]) // By Smugller
{
new Float:dis;
dis = floatsqroot((pos2[0]-pos1[0])*(pos2[0]-pos1[0])+(pos2[1]-pos1[1])*(pos2[1]-pos1[1]));
	return floatround(dis);
}
native GetDistancePointToPoint(Float:pos1[2], Float:pos2[2]);

//-------------------------------------------------------------------------------

stock GetDistancePointToPointIx(Float:pos1[3], Float:pos2[3]) // By Smugller
{
new Float:dis;
dis = floatsqroot((pos2[0]-pos1[0])*(pos2[0]-pos1[0])+(pos2[1]-pos1[1])*(pos2[1]-pos1[1])+(pos2[2]-pos1[2])*(pos2[2]-pos1[2]));
	return floatround(dis);
}
native GetDistancePointToPointIx(Float:pos1[3], Float:pos2[3]);

//-------------------------------------------------------------------------------

stock GetPointDistanceToPoint2(Float:...) //by Sacky
{
if(numargs() == 4) return floatsqroot(floatpower(floatabs(floatsub(Float:getarg(0),Float:getarg(2))),2)+floatpower(floatabs(floatsub(Float:getarg(1),Float:getarg(3))),2));
return floatsqroot(floatpower(floatabs(floatsub(Float:getarg(0),Float:getarg(3))),2)+floatpower(floatabs(floatsub(getarg(1),Float:getarg(4))),2)+floatpower(floatabs(floatsub(getarg(2),Float:getarg(5))),2));
}
native GetPointDistanceToPoint2(Float:...);

//-------------------------------------------------------------------------------

stock GetDistancePlayerToPoint(playerid, Float:pointpos[2]) // By Smugller
{
		new Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		return GetDistancePointToPointIx(pos, pointpos);
}
native GetDistancePlayerToPoint(playerid, Float:pointpos[2]);

//-------------------------------------------------------------------------------

stock GetDistancePlayerToPointIx(playerid, Float:pointpos[3]) // By Smugller
{
		new Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		return GetDistancePointToPointIx(pos, pointpos);
}
native GetDistancePlayerToPointIx(playerid, Float:pointpos[3]);

//-------------------------------------------------------------------------------

stock GetDistancePlayerToPlayer(playerid1, playerid2) // By Smugller
{
		new Float:pos1[3], Float:pos2[3];
		GetPlayerPos(playerid1,pos1[0],pos1[1],pos1[2]);
		GetPlayerPos(playerid2,pos2[0],pos2[1],pos2[2]);
 return GetDistancePointToPointIx(pos1, pos2);
}
native GetDistancePlayerToPlayer(playerid1, playerid2);

//-------------------------------------------------------------------------------

stock GetPlayerDistanceToHeight(playerid,Float:z) //By [NB]Boylett
{
new Float:x1,Float:y1,Float:z1;
new Float:tmpdis;
GetPlayerPos(playerid,x1,y1,z1);
tmpdis = z1 - z;
if(tmpdis < 0)
{
    new string[256];
format(string, sizeof(string), "%f", tmpdis * -1);
return strval(string);
} else {
    new string[256];
format(string, sizeof(string), "%f", tmpdis);
return strval(string);
}
return 1;
}
native GetPlayerDistanceToHeight(playerid,Float:z);

//-------------------------------------------------------------------------------

stock GetPlayerDistanceToHeightEx(playerid, Float:Z) //by Betamaster
{
   new Float:X1, Float: Y1, Float:Z1;
   new tempvalue;
   GetPlayerPos(playerid, X1, Y1, Z1);
   tempvalue = floatround(Z1 - Z);
   if(tempvalue < 0) tempvalue=(tempvalue*-1);
   return tempvalue;
}
native GetPlayerDistanceToHeightEx(playerid, Float:Z);

//-------------------------------------------------------------------------------

stock GetPlayerDistanceToHeightEx2(playerid, Float:Z) //by Y_Less
{
   new Float:Z1;
   GetPlayerPos(playerid, Z1, Z1, Z1);
   Z1 -= Z;
   if (Z1 < 0) Z1 *= -1.0
   return Z1;
}
native GetPlayerDistanceToHeightEx2(playerid, Float:Z);

//-------------------------------------------------------------------------------

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}
native PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

//-------------------------------------------------------------------------------

stock SendFormattedGameTextToPlayer(playerid, const msg[], time, style, define) //By Allan
{
	new wrap[256];
	format(wrap, sizeof(wrap), msg, define);
	GameTextForPlayer(playerid,wrap,time,style);
}
native SendFormattedGameTextToPlayer(playerid, const msg[], time, style, define);

//-------------------------------------------------------------------------------

stock SendFormattedGameTextToAll(const msg[], time, style, define) //By Allan
{
	new wrap[256];
	format(wrap, sizeof(wrap), msg, define);
	GameTextForAll(wrap,time,style);
}
native SendFormattedGameTextToAll(const msg[], time, style, define);

//-------------------------------------------------------------------------------

stock SendPlayerFormattedText(playerid, const Format[], {Float,_}:...) //by REALfreaky
{
    new bool:searching, x;

    new string[256], tmp[256], tmp2[256];
    new currarg, i;
    currarg=2;
    for(i=0; i < strlen(Format); i++) {
        if(Format[i] != '%') {
            string[strlen(string)] = Format[i];
            string[strlen(string)] = '\0';
            continue;
         }
        if(Format[i] == '%' && Format[i+1] == '%') {
            string[strlen(string)] = Format[i];
            string[strlen(string)] = '\0';
            i++;
            continue;
         }
         searching = true;

        new tempFormat[256];

        while(searching) {
            tempFormat[strlen(tempFormat)] = Format[i];
            tempFormat[strlen(tempFormat)] = '\0';
            switch(Format[i]) {
                case 's', 'S' : {
                    strdel(tmp, 0, sizeof(tmp));
                    strdel(tmp2, 0, sizeof(tmp2));
                    x=0;
                    for(x=0; getarg(currarg, x) != '\0'; x++) {
                        tmp2[x] = getarg(currarg, x);
                       }
                       tmp2[x] = '\0';
                    format(tmp, sizeof(tmp), tempFormat, tmp2);
                    strcat(string, tmp);
                    searching = false;
                    currarg++;
                   }
                case 'f', 'F' : {
                    strdel(tmp, 0, sizeof(tmp));
                    format(tmp, sizeof(tmp), tempFormat, Float:getarg(currarg));
                    strcat(string, tmp);
                    searching = false;
                    currarg++;
                   }
                case 'd', 'D' : {
                    strdel(tmp, 0, sizeof(tmp));
                    format(tmp, sizeof(tmp), tempFormat, getarg(currarg));
                    strcat(string, tmp);
                    searching = false;
                    currarg++;
                   }
               }
               if(searching)
                i++;
          }
    }
    SendClientMessage(playerid, 0xFFFF00AA, string);
}
native SendPlayerFormattedText(playerid, const Format[], {Float,_}:...);

//-------------------------------------------------------------------------------

stock GetCurrentPosition(playerid) //By Sacky
{
new Float:x;
new Float:y;
new Float:z;
new Float:a;
new string[256];
GetPlayerPos(playerid,x,y,z);
GetPlayerFacingAngle(playerid,a);
format(string,sizeof(string),"x: %d, y: %d, z: %d, angle: %d",floatround(x),floatround(y),floatround(z),floatround(a));
 return string;
}
native GetCurrentPosition(playerid);

//-------------------------------------------------------------------------------

stock TakePlayerMoney(playerid,money) //By Sacky
{
GivePlayerMoney(playerid,0-money);
}
native TakePlayerMoney(playerid,money);

//-------------------------------------------------------------------------------

stock PlayerPlaySoundEx(playerid,soundid) //By Sacky
{
 new Float:x;
 new Float:y;
 new Float:z;
 GetPlayerPos(playerid,x,y,z);
 PlayerPlaySound(playerid,soundid,x,y,z);
}
native PlayerPlaySoundEx(playerid,soundid);

//-------------------------------------------------------------------------------

stock GivePlayerWeaponEx( playerid, ... ) //By Peter
{
    new Count = numargs();
    for( new i = 1; i < Count; i += 2 )
    {
        new WeaponID = getarg( i );
        new Ammo = getarg( ( i + 1 ) );
        if( WeaponID > 0 && WeaponID < 47 )
        {
            GivePlayerWeaponAlt( playerid, WeaponID, Ammo );
        }
    }
}
native GivePlayerWeaponEx( playerid, ... );

//-------------------------------------------------------------------------------

stock SendClientMessageToAllOthers(playerid, color, const message[]) //By yom
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if ((IsPlayerConnected(i)) && (i != playerid))
        {
            SendClientMessage(i, color, message);
        }
    }
}
native SendClientMessageToAllOthers(playerid, color, const message[]);

//-------------------------------------------------------------------------------

stock GameTextForAllOthers(playerid, const string[], time, style) //By yom
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if ((IsPlayerConnected(i)) && (i != playerid))
        {
            GameTextForPlayer(i, string, time, style);
        }
    }
}
native GameTextForAllOthers(playerid, const string[], time, style);

//-------------------------------------------------------------------------------

stock SendMultipleClientMessages(playerid,colour,text[],...) //by [NB]Boylett
{
SendClientMessage(playerid,colour,text);
for(new i = 3; i < numargs(); i++)
{
new message[256],
j = 0,
cur = getarg(i,j);
while(cur != 0)
{
message[j] = getarg(i,j);
j++;
cur = getarg(i,j);
}
SendClientMessage(playerid,colour,message);
}
}
native SendMultipleClientMessages(playerid,colour,text[],...);

//-------------------------------------------------------------------------------

stock SetPlayerColourAlpha(playerid, alpha) //By Betamaster
{
	new r, g, b, a;
	HexToRGBA(GetPlayerColor(playerid), r, g, b, a);
	SetPlayerColor(playerid, RGBAToHex(r, g, b, alpha));
}
native SetPlayerColourAlpha(playerid, alpha);

//-------------------------------------------------------------------------------

stock Eraser(playerid, lines) //by yom
{
    for (new a = 1; a <= lines; a++)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "\n");
    }
}
native Eraser(playerid, lines);


//-------------------------------------------------------------------------------

stock wiper(playerid) //By Spectre
{
 for (new a=1;a<=10;a++)
 {
  SendClientMessage(playerid,0xFFFFFFFF,"\n");
 }
 return 1;
}
native wiper(playerid);

//-------------------------------------------------------------------------------

stock Float:GetPlayerTheoreticAngle(i)  // By Luby
{
 new Float:sin;
 new Float:dis;
 new Float:angle2;
 new Float:x,Float:y,Float:z;
 new Float:tmp3;
 new Float:tmp4;
 new Float:MindAngle;
 if(IsPlayerConnected(i)){
  GetPlayerPos(i,x,y,z);
  dis = floatsqroot(floatpower(floatabs(floatsub(x,ppos[i][0])),2)+floatpower(floatabs(floatsub(y,ppos[i][1])),2));
  if(IsPlayerInAnyVehicle(i))GetVehicleZAngle(GetPlayerVehicleID(i), angle2); else GetPlayerFacingAngle(i, angle2);
  if(x>ppos[i][0]){tmp3=x-ppos[i][0];}else{tmp3=ppos[i][0]-x;}
  if(y>ppos[i][1]){tmp4=y-ppos[i][1];}else{tmp4=ppos[i][1]-y;}
  if(ppos[i][1]>y && ppos[i][0]>x){ //1
   sin = asin(tmp3/dis);
   MindAngle = floatsub(floatsub(floatadd(sin, 90), floatmul(sin, 2)), -90.0);
  }
  if(ppos[i][1]<y && ppos[i][0]>x){ //2
  sin = asin(tmp3/dis);
  MindAngle = floatsub(floatadd(sin, 180), 180.0);
  }
  if(ppos[i][1]<y && ppos[i][0]<x){ //3
  sin = acos(tmp4/dis);
  MindAngle = floatsub(floatadd(sin, 360), floatmul(sin, 2));
  }
  if(ppos[i][1]>y && ppos[i][0]<x){ //4
  sin = asin(tmp3/dis);
  MindAngle = floatadd(sin, 180);
  }
 }
 return MindAngle;
}
native Float:GetPlayerTheoreticAngle(i);

//-------------------------------------------------------------------------------

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance) //by Y_Less
{
 new Float:a;
 GetPlayerPos(playerid, x, y, a);
 GetPlayerFacingAngle(playerid, a);
 x += (distance * floatsin(-a, degrees));
 y += (distance * floatcos(-a, degrees));
}
native GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance);

//-------------------------------------------------------------------------------

stock Float:GetXYInFrontOfPlayerEx(playerid, &Float:x, &Float:y, Float:distance)  // By Luby
{
new Float:a;
GetPlayerPos(playerid, x, y, a);
a = GetPlayerTheoreticAngle(playerid);
x += (distance * floatsin(-a, degrees));
y += (distance * floatcos(-a, degrees));
return a;
}
native Float:GetXYInFrontOfPlayerEx(playerid, &Float:x, &Float:y, Float:distance);

//-------------------------------------------------------------------------------

stock GetTheoreticalPlayerCameraPos(playerid,&Float:x,&Float:y,&Float:z) //by Sacky
{
	new Float:x1;
	new Float:y1;
	new Float:z1
	GetPlayerPos(playerid,x1,y1,z1);
	z = z1+3;
	GetXYBehindPlayer(playerid,x,y,10);
}
native GetTheoreticalPlayerCameraPos(playerid,&Float:x,&Float:y,&Float:z);

//-------------------------------------------------------------------------------

stock GetXYBehindPlayer(playerid, &Float:x, &Float:y, Float:distance) //by Sacky
{
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);
    x -= (distance * floatsin(-a, degrees));
    y -= (distance * floatcos(-a, degrees));
}
native GetXYBehindPlayer(playerid, &Float:x, &Float:y, Float:distance);

//-------------------------------------------------------------------------------

stock SetPlayerPosEx(playerid,Float:X,Float:Y,Float:Z,Float:Ang,Int) //by metalpenguin and Kamazy (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
 SetVehiclePos(GetPlayerVehicleID(playerid),X,Y,Z);
 SetVehicleZAngle(GetPlayerVehicleID(playerid), Ang);
 LinkVehicleToInterior(GetPlayerVehicleID(playerid), Int);
 } else {
 RemovePlayerFromVehicle(playerid);
 SetPlayerPos(playerid,X,Y,Z);
 SetPlayerFacingAngle(playerid,Ang);
 SetPlayerInterior(playerid,Int);
 SetCameraBehindPlayer(playerid);
}

//-------------------------------------------------------------------------------

stock SetPlayersPosInCircle(Float:X, Float:Y, Float:Z, Float:radius) //by 50p
{
new i,
Float: radAngle,
Float: xCoord,
Float: yCoord,
players_num,
bool:playerAlreadySet[100] = {false,...};

for(i=0; i<100; i++)
if(IsPlayerConnected(i))
players_num++;

for(i=0; i<players_num; i++) {
    radAngle = floatdiv(floatmul(i,PI), floatdiv(players_num, 2));
    xCoord = floatmul(floatcos(radAngle), radius);
    yCoord = floatmul(floatsin(radAngle), radius);

for(i=0; i<100; i++) if(IsPlayerConnected(i) && !playerAlreadySet[i]){
    playerAlreadySet[i] = true;
    SetPlayerPos(i,
floatadd(xCoord, (X)),
floatadd(yCoord, (Y)),
Z);
SetPlayerFacingAngle(i, floatadd(floatmul(radAngle, 60), 90));
break;
}
}

return 1;
}
native SetPlayersPosInCircle(Float:X, Float:Y, Float:Z, Float:radius);

//-------------------------------------------------------------------------------

stock GetPlayerClan(playerid) //by Sacky
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
	new mrk1;
	new mrk2;
	new clan[16];
	if(strfind(playername,"[",false)==-1 && strfind(playername,"]",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[3];
			strmid(character,playername,i,i+1,2);
			if(strcmp(character,"[",false)==0){
				mrk1 = i;
			}
			else if(strcmp(character,"]",false)==0){
				mrk2 = i;
			}
		}
		if(mrk1 != 0 && mrk2 != 0){
			strmid(clan,playername,mrk1,mrk2);
			return clan;
		}
		else{
			mrk1 = 0;
			mrk2 = 0;
		}
	}
	if(strfind(playername,"(",false)==-1 && strfind(playername,")",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[3];
			strmid(character,playername,i,i+1,2);
			if(strcmp(character,"(",false)==0){
				mrk1 = i;
			}
			else if(strcmp(character,")",false)==0){
				mrk2 = i;
			}
		}
		if(mrk1 != 0 && mrk2 != 0){
			strmid(clan,playername,mrk1,mrk2);
			return clan;
		}
		else{
			mrk1 = 0;
			mrk2 = 0;
		}
	}
	if(strfind(playername,"{",false)==-1 && strfind(playername,"}",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[3];
			strmid(character,playername,i,i+1,2);
			if(strcmp(character,"{",false)==0){
				mrk1 = i;
			}
			else if(strcmp(character,"}",false)==0){
				mrk2 = i;
			}
		}
		if(mrk1 != 0 && mrk2 != 0){
			strmid(clan,playername,mrk1,mrk2);
			return clan;
		}
		else{
			mrk1 = 0;
			mrk2 = 0;
		}
	}
	if(strfind(playername,"XII",false)==-1){}
	else{
		format(clan,sizeof(clan),"XII");
		return clan;
	}
	if(strfind(playername,"<",false)==-1 && strfind(playername,">",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[3];
			strmid(character,playername,i,i+1,2);
			if(strcmp(character,"<",false)==0){
				mrk1 = i;
			}
			else if(strcmp(character,">",false)==0){
				mrk2 = i;
			}
		}
		if(mrk1 != 0 && mrk2 != 0){
			strmid(clan,playername,mrk1,mrk2);
			return clan;
		}
		else{
			mrk1 = 0;
			mrk2 = 0;
		}
	}
	if(strfind(playername,"::",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[4];
			strmid(character,playername,i,i+2,2);
			if(strcmp(character,"::",false)==0){
				if(mrk1 == 0){
					mrk1 = i;
				}
				else{
					mrk2 = i;
				}
			}
		}
		if(mrk1 != 0){
			if(mrk2 != 0){
				strmid(clan,playername,mrk1,mrk2);
				return clan;
			}
			else{
				if(mrk1 >= strlen(playername)/2){
					strmid(clan,playername,0,mrk1);
					return clan;
				}
				else{
					strmid(clan,playername,mrk1,strlen(playername));
					return clan;
				}
			}
		}
		else{
			mrk1 = 0;
			mrk2 = 0;
		}
	}
	if(strfind(playername,"<<",false)==-1 && strfind(playername,">>",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[4];
			strmid(character,playername,i,i+2,2);
			if(strcmp(character,"<<",false)==0){
				mrk1 = i;
			}
			else if(strcmp(character,">>",false)==0){
				mrk2 = i;
			}
		}
		if(mrk1 != 0 && mrk2 != 0){
			strmid(clan,playername,mrk1,mrk2);
			return clan;
		}
		else{
			mrk1 = 0;
			mrk2 = 0;
		}
	}
	if(strfind(playername,"-",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[3];
			strmid(character,playername,i,i+1,2);
			if(strcmp(character,"-",false)==0){
				if(mrk1 == 0){
					mrk1 = i;
				}
				else{
					mrk2 = i;
				}
			}
		}
		if(mrk1 != 0 && mrk2 != 0){
			strmid(clan,playername,mrk1,mrk2);
			return clan;
		}
		else{
			mrk1 = 0;
			mrk2 = 0;
		}
	}
	if(strfind(playername,":",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[3];
			strmid(character,playername,i,i+1,2);
			if(strcmp(character,":",false)==0){
				mrk1 = i;
				break;
			}
		}
		if(mrk1 >= strlen(playername)/2){
			strmid(clan,playername,0,mrk1);
			return clan;
		}
		else{
			strmid(clan,playername,mrk1,strlen(playername));
			return clan;
		}
	}
	if(strfind(playername,"=",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[3];
			strmid(character,playername,i,i+1,2);
			if(strcmp(character,"=",false)==0){
				if(mrk1 == 0){
					mrk1 = i;
				}
				else{
					mrk2 = i;
				}
			}
		}
		if(mrk1 != 0 && mrk2 != 0){
			strmid(clan,playername,mrk1,mrk2);
			return clan;
		}
		else{
			mrk1 = 0;
			mrk2 = 0;
		}
	}
	if(strfind(playername,">",false)==-1 && strfind(playername,"<",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[3];
			strmid(character,playername,i,i+1,2);
			if(strcmp(character,">",false)==0){
				mrk1 = i;
			}
			else if(strcmp(character,"<",false)==0){
				mrk2 = i;
			}
		}
		if(mrk1 != 0 && mrk2 != 0){
			strmid(clan,playername,mrk1,mrk2);
			return clan;
		}
		else{
			mrk1 = 0;
			mrk2 = 0;
		}
	}
	if(strfind(playername,"|",false)==-1){}
	else{
		for(new i=0;i<strlen(playername);i++){
			new character[3];
			strmid(character,playername,i,i+1,2);
			if(strcmp(character,"|",false)==0){
				if(mrk1 == 0){
					mrk1 = i;
				}
				else{
					mrk2 = i;
				}
			}
		}
		if(mrk1 != 0 && mrk2 != 0){
			strmid(clan,playername,mrk1,mrk2);
			return clan;
		}
		else{
			mrk1 = 0;
			mrk2 = 0;
		}
	}
	return clan;
}
native GetPlayerClan(playerid);

//-------------------------------------------------------------------------------

stock FindTag(name[],tag[]) //by Pixels^
{
    if(strfind(name, tag, true) == 0) return 1;
    else return 0;
}
native FindTag(name[],tag[]);

//-------------------------------------------------------------------------------

stock ToggleBlipVisibilty(playerid, bool:visible) //by Simon
{
    new tmpcolor = GetPlayerColor(playerid);
	if(visible == true) tmpcolor &= 0xFFFFFF00;
	else tmpcolor |= 0x000000FF;
	SetPlayerColor(playerid, tmpcolor);
}
native ToggleBlipVisibilty(playerid, bool:visible);

//-------------------------------------------------------------------------------

stock GetPlayeridMid(name[]) //by [NB]Boylett
{
 for (new i = 0; i < MAX_PLAYERS; i++)
 {
  if (IsPlayerConnected(i))
  {
   new gPlayerName[MAX_PLAYER_NAME];
   GetPlayerName(i, gPlayerName, MAX_PLAYER_NAME);
   if(strfind(gPlayerName, name, true) != -1)
   {
    return i;
   }
  }
 }
 return INVALID_PLAYER_ID;
}
native GetPlayeridMid(name[]);

//-------------------------------------------------------------------------------

stock VL_SetPlayerSkin(playerid, skinid) //by [NB]Boylett
{
new Float:x, Float:y, Float:z, Float:r;
GetPlayerPos(playerid, x, y, z);
GetPlayerFacingAngle(playerid, r);
SetSpawnInfo(playerid, 0, skinid, x, y, z, r, 0, 0, 0, 0, 0, 0);
SpawnPlayer(playerid);
return true;
}
native VL_SetPlayerSkin(playerid, skinid);

//-------------------------------------------------------------------------------

stock SetPlayerIntBounds(playerid, Float:xmax, Float:xmin, Float:ymax, Float:ymin, Float:zmin) //by Arsenic
{
     gPlayerIntBounds[playerid][max_x] = xmax;
     gPlayerIntBounds[playerid][min_x] = xmin;
     gPlayerIntBounds[playerid][max_y] = ymax;
     gPlayerIntBounds[playerid][min_y] = ymin;
     gPlayerIntBounds[playerid][min_z] = zmin;
}

native SetPlayerIntBounds(playerid, Float:xmax, Float:xmin, Float:ymax, Float:ymin, Float:zmin) //Needs this in OnGameModeInit(): SetTimer("CheckInternalBounds", 500, 1);

forward CheckInternalBounds();
public CheckInternalBounds()
{
     new Float:px, Float:py, Float:pz;
     for (new i = 0; i < MAX_PLAYERS; i++)
          if (IsPlayerConnected(i)) {//&& !IsPlayerAdmin(i)) { to make areas admin only
               GetPlayerPos(i, px, py, pz);
               if (pz < gPlayerIntBounds[i][min_z]) {
                    if (px < gPlayerIntBounds[i][max_x] && px > gPlayerIntBounds[i][min_x]) {     //XPOS in area
                         if (py > (gPlayerIntBounds[i][max_y] + gPlayerIntBounds[i][min_y]) / 2)     //above area
                              SetPlayerWorldBounds(i, gWorldExtBounds[max_x], gWorldExtBounds[min_x], gWorldExtBounds[max_y], gPlayerIntBounds[i][max_y]);
                          else     //below area
                               SetPlayerWorldBounds(i, gWorldExtBounds[max_x], gWorldExtBounds[min_x], gPlayerIntBounds[i][min_y], gWorldExtBounds[min_y]);
                     } else
                          if (py < gPlayerIntBounds[i][max_y] && py > gPlayerIntBounds[i][min_y]) {     //YPOS in area
                               if (px > (gPlayerIntBounds[i][max_x] + gPlayerIntBounds[i][min_x]) / 2)     //above area
                                    SetPlayerWorldBounds(i, gWorldExtBounds[max_x], gPlayerIntBounds[i][max_x], gWorldExtBounds[max_y], gWorldExtBounds[min_y]);
                               else     //below area
                                    SetPlayerWorldBounds(i, gPlayerIntBounds[i][min_x], gWorldExtBounds[min_x], gWorldExtBounds[max_y], gWorldExtBounds[min_y]);
                          } else     //not in area
                               SetPlayerWorldBounds(i, gWorldExtBounds[max_x], gWorldExtBounds[min_x], gWorldExtBounds[max_y], gWorldExtBounds[min_y]);
                } else     //above area
                     SetPlayerWorldBounds(i, gWorldExtBounds[max_x], gWorldExtBounds[min_x], gWorldExtBounds[max_y], gWorldExtBounds[min_y]);
          }
     return 1;
}

//-------------------------------------------------------------------------------

stock ResetBounds(playerid) //by Ramjet.
{
    SetPlayerWorldBounds(playerid,20000.0, -20000.0, 20000.0, -20000.0);
    return true;
}
native ResetBounds(playerid);

//-------------------------------------------------------------------------------

stock AddPlayerHealth(playerid, Float:health) //by 50p
{
new Float:pHealth;
GetPlayerHealth(playerid, pHealth);
new Float:total = pHealth + health;
if(total > 100)
    SetPlayerHealth(playerid, 100.0);
else
            SetPlayerHealth(playerid, total);
return true;
}
native AddPlayerHealth(playerid, Float:health);

//-------------------------------------------------------------------------------

stock AddPlayerHealthEx(playerid, Float:health) //by [NB]Boylett
{
new Float:phealth;
GetPlayerHealth(playerid, phealth);
SetPlayerHealth(playerid, phealth + health);
}

//-------------------------------------------------------------------------------

stock AddWantedLevel(playerid, pLevel) //by Smugller
{
new pLevel;
if(GetPlayerWantedLevel(playerid) > 6)
SetPlayerWantedLevel(playerid, 6);
else
SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+pLevel);
  return 1;
}
native AddWantedLevel(playerid, pLevel);

//-------------------------------------------------------------------------------

stock AddPlayerArmour(playerid, Float:armour) //by Smugller
{
	new Float:pArmour;
	GetPlayerArmour(playerid, pArmour);
	new Float:total=pArmour+armour;
	if(total > 100) SetPlayerArmour(playerid, 100.0); else SetPlayerArmour(playerid, pArmour+armour);
	return 1;
}
native AddPlayerArmour(playerid, Float:armour);

//-------------------------------------------------------------------------------

stock AddPlayerAmmo(playerid, weaponslot, ammo) //by Smugller
{
  SetPlayerAmmo(playerid, weaponslot, GetPlayerAmmo(playerid)+ammo);
}
native AddPlayerAmmo(playerid, weaponslot, ammo);


//-------------------------------------------------------------------------------

stock SetPlayerTotalAmmo(playerid, ammo) // By Luby
{
 for(new g=0;g<12;g++)if(IsPlayerConnected(g))SetPlayerAmmo(playerid, g, ammo);
 return true;
}
native SetPlayerTotalAmmo(playerid, ammo);

//-------------------------------------------------------------------------------

stock PutCameraBehindPlayer(playerid) // by BeckzyBoi
{
new Float:X, Float:Y, Float:Z, Float:A;
GetPlayerPos(playerid, X, Y, Z);
GetPlayerFacingAngle(playerid, A);
{ if(A >= 0 && A <= 44.999999)
SetPlayerCameraPos(playerid, X,Y-2,Z);
SetPlayerCameraLookAt(playerid, X,Y,Z); }
{ if(A >= 45 && A <= 134.999999)
SetPlayerCameraPos(playerid, X+2,Y,Z);
SetPlayerCameraLookAt(playerid, X,Y,Z); }
{ if(A >= 135 && A <= 224.999999)
SetPlayerCameraPos(playerid, X,Y+2,Z);
SetPlayerCameraLookAt(playerid, X,Y,Z); }
{ if(A >= 225 && A <= 314.999999)
SetPlayerCameraPos(playerid, X-2,Y,Z);
SetPlayerCameraLookAt(playerid, X,Y,Z); }
{ if(A >= 315 && A <= 359.999999)
SetPlayerCameraPos(playerid, X,Y-2,Z);
SetPlayerCameraLookAt(playerid, X,Y,Z); }
return 1;
}
native PutCameraBehindPlayer(playerid);

//-------------------------------------------------------------------------------

stock PutCameraBehindPlayerEx(playerid) //by Sacky
{
new Float:x,Float:y,Float:z,Float:a;
GetPlayerPos(playerid,x,y,z);
GetPlayerAngle(playerid,a);
new Float:tmpx,Float:tmpy;
GetXYBehindPlayer(playerid,tmpx,tmpy,a,5.0);
SetPlayerCameraPos(playerid,tmpx,tmpy,z);
SetPlayerCameraLookAt(playerid,x,y,z);
}
native PutCameraBehindPlayerEx(playerid);

//-------------------------------------------------------------------------------

stock IsDead(playerid) //by Sacky
{
if(GetPlayerState(playerid) == PLAYER_STATE_WASTED) return true;
return false;
}
native IsDead(playerid);

//-------------------------------------------------------------------------------

stock CreateExplosionSounds(DUR_EXP, NUM_EXP) //by Arsenic
{
 new sqRoot = floatround(floatsqroot(DUR_EXP));
 for (new i = 0; i < NUM_EXP; i++)
 SetTimer("Explode", random(sqRoot) * random(sqRoot), 0);
}
native CreateExplosionSounds(DUR_EXP, NUM_EXP);

PlayExplosionNearby(playerid, radius)
{
 new Float:px, Float:py, Float:pz;
 GetPlayerPos(playerid, px, py, pz);
 PlayerPlaySound(playerid, 1159, px - radius + random(radius * 2), py - radius + random(radius * 2), pz);
}

forward Explode();
public Explode()
{
for (new playerid = 0; playerid < MAX_PLAYERS; playerid++)
if (IsPlayerConnected(playerid))
PlayExplosionNearby(playerid, 10);
return 1;
}

//-------------------------------------------------------------------------------

stock GetLowestPlayerid() //by [NB]Boylett
{
for(new i; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) return i;
return -1;
}
native GetLowestPlayerid();

//-------------------------------------------------------------------------------

stock GetHighestPlayerid() //by [NB]Boylett
{
for(new i = 99; i >= 0; i--) if(IsPlayerConnected(i)) return i;
return -1;
}
native GetHighestPlayerid();

//-------------------------------------------------------------------------------

stock GetNumberedPlayerid(number) //by [NB]Boylett
{
new cur = -1;
for(new i; i < MAX_PLAYERS; i++)
{
if(IsPlayerConnected(i))
{
cur++
if(cur == number) return i;
}
}
return cur;
}
native GetNumberedPlayerid(number);

//-------------------------------------------------------------------------------

stock AddAllClass(Float:x,Float:y,Float:z,Float:r,w1,a1,w2,a2,w3,a3) //by [NB]Boylett
{
 for(new i; i < 300; i++)
 {
  if(IsValidSkin(i)) AddPlayerClass(i,x,y,z,r,w1,a1,w2,a2,w3,a3);
 }
}
native AddAllClass(Float:x,Float:y,Float:z,Float:r,w1,a1,w2,a2,w3,a3);

//-------------------------------------------------------------------------------

stock AddAllClassEx(Float:x,Float:y,Float:z,Float:r,w1,a1,w2,a2,w3,a3,bool:ignore[300]=false) //by [NB]Boylett
{
 for(new i; i < 300; i++)
 {
  if(IsValidSkin(i) && !ignore[i]) AddPlayerClass(i,x,y,z,r,w1,a1,w2,a2,w3,a3);
 }
}
native AddAllClassEx(Float:x,Float:y,Float:z,Float:r,w1,a1,w2,a2,w3,a3,bool:ignore[300]=false);

//-------------------------------------------------------------------------------

stock IsVehicleSkinCompatible_TF(skinid) //by Ramjet.
{
    switch(skinid)
    {
        case 445, 602, 429, 496, 401, 518, 402, 541, 438, 527, 415, 542, 589, 480, 507, 585, 419, 587, 533, 526, 466, 492, 474, 579, 545, 411, 546, 400, 517, 410, 551, 500, 516, 467, 404, 603, 600, 426, 436, 547, 489, 479, 442, 475, 405, 458, 439, 580, 409, 550, 506, 549, 420, 451, 540, 491, 421, 529, 555, 477, 422, 418, 478: return true;
    }
    return false;
}
native IsVehicleSkinCompatible_TF(skinid);

//-------------------------------------------------------------------------------

stock IsVehicleSkinCompatible_WAA(skinid) //by Ramjet.
{
    switch(skinid)
    {
        case 562, 565, 559, 561, 560, 558: return true;
    }
    return false;
}
native IsVehicleSkinCompatible_WAA(skinid);

//-------------------------------------------------------------------------------

stock IsVehicleSkinCompatible_LLC(skinid) //by Ramjet.
{
    switch(skinid)
    {
        case 566, 412, 576, 536, 567, 535, 575, 534: return true;
    }
    return false;
}
native IsVehicleSkinCompatible_LLC(skinid);

//-------------------------------------------------------------------------------

stock IsValidSkin(skinid) //by Simon
{
#define MAX_BAD_SKINS   22

new badSkins[MAX_BAD_SKINS] = {
3, 4, 5, 6, 8, 42, 65, 74, 86,
119, 149, 208, 265, 266, 267,
268, 269, 270, 271, 272, 273, 289
};

if  (skinid < 0 || skinid > 299) return false;
for (new i = 0; i < MAX_BAD_SKINS; i++) {
    if (skinid == badSkins[i]) return false;
}

#undef MAX_BAD_SKINS
return true;
}
native IsValidSkin(skinid);

//-------------------------------------------------------------------------------

stock IsHealth(playerid,Float:Health) //by Pixels^ and Xtreme
{
  new Float:hlth;
  if(GetPlayerHealth(playerid,hlth) == Health) {
    return true;
  }
  else {
    return false;
}
native IsHealth(playerid,Float:Health);

//-------------------------------------------------------------------------------

stock IsScore(playerid,score) //by Pixels^ and Xtreme
{
  if(GetPlayerScore(playerid) == score) {
    return true;
  }
  else {
    return false;
}
native IsScore(playerid,score);

//-------------------------------------------------------------------------------

stock IsColor(playerid,color) //by Pixels^ and Xtreme
{
  if(color == GetPlayerColor(playerid)) {
    return true;
  }
  else {
    return false;
  }
}
native IsColor(playerid,color);

//-------------------------------------------------------------------------------

stock ShowRatio(playerid,data1,data2) //by Pixels^ and Xtreme
{
  new string[256];
  new Float:ratio = floatdiv(data1,data2);
  format(string,sizeof(string),"%.2f",ratio);
  return SendClientMessage(playerid,0xFFFF00AA,string);
}
native ShowRatio(playerid,data1,data2);

//-------------------------------------------------------------------------------

stock SyncClockByPlayer(playerid) // By Luby
{ 
 new godzina, minuta;
 GetPlayerTime(playerid, godzina, minuta);
 new g;
 while(g<200 && g != playerid && IsPlayerConnected(g)){
  SetPlayerTime(g, godzina, minuta);
 }
 return true;
}
native SyncClockByPlayer(playerid);

//-------------------------------------------------------------------------------

stock ReturnIP(playerid) //by Luby
{
new ip[17];
GetPlayerIp(playerid, ip, 17);
return ip;
}
native ReturnIP(playerid);

//-------------------------------------------------------------------------------

stock SetTextShowTime(playerid, Msg[], Float:X, Float:Y, time, align = 0, color = 0xFFFFFFFF, box = 0, boxcolor = 0xFFFFFFAA, Shadow = 0, outline = 0, bgcolor = 0xFFFFFF00, prop = 0, type = 0) //by Luby
{
new Text:lol = TextDrawCreate(X, Y, Msg);
TextDrawFont(           lol, type);
TextDrawAlignment(      lol, align);
TextDrawColor(          lol, color);
TextDrawUseBox(         lol, box);
TextDrawBoxColor(       lol, boxcolor);
TextDrawSetShadow(      lol, Shadow);
TextDrawSetOutline(     lol, outline);
TextDrawBackgroundColor(lol, bgcolor);
TextDrawSetProportional(lol, prop);

TextDrawShowForPlayer(playerid, lol);
SetTimerEx("HideText", time, 0, "d, i", playerid, _:lol);
}
native SetTextShowTime(playerid, Msg[], Float:X, Float:Y, time, align = 0, color = 0xFFFFFFFF, box = 0, boxcolor = 0xFFFFFFAA, Shadow = 0, outline = 0, bgcolor = 0xFFFFFF00, prop = 0, type = 0);

forward HideText(playerid,Text:text);
public HideText(playerid,Text:text)
{
TextDrawHideForPlayer(playerid, text);
TextDrawDestroy(text);
}

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

