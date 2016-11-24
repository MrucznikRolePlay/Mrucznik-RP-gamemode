//------------------------------------------------------------------------------
// xStreamer Client - Designed for SMD v0.1

#include <float>
#include <file>

/*
native SetPlayerPosEx(playerid,Float:x,Float:y,Float:z);
native CreateStreamedObject(modelid2,Float:xf,Float:yf,Float:z,Float:rx,Float:ry,Float:rz,Float:viewdistance = 200.0);
native DestroyStreamedObject(objectid);
native SetStreamedTimerSpeed(speed);
// native LoadSMDFile(filename[]);
native CreateTeleport(name[],Float:x,Float:y,Float:z,Float:rot,interior,msg[]);
native DestroyTeleport(teleportid);
*/

/* SMD format xClient uses:

[Object*]


*/

//------------------------------------------------------------------------------

#define SMD_UNKNOWN 0
#define SMD_OBJECT 1
#define SMD_TELEPORT 2

#if !defined STR
#define STR 128
#endif

#if !defined NO_CORE_CHECK
new stock
    bool:xstreamer_client_tested = false,
    bool:xstreamer_client_outdone = false;
#endif

//------------------------------------------------------------------------------

#if !defined MAX_MAP_OBJECTS
#define MAX_MAP_OBJECTS 3000
#endif

#if !defined MAX_MAP_TELEPORTS
#define MAX_MAP_TELEPORTS 5
#endif

#if !defined MAX_MAPS
#define MAX_MAPS 20
#endif

enum xclient_maps_smd
{
	x_objs[MAX_MAP_OBJECTS],
	x_tele[MAX_MAP_TELEPORTS],
	bool:x_used
}

new stock xclient_maps[MAX_MAPS][xclient_maps_smd];

/*
    For errors, check the server_log.txt
*/

//------------------------------------------------------------------------------
// its just useful, ok :)

#if !defined sscanf
stock sscanf(string[], format[], {Float,_}:...)//sscanf by Y_Less
{
	print("s1");
    new
        formatPos,
        stringPos,
        paramPos = 2,
        paramCount = numargs();
	print("s2");
    while (paramPos < paramCount && string[stringPos])
    {
		print("s3");
        switch (format[formatPos])
        {
            case '\0': break;
            case 'i', 'd': setarg(paramPos, 0, strval(string[stringPos]));
            case 'c': setarg(paramPos, 0, string[stringPos]);
            case 'f': setarg(paramPos, 0, _:floatstr(string[stringPos]));
            case 's':
            {
                new
                    end = format[formatPos + 1] == '\0' ? '\0' : ' ',
                    i;
                while (string[stringPos] != end) setarg(paramPos, i++, string[stringPos++]);
                setarg(paramPos, i, '\0');
            }
            default: goto skip;
        }
		print("s4");
        while (string[stringPos] && string[stringPos] != ' ') stringPos++;
        while (string[stringPos] == ' ') stringPos++;
        paramPos++;
        skip:
        formatPos++;
		print("s5");
    }
	print("s6");
    return format[formatPos] ? 0 : 1;
}
#endif

bool:isblank(string[])
{
    new i = 0;
    while(string[i] != 0)
        if(string[i] != '\r' || string[i] != '\n' || string[i] != '\t' || string[i] != ' ') return false;
    return true;
}

/*------------------------------------------------------------------------------
    Sets the players position via the streamer, so streamed things are updated instantly
    Returns -1 if there is an error, otherwise it returns what SetPlayerPos would return
*/

stock SetPlayerPosEx(playerid,Float:x,Float:y,Float:z)
{
    #if !defined NO_CORE_CHECK
    if(!xstreamer_client_tested)
        if(!CallRemoteFunction("Core_Online",""))
        {
            if(!xstreamer_client_outdone)
            {
                printf("xStreamer error: Core isn't online");
                xstreamer_client_outdone = true;
            }
            return -1;
        } else xstreamer_client_tested = true;
    #endif
    return CallRemoteFunction("Core_SetPlayerPos","ifff",playerid,x,y,z);
}

/*------------------------------------------------------------------------------
    Creates an object
    Returns -1 if there is an error
    Returns the objectid if its successful
*/

stock CreateStreamedObject(modelid2,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz,Float:viewdistance = 200.0)
{
    #if !defined NO_CORE_CHECK
    if(!xstreamer_client_tested)
        if(!CallRemoteFunction("Core_Online",""))
        {
            if(!xstreamer_client_outdone)
            {
                printf("xStreamer error: Core isn't online");
                xstreamer_client_outdone = true;
            }
            return -1;
        } else xstreamer_client_tested = true;
    #endif
    return CallRemoteFunction("Core_CreateObject","ifffffff",modelid2,x,y,z,rx,ry,rz,viewdistance);
}

/*------------------------------------------------------------------------------
    Destroys an object
    Returns -1 if there is an error
    Returns something else if its successful
*/

stock DestroyStreamedObject(objectid)
{
    #if !defined NO_CORE_CHECK
    if(!xstreamer_client_tested)
        if(!CallRemoteFunction("Core_Online",""))
        {
            if(!xstreamer_client_outdone)
            {
                printf("xStreamer error: Core isn't online");
                xstreamer_client_outdone = true;
            }
            return -1;
        } else xstreamer_client_tested = true;
    #endif
    return CallRemoteFunction("Core_DestroyObject","i",objectid);
}

/*------------------------------------------------------------------------------
    Sets the reload speed
    Returns -1 if there is an error
    Returns 1 if it's successful
*/

stock SetStreamedTimerSpeed(speed)
{
    #if !defined NO_CORE_CHECK
    if(!xstreamer_client_tested)
        if(!CallRemoteFunction("Core_Online",""))
        {
            if(!xstreamer_client_outdone)
            {
                printf("xStreamer error: Core isn't online");
                xstreamer_client_outdone = true;
            }
            return -1;
        } else xstreamer_client_tested = true;
    #endif
    return CallRemoteFunction("Core_SetTimerSpeed","i",speed);
}

/*------------------------------------------------------------------------------
    Creates objects (and teleport commands) from an SMD file
    Returns -1 if there is an error
    Returns 1 if its fully successful
    
    if retmap isnt equal to -1 then a map was successfully created, whether there was an error or not.
*/

stock LoadSMDFile(filename[],&retmapid,bool:ignoreerrors = false)
{
    #if !defined NO_CORE_CHECK
    if(!xstreamer_client_tested)
        if(!CallRemoteFunction("Core_Online",""))
        {
            if(!xstreamer_client_outdone)
            {
                printf("xStreamer error: Core isn't online");
                xstreamer_client_outdone = true;
            }
            return -1;
        } else xstreamer_client_tested = true;
    #endif

    return -1; // nothing exists here yet
}

/*------------------------------------------------------------------------------
    Creates a teleport command
    Returns -1 if there is an error, otherwise it returns the teleport id
*/

stock CreateTeleport(name[],Float:x,Float:y,Float:z,Float:rot,interior,msg[])
{
    #if !defined NO_CORE_CHECK
    if(!xstreamer_client_tested)
        if(!CallRemoteFunction("Core_Online",""))
        {
            if(!xstreamer_client_outdone)
            {
                printf("xStreamer error: Core isn't online");
                xstreamer_client_outdone = true;
            }
            return -1;
        } else xstreamer_client_tested = true;
    #endif
    return CallRemoteFunction("Core_CreateTeleport","sffffis",name,x,y,z,rot,interior,msg);
}

/*------------------------------------------------------------------------------
    Destroys a teleport command
    Returns -1 if there is an error, otherwise it returns 1
*/

stock DestroyTeleport(teleportid)
{
    #if !defined NO_CORE_CHECK
    if(!xstreamer_client_tested)
        if(!CallRemoteFunction("Core_Online",""))
        {
            if(!xstreamer_client_outdone)
            {
                printf("xStreamer error: Core isn't online");
                xstreamer_client_outdone = true;
            }
            return -1;
        } else xstreamer_client_tested = true;
    #endif
    return CallRemoteFunction("Core_DestroyTeleport","i",teleportid);
}
