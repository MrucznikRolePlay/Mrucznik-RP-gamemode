#include <a_samp>
#define FILTERSCRIPT
#define COLOR 0x33CCFFAA
#define hp 30
new incar[MAX_PLAYERS];
new WszedlDoPojazdu[MAX_PLAYERS];
new scan;
new Float:oldhealth[MAX_PLAYERS];
new Float:newhealth[MAX_PLAYERS];
new pasy[100];//pasy
new kask[100];

forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);

public OnFilterScriptInit()
{
	print("Wypadek by Mrucznik");
	return 1;
}

public OnPlayerConnect(playerid)
{
    incar[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(incar[playerid] == 1) KillTimer(scan);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(incar[playerid] == 1) KillTimer(scan);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	GetVehicleHealth(vehicleid,newhealth[playerid]);
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
	    SetTimerEx("scanhp",1000,1,"i",playerid);
	    GetVehicleHealth(vehicleid,oldhealth[playerid]);
	    incar[playerid] = 1;
		return 1;
	}
	if((oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT) || (oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT))
	{
		KillTimer(scan);
		new nick[MAX_PLAYER_NAME];
	   	new string[256];
		GetPlayerName(playerid, nick, sizeof(nick));
		if(pasy[playerid] == 1)
		{
		   	format(string, sizeof(string), "* %s odpina pasy.", nick);
			ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
			pasy[playerid] = 0;
		}
		if(kask[playerid] == 1)
		{
		   	format(string, sizeof(string), "* %s œci¹ga kask z g³owy.", nick);
			ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
			RemovePlayerAttachedObject(playerid, 3);
			kask[playerid] = 0;
		}
		incar[playerid] = 0;
		return 1;
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    SetTimerEx("EnterCar",15000,0,"d",playerid);
	WszedlDoPojazdu[playerid] = 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == 2 || GetPlayerState(playerid) == 3)
	{
		if(!strcmp(cmdtext, "/zp", true) || !strcmp(cmdtext, "/zapnijpasy", true))
		{
		    if(!IsABike(GetPlayerVehicleID(playerid)))
	    	{
		    	new nick[MAX_PLAYER_NAME];
		   		new string[256];
				GetPlayerName(playerid, nick, sizeof(nick));
	    		format(string, sizeof(string), "* %s zapina pasy", nick);
				ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
				pasy[playerid] = 1;
            }
			else
			{
				SendClientMessage(playerid,COLOR,"Nie mo¿esz zapi¹æ pasów!");
			}
		}
		if(!strcmp(cmdtext, "/op", true) || !strcmp(cmdtext, "/odepnijpasy", true))
		{
		    if(!IsABike(GetPlayerVehicleID(playerid)))
	    	{
		    	new nick[MAX_PLAYER_NAME];
		   		new string[256];
				GetPlayerName(playerid, nick, sizeof(nick));
	    		format(string, sizeof(string), "* %s odpina pasy", nick);
				ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
				pasy[playerid] = 0;
            }
			else
			{
				SendClientMessage(playerid,COLOR,"Nie mo¿esz odpi¹æ pasów!");
			}
		}
		if(!strcmp(cmdtext, "/kask", true))
		{
			if(IsABike(GetPlayerVehicleID(playerid)))
	    	{
		    	new nick[MAX_PLAYER_NAME];
		   		new string[256];
				GetPlayerName(playerid, nick, sizeof(nick));
	    		if(kask[playerid] == 1)
				{
		   			format(string, sizeof(string), "* %s œci¹ga kask z g³owy.", nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					RemovePlayerAttachedObject(playerid, 3);
					kask[playerid] = 0;
				}
				else if(kask[playerid] != 1)
				{
			    	format(string, sizeof(string), "* %s zak³ada kask na g³owê.", nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SetPlayerAttachedObject(playerid,3 , 18645, 2, 0.07, 0.017, 0, 88, 75, 0);
					kask[playerid] = 1;
				}
			}
			else
			{
				SendClientMessage(playerid,COLOR,"Nie mo¿esz za³o¿yæ kasku!");
			}
		}
	}
	return 0;
}

forward scanhp(playerid);
public scanhp(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return 1;
    new vehicleid = GetPlayerVehicleID(playerid);
	GetVehicleHealth(vehicleid,newhealth[playerid]);
	if(oldhealth[playerid] > (newhealth[playerid] + hp))
	{
	    if(IsPlayerInRangeOfPoint(playerid, 7.0, 2064.0703,-1831.3167,13.3853) || IsPlayerInRangeOfPoint(playerid, 7.0, 1024.8514,-1022.2302,31.9395) || IsPlayerInRangeOfPoint(playerid, 7.0, 486.9398,-1742.4130,10.9594) || IsPlayerInRangeOfPoint(playerid, 7.0, -1904.2325,285.3743,40.8843)  || IsPlayerInRangeOfPoint(playerid, 7.0, 720.0876,-458.3574,16.3359))
	    {
	        SendClientMessage(playerid,COLOR,"Pojazd naprawiony!");
	    }
	    else
		{
		    if(pasy[playerid] == 1)
		    {
		        if(WszedlDoPojazdu[playerid] == 0)
		        {
			        if(oldhealth[playerid] > (newhealth[playerid] + 120))
					{
					    new nick[MAX_PLAYER_NAME];
				    	new string[256];
				    	new Float:zyciewypadku;
						GetPlayerName(playerid, nick, sizeof(nick));
						GetPlayerHealth(playerid, zyciewypadku);
						SetPlayerHealth(playerid, zyciewypadku-7);
					    format(string, sizeof(string), "* %s uderzy³ g³ow¹ w kierownice mimo zapiêtych pasów", nick);
						ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
						SendClientMessage(playerid,COLOR,"Ale przywali³eœ, szczêœcie ¿e mia³eœ zapiête pasy!");
					}
			        else if(oldhealth[playerid] > (newhealth[playerid] + hp))
					{
				 		new nick[MAX_PLAYER_NAME];
				    	new string[256];
						GetPlayerName(playerid, nick, sizeof(nick));
					    format(string, sizeof(string), "* Pasy zadzia³a³y i %s nie dozna³ powa¿nych obra¿eñ (( %s ))", nick, nick);
						ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					    SendClientMessage(playerid,COLOR,"Kolejna st³uczka, mia³eœ zapiête pasy i nic ci siê nie sta³o!");
					}
				}
			}
			else if(kask[playerid] == 1)
		    {
		        if(WszedlDoPojazdu[playerid] == 0)
		        {
			        if(oldhealth[playerid] > (newhealth[playerid] + 120))
					{
					    new nick[MAX_PLAYER_NAME];
				    	new string[256];
				    	new Float:zyciewypadku;
						GetPlayerName(playerid, nick, sizeof(nick));
						GetPlayerHealth(playerid, zyciewypadku);
						SetPlayerHealth(playerid, zyciewypadku-7);
					    format(string, sizeof(string), "* %s uderzy³ kaskiem w kierownicê.", nick);
						ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
						SendClientMessage(playerid,COLOR,"Ale przywali³eœ, szczêœcie ¿e mia³eœ kask na g³owie!");
					}
			        else if(oldhealth[playerid] > (newhealth[playerid] + hp))
					{
				 		new nick[MAX_PLAYER_NAME];
				    	new string[256];
						GetPlayerName(playerid, nick, sizeof(nick));
					    format(string, sizeof(string), "* Kask uratowa³ %s i nie dozna³ powa¿nych obra¿eñ. (( %s ))", nick, nick);
						ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					    SendClientMessage(playerid,COLOR,"Kolejna st³uczka, mia³eœ kask na g³owie i nic ci siê nie sta³o!");
					}
				}
			}
			else
			{
			    if(WszedlDoPojazdu[playerid] == 0)
			    {
		  			if(oldhealth[playerid] > (newhealth[playerid] + 120))
					{
					    new nick[MAX_PLAYER_NAME];
				    	new string[256];
				    	new Float:zyciewypadku;
						GetPlayerName(playerid, nick, sizeof(nick));
						GetPlayerHealth(playerid, zyciewypadku);
						TogglePlayerControllable(playerid, 0);
						SetPlayerHealth(playerid, zyciewypadku-20);
					    format(string, sizeof(string), "* %s z powodu wypadku wylecia³ z pojazdu.", nick);
						ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					    SendClientMessage(playerid,COLOR,"Ale przywali³eœ, aby unikn¹æ wypadania z pojazdu wpisz /zp lub /kask!");
					    new Float:px, Float:py, Float:pz, Float:pa;
						GetPlayerFacingAngle(playerid,pa);
						if(pa >= 0.0 && pa <= 22.5) //n1
						{
							GetPlayerPos(playerid, px, py, pz);
							SetPlayerPos(playerid, px, py+2, pz+2);
						}
						if(pa >= 332.5 && pa < 0.0) //n2
						{
							GetPlayerPos(playerid, px, py, pz);
							SetPlayerPos(playerid, px, py+2, pz+2);
						}
						if(pa >= 22.5 && pa <= 67.5) //nw
						{
							GetPlayerPos(playerid, px, py, pz);
							SetPlayerPos(playerid, px-1.0, py+1.0, pz+3);
						}
						if(pa >= 67.5 && pa <= 112.5) //w
						{
							GetPlayerPos(playerid, px, py, pz);
							SetPlayerPos(playerid, px-2, py, pz+2);
						}
						if(pa >= 112.5 && pa <= 157.5) //sw
						{
							GetPlayerPos(playerid, px, py, pz);
							SetPlayerPos(playerid, px-1.0, py-1.0, pz+3);
						}
						if(pa >= 157.5 && pa <= 202.5) //s
						{
							GetPlayerPos(playerid, px, py, pz);
							SetPlayerPos(playerid, px, py-2, pz+3);
						}
						if(pa >= 202.5 && pa <= 247.5)//se
						{
							GetPlayerPos(playerid, px, py, pz);
							SetPlayerPos(playerid, px+1.0, py-1.0, pz+3);
						}
						if(pa >= 247.5 && pa <= 292.5)//e
						{
							GetPlayerPos(playerid, px, py, pz);
							SetPlayerPos(playerid, px+2, py, pz+3);
						}
						if(pa >= 292.5 && pa <= 332.5)//e
						{
							GetPlayerPos(playerid, px, py, pz);
							SetPlayerPos(playerid, px+1.0, py+1.0, pz+3);
						}
						TogglePlayerControllable(playerid, 1);
					}
				    else if(oldhealth[playerid] > (newhealth[playerid] + hp))
					{
					    new nick[MAX_PLAYER_NAME];
				    	new string[256];
				    	new Float:zyciewypadku;
						GetPlayerName(playerid, nick, sizeof(nick));
						GetPlayerHealth(playerid, zyciewypadku);
						SetPlayerHealth(playerid, zyciewypadku-7);
					    format(string, sizeof(string), "* %s mia³ uderzy³ g³ow¹ w kierownicê. (( %s ))", nick, nick);
						ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					    SendClientMessage(playerid,COLOR,"Kolejna st³uczka, aby unikn¹æ obra¿eñ wpisz /zp lub /kask!");
					}
				}
			}
		}
	}
	GetVehicleHealth(vehicleid,oldhealth[playerid]);
	return 1;
}

forward EnterCar(playerid);
public EnterCar(playerid)
{
	WszedlDoPojazdu[playerid] = 0;
}

public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					SendClientMessage(i, col1, string);
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					SendClientMessage(i, col2, string);
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					SendClientMessage(i, col3, string);
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					SendClientMessage(i, col4, string);
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessage(i, col5, string);
				}
			}
		}
	}//not connected
	return 1;
}
stock IsABike(vehicleid) //Made by me :D
{
	new result;
	new model = GetVehicleModel(vehicleid);
    switch(model)
    {
        case 509, 481, 510, 462, 448, 581, 522, 461, 521, 523, 463, 586, 468, 471: result = model;
        default: result = 0;
    }
	return result;
}
