//------------------------------------------------

#include <a_samp>
#include <a_http>

forward MyHttpResponse(index, response_code, data[]);

//------------------------------------------------

public OnFilterScriptInit()
{
	print("\n--HTTP Test Loaded.\n");
	return 1;
}

//------------------------------------------------

public MyHttpResponse(index, response_code, data[])
{
	new showdata[256+1];
	format(showdata, 256, "Index: %d ResponseCode: %d Data: %s", index, response_code, data);
	SendClientMessage(index, 0xFFFFFFFF, showdata);
}

//------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256+1];

	if(strcmp("/httptest", cmd, true) == 0)
	{
	    HTTP(playerid, HTTP_GET, "sa-mp.com/return.txt", "", "MyHttpResponse");
	    return 1;
	}
	
	return 0;
}
//------------------------------------------------
