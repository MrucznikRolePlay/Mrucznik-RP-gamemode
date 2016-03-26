//-------------------------------------------------
//
//  SA-MP 0.3+ commands for internal testing.
//  These were left in the distribution in case
//  anyone found the snippets useful for their
//  own scripts.
//  Don't load this script on a public server
//  as it could break your existing scripts.
//  Kye 2009-2015
//
//-------------------------------------------------

#pragma tabsize 0

#include <a_samp>
#include <core>
#include <float>

#include "../include/gl_common.inc"

new Text3D:textid;
new PlayerText3D:player3dtextid;

new savanna=0;
new blade=0;
new fence=0;

new unfreezeplayer=0;
new testlbplayer=0;

new edit_objectid = INVALID_OBJECT_ID;
new vehicleid_tokill = 0;

// For testing text material/texture replacements
new test_tex_objects[128];
new text_counter = 0;
new text_update_timer = -1;
new text_update_player = INVALID_PLAYER_ID;

forward UnFreezeMe();
forward ShowTestDialog();
forward TimedVehicleDeath();
forward UpdateTextTimer();

#define     AMMUNATION_SMGS_DIALOG      "\
Weapon\tAmount\tPrice\n\
{FFFFFF}MP5\t90\t{FF0000}$3500\
"

new Text:txtSpriteTest[5];

new test_actor_id = INVALID_ACTOR_ID;

//-------------------------------------------------

SpawnVehicle_InfrontOfPlayer(playerid, vehiclemodel, color1, color2)
{
	new Float:x,Float:y,Float:z;
	new Float:facing;
	new Float:distance;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, facing);

    new Float:size_x,Float:size_y,Float:size_z;
	GetVehicleModelInfo(vehiclemodel, VEHICLE_MODEL_INFO_SIZE, size_x, size_y, size_z);

	distance = size_x + 0.5;

  	x += (distance * floatsin(-facing, degrees));
    y += (distance * floatcos(-facing, degrees));

	facing += 90.0;
	if(facing > 360.0) facing -= 360.0;

	return CreateVehicle(vehiclemodel, x, y, z + (size_z * 0.25), facing, color1, color2, -1);
}

//-------------------------------------------------

stock CreateExplosionEx(Float:X, Float:Y, Float:Z, type, Float:Radius, virtualworld)
{
	new x;
	while(x != MAX_PLAYERS) {
		if(IsPlayerConnected(x)) {
   			if(virtualworld == -1 || virtualworld == GetPlayerVirtualWorld(x)) {
				CreateExplosionForPlayer(x, X, Y, Z, type, Radius);
			}
		}
		x++;
	}
}

//-------------------------------------------------

public UnFreezeMe()
{
	TogglePlayerControllable(unfreezeplayer,1);
}

//-------------------------------------------------

public ShowTestDialog()
{
      new listitems[] = "{FFFFFF}1\t{55EE55}Deagle\n{FFFFFF}2\t{55EE55}Sawnoff\n{FFFFFF}3\t{55EE55}Pistol\n{FFFFFF}4\t{55EE55}Grenade\n{FFFFFF}5\t{55EE55}Parachute\n6\t{55EE55}Lorikeet";
	  ShowPlayerDialog(testlbplayer,2,DIALOG_STYLE_LIST,"{448844}List of weapons:",listitems,"Select","Cancel");
}

//-------------------------------------------------

TabListDialogTest(playerid)
{
      new listitems[] =
  	  "Deagle\t$5000\t100\n" \
	  "Sawnoff\t$5000\t100\n" \
	  "Pistol\t$1000\t50\n" \
	  "M4\t$10000\t100\n" \
	  "MP5\t$7500\t200\n" \
	  "Grenade\t$500\t1\n" \
	  "Parachute\t$10000\t1\n" \
	  "Lorikeet\t$50000\t500\n";

	  ShowPlayerDialog(playerid,2,DIALOG_STYLE_TABLIST,"Buy Weapon",listitems,"Select","Cancel");
}

//-------------------------------------------------

TabListHeadersDialogTest(playerid)
{
      new listitems[] =
      "Weapon\tPrice\tAmmo\n" \
  	  "Deagle\t$5000\t100\n" \
	  "Sawnoff\t$5000\t100\n" \
	  "Pistol\t$1000\t50\n" \
	  "M4\t$10000\t100\n" \
	  "MP5\t$7500\t200\n" \
	  "Grenade\t$500\t1\n" \
	  "Parachute\t$10000\t1\n" \
	  "Lorikeet\t$50000\t500\n";

	  ShowPlayerDialog(playerid,2,DIALOG_STYLE_TABLIST_HEADERS,"Buy Weapon",listitems,"Select","Cancel");
}

//-------------------------------------------------

public TimedVehicleDeath()
{
	if(vehicleid_tokill > 0) {
	    DestroyVehicle(vehicleid_tokill);
	}
}

//-------------------------------------------------

public UpdateTextTimer()
{
	new textdisp[256+1];
	format(textdisp,256,"Dynamic Update (%d)", text_counter);
	text_counter++;
	
	SetPlayerObjectMaterialText(text_update_player, test_tex_objects[0], textdisp, 0, OBJECT_MATERIAL_SIZE_512x128, "Courier New", 48, 1, 0xFF000000, 0, 0);
}

//-------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256+1];
	new idx;
	cmd = strtok(cmdtext, idx);
	new engine,lights,alarm,doors,bonnet,boot,objective;
	
	//if(!IsPlayerAdmin(playerid)) return 0; // this is an admin only script

	if(strcmp(cmd, "/player2v", true) == 0)
	{
  		new tmp[256];
	  	new tmp2[256];
		tmp = strtok(cmdtext,idx);
		tmp2 = strtok(cmdtext,idx);
		PutPlayerInVehicle(strval(tmp),strval(tmp2),0);
	    return 1;
	}

	if(strcmp( cmd, "/vc", true ) == 0 )
	{
		new tmp[256];
		new created_vehicle_id;
		tmp = strtok( cmdtext, idx );
		
		created_vehicle_id = SpawnVehicle_InfrontOfPlayer(playerid, strval(tmp), -1, -1);

		new msg[128+1];
		format(msg,128,"Created vehicle: %d",created_vehicle_id);
		SendClientMessage(playerid,0xAAAAAAAA,msg);

		return 1;
	}
	

	if(strcmp( cmd, "/weap", true ) == 0 )
	{
		new tmp[256];
		tmp = strtok( cmdtext, idx );
		GivePlayerWeapon(playerid, strval(tmp), 9999);
		return 1;
	}

	if(strcmp( cmd, "/dvehicle", true ) == 0 )
	{
		new tmp[256];
		tmp = strtok( cmdtext, idx );

		DestroyVehicle( strval(tmp) );

		new msg[256];
		format(msg,256,"Destroyed vehicle: %d",strval(tmp));
		SendClientMessage(playerid,0xAAAAAAAA,msg);

		return 1;
	}

	if(strcmp( cmd, "/goto", true ) == 0)
	{
	    new tmp[256];

	    tmp = strtok(cmdtext,idx);
	    if(!strlen(tmp)) { return 1; }

	    new Float:X, Float:Y, Float:Z;

	    if(GetPlayerVehicleID(playerid))
	    {
		    GetPlayerPos( strval(tmp), X, Y, Z );
		    SetVehiclePos( GetPlayerVehicleID(playerid), X+2, Y+2, Z );
	    } else {
		    GetPlayerPos( strval(tmp), X, Y, Z );
		    SetPlayerPos( playerid, X+2, Y+2, Z );
	    }

	    return 1;
	}

	if(strcmp(cmd, "/bring", true) == 0)
	{
	    new tmp[256];

	    tmp = strtok(cmdtext, idx);

	    if(!strlen(tmp)) { return 1; }

	    new Float:X, Float:Y, Float:Z;

	    if(GetPlayerVehicleID(strval(tmp)))
	    {
		    GetPlayerPos(playerid, X, Y, Z);
		    SetVehiclePos(GetPlayerVehicleID(strval(tmp)), X+2, Y+2, Z);
	    } else {
		    GetPlayerPos(playerid, X, Y, Z);
		    SetPlayerPos(strval(tmp), X+2, Y+2, Z);
	    }
	    
	    return 1;
	}

	if(strcmp(cmd, "/me2v", true) == 0)
	{
	  	new tmp[256];
		tmp = strtok(cmdtext,idx);
		PutPlayerInVehicle(playerid,strval(tmp),0);
	    return 1;
	}

	if(strcmp(cmd, "/tpzero", true) == 0)
	{
	  	new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
			SetVehiclePos(vid,0.0,0.0,10.0);
		}
	    return 1;
	}

	if(strcmp(cmd, "/myvw", true) == 0)
	{
        new tmp[256];
		tmp = strtok(cmdtext,idx);
		SetPlayerVirtualWorld(playerid,strval(tmp));
	    return 1;
	}

	if(strcmp( cmd, "/fight", true ) == 0)
	{
		new tmp[256];
		new name[128];

		tmp = strtok(cmdtext, idx);
		new style = strval(tmp);
		SetPlayerFightingStyle(playerid, style);
		GetPlayerName(playerid,name,128);
		format(tmp, 256, "(%s) fighting style changed to %d", name, style);
		SendClientMessageToAll(0x4499CCFF,tmp);
		return 1;
	}

	if(strcmp( cmd, "/myfacingangle", true ) == 0)
	{
	    new Float:angle;
	    new tmp[256];
	    GetPlayerFacingAngle(playerid,angle);
		format(tmp, 256, "Facing: %f",angle);
		SendClientMessage(playerid,0x4499CCFF,tmp);
		return 1;
	}

	if(strcmp(cmd, "/crime", true) == 0) {
	    new tmp[256];
	  	new tmp2[256];
		tmp = strtok(cmdtext,idx);
		tmp2 = strtok(cmdtext,idx);
		PlayCrimeReportForPlayer(playerid, strval(tmp), strval(tmp2));
		return 1;
	}

	if(strcmp(cmd, "/repairmycar", true) == 0) {
	    new vid = GetPlayerVehicleID(playerid);
	    if (vid) RepairVehicle(vid);
		return 1;
	}

    if(strcmp(cmd, "/bv", true) == 0)
	{
		new tmp[128], iCar, string[128];

		tmp = strtok(cmdtext, idx);

		if(strlen(tmp) == 0) return SendClientMessage(playerid, 0xFFFFFFFF, "DO: /bv [vehicleid]");

		iCar = strval(tmp);

		new File:file = fopen("badvehicles.txt",io_append);
		format(string,sizeof(string),"%d\r\n", iCar);
		fwrite(file,string);
		fclose(file);

		GetPlayerName(playerid,tmp,128);
		format(string, sizeof(string), "Veh ID %i marked as bad vehicle by %s", iCar, tmp);
		SendClientMessageToAll(0xFFFFFFFF, string);
		return 1;
	}

	if(strcmp(cmd, "/weapskill", true) == 0) {
	    new tmp[256];
	  	new tmp2[256];
		tmp = strtok(cmdtext,idx);
		tmp2 = strtok(cmdtext,idx);
		SetPlayerSkillLevel(playerid, strval(tmp), strval(tmp2));
		return 1;
	}

	if(strcmp(cmd, "/labelonvehicle", true) == 0) {
	    new vid = GetPlayerVehicleID(playerid);
	    textid = Create3DTextLabel("My Vehicle\nOwned by me\nNo Fuel\nRunning on vapour",0xEEEEEE50,0.0,0.0,0.0,15.0,0);
	    Attach3DTextLabelToVehicle(textid, vid, 0.0, -1.6, -0.35); // tail of the vehicle toward the ground
		return 1;
	}

	if(strcmp(cmd, "/labelonplayer", true) == 0) {
		new tmp[256];
		tmp = strtok(cmdtext,idx);
 		textid = Create3DTextLabel("Player Label",0xFFFFFFFF,0.0,0.0,0.0,40.0,0);
	    Attach3DTextLabelToPlayer(textid, strval(tmp), 0.0, 0.0, -0.4);
		return 1;
	}

	if(strcmp(cmd, "/manylabels", true) == 0) {
	    new Float:X, Float:Y, Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
	    new x=0;
	    while(x!=50) {
 			Create3DTextLabel("Mah Labels",0xFFFFFFFF,X,Y,Z,100.0,0);
 			Z = Z + 0.1;
 			x++;
		}
		return 1;
	}

    if(strcmp(cmd, "/dellabel", true) == 0) {
	    Delete3DTextLabel(textid);
		return 1;
	}

	if(strcmp(cmd, "/playerlabel", true) == 0) {
	    new Float:X, Float:Y, Float:Z;
	    GetPlayerPos( playerid, X, Y, Z );
	    player3dtextid = CreatePlayer3DTextLabel(playerid,"Hello\nI'm at your position",0x008080FF,X,Y,Z,40.0);
	    SendClientMessage(playerid, 0xFFFFFFFF, "I created a player label at your position.");
		return 1;
	}

	if(strcmp(cmd, "/playerlabelveh", true) == 0) {
	    new vid = GetPlayerVehicleID(playerid);
	    player3dtextid = CreatePlayer3DTextLabel(playerid,"im in your vehicles\nand hiding behind the walls",0x008080FF,0.0,-1.6,-0.35,20.0,INVALID_PLAYER_ID,vid,1);
		return 1;
	}

	if(strcmp(cmd, "/playerlabelpl", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext,idx);
	    player3dtextid = CreatePlayer3DTextLabel(playerid,"Hello Testing",0x008080FF,0.0,0.0,0.0,30.0,strval(tmp));
		return 1;
	}

    if(strcmp(cmd, "/delplayerlabel", true) == 0) {
	    DeletePlayer3DTextLabel(playerid, player3dtextid);
		return 1;
	}

	if(strcmp(cmd, "/updateplayerlabel", true) == 0) {
	    UpdatePlayer3DTextLabelText(playerid, player3dtextid, 0xFFFFFFFF, "");
		return 1;
	}

	if(strcmp(cmd, "/carmodtest", true) == 0) {
	    // spawns a couple of cars in Grove with mods applied
	   	savanna = CreateVehicle(567,2509.1343,-1686.2330,13.2296,47.3679,16,16,10000);
		AddVehicleComponent(savanna,1189); //Front Bumper
		AddVehicleComponent(savanna,1187); //Rear Bumper
		AddVehicleComponent(savanna,1129); //Exhaust
		AddVehicleComponent(savanna,1102); //Left Side Skirt
		AddVehicleComponent(savanna,1133); //Right Side Skirt
		AddVehicleComponent(savanna,1078); //Wheels
		AddVehicleComponent(savanna,1010); //Nitro 10x
		AddVehicleComponent(savanna,1087); //Hydrolics

		blade = CreateVehicle(536,2509.8462,-1671.8666,13.1510,348.3512,16,16,10000);
		AddVehicleComponent(blade,1182); //Front Bumper
		AddVehicleComponent(blade,1184); //Rear Bumper
		AddVehicleComponent(blade,1104); //Exhaust
		AddVehicleComponent(blade,1108); //Left Side Skirt
		AddVehicleComponent(blade,1107); //Right Side Skirt
		AddVehicleComponent(blade,1078); //Wheels
		AddVehicleComponent(blade,1010); //Nitro 10x
		AddVehicleComponent(blade,1087); //Hydrolics
  		return 1;
	}

	if(strcmp(cmd, "/addnitro", true) == 0) {
	    new vid = GetPlayerVehicleID(playerid);
	    AddVehicleComponent(vid, 1010);
	    return 1;
	}


	if(strcmp(cmd, "/remnitro", true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	    RemoveVehicleComponent(vid, 1010);
	    return 1;
	}

	if(strcmp(cmd, "/paintjob", true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext,idx);
	    new vid = GetPlayerVehicleID(playerid);
		ChangeVehiclePaintjob(vid,strval(tmp));
		return 1;
	}

	if(strcmp(cmd, "/longtd", true) == 0) {
  		new st4[256];
  		new st5[256];
		new st6[256];
		new st7[1024];

		format(st4,sizeof(st4),"0123456789012345678901234567890123456789~n~012345678901234567890123456789~n~01234567890123456789~n~0123456789~n~0123456789012345678901234567890123456789~n~01234567890123456789~n~01234567890123456789~n~01234567890123456789~n~");
		format(st5,sizeof(st5),"0123456789012345678901234567890123456789~n~012345678901234567890123456789~n~01234567890123456789~n~0123456789~n~0123456789012345678901234567890123456789~n~01234567890123456789~n~01234567890123456789~n~01234567890123456789~n~");
		format(st6,sizeof(st6),"0123456789012345678901234567890123456789~n~012345678901234567890123456789~n~01234567890123456789~n~0123456789~n~0123456789012345678901234567890123456789~n~01234567890123456789~n~01234567890123456789~n~01234567890123456789");
		format(st7,sizeof(st7),"%s %s %s~n~LEN(%d)",st4,st5,st6,strlen(st4)+strlen(st5)+strlen(st6));

        new Text:Stats = TextDrawCreate(10.0, 10.0, st7);
		TextDrawTextSize(Stats, 400.0, 400.0);
		TextDrawUseBox(Stats,0);
		TextDrawBoxColor(Stats,0xFFFFFFFF);
		TextDrawFont(Stats,1);
		TextDrawLetterSize(Stats,0.5,0.5);
		TextDrawShowForPlayer(playerid,Stats);
		return 1;
	}
	
	if(strcmp(cmd, "/testmsgbox", true) == 0) {
		ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"Welcome","Welcome to the SA-MP 0.3 server. This is test_cmds.pwn /testmsgbox\nHope it's useful to you.","OK","");
        return 1;
	}
	
	if(strcmp(cmd, "/testmsgbox2", true) == 0) {
		ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX,"Welcome","Welcome:\tInfo\nTest:\t\tTabulated\nLine:\t\tHello","OK","Cancel");
        return 1;
	}

	if(strcmp(cmd, "/testinputbox", true) == 0) {
	    new loginmsg[256+1];
	    new loginname[MAX_PLAYER_NAME+1];
	    GetPlayerName(playerid,loginname,MAX_PLAYER_NAME);
	    format(loginmsg,256,"Welcome to the SA-MP 0.3 server.\n\n{EEEE88}Account:\t{FFFFFF}%s\n\n{FFFFFF}Please enter your password below:",loginname);
		ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"{EE7777}Login to SA-MP",loginmsg,"Login","Cancel");
        return 1;
	}

	if(strcmp(cmd, "/testpassbox", true) == 0) {
	    new loginmsg[256+1];
	    new loginname[MAX_PLAYER_NAME+1];
	    GetPlayerName(playerid,loginname,MAX_PLAYER_NAME);
	    format(loginmsg,256,"Welcome to the SA-MP 0.3 server.\n\n{EEEE88}Account:\t{FFFFFF}%s\n\n{FFFFFF}Please enter your password below:",loginname);
		ShowPlayerDialog(playerid,1,DIALOG_STYLE_PASSWORD,"{EE7777}Login to SA-MP",loginmsg,"Login","Cancel");
        return 1;
	}
	
	if(strcmp(cmd, "/testlistbox", true) == 0) {
	    new listitems[] = "{FFFFFF}1\t{55EE55}Deagle\n{FFFFFF}2\t{55EE55}Sawnoff\n{FFFFFF}3\t{55EE55}Pistol\n{FFFFFF}4\t{55EE55}Grenade\n{FFFFFF}5\t{55EE55}Parachute\n6\t{55EE55}Lorikeet";
	    ShowPlayerDialog(playerid,2,DIALOG_STYLE_LIST,"{448844}List of weapons:",listitems,"Select","Cancel");
        return 1;
	}
	
	if(strcmp(cmd, "/testtablist", true) == 0) {
	    TabListDialogTest(playerid);
        return 1;
	}
	
	if(strcmp(cmd, "/testtablistheaders", true) == 0) {
	    TabListHeadersDialogTest(playerid);
        return 1;
	}

	if(strcmp(cmd, "/testtablistcrash", true) == 0) {
		//ShowPlayerDialog(playerid,2,DIALOG_STYLE_TABLIST_HEADERS,"{FFFF00}SMGs", "Weapon\tAmount\tPrice\n{FFFFFF}MP5\t90\t{FF0000}$3500","Buy", "Go Back");
        ShowPlayerDialog(playerid,2,DIALOG_STYLE_TABLIST_HEADERS,"{FFFF00}SMGs", AMMUNATION_SMGS_DIALOG, "Buy", "Go Back");
		return 1;
	}
	
    if(strcmp(cmd, "/testclosebox", true) == 0) {
	    ShowPlayerDialog(playerid,-1,0,"","","","");
        return 1;
	}

    if(strcmp(cmd, "/setfacingzero", true) == 0) {
	    SetPlayerFacingAngle(playerid, 0.0);
        return 1;
	}

    if(strcmp(cmd, "/detachtrailer", true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	    DetachTrailerFromVehicle(vid);
        return 1;
	}
	
	if(strcmp(cmd, "/testformat", true) == 0) {
	    new strtest[256];
	    new File:f = fopen("test.txt",io_write);
	    format(strtest,256,"[chat] %d %s\r\n",24,"þÿÿþ");
	    SendClientMessage(playerid,0xFFFFFFFF,strtest);
	    fwrite(f,strtest);
	    format(strtest,256,"[chat] %d %s\r\n",34," þÿÿþ");
	    SendClientMessage(playerid,0xFFFFFFFF,strtest);
	    fwrite(f,strtest);
	    fclose(f);
	    return 1;
	}

	if(strcmp(cmd, "/setskin", true) == 0) {
        new tmp[256];
		tmp = strtok(cmdtext,idx);
		SetPlayerSkin(playerid,strval(tmp));
	    return 1;
	}
	
	if(strcmp(cmd, "/setvars", true) == 0) {
		SetPVarInt(playerid,"num_test",7001);
		SetPVarString(playerid,"additional_tag","Hello World");
		SetPVarFloat(playerid,"some_float",1001.0);
		SendClientMessage(playerid,0xFFFFFFFF, "Vars set");
	    return 1;
	}
	
	if(strcmp(cmd, "/modvars", true) == 0) {
		SetPVarInt(playerid,"num_test",8001);
		SetPVarString(playerid,"additional_tag","World Hello");
		SetPVarFloat(playerid,"some_float",6901.0);
		SendClientMessage(playerid,0xFFFFFFFF, "Vars modded");
	    return 1;
	}
	
	if(strcmp(cmd, "/getvars", true) == 0) {
	
		new tst_IntRet;
		new Float:tst_FloatRet;
		new tst_StrRet[256];
		new tst_DispStr[256];
		
		tst_IntRet = GetPVarInt(playerid,"num_test");
		tst_FloatRet = GetPVarFloat(playerid,"some_float");
 		GetPVarString(playerid,"additional_tag",tst_StrRet,256);
 		
		format(tst_DispStr,256,"num_test: %d some_float: %f additional_tag: %s",tst_IntRet,tst_FloatRet,tst_StrRet);
		SendClientMessage(playerid,0xFFFFFFFF, tst_DispStr);
		
	    return 1;
	}
	
	if(strcmp(cmd, "/delvars", true) == 0) {
		DeletePVar(playerid,"num_test");
		DeletePVar(playerid,"additional_tag");
		DeletePVar(playerid,"some_float");
		SendClientMessage(playerid,0xFFFFFFFF, "Vars deleted");
	    return 1;
	}

	if(strcmp(cmd, "/pvarlist", true) == 0) {
		SendPVarListToPlayer(playerid);
	    return 1;
	}

	if(strcmp(cmd, "/kill",true) == 0) {
	    SetPlayerHealth(playerid,0.0);
	    return 1;
	}
	
	if(strcmp(cmd, "/kickallnpc",true) == 0) {
		new p=0;
		while(p!=MAX_PLAYERS) {
			if(IsPlayerConnected(p) && IsPlayerNPC(p)) Kick(p);
			p++;
		}
	    return 1;
	}
	
	if(strcmp(cmd, "/startengine",true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
	  	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	  	    SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
		}
	    return 1;
	}
	if(strcmp(cmd, "/stopengine",true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
	  	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	  	    SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
		}
	    return 1;
	}
	
	if(strcmp(cmd, "/openboot",true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
	  	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	  	    SetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_ON,objective);
		}
	    return 1;
	}
	if(strcmp(cmd, "/closeboot",true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
	  	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	  	    SetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_OFF,objective);
		}
	    return 1;
	}
	if(strcmp(cmd, "/openbonnet",true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
	  	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	  	    SetVehicleParamsEx(vid,engine,lights,alarm,doors,VEHICLE_PARAMS_ON,boot,objective);
		}
	    return 1;
	}
	if(strcmp(cmd, "/closebonnet",true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
	  	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	  	    SetVehicleParamsEx(vid,engine,lights,alarm,doors,VEHICLE_PARAMS_OFF,boot,objective);
		}
	    return 1;
	}
	if(strcmp(cmd, "/alarmon",true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
	  	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	  	    SetVehicleParamsEx(vid,engine,lights,VEHICLE_PARAMS_ON,doors,bonnet,boot,objective);
		}
	    return 1;
	}
	if(strcmp(cmd, "/alarmoff",true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
	  	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	  	    SetVehicleParamsEx(vid,engine,lights,VEHICLE_PARAMS_OFF,doors,bonnet,boot,objective);
		}
	    return 1;
	}
	if(strcmp(cmd, "/lightson",true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
	  	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	  	    SetVehicleParamsEx(vid,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
		}
	    return 1;
	}
	if(strcmp(cmd, "/lightsoff",true) == 0) {
        new vid = GetPlayerVehicleID(playerid);
	  	if(vid != INVALID_VEHICLE_ID) {
	  	    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
	  	    SetVehicleParamsEx(vid,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
		}
	    return 1;
	}

	if(strcmp(cmd, "/holdobjectid",true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext,idx);
		SetPlayerAttachedObject(playerid,0,strval(tmp),6);
		SetPlayerAttachedObject(playerid,1,strval(tmp),5);
		//SetPlayerAttachedObject(playerid, 0, 1254,2, 0.1,0.05,0,0,90,0);
	    return 1;
	}

	if(strcmp(cmd, "/removeheld",true) == 0) {
		new zz=0;
		while(zz!=MAX_PLAYER_ATTACHED_OBJECTS) {
		    if(IsPlayerAttachedObjectSlotUsed(playerid, zz)) {
		        RemovePlayerAttachedObject(playerid, zz);
			}
			zz++;
		}
	    return 1;
	}

	if(strcmp(cmd, "/attachobj",true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext,idx);
		new obj = CreateObject(strval(tmp),0.0,0.0,0.0,0.0,0.0,0.0,200.0);
		AttachObjectToVehicle(obj,GetPlayerVehicleID(playerid),0.0,0.0,1.0,0.0,0.0,0.0);
		return 1;
	}
	
	if(strcmp(cmd, "/attachtome",true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext,idx);
		new obj = CreateObject(strval(tmp),0.0,0.0,0.0,0.0,0.0,0.0,200.0);
		AttachObjectToPlayer(obj,playerid,0.0,0.0,2.0,0.0,0.0,0.0);
		return 1;
	}

	if(strcmp(cmd, "/mapicontest",true) == 0) {
	    new Float:X, Float:Y, Float:Z;
 		GetPlayerPos(playerid, X, Y, Z);
 		SetPlayerCheckpoint(playerid,X,Y,Z,5.0);
	   	SetPlayerMapIcon(playerid, 1, X+50.0, Y, Z, 52, 0, MAPICON_LOCAL_CHECKPOINT);
	   	SetPlayerMapIcon(playerid, 2, X+100.0, Y, Z, 53, 0, MAPICON_LOCAL_CHECKPOINT);
	   	SetPlayerMapIcon(playerid, 3, X+150.0, Y, Z, 54, 0, MAPICON_LOCAL_CHECKPOINT);
	   	SetPlayerMapIcon(playerid, 4, X+200.0, Y, Z, 55, 0, MAPICON_LOCAL_CHECKPOINT);
	   	SetPlayerMapIcon(playerid, 5, X+250.0, Y, Z, 0, 0x00FF00FF);
		return 1;
	}
	
	if(strcmp(cmd, "/mapicondel",true) == 0) {
        RemovePlayerMapIcon(playerid, 1);
        RemovePlayerMapIcon(playerid, 2);
        RemovePlayerMapIcon(playerid, 3);
        RemovePlayerMapIcon(playerid, 4);
        RemovePlayerMapIcon(playerid, 5);
     	return 1;
	}
	
	if(strcmp(cmd, "/mapicontest2",true) == 0) {
	    new Float:X, Float:Y, Float:Z;
 		GetPlayerPos(playerid, X, Y, Z);
		RemovePlayerMapIcon(playerid, 0);
		SetPlayerMapIcon(playerid, 0, X, Y, Z, 33, 0, MAPICON_GLOBAL);
		RemovePlayerMapIcon(playerid, 2);
		SetPlayerMapIcon(playerid, 2, X+100.0, Y, Z, 55, 0, MAPICON_LOCAL);
  		return 1;
	}
	
	if(strcmp(cmd, "/setweap",true) == 0) {
	    new tmp[256];
		tmp = strtok(cmdtext,idx);
		SetPlayerArmedWeapon(playerid,strval(tmp));
  		return 1;
	}

	if(strcmp(cmd, "/jetpack",true) == 0) {
	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
		return 1;
	}
	
	if(strcmp(cmd, "/crobj",true) == 0) {
	    new Float:X, Float:Y, Float:Z;
	   	new tmp[256];
 		GetPlayerPos(playerid, X, Y, Z);
 		tmp = strtok(cmdtext,idx);
		CreateObject(strval(tmp),X+1.0,Y+1.0,Z+0.5,0.0,0.0,0.0,200.0);
		return 1;
	}

	if(strcmp(cmd, "/dropaudio",true) == 0) {
	    new Float:X, Float:Y, Float:Z;
 		GetPlayerPos(playerid, X, Y, Z);
		PlayAudioStreamForPlayer(playerid, "http://somafm.com/tags.pls", X, Y, Z, 40.0, true);
		return 1;
	}
	
	if(strcmp(cmd, "/officefloor",true) == 0) {
 		SetPlayerPos(playerid,1786.0645,-1298.7510,104.2);
		return 1;
	}
	
	if(strcmp(cmd, "/lvpd",true) == 0) {
	    SetPlayerInterior(playerid, 3);
 		SetPlayerPos(playerid,237.5571,148.7559,1005.4703);
		return 1;
	}

	if(strcmp(cmd, "/kill",true) == 0) {
 		SetPlayerHealth(playerid,0.0);
		return 1;
	}
	
	if(strcmp(cmd, "/atrailer",true) == 0) {
 		new tmp[256];
 		tmp = strtok(cmdtext,idx);
		AttachTrailerToVehicle(strval(tmp),GetPlayerVehicleID(playerid));
		return 1;
	}
	
	if(strcmp(cmd, "/dtrailer",true) == 0) {
		if(GetVehicleTrailer(GetPlayerVehicleID(playerid)) != 0) {
		    DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
		}
		return 1;
	}
	
	if(strcmp(cmd, "/cfence",true) == 0) {
		SetPlayerPos(playerid,2496.40, -1664.84, 13.19);
		if(!fence) fence = CreateObject(1410, 2496.80, -1661.88, 13.4, 0.00, 0.00, 0.00);
		return 1;
	}
	
	if(strcmp(cmd, "/mfence1",true) == 0) {
	    MoveObject(fence, 2494.56, -1664.12, 13.4, 1.0, 0.00, 0.00, -90.0);
		return 1;
	}
	
	if(strcmp(cmd, "/mfence2",true) == 0) {
	    MoveObject(fence, 2496.80, -1661.88, 13.4, 1.0, 0.00, 0.00, 0.00);
		return 1;
	}

	if(strcmp(cmd, "/usecell",true) == 0) {
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	    //SetPlayerAttachedObject(playerid, 4, 330, 6); // 4 = attachment slot, 330 = cellphone model, 6 = right hand
		return 1;
	}
	
	if(strcmp(cmd, "/stopcell",true) == 0) {
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	    RemovePlayerAttachedObject(playerid, 4);
		return 1;
	}
	
	if(strcmp(cmd, "/objvehst",true) == 0) {
	    new objveh;
		new objatt;
		new Float:X, Float:Y, Float:Z;
 		GetPlayerPos(playerid, X, Y, Z);
		objveh = CreateVehicle(563, X+2.0, Y+2.0, Z, 0.0, 0, 0, -1);
		objatt = CreateObject(19277, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 200.0);
		AttachObjectToVehicle(objatt, objveh, 2.0, 0.15, 0.0, 0.0, 0.0, 90.0);
		return 1;
	}

	if(strcmp(cmd, "/uncontrol", true) == 0) {
	    TogglePlayerControllable(playerid, 0);
	    unfreezeplayer = playerid;
	    //SetTimer("UnFreezeMe",5000,0);
	    return 1;
	}
	
	if(strcmp(cmd, "/recontrol", true) == 0) {
	    TogglePlayerControllable(playerid, 1);
	    return 1;
	}

	if(strcmp(cmd, "/objlim1", true) == 0) {
	    new Float:X, Float:Y, Float:Z;
	    new lp=0;
 		GetPlayerPos(playerid, X, Y, Z);
 		while(lp != 999) {
	    	CreateObject(1656, X, Y, Z, 0.00, 0.00, 0.00, 1000.0);
	    	Y += 0.25;
	    	lp++;
		}
	    return 1;
	}

	if(strcmp(cmd, "/kkeys", true) == 0) {
		new message[256+1];
		format(message, 256, "{FFFFFF}Left Key: {FFFF00}~k~~GO_LEFT~ {FFFFFF}Right Key: {FFFF00}~k~~GO_RIGHT~ {FFFFFF}Fire Key: {FFFF00}~k~~PED_FIREWEAPON~");
		SendClientMessage(playerid, 0xFFFFFFFF, message);
		return 1;
	}
	
	if(strcmp(cmd, "/timeddlg", true) == 0) {
	    testlbplayer = playerid;
	    SetTimer("ShowTestDialog",5000,0);
	    return 1;
	}
	
	if(strcmp(cmd, "/editattach",true) == 0) {
	    if(!IsPlayerAttachedObjectSlotUsed(playerid, 0)) {
			SetPlayerAttachedObject(playerid,0,19006,2); // red sunglasses to head bone
		}
		SendClientMessage(playerid, 0xFFFFFFFF, "Hint: Use {FFFF00}~k~~PED_SPRINT~{FFFFFF} to look around.");
		EditAttachedObject(playerid, 0);
	    return 1;
	}
	
	if(strcmp(cmd, "/editobject",true) == 0) {
		if(edit_objectid == INVALID_OBJECT_ID) {
		    new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			edit_objectid = CreateObject(1656,X+1.0,Y+1.0,Z+0.5,0.0,0.0,0.0,200.0);
		}
		SendClientMessage(playerid, 0xFFFFFFFF, "Hint: Use {FFFF00}~k~~PED_SPRINT~{FFFFFF} to look around.");
		EditObject(playerid, edit_objectid);
	    return 1;
	}
	
	if(strcmp(cmd, "/selobj",true) == 0) {
		SendClientMessage(playerid, 0xFFFFFFFF, "Hint: Use {FFFF00}~k~~PED_SPRINT~{FFFFFF} to look around.");
		SelectObject(playerid);
	    return 1;
	}
	
	if(strcmp(cmd, "/canceledit",true) == 0) {
		CancelEdit(playerid);
	    return 1;
	}
	
	if(strcmp(cmd, "/editpobject",true) == 0) {
		if(edit_objectid == INVALID_OBJECT_ID) {
		    new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			edit_objectid = CreatePlayerObject(playerid,19522,X+1.0,Y+1.0,Z+0.5,0.0,0.0,0.0,200.0);
		}
		SendClientMessage(playerid, 0xFFFFFFFF, "Hint: Use {FFFF00}~k~~PED_SPRINT~{FFFFFF} to look around.");
		EditPlayerObject(playerid, edit_objectid);
	    return 1;
	}
	
	if(strcmp(cmd, "/cam_on_obj",true) == 0) {
	  	new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		if(edit_objectid == INVALID_OBJECT_ID) {
			edit_objectid = CreateObject(19320,X+1.0,Y+1.0,Z+0.5,0.0,0.0,0.0,200.0);
		}
		//TogglePlayerSpectating(playerid, 1);
	    AttachCameraToObject(playerid, edit_objectid);
	    MoveObject(edit_objectid, X, Y + 2000.0, Z + 400.0, 20.0);
	    return 1;
	}
	
	if(strcmp(cmd, "/cam_on_train",true) == 0) {
	  	new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		if(edit_objectid == INVALID_OBJECT_ID) {
			edit_objectid = CreateObject(19320,X+1.0,Y+1.0,Z+0.5,0.0,0.0,0.0,200.0);
		}
		TogglePlayerSpectating(playerid, 1);
		AttachObjectToVehicle(edit_objectid, 9, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0);
		PlayerSpectateVehicle(playerid, 9);
	    AttachCameraToObject(playerid, edit_objectid);
	    return 1;
	}
	
	if(strcmp(cmd, "/cam_interp",true) == 0) {
	  	new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		InterpolateCameraPos(playerid, X, Y, Z, X + 100.0, Y + 100.0, Z + 20.0, 10000);
	    return 1;
	}
	
	if(strcmp(cmd, "/cam_interp_look",true) == 0) {
	  	new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		InterpolateCameraPos(playerid, X, Y, Z, X + 100.0, Y + 100.0, Z + 20.0, 10000);
		InterpolateCameraLookAt(playerid, X, Y, Z, 0.0, 0.0, 0.0, 10000);
	    return 1;
	}

	if(strcmp(cmd, "/cam_behind",true) == 0) {
	    SetCameraBehindPlayer(playerid);
	    return 1;
	}
	
	if(strcmp(cmd, "/respawn_veh",true) == 0) {
	  	new tmp[256];
		tmp = strtok(cmdtext,idx);
		SetVehicleToRespawn(strval(tmp));
		return 1;
	}
	
	if(strcmp(cmd, "/crplain", true) == 0) {
        CreateObject(19003, 416.54, 1655.75, 700.00, 0.00, 0.00, 0.00, 200.0);
        CreateObject(4561, -26.98, 1639.33, 98.03, 0.00, 0.00, 0.00, 1000.0);
	    return 1;
	}

	if(strcmp(cmd, "/testplain", true) == 0) {
        CreateObject(19003, 416.54, 1655.75, 700.00, 0.00, 0.00, 0.00);
                    
	    if(GetPlayerVehicleID(playerid)) {
		    SetVehiclePos(GetPlayerVehicleID(playerid), 416.54, 1655.75, 705.00);
	    }
		else {
		    SetPlayerPos(playerid, 416.54, 1655.75, 710.00);
	    }
	    return 1;
	}
	
	if(strcmp(cmd, "/testplain2", true) == 0) {
 		CreateObject(10766, 168.86, 1686.77, 44.86, 0.00, 0.00, 0.00, 1000.0);
		CreateObject(10766, 168.86, 1532.52, 44.86, 0.00, 0.00, 0.00, 1000.0);

	    if(GetPlayerVehicleID(playerid)) {
		    SetVehiclePos(GetPlayerVehicleID(playerid), 162.9956, 1606.2555, 55.3197);
	    }
		else {
		    SetPlayerPos(playerid, 162.9956, 1606.2555, 55.3197);
	    }
	    return 1;
	}

	if(strcmp(cmd, "/clicktd",true) == 0) {
		new Text:txtTestText1;

    	txtTestText1 = TextDrawCreate(320.0, 100.0, "Test Text 1");
    	TextDrawUseBox(txtTestText1, 1);
    	TextDrawBoxColor(txtTestText1, 0x00000044);
		TextDrawFont(txtTestText1, 3);
		TextDrawSetShadow(txtTestText1,0); // no shadow
    	TextDrawSetOutline(txtTestText1,2); // thickness 1
    	TextDrawBackgroundColor(txtTestText1,0x000000FF);
    	TextDrawColor(txtTestText1,0xFFFFFFFF);
    	TextDrawAlignment(txtTestText1,2); // centered
		TextDrawLetterSize(txtTestText1,0.5,1.5);
		TextDrawTextSize(txtTestText1, 20.0, 200.0); // reverse width and height for rockstar (only for centered td's)
		TextDrawSetSelectable(txtTestText1, 1);
		TextDrawShowForPlayer(playerid,txtTestText1);

    	new Text:txtSprite1;
    	txtSprite1 = TextDrawCreate(200.0, 220.0, "samaps:map"); // Text is txdfile:texture
    	TextDrawFont(txtSprite1, 4); // Font ID 4 is the sprite draw font
    	TextDrawColor(txtSprite1,0xFFFFFFFF);
    	TextDrawTextSize(txtSprite1,200.0,200.0); // Text size is the Width:Height
    	TextDrawSetSelectable(txtSprite1, 1);
    	TextDrawShowForPlayer(playerid,txtSprite1);
    	
    	SelectTextDraw(playerid, 0x9999BBBB);
    	return 1;
	}
	
	if(strcmp(cmd, "/playertd",true) == 0) {
		/*
		new PlayerText:PlayerTestText1;
    	PlayerTestText1 = CreatePlayerTextDraw(playerid, 320.0, 100.0, "Test Text 1");
    	PlayerTextDrawUseBox(playerid,PlayerTestText1, 1);
    	PlayerTextDrawBoxColor(playerid,PlayerTestText1, 0x00000044);
		PlayerTextDrawFont(playerid,PlayerTestText1, 3);
		PlayerTextDrawSetShadow(playerid,PlayerTestText1,0); // no shadow
    	PlayerTextDrawSetOutline(playerid,PlayerTestText1,2); // thickness 1
    	PlayerTextDrawBackgroundColor(playerid, PlayerTestText1,0x000000FF);
    	PlayerTextDrawColor(playerid,PlayerTestText1,0xFFFFFFFF);
    	//PlayerTextDrawAlignment(playerid,PlayerTestText1,2); // centered
		PlayerTextDrawLetterSize(playerid,PlayerTestText1,0.5,1.5);
		PlayerTextDrawTextSize(playerid,PlayerTestText1, 50.0, 200.0); // reverse width and height for rockstar (only for centered td's)
		PlayerTextDrawSetSelectable(playerid,PlayerTestText1,1);
		PlayerTextDrawShow(playerid,PlayerTestText1);*/

    	//SelectTextDraw(playerid, 0x9999BBBB);
    	return 1;
	}
	
	if(strcmp(cmd, "/canceltd",true) == 0) {
	    CancelSelectTextDraw(playerid);
	    return 1;
	}

	if(strcmp(cmd, "/timed_vd", true) == 0) {
	    vehicleid_tokill = GetPlayerVehicleID(playerid);
	    SetTimer("TimedVehicleDeath",3000,0);
	    return 1;
	}
	
	if(strcmp(cmd, "/vmodelsize", true) == 0) {
	    new Float:X, Float:Y, Float:Z;
	    new VehicleId = GetPlayerVehicleID(playerid);
		new message[256+1];
		if(!VehicleId || VehicleId == INVALID_VEHICLE_ID) {
		    SendClientMessage(playerid, 0xFFFFFFFF, "/vmodelsize : Be in a vehicle to use this command." );
			return 1;
		}
		new VehicleModel = GetVehicleModel(VehicleId);
		GetVehicleModelInfo(VehicleModel, VEHICLE_MODEL_INFO_SIZE, X, Y, Z);
		format(message, 256, "Vehicle(%d) Size: %.4f, %.4f, %.4f", VehicleModel, X, Y, Z);
		SendClientMessage(playerid, 0xFFFFFFFF, message);
	    return 1;
	}
	

	if(strcmp(cmd, "/crptex",true) == 0) {
	    new lp=0;
		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		X+=1.0;
		while(lp != 128) {
			test_tex_objects[lp] = CreatePlayerObject(playerid,19372,X,Y,Z+0.5,0.0,0.0,0.0,0.0);
			//SetPlayerObjectMaterial(playerid, test_tex_objects[lp], 0, 0, "null", "null", 0);
			
			if(lp % 2 == 0) {
				SetPlayerObjectMaterial(playerid, test_tex_objects[lp], 0, 19325, "all_walls", "stormdrain3_nt", 0xFF00FF00);
			} else {
			    SetPlayerObjectMaterial(playerid, test_tex_objects[lp], 0, 19371, "all_walls", "stormdrain3_nt", 0xFF551155);
			}
			
			X+=2.0;
			lp++;
		}
	}

    if(strcmp(cmd, "/crpmix",true) == 0) {
	    new lp=0;
		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		X+=1.0;
		new szId[256+1];
		while(lp != 128) {
			test_tex_objects[lp] = CreatePlayerObject(playerid,19371,X,Y,Z+0.5,0.0,0.0,0.0,300.0);
			//format(szId, 256, "Text Here: {00FF00}%d", lp);
			//SetPlayerObjectMaterialText(playerid, test_tex_objects[lp], szId, 0, OBJECT_MATERIAL_SIZE_512x512, "Verdana", 60, 1, 0xFF5555FF, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			if(lp % 2 == 0) {
			    SetPlayerObjectMaterial(playerid, test_tex_objects[lp], 0, 19371, "all_walls", "stormdrain3_nt", 0xFF55AA55);
			} else {
			    format(szId, 256, "Text: {00FF00}%d", lp);
			    SetPlayerObjectMaterialText(playerid, test_tex_objects[lp], szId, 0, OBJECT_MATERIAL_SIZE_512x256, "Verdana", 60, 1, 0xFF5555FF, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			}
			X+=2.0;
			lp++;
		}
		return 1;
	}

	if(strcmp(cmd, "/crptext",true) == 0) {
		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		X+=1.0;
		
		test_tex_objects[0] = CreatePlayerObject(playerid,19479,X,Y,Z+0.5,0.0,0.0,0.0,300.0);
		SetObjectMaterialText(test_tex_objects[0], "Dynamic Update (0)", 0, OBJECT_MATERIAL_SIZE_512x128, "Courier New", 48, 1, 0xFF000000, 0, 0);
		X+=3.0;
		
		// This is a dynamic update material text
		if(text_update_timer == -1) {
			text_update_timer = SetTimer("UpdateTextTimer", 1000, 1);
			text_update_player = playerid;
		}

		test_tex_objects[1] = CreatePlayerObject(playerid,19479,X,Y,Z+4.0,0.0,0.0,0.0,300.0);
		SetPlayerObjectMaterialText(playerid, test_tex_objects[1], "ABDSJFUEGI\nABDRJCFEGI\n{DDDDDD}Center", 0, OBJECT_MATERIAL_SIZE_512x256, "GTAWEAPON3", 70, 0, 0xFF00FF00, 0xFF444477, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
		X+=3.0;
		
		test_tex_objects[2] = CreatePlayerObject(playerid,19480,X,Y,Z+4.0,0.0,0.0,0.0,300.0);
		SetPlayerObjectMaterialText(playerid, test_tex_objects[2], "Blue Text\nVerdana\nAlpha BG\n{DDDDDD}Center", 0, OBJECT_MATERIAL_SIZE_512x256, "Verdana", 60, 1, 0xFF000000, 0xFFFFFFFF, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
		X+=3.0;

		test_tex_objects[3] = CreatePlayerObject(playerid,19481,X,Y,Z+4.0,0.0,0.0,0.0,300.0);
		SetPlayerObjectMaterialText(playerid, test_tex_objects[3], "Blue Text\nArial\nAlpha BG\n{DDDDDD}Center", 0, OBJECT_MATERIAL_SIZE_512x256, "Arial", 60, 1, 0xFF000000, 0xFFCDD704, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
		X+=3.0;

		test_tex_objects[4] = CreatePlayerObject(playerid,19482,X,Y,Z+4.0,0.0,0.0,0.0,300.0);
		SetPlayerObjectMaterialText(playerid, test_tex_objects[4], "Blue Text\nVerdana\nAlpha BG\n{DDDDDD}Center", 0, OBJECT_MATERIAL_SIZE_512x256, "Verdana", 60, 1, 0xFF000000, 0xFFCDD704, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
		X+=3.0;

		test_tex_objects[5] = CreatePlayerObject(playerid,19483,X,Y,Z+4.0,0.0,0.0,0.0,300.0);
		SetPlayerObjectMaterialText(playerid, test_tex_objects[5], "Blue Text\nArial\nAlpha BG\n{DDDDDD}Center", 0, OBJECT_MATERIAL_SIZE_512x256, "Arial", 60, 1, 0xFF000000, 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
		X+=3.0;

		//EditPlayerObject(playerid, test_tex_objects[0]);
	    return 1;
	}
	
	if(strcmp(cmd, "/delptex",true) == 0) {
	    new lp=0;
		while(lp != 128) {
			if(IsValidPlayerObject(playerid, test_tex_objects[lp])) {
				DestroyPlayerObject(playerid, test_tex_objects[lp]);
			}
			lp++;
		}
		if(text_update_timer >= 0) {
			KillTimer(text_update_timer);
			text_update_timer = -1;
		}
	    return 1;
	}

	// Damian's bed that crashed because material object id and original object id were the same
	if(strcmp(cmd, "/crashbed",true) == 0) {
	    new objbed1=0;
	    new objbed2=0;
		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		
		// 14446
		//0:18028:cj_bar2:CJ_nastybar_D2:000000;
		//2:18646:matcolours:blue:000fff;
		objbed1 = CreatePlayerObject(playerid,14446,X,Y,Z+0.1,0.0,0.0,0.0,300.0);
		SetPlayerObjectMaterial(playerid, objbed1, 0, 18028, "cj_bar2", "CJ_nastybar_D2", 0xFF000000);
	    SetPlayerObjectMaterial(playerid, objbed1, 2, 18646, "matcolours", "blue", 0xFF000fff);

	   	// 14446
		//0:0:none:none:000000;
		//1:0:none:none:0000ff;
		//2:14446:carter_block:zebra_skin:000000;
	    objbed2 = CreatePlayerObject(playerid,14446,X,Y+2.0,Z+0.1,0.0,0.0,0.0,300.0);
        SetPlayerObjectMaterial(playerid, objbed2, 0, 0, "none", "none", 0xFF000000);
        SetPlayerObjectMaterial(playerid, objbed2, 1, 0, "none", "none", 0xFF0000FF);
        //SetPlayerObjectMaterial(playerid, objbed2, 2, 18646, "matcolours", "blue", 0xFFFFFFFF);
	    SetPlayerObjectMaterial(playerid, objbed2, 2, 14446, "carter_block", "mp_carter_wall", 0xFFFFFFFF);
	    
	    return 1;
	}
	
	// Damian's house object that is crashing in 0.3x
	if(strcmp(cmd, "/crash_hobj",true) == 0) {
	    new objcab=0;
		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);

		//2385
		//;index_id:model_id:txd_name:txd_txt:txd_color(0 if no color);
		//;0:2748:pizza_furn:CJ_WOOD6:0;
		//;1:2748:pizza_furn:CJ_WOOD6:A78D84;
		//;2:2748:pizza_furn:CJ_WOOD6:A78D84;
		objcab = CreatePlayerObject(playerid,2385,X,Y,Z+0.1,0.0,0.0,0.0,0.0);
		
		SetPlayerObjectMaterial(playerid, objcab, 0, 2748, "pizza_furn", "CJ_WOOD6", 0);
	    SetPlayerObjectMaterial(playerid, objcab, 1, 2748, "pizza_furn", "CJ_WOOD6", 0xFFA78D84);
	    SetPlayerObjectMaterial(playerid, objcab, 2, 2748, "pizza_furn", "CJ_WOOD6", 0xFFA78D84);
	    
	    /*
	    SetPlayerObjectMaterial(playerid, objcab, 0, -1, "none", "none", 0xFF00AA00);
	    SetPlayerObjectMaterial(playerid, objcab, 1, -1, "none", "none", 0xFF00AA00);
	    SetPlayerObjectMaterial(playerid, objcab, 2, -1, "none", "none", 0xFF00AA00);*/

	    return 1;
	}
	
	if(strcmp(cmd, "/kickmessage", true) == 0) {
        KickWithMessage(playerid, "Bye!");
        return 1;
	}

	if(strcmp(cmd, "/animindex", true) == 0) {
	    new msg[256+1];
		new animlib[64+1];
		new animname[64+1];
	    new tmp[256+1];
		tmp = strtok(cmdtext,idx);
		GetAnimationName(strval(tmp), animlib, 64, animname, 64);
		format(msg,sizeof(msg),"AnimIndex: %d is %s:%s", strval(tmp), animlib, animname);
		SendClientMessage(playerid, 0xFFFFFFFF, msg);
		return 1;
	}
	
	if(strcmp(cmd, "/weapdata", true) == 0) {
	    new msg[256+1];
	    new x=0;
	    new weaponret;
	    new ammoret;
	    while(x!=13) {
	        GetPlayerWeaponData(playerid, x, weaponret, ammoret);
			format(msg,sizeof(msg),"WeapSlot(%d) %d:%d", x, weaponret, ammoret);
			SendClientMessage(playerid, 0xFFFFFFFF, msg);
			x++;
		}
		return 1;
	}
	
	if(strcmp(cmd, "/explosion", true) == 0) {
		new tmp[256];
		tmp = strtok(cmdtext,idx);
	    new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		CreateExplosionEx(X+10.0, Y+10.0, Z+10.0, 1, 2.0, strval(tmp));
		return 1;
	}
	
	if(strcmp(cmd, "/flatbedcontainer",true) == 0) {
		new create_flatbed = SpawnVehicle_InfrontOfPlayer(playerid, 578, -1, -1);
		new obj = CreateObject(19321,0.0,0.0,0.0,0.0,0.0,0.0);
		AttachObjectToVehicle(obj,create_flatbed,-0.0165,-2.0660,1.2442,0.0,0.0,0.0);
		return 1;
	}
	
	if(strcmp(cmd, "/disablevcol",true) == 0) {
	    DisableRemoteVehicleCollisions(playerid, 1);
		return 1;
	}
	
	if(strcmp(cmd, "/enablevcol",true) == 0) {
        DisableRemoteVehicleCollisions(playerid, 0);
		return 1;
	}

	if(strcmp(cmd, "/disablecamtarget",true) == 0) {
	    EnablePlayerCameraTarget(playerid, 0);
		return 1;
	}

	if(strcmp(cmd, "/enablecamtarget",true) == 0) {
        EnablePlayerCameraTarget(playerid, 1);
		return 1;
	}

	if(strcmp(cmd, "/poolsize", true) == 0) {
	    new msg[256+1];
	    new HigestPlayerId = GetPlayerPoolSize();
	    new HigestVehicleId = GetVehiclePoolSize();
	 	format(msg,sizeof(msg),"PlayerPoolSize: %d", HigestPlayerId);
		SendClientMessage(playerid, 0xFFFFFFFF, msg);
        format(msg,sizeof(msg),"VehiclePoolSize: %d", HigestVehicleId);
		SendClientMessage(playerid, 0xFFFFFFFF, msg);
		return 1;
	}
	
	if(strcmp(cmd, "/sirenstate", true ) == 0)
	{
	    if( GetPlayerVehicleID(playerid) && GetPlayerVehicleID(playerid) != INVALID_VEHICLE_ID &&
		    GetVehicleParamsSirenState(GetPlayerVehicleID(playerid)) == VEHICLE_PARAMS_ON )
		{
		   SendClientMessage(playerid, 0xFFFFFFFF, "Siren is ON");
	    }
		else {
		   SendClientMessage(playerid, 0xFFFFFFFF, "Siren is OFF");
	    }

	    return 1;
	}

	if(strcmp(cmd, "/opencardoors", true ) == 0)
	{
        if(GetPlayerVehicleID(playerid) && GetPlayerVehicleID(playerid) != INVALID_VEHICLE_ID)
		{
			SetVehicleParamsCarDoors(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON);
	    }
	    /*
   		if(GetPlayerCameraTargetVehicle(playerid) != INVALID_VEHICLE_ID)
		{
			SetVehicleParamsCarDoors(GetPlayerCameraTargetVehicle(playerid), VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON);
	    }*/
	    return 1;
	}

	if(strcmp(cmd, "/closecardoors", true ) == 0)
	{
	    if(GetPlayerVehicleID(playerid) && GetPlayerVehicleID(playerid) != INVALID_VEHICLE_ID)
		{
			SetVehicleParamsCarDoors(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF);
	    }
	    /*
	    if(GetPlayerCameraTargetVehicle(playerid) != INVALID_VEHICLE_ID)
		{
			SetVehicleParamsCarDoors(GetPlayerCameraTargetVehicle(playerid), VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF);
	    }*/
 	    return 1;
	}
	
	if(strcmp(cmd, "/opencarwindows", true ) == 0)
	{
	    if(GetPlayerVehicleID(playerid) && GetPlayerVehicleID(playerid) != INVALID_VEHICLE_ID)
		{
			SetVehicleParamsCarWindows(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF);
	    }
	    return 1;
	}
	
	if(strcmp(cmd, "/closecarwindows", true ) == 0)
	{
	    if(GetPlayerVehicleID(playerid) && GetPlayerVehicleID(playerid) != INVALID_VEHICLE_ID)
		{
			SetVehicleParamsCarWindows(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON);
	    }
	    return 1;
	}

	if(strcmp(cmd, "/spritetest", true ) == 0)
	{
    	txtSpriteTest[0] = TextDrawCreate(100.0, 100.0, "ld_grav:timer"); // Text is txdfile:texture
    	TextDrawFont(txtSpriteTest[0], 4); // Font ID 4 is the sprite draw font
    	TextDrawColor(txtSpriteTest[0],0xFFFFFFFF);
    	TextDrawTextSize(txtSpriteTest[0],100.0,100.0); // Text size is the Width:Height
    	TextDrawShowForPlayer(playerid,txtSpriteTest[0]);
    	
    	txtSpriteTest[1] = TextDrawCreate(200.0, 100.0, "ld_grav:bee2"); // Text is txdfile:texture
    	TextDrawFont(txtSpriteTest[1], 4); // Font ID 4 is the sprite draw font
    	TextDrawColor(txtSpriteTest[1],0xFFFFFFFF);
    	TextDrawTextSize(txtSpriteTest[1],100.0,100.0); // Text size is the Width:Height
    	TextDrawShowForPlayer(playerid,txtSpriteTest[1]);
    	
    	txtSpriteTest[2] = TextDrawCreate(100.0, 200.0, "ld_slot:r_69"); // Text is txdfile:texture
    	TextDrawFont(txtSpriteTest[2], 4); // Font ID 4 is the sprite draw font
    	TextDrawColor(txtSpriteTest[2],0xFFFFFFFF);
    	TextDrawTextSize(txtSpriteTest[2],100.0,100.0); // Text size is the Width:Height
    	TextDrawShowForPlayer(playerid,txtSpriteTest[2]);

		txtSpriteTest[3] = TextDrawCreate(200.0, 200.0, "ld_slot:cherry"); // Text is txdfile:texture
    	TextDrawFont(txtSpriteTest[3], 4); // Font ID 4 is the sprite draw font
    	TextDrawColor(txtSpriteTest[3],0xFFFFFFFF);
    	TextDrawTextSize(txtSpriteTest[3],100.0,100.0); // Text size is the Width:Height
    	TextDrawShowForPlayer(playerid,txtSpriteTest[3]);
    	
    	txtSpriteTest[4] = TextDrawCreate(100.0, 300.0, "ld_card:cd9d"); // Text is txdfile:texture
    	TextDrawFont(txtSpriteTest[4], 4); // Font ID 4 is the sprite draw font
    	TextDrawColor(txtSpriteTest[4],0xFFFFFFFF);
    	TextDrawTextSize(txtSpriteTest[4],100.0,100.0); // Text size is the Width:Height
    	TextDrawShowForPlayer(playerid,txtSpriteTest[4]);
    	
    	return 1;
	}
	
	if(strcmp(cmd, "/delspritetest", true ) == 0)
	{
		TextDrawDestroy(txtSpriteTest[0]);
		TextDrawDestroy(txtSpriteTest[1]);
		TextDrawDestroy(txtSpriteTest[2]);
		TextDrawDestroy(txtSpriteTest[3]);
		TextDrawDestroy(txtSpriteTest[4]);
		return 1;
	}

	if(strcmp(cmd, "/removeallbuilding", true ) == 0)
	{
		RemoveBuildingForPlayer(playerid, -1, 0.0, 0.0, 0.0, 6000.0);
		return 1;
	}

	if(strcmp(cmd, "/actoratme", true ) == 0)
	{
	  	new Float:X, Float:Y, Float:Z, Float:fang;
	    GetPlayerPos(playerid, X, Y, Z);
	    GetPlayerFacingAngle(playerid, fang);
		test_actor_id = CreateActor(305, X+1.0, Y+1.0, Z+0.5, fang);
		//SetActorInvulnerable(test_actor_id);
		SetActorVirtualWorld(test_actor_id, GetPlayerVirtualWorld(playerid));
		return 1;
	}

	if(strcmp(cmd, "/actorground", true) == 0) {
	    ApplyActorAnimation(test_actor_id, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0);
		return 1;
	}

	if(strcmp(cmd, "/actorclear", true) == 0) {
	    ClearActorAnimations(test_actor_id);
		return 1;
	}

	if(strcmp(cmd, "/actorface", true) == 0) {
	    new Float:fang;
	    GetPlayerFacingAngle(playerid, fang);
	    SetActorFacingAngle(test_actor_id, fang);
		return 1;
	}

	if(strcmp(cmd, "/actorpos", true) == 0) {
	   	new Float:X, Float:Y, Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
	    SetActorPos(test_actor_id, X+1.0, Y+1.0, Z);
		return 1;
	}

  	return 0;
}

//-------------------------------------------

forward KickPublic(playerid);
public KickPublic(playerid) { Kick(playerid); }

//-------------------------------------------

KickWithMessage(playerid, message[])
{
	SendClientMessage(playerid, 0xFF4444FF, message);
	SetTimerEx("KickPublic", 1000, 0, "d", playerid);
}

//-------------------------------------------

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	new msg[256+1];
	format(msg,sizeof(msg),"(TextDraw) You selected: %d", int:clickedid);
	SendClientMessage(playerid, 0xFFFFFFFF, msg);
}

//-------------------------------------------

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	new msg[256+1];
	format(msg,sizeof(msg),"(PlayerTextDraw) You selected: %d", int:playertextid);
	SendClientMessage(playerid, 0xFFFFFFFF, msg);
}

//-------------------------------------------
// Sends a list of all PVars to the player as
// client messages.

SendPVarListToPlayer(playerid)
{
    new ubound = GetPVarsUpperIndex(playerid);
	new x=0;
	new name[40+1];
	new line[128+1];
	
    SendClientMessage(playerid,0xF000F0F0, "---Player Vars List---");
	while(x != ubound) {
		if(GetPVarNameAtIndex(playerid,x,name,40)) {
			if(Util_GetPVarEntryAsString(playerid,name,line,128)) {
                 SendClientMessage(playerid,0xFFFFFFFF,line);
			}
		}
		x++;
	}
}

//-------------------------------------------
// return PVar entry as 'name'='value' string

stock Util_GetPVarEntryAsString(playerid, name[], ret[], len)
{
	new Float:fValue;
	new iValue;
	new szStrValue[1024+1]; // this might require greater size if you store large strings in PVars
	new type;
    ret[0] = EOS;
    
  	type = GetPVarType(playerid, name);
	if(type != PLAYER_VARTYPE_NONE) {
		switch(type)
		{
			case PLAYER_VARTYPE_STRING:
			{
				GetPVarString(playerid,name,szStrValue,1024);
				format(ret,len,"%s=%s",name,szStrValue);
			}
			case PLAYER_VARTYPE_INT:
			{
				iValue = GetPVarInt(playerid,name);
				format(ret,len,"%s=%d",name,iValue);
			}
			case PLAYER_VARTYPE_FLOAT:
			{
			    fValue = GetPVarFloat(playerid,name);
				format(ret,len,"%s=%f",name,fValue);
			}
		}
		return 1;
	}
	return 0;
}

//-------------------------------------------
// Fills the provided string with all the player's PVars
// seperated by the specified 'delimiter'

stock Util_CreatePVarList(playerid, retstr[], len, delimiter[])
{
	if(!IsPlayerConnected(playerid)) return 0;
	
	new x=0;
	new remaining_string=len;
	new line[2048+1];
	new name[40+1];
	retstr[0] = EOS;

	new ubound = GetPVarsUpperIndex(playerid);
	
	while(x != ubound) {
		if(GetPVarNameAtIndex(playerid,x,name,40)) {
			if(Util_GetPVarEntryAsString(playerid,name,line,2048)) {
				// if there is enough space, concat this line to the return string
				if(remaining_string > (strlen(line) + strlen(delimiter))) {
			    	strcat(retstr,line);
			    	strcat(retstr,delimiter);
					remaining_string -= (strlen(line) + strlen(delimiter));
				}
			}
		}
		x++;
	}
	
	return 1;
}

//-------------------------------------------
// Test reapplying vehicle mods on respawn

public OnVehicleSpawn(vehicleid)
{
	if(vehicleid == savanna) {
	    AddVehicleComponent(savanna,1189); //Front Bumper
		AddVehicleComponent(savanna,1187); //Rear Bumper
		AddVehicleComponent(savanna,1129); //Exhaust
		AddVehicleComponent(savanna,1102); //Left Side Skirt
		AddVehicleComponent(savanna,1133); //Right Side Skirt
		AddVehicleComponent(savanna,1078); //Wheels
		AddVehicleComponent(savanna,1010); //Nitro 10x
		AddVehicleComponent(savanna,1087); //Hydraulics
	}
	else if(vehicleid == blade) {
	    AddVehicleComponent(blade,1182); //Front Bumper
		AddVehicleComponent(blade,1184); //Rear Bumper
		AddVehicleComponent(blade,1104); //Exhaust
		AddVehicleComponent(blade,1108); //Left Side Skirt
		AddVehicleComponent(blade,1107); //Right Side Skirt
		AddVehicleComponent(blade,1078); //Wheels
		AddVehicleComponent(blade,1010); //Nitro 10x
		AddVehicleComponent(blade,1087); //Hydraulics
	}
}

//-------------------------------------------
// Example of handling dialog responses.

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(!IsPlayerAdmin(playerid)) return 0; // this is an admin only script
    
	if(dialogid == 0) { // Our example msgbox
		if(response) {
		    SendClientMessage(playerid,0xFFFFFFFF,"You selected OK");
		} else {
		    SendClientMessage(playerid,0xFFFFFFFF,"You selected Cancel");
		}
		return 1; // we processed this. no need for other filterscripts to process it.
	}
	
	if(dialogid == 1) { // Our example inputbox
		if(response) {
			new message[256+1];
			format(message, 256, "You replied: %s", inputtext);
		    SendClientMessage(playerid, 0xFFFFFFFF, message);
		} else {
		    SendClientMessage(playerid, 0xFFFFFFFF, "You selected Cancel");
		}
		return 1; // we processed it.
	}
	
	if(dialogid == 2) { // Our example listbox
		if(response) {
			new message[256+1];
			format(message, 256, "You selected item %d:", listitem);
		    SendClientMessage(playerid, 0xFFFFFFFF, message);
		    SendClientMessage(playerid, 0xFFFFFFFF, inputtext);
		} else {
		    SendClientMessage(playerid, 0xFFFFFFFF, "You selected Cancel");
		}
		return 1; // we processed it.
	}
	
	return 0; // we didn't handle anything.
}

//-------------------------------------------
// Example of handling scoreboard click.

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(!IsPlayerAdmin(playerid)) return 0; // this is an admin only script
	
    new message[256+1];
	format(message, 256, "You clicked on player %d", clickedplayerid);
	SendClientMessage(playerid, 0xFFFFFFFF, message);
	return 1;
}

//-------------------------------------------

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
 	new message[256+1];
	format(message, 256, "You place marker at point: %f %f %f", fX, fY, fZ);
	SendClientMessage(playerid, 0xFFFFFFFF, message);
	SetPlayerPos(playerid, fX, fY, fZ);
}

//-------------------------------------------
/*
public OnPlayerEditAttachedObject( playerid, response, index, modelid, boneid,
								   Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,
								   Float:fRotX, Float:fRotY, Float:fRotZ,
  								   Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
	SendClientMessage(playerid, 0xFFFFFFFF, "You finished editing an attached object");
	SetPlayerAttachedObject(playerid,index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);
	return 1;
}*/

//-------------------------------------------

public OnPlayerEditObject( playerid, playerobject, objectid, response,
Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ )
{
	if(!playerobject) {
	    if(!IsValidObject(objectid)) return;
		MoveObject(objectid, fX, fY, fZ, 10.0, fRotX, fRotY, fRotZ);
	} else {
	    if(!IsValidPlayerObject(playerid, objectid)) return;
	    MovePlayerObject(playerid, objectid, fX, fY, fZ, 10.0, fRotX, fRotY, fRotZ);
	}
	
	if(response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL) {
	    // put them back in selection mode after they click save
	    SelectObject(playerid);
	}
}

//-------------------------------------------

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
    new message[256+1];
    
    if(type == SELECT_OBJECT_GLOBAL_OBJECT) {
        if(!IsValidObject(objectid)) return 0;
        format(message,sizeof(message),"(Object) You selected: %d model: %d Pos: %.4f,%.4f,%.4f", objectid, modelid, fX, fY, fZ);
        SendClientMessage(playerid, 0xFFFFFFFF, message);
        EditObject(playerid, objectid);
        return 1;
	}
	
	if(type == SELECT_OBJECT_PLAYER_OBJECT) {
        if(!IsValidPlayerObject(playerid, objectid)) return 0;
        format(message,sizeof(message),"(Player Object) You selected: %d model: %d Pos: %.4f,%.4f,%.4f", objectid, modelid, fX, fY, fZ);
        SendClientMessage(playerid, 0xFFFFFFFF, message);
        EditPlayerObject(playerid, objectid);
        return 1;
	}
	
	return 0;
}

//-------------------------------------------
/*
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    new message[256+1];
    new weaponname[64+1];
	new File:file = fopen("playershots.txt",io_append);
	
	GetWeaponName(weaponid, weaponname, 64);

	if(hittype == BULLET_HIT_TYPE_PLAYER) {
		format(message,256,"Shooter(%d) hit Player(%d) PlayerAnim: %d Using: %s [%.2f, %.2f, %.2f]\r\n", playerid, hitid,
			   GetPlayerAnimationIndex(hitid), weaponname, fX, fY, fZ);
	}
	else if(hittype == BULLET_HIT_TYPE_VEHICLE) {
	    format(message,256,"Shooter(%d) hit Vehicle(%d) Using: %s [%.2f, %.2f, %.2f]\r\n",playerid, hitid, weaponname, fX, fY, fZ);
	}
	else if(hittype == BULLET_HIT_TYPE_NONE) {
	    format(message,256,"Shooter(%d) hit World Using: %s [%.2f, %.2f, %.2f]\r\n",playerid,weaponname,fX,fY,fZ);
	}
	else {
	    format(message,256,"Shooter(%d) hit Object(%d) Using: %s [%.2f, %.2f, %.2f]\r\n",playerid, hitid, weaponname, fX, fY, fZ);
	}
	
	fwrite(file, message);
	fclose(file);
	
	//new LastVectors[128+1];
	//new Float:OriginX, Float:OriginY, Float:OriginZ;
	//new Float:HitX, Float:HitY, Float:HitZ;
	//GetPlayerLastShotVectors(playerid, OriginX, OriginY, OriginZ, HitX, HitY, HitZ);
	//format(LastVectors, 128, "Last Vectors: [%.2f, %.2f, %.2f] [%.2f, %.2f, %.2f]", OriginX, OriginY, OriginZ, HitX, HitY, HitZ);
	//SendClientMessage(playerid, 0xFFFFFFFF, LastVectors);
	
	SendClientMessage(playerid, 0xFFFFFFFF, message);
 	return 1;
}*/

//-------------------------------------------
/*
new LastShotTime = 0;
new LastShotWeapon = 0;

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	new message[128+1];
	
	if(!LastShotTime) {
	    LastShotTime = GetTickCount();
	    return 1;
	}
	
	if(weaponid == LastShotWeapon) {
		 format(message, 128, "WeaponId: %d LastShotDelta: %d", weaponid, GetTickCount() - LastShotTime);
		 SendClientMessage(playerid, 0xFFFFFFFF, message);
	     printf("%s", message);
	}
	
	LastShotWeapon = weaponid;
	LastShotTime = GetTickCount();
	
 	return 1;
}*/

//-------------------------------------------
// Example of TakeDamage
/*
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	new File:file = fopen("playershots.txt",io_append);
 	new message[256+1];
 	new weapname[64+1];
	
	if(issuerid != INVALID_PLAYER_ID) {
	    GetWeaponName(weaponid, weapname, 64);
		format(message, 256, "PlayerTakeDamage(%d) from Player(%d) (%f) weapon: (%s) bodypart: %d\r\n", playerid, issuerid, amount, weapname, bodypart);
		SendClientMessageToAll(0xFFFFFFFF, message);
	}
	else {
		format(message, 256, "PlayerTakeDamage(%d) (%f) from: %d\r\n", playerid, amount, weaponid);
		SendClientMessageToAll(0xFFFFFFFF, message);
	}
	
	fwrite(file, message);
	fclose(file);
}*/

//-------------------------------------------
// Example of GiveDamage
/*
public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	new File:file = fopen("playershots.txt",io_append);
 	new message[256+1];
 	new weapname[64+1];
 	
    GetWeaponName(weaponid, weapname, 64);
	format(message, 256, "PlayerGiveDamage(%d) to Player(%d) (%f) weapon: (%s) bodypart: %d\r\n", playerid, damagedid, amount, weapname, bodypart);
	
	fwrite(file, message);
	fclose(file);
	SendClientMessageToAll(0xFFFFFFFF, message);
}*/


//-------------------------------------------
/*
public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, weaponid, bodypart)
{
    new message[256+1];
    new weapname[64+1];
    
    GetWeaponName(weaponid, weapname, 64);
    format(message, 256, "PlayerGiveDamageActor(%d) to Actor(%d) (%f) weapon: (%s) bodypart: %d\r\n", playerid, damaged_actorid, amount, weapname, bodypart);
    SendClientMessageToAll(0xFFFFFFFF, message);
    
	if(IsValidActor(damaged_actorid)) {
	    new Float:fActorHealth;
	    GetActorHealth(damaged_actorid, fActorHealth);
	    fActorHealth -= amount;
		if(fActorHealth < 0.0) fActorHealth = 0.0;
		SetActorHealth(damaged_actorid, fActorHealth);
	}
}
*/
//-------------------------------------------

/*
public OnPlayerDeath(playerid, killerid, reason)
{
    SendDeathMessage(killerid, playerid, reason);
    return 1;
}*/

//-------------------------------------------
/*
public OnEnterExitModShop(playerid, enterexit, interiorid)
{
    new message[256+1];
    if(enterexit) {
		format(message, 256, "You entered modshop at interior %d", interiorid);
		SendClientMessage(playerid, 0xFFFFFFFF, message);
	} else {
	   	format(message, 256, "You exited the modshop");
		SendClientMessage(playerid, 0xFFFFFFFF, message);
	}
	return 1;
}
*/
//-------------------------------------------

/*
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new panel, doors, lights, tires;
	new update_msg[128+1];
	
	if(!IsPlayerAdmin(playerid)) return 0;
	
	GetVehicleDamageStatus(vehicleid,panel,doors,lights,tires);
	format(update_msg,128,"VehicleDamage[ID:%d PN:0x%x DR:0x%x LT:0x%x TR:0x%x]",vehicleid,panel,doors,lights,tires);
	SendClientMessage(playerid,0xFFFFFFFF,update_msg);
	
	return 1;
}*/

//-------------------------------------------

/*
public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z)
{
    new update_msg[128+1];
    new Float:X, Float:Y, Float:Z;
    
    //if(!IsPlayerAdmin(playerid)) return 0;
    
    GetVehiclePos(vehicleid, X, Y, Z);

    format(update_msg,128,"NoDriverVehicleUpdate(playerid=%d vehicle=%d passenger=%d cur_pos: %.2f %.2f %.2f new_pos: %.2f %.2f %.2f)",
		playerid, vehicleid, passenger_seat, X, Y, Z, new_x, new_y, new_z);
			
	SendClientMessageToAll(0xFFFFFFFF,update_msg);
	
	return 1;
}*/

//-------------------------------------------

