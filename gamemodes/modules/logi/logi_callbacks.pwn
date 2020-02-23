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
	adminLog = CreateLog("logi/admin", ALL, false); 
	payLog = CreateLog("logi/pay", ALL, false);
	premiumLog = CreateLog("logi/premium", ALL, false);
	punishmentLog = CreateLog("logi/punishment", ALL, false);
	warningLog = CreateLog("logi/warning", ALL, false);
	nickLog = CreateLog("logi/nick", ALL, false);
	sejfLog = CreateLog("logi/sejf", ALL, false);
	serverLog = CreateLog("logi/server", ALL, false);
	commandLog = CreateLog("logi/command", ALL, false);
	chatLog = CreateLog("logi/chat", ALL, false);
	damageLog = CreateLog("logi/damage", ALL, false);
	connectLog = CreateLog("logi/connect", ALL, false);
	mysqlLog = CreateLog("logi/mysql", ALL, true);
	moneyLog = CreateLog("logi/money", ALL, false);
	errorLog = CreateLog("logi/error", ERROR, true);
	businessLog = CreateLog("logi/business", ALL, false); 
	businessCashLog = CreateLog("logi/businesscash", ALL, false); 
	//old
	admindutyLog = CreateLog("logi/adminduty", ALL, false);
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
	DestroyLog(moneyLog);
	DestroyLog(errorLog);
	DestroyLog(admindutyLog);
	DestroyLog(businessLog); 
	DestroyLog(businessCashLog); 
}

//end