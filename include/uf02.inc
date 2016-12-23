//#include <ufothers.inc>
#include <uftime.inc> //1 zle
#include <ufallplayers.inc> //ok
//#include <ufplayers.inc>
//#include <ufvehicles.inc>
//#include <uffunction.inc>
#include <ufteam.inc> //ok

/*
Credits:
 Alex "Y_Less" Cole
 Allan
 Arsenic
 BeckzyBoi
 Betamaster
 Boss
 Cypog
 Dabombber
 Darkrealm
 De[M]oN
 dyraXon
 d.wine
 El Presy
 Hellomy
 Iain Gilbert
 Jan "DracoBlue" Schütze
 Kamazy
 kool
 Luby
 LucifeR
 mabako
 MaXx001
 Mike
 Peter
 Pixels^
 ProRail
 PsYcHoGoD
 Ramjet.
 rapidZ
 REALfreaky
 Sacky
 SidViciousII
 Simon
 Slick
 Smugller
 Spectre
 Toxic
 Tratulla
 Xtreme
 yellowblood
 yom
 50p
 !damo!spiderman
 [NB]Boylett
 [EGG]Marco
*/

#define UPPER_CASE 1
#define LOWER_CASE 2

#define VTYPE_CAR 1
#define VTYPE_HEAVY 2
#define VTYPE_BIKE 3
#define VTYPE_AIR 4
#define VTYPE_SEA 5

#define WTYPE_MELEE 1
#define WTYPE_PROJECTILE 2
#define WTYPE_PISTOL 3
#define WTYPE_SHOTGUN 4
#define WTYPE_MACHINEGUN 5
#define WTYPE_ASSAULT 6
#define WTYPE_RIFLE 7
#define WTYPE_HEAVY 8
#define WTYPE_SPECIAL 9

#define GetArgString(%1,%2) for(new x=0;getarg(%1,x)!='\0';x++) %2[x] = getarg(%1,x)

#define TYPE_STR 1
#define TYPE_FLO 2
#define TYPE_INT 3

#define GetArgType(%1,%2) if(getarg(%1,0) > 32 && getarg(%1,0) < 127) %2 = TYPE_STR; else if(Float:getarg(%1) == floatstr(strfloat(Float:getarg(%1)))) %2 = TYPE_FLO; else %2 = TYPE_INT

#define PI 3.14

enum bounds {Float:max_x, Float:min_x, Float:max_y, Float:min_y, Float:min_z};
new gPlayerIntBounds[MAX_PLAYERS][bounds];
new gWorldExtBounds[bounds] = {5000.0, -5000.0, 5000.0, -5000.0};//For everyone, default is 5000, 2km out to sea.

//-------------------------------------------------------------------------------

stock GetWeaponType(weaponid) //by Sacky
{
	new type;
	switch(weaponid){
		case 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15:type = WTYPE_MELEE;
		case 16,17,18,19,20,21:type = WTYPE_PROJECTILE;
		case 22,23,24:type = WTYPE_PISTOL;
		case 25,26,27:type = WTYPE_SHOTGUN;
		case 28,32:type = WTYPE_MACHINEGUN;
		case 29,30,31:type = WTYPE_ASSAULT;
		case 33,34:type = WTYPE_RIFLE;
		case 35,36,37,38,39,40:type = WTYPE_HEAVY;
		case 41,42,43,44,45,46,47:type = WTYPE_SPECIAL;
	}
	return type;
}
native GetWeaponType(weaponid);

//-------------------------------------------------------------------------------

stock GetWeaponSlot(weaponid) // by Betamaster
{
new slot;
 switch(weaponid)
 {
  case 0, 1: slot = 0;            // No weapon
  case 2 .. 9: slot = 1;          // Melee
  case 22 .. 24: slot = 2;        // Handguns
  case 25 .. 27: slot = 3;        // Shotguns
  case 28, 29, 32: slot = 4;      // Sub-Machineguns
  case 30, 31: slot = 5;          // Machineguns
  case 33, 34: slot = 6;          // Rifles
  case 35 .. 38: slot = 7;        // Heavy Weapons
  case 16, 18, 39: slot = 8;      // Projectiles
  case 42, 43: slot = 9;          // Special 1
  case 14: slot = 10;             // Gifts
  case 44 .. 46: slot = 11;       // Special 2
  case 40: slot = 12;             // Detonators
  default: slot = -1;             // No slot
 }
return slot;
}
native GetWeaponSlot(weaponid);

//-------------------------------------------------------------------------------

stock ReturnWeaponName(weaponid) //by Sacky
{
	new weaponname[256];
	GetWeaponName(weaponid,weaponname,sizeof(weaponname));
	return weaponname;
}
native ReturnWeaponName(weaponid);

//-------------------------------------------------------------------------------

stock SendClientMessageToAdmins(colour,const str[]) //By Mike
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
  if (IsPlayerConnected(i))
  {
   if (IsPlayerAdmin(i))
   {
    SendClientMessage(i, colour, str);
   }
  }
	}
}
native SendClientMessageToAdmins(colour,const str[]);

//-------------------------------------------------------------------------------

stock GameTextForAdmins(const string[], time, style) //by 50p
{
    for(new a=0; a<MAX_PLAYERS; a++) {
        if(IsPlayerConnected(a)) {
            if(IsPlayerAdmin(a)) {
                GameTextForPlayer(a, string, time, style);
            }
        }
    }
}
native GameTextForAdmins(const string[], time, style);

//-------------------------------------------------------------------------------

stock SetCheckpointForAdmin(Float:x,Float:y,Float:z,Float:size) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(IsPlayerAdmin(i)) {
        SetPlayerCheckpoint(i,x,y,z,size);
      }
    }
  }
}
native SetCheckpointForAdmin(Float:x,Float:y,Float:z,Float:size);

//-------------------------------------------------------------------------------

stock DisableCheckpointForAdmin() //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(IsPlayerAdmin(i)) {
        DisablePlayerCheckpoint(i);
      }
    }
  }
}
native DisableCheckpointForAdmin();

//-------------------------------------------------------------------------------

stock SetAdminColor(color) //by Pixels^ and Xtreme
{
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(IsPlayerAdmin(i)) {
        SetPlayerColor(i,color);
      }
    }
  }
}
native SetAdminColor(color);

//-------------------------------------------------------------------------------

stock IsValidPickup(model) //by Pixels^
{
     if(model <= 1209) return false;
     if(model >= 1326) return false;
     return true;
}
native IsValidPickup(model);

//-------------------------------------------------------------------------------

stock IsValidWeaponModel(model) //by Pixels^
{
     if(model == 1242) return true;
     if(model <= 331 || model >= 371) return false;
     return true;
}
native IsValidWeaponModel(model);

//-------------------------------------------------------------------------------

stock AddRandomWeaponPickup(Float:x,Float:y,Float:z) //by Pixels^
{
     new r = minrand(331,371);
     if(IsValidWeaponModel(r)) return AddStaticPickup(r,x,y,z);
     new s = r + random(3) + 1;
     return AddStaticPickup(s,x,y,z);
}
native AddRandomWeaponPickup(Float:x,Float:y,Float:z);

//-------------------------------------------------------------------------------

stock SetObjectToFaceCords(objectid, Float:x1,Float:y1,Float:z1) //by LucifeR
{
//   SetObjectToFaceCords() By LucifeR   //
//                LucifeR@vgames.co.il   //

// setting the objects cords
new Float:x2,Float:y2,Float:z2;
GetObjectPos(objectid, x2,y2,z2);

// setting the distance values
new Float:DX = floatabs(x2-x1);
new Float:DY = floatabs(y2-y1);
new Float:DZ = floatabs(z2-z1);

// defining the angles and setting them to 0
    new Float:yaw = 0;
    new Float:pitch = 0;

    // check that there isnt any 0 in one of the distances,
// if there is any  use the given parameters:
if(DY == 0 || DX == 0)
{
    if(DY == 0 && DX > 0) {
yaw = 0;
pitch = 0; }
else if(DY == 0 && DX < 0) {
yaw = 180;
pitch = 180; }
else if(DY > 0 && DX == 0)  {
yaw = 90;
pitch = 90; }
else if(DY < 0 && DX == 0) {
yaw = 270;
pitch = 270; }
else if(DY == 0 && DX == 0) {
yaw = 0;
pitch = 0; }
}

// calculating the angale using atan
else // non of the distances is 0.
{
    // calculatin the angles
yaw = atan(DX/DY);
pitch = atan(floatsqroot(DX*DX + DZ*DZ) / DY);

// there are three quarters in a circle, now i will
// check wich circle this is and change the angles
// according to it.
if(x1 > x2 && y1 <= y2) {
    yaw = yaw + 90;
pitch = pitch - 45; }
        else if(x1 <= x2 && y1 < y2) {
    yaw = 90 - yaw;
pitch = pitch - 45; }
        else if(x1 < x2 && y1 >= y2) {
    yaw = yaw - 90;
pitch = pitch - 45; }
        else if(x1 >= x2 && y1 > y2) {
    yaw = 270 - yaw;
pitch = pitch + 315; }

// the pitch could be only in two quarters, lets see wich one:
        if(z1 < z2)
    pitch = 360-pitch;
}

// setting the object rotation (should be twice cuz of lame GTA rotation system)
SetObjectRot(objectid, 0, 0, yaw);
SetObjectRot(objectid, 0, pitch, yaw);
}
native SetObjectToFaceCords(objectid, Float:x1,Float:y1,Float:z1);

//-------------------------------------------------------------------------------
