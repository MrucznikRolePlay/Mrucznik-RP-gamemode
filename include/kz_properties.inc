/*##############################################################################


					########################################
					#                                      #
					#    PROPERTIES INCLUDE FILE BY YOM    #
					#                                      #
					########################################


- Informations about this file:
===============================

	-	This include file allow you to handle properties easily,
		based on a property id (not a hashed name) for faster processing.

	-	I created it originally for my admin script and my gamemodes, where i
		needed to communicate a lot of values between scripts.

	-	Just be carefull to not use the same property id for differents properties.
	
	-	There is global properties, and per player properties.
	
	-	Functions are available in the Function List of Pawno.



- Copyright:
============

	-	Yom Productions © ®.
	-	You can use this script and distribute it but,
	-	You WILL NOT sell it or tell it is your own work.



- Versions changes:
===================

	-	1.0 :	Initial (and probably final) release.
	

##############################################################################*/


/*########################### Natives definitions ############################*/

/*
native SetProp_Int(propid, value, virtual_machine=0);
native SetProp_Bool(propid, bool:value, virtual_machine=0);
native SetProp_Float(propid, Float:value, virtual_machine=0);
native SetProp_String(propid, value[], virtual_machine=0);

native GetProp_Int(propid, virtual_machine=0);
native GetProp_Bool(propid, virtual_machine=0);
native GetProp_Float(propid, virtual_machine=0);
native GetProp_String(propid, virtual_machine=0);

native ExistProp(propid, virtual_machine=0);
native DelProp(propid, virtual_machine=0);

native SetPlayerProp_Int(playerid, propid, value, virtual_machine=0);
native SetPlayerProp_Bool(playerid, propid, bool:value, virtual_machine=0);
native SetPlayerProp_Float(playerid, propid, Float:value, virtual_machine=0);
native SetPlayerProp_String(playerid, propid, value[], virtual_machine=0);

native GetPlayerProp_Int(playerid, propid, virtual_machine=0);
native GetPlayerProp_Bool(playerid, propid, virtual_machine=0);
native GetPlayerProp_Float(playerid, propid, virtual_machine=0);
native GetPlayerProp_String(playerid, propid, virtual_machine=0);

native ExistPlayerProp(playerid, propid, virtual_machine=0);
native DelPlayerProp(playerid, propid, virtual_machine=0);
*/


/*################################ SetProp ###################################*/

stock SetProp_Int(propid, value, virtual_machine=0)
{
	new intstring[15];
	format(intstring,sizeof(intstring),"%d",value);
	return SetProp_String(propid,intstring,virtual_machine);
}

stock SetProp_Bool(propid, bool:value, virtual_machine=0)
{
	return SetProp_Int(propid,value,virtual_machine);
}

stock SetProp_Float(propid, Float:value, virtual_machine=0)
{
	new floatstring[15];
	format(floatstring,sizeof(floatstring),"%f",value);
	return SetProp_String(propid,floatstring,virtual_machine);
}

stock SetProp_String(propid, value[], virtual_machine=0)
{
	return setproperty(virtual_machine,"",propid,value);
}


/*################################ GetProp ###################################*/

stock GetProp_Int(propid, virtual_machine=0)
{
	return strval(GetProp_String(propid,virtual_machine));
}

stock GetProp_Bool(propid, virtual_machine=0)
{
	return bool:strval(GetProp_String(propid,virtual_machine));
}


stock Float:GetProp_Float(propid, virtual_machine=0)
{
	return floatstr(GetProp_String(propid,virtual_machine));
}

stock GetProp_String(propid, virtual_machine=0)
{
	new propstring[255];
	getproperty(virtual_machine,"",propid,propstring);
	strunpack(propstring,propstring);
	return propstring;
}


/*################################ ExistProp #################################*/

stock ExistProp(propid, virtual_machine=0)
{
	return existproperty(virtual_machine,"",propid) ? true : false;
}


/*################################ DelProp ###################################*/

stock DelProp(propid, virtual_machine=0)
{
	return deleteproperty(virtual_machine,"",propid);
}




/*############################# SetPlayerProp ################################*/

stock SetPlayerProp_Int(playerid, propid, value, virtual_machine=0)
{
	return SetProp_Int(PlayerPropID(playerid,propid),value,virtual_machine);
}

stock SetPlayerProp_Bool(playerid, propid, bool:value, virtual_machine=0)
{
	return SetProp_Bool(PlayerPropID(playerid,propid),value,virtual_machine);
}

stock SetPlayerProp_Float(playerid, propid, Float:value, virtual_machine=0)
{
	return SetProp_Float(PlayerPropID(playerid,propid),value,virtual_machine);
}

stock SetPlayerProp_String(playerid, propid, value[], virtual_machine=0)
{
	return SetProp_String(PlayerPropID(playerid,propid),value,virtual_machine);
}


/*############################# GetPlayerProp ################################*/

stock GetPlayerProp_Int(playerid, propid, virtual_machine=0)
{
	return GetProp_Int(PlayerPropID(playerid,propid),virtual_machine);
}

stock GetPlayerProp_Bool(playerid, propid, virtual_machine=0)
{
	return GetProp_Bool(PlayerPropID(playerid,propid),virtual_machine);
}

stock Float:GetPlayerProp_Float(playerid, propid, virtual_machine=0)
{
	return GetProp_Float(PlayerPropID(playerid,propid),virtual_machine);
}

stock GetPlayerProp_String(playerid, propid, virtual_machine=0)
{
//	return GetProp_String(PlayerPropID(playerid,propid), virtual_machine);
	new propstring[255];
	getproperty(virtual_machine,"",PlayerPropID(playerid,propid),propstring);
	strunpack(propstring,propstring);
	return propstring;
}


/*############################ ExistPlayerProp ###############################*/

stock ExistPlayerProp(playerid, propid, virtual_machine=0)
{
	return ExistProp(PlayerPropID(playerid,propid),virtual_machine) ? true : false;
}


/*############################# DelPlayerProp ################################*/

stock DelPlayerProp(playerid, propid, virtual_machine=0)
{
	return DelProp(PlayerPropID(playerid,propid),virtual_machine);
}


/*########################## PlayerPropID (private) ##########################*/

stock PlayerPropID(playerid, propid)
{
	new propname[7];
	format(propname,sizeof(propname),"1%02d%03d",playerid,propid);
	return strval(propname);
}
