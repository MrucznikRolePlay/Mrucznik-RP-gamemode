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
	adminLog = CreateLog("logi/admin", false); 
	payLog = CreateLog("logi/pay", false);
	premiumLog = CreateLog("logi/premium", false);
	punishmentLog = CreateLog("logi/punishment", false);
	warningLog = CreateLog("logi/warning", false);
	nickLog = CreateLog("logi/nick", false);
	sejfLog = CreateLog("logi/sejf", false);
	serverLog = CreateLog("logi/server", false);
	crashLog = CreateLog("logi/crash", false);
	commandLog = CreateLog("logi/command", false);
	chatLog = CreateLog("logi/chat", false);
	damageLog = CreateLog("logi/damage", false);
	connectLog = CreateLog("logi/connect", false);
	mysqlLog = CreateLog("logi/mysql", true);
	moneyLog = CreateLog("logi/money", false);
	errorLog = CreateLog("logi/error", true);

	//old
	admindutyLog = CreateLog("logi/adminduty", false);
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
	DestroyLog(crashLog);
	DestroyLog(commandLog);
	DestroyLog(chatLog);
	DestroyLog(damageLog);
	DestroyLog(connectLog);
	DestroyLog(mysqlLog);
	DestroyLog(moneyLog);
	DestroyLog(errorLog);
	DestroyLog(admindutyLog);
}

//end