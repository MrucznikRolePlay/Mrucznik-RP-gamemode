//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                    logi                                                   //
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
// Autor: Mrucznik
// Data utworzenia: 04.05.2019
//Opis:
/*
	Narzêdzia do obs³ugi logów.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnGameModeInit()
{
	adminLog = CreateLog("logi/admin", INFO, false); 
	payLog = CreateLog("logi/pay", INFO, false);
	premiumLog = CreateLog("logi/premium", E_LOGLEVEL:DEBUG | INFO, false);
	punishmentLog = CreateLog("logi/punishment", INFO, false);
	warningLog = CreateLog("logi/warning", INFO, false);
	nickLog = CreateLog("logi/nick", INFO, false);
	sejfLog = CreateLog("logi/sejf", INFO, false);
	serverLog = CreateLog("logi/server", E_LOGLEVEL:ALL, false);
	commandLog = CreateLog("logi/command", INFO | WARNING | ERROR, false);
	chatLog = CreateLog("logi/chat", E_LOGLEVEL:DEBUG | INFO, false);
	damageLog = CreateLog("logi/damage", E_LOGLEVEL:DEBUG | INFO, false);
	connectLog = CreateLog("logi/connect", INFO, false);
	mysqlLog = CreateLog("logi/mysql", E_LOGLEVEL:ALL, true);

	//old
	admindutyLog = CreateLog("logi/adminduty", INFO, false);
	admindutyMaszLog = CreateLog("logi/admindutymasz", INFO, false);
}

hook OnGameModeExit()
{
	DestroyLog(adminLog);
	DestroyLog(payLog);
	DestroyLog(premiumLog);
	DestroyLog(punishmentLog);
	DestroyLog(warningLog);
	DestroyLog(nickLog);
	DestroyLog(sejfLog);
	DestroyLog(serverLog);
	DestroyLog(commandLog);
	DestroyLog(chatLog);
	DestroyLog(damageLog);
	DestroyLog(connectLog);
	DestroyLog(mysqlLog);
	DestroyLog(admindutyLog);
	DestroyLog(admindutyMaszLog);
}

//end