/*
	SACNR Monitor Announce Filterscript

	Use this filterscript if your server is not on the internet list, but you
	want it to show up on SACNR Monitor.

	Contributors:
		Blacklite
		King_Hual
		Jamie
		Blake
*/

#include <a_samp>
#include <a_http>

#define ANNOUNCE_URL        "monitor.sacnr.com/api/?Action=announce"
#define LOG_PREFIX          "[SACNR Monitor] "

#define HTTP_CREATED                201
#define HTTP_FORBIDDEN				403
#define HTTP_UNPROCESSABLE_ENTITY   422
#define HTTP_TOO_MANY_REQUESTS      429

public OnFilterScriptInit()
{
    Announce();
}

stock GetIP(ip[], const len)
{
    GetServerVarAsString("bind", ip, len);
}

forward Announce();
public Announce()
{
    new postData[32],
        ip[16];
	GetIP(ip, sizeof(ip));
    printf("%sAnnouncing server...", LOG_PREFIX);
    if (!strlen(ip)) {
        printf("%sBind address empty, can't announce server", LOG_PREFIX);
    }
    format(postData, sizeof(postData), "ipp=%s:%d", ip, GetServerVarAsInt("port"));
    HTTP(0, HTTP_POST, ANNOUNCE_URL, postData, "OnAnnounced"); // no need for different announce indices
}

forward OnAnnounced(index, response_code, data[]);
public OnAnnounced(index, response_code, data[])
{
    #pragma unused data
    switch (response_code) {
        case HTTP_ERROR_BAD_HOST: {
            printf("%sServer failed to announce: HTTP_ERROR_BAD_HOST", LOG_PREFIX);
        }
        case HTTP_ERROR_NO_SOCKET: {
            printf("%sServer failed to announce: HTTP_ERROR_NO_SOCKET", LOG_PREFIX);
        }
        case HTTP_ERROR_CANT_CONNECT: {
            printf("%sServer failed to announce: HTTP_ERROR_CANT_CONNECT", LOG_PREFIX);
        }
        case HTTP_ERROR_CANT_WRITE: {
            printf("%sServer failed to announce: HTTP_ERROR_CANT_WRITE", LOG_PREFIX);
        }
        case HTTP_ERROR_CONTENT_TOO_BIG: {
            printf("%sServer failed to announce: HTTP_ERROR_CONTENT_TOO_BIG", LOG_PREFIX);
        }
        case HTTP_ERROR_MALFORMED_RESPONSE: {
            printf("%sServer failed to announce: HTTP_ERROR_MALFORMED_RESPONSE", LOG_PREFIX);
        }
        case HTTP_CREATED: {
            printf("%sServer announced successfully.", LOG_PREFIX);
        }
        case HTTP_FORBIDDEN: {
        	printf("%sServer failed to announce: 403 Forbidden. This can happen if your server has multiple IP addresses or lots of public SA-MP servers on your subnet.", LOG_PREFIX);
        }
        case HTTP_UNPROCESSABLE_ENTITY: {
            printf("%sServer failed to announce: 422 Unprocessable Entity. You might get this error if you are running a local/LAN server.", LOG_PREFIX);
        }
        case HTTP_TOO_MANY_REQUESTS: {
            printf("%sServer already announced (interval too small?).", LOG_PREFIX);
        }
        default: {
            printf("%sServer failed to announce (error %d).", LOG_PREFIX, response_code);
        }
    }
}
