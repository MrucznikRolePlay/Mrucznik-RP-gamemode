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
	serverLog = CreateLog("logi/server");
	vehicleErrorLog = CreateLog("logi/vehicleerror");
	warningLog = CreateLog("logi/warning");
	cmdLog = CreateLog("logi/cmd");
	sejfLog = CreateLog("logi/sejf");
	actionLog = CreateLog("logi/action");
	weapLog = CreateLog("logi/weap");
	czitLog = CreateLog("logi/czit");
	kasynoLog = CreateLog("logi/kasyno");
	przekretLog = CreateLog("logi/przekret");
	payLog = CreateLog("logi/pay");
	autaLog = CreateLog("logi/auta");
	bankomatLog = CreateLog("logi/bankomat");
	premiumLog = CreateLog("logi/premium");
	kickLog = CreateLog("logi/kick");
	banLog = CreateLog("logi/ban");
	admindutyLog = CreateLog("logi/adminduty");
	admindutyMaszLog = CreateLog("logi/admindutymasz");
	biznesLog = CreateLog("logi/biznesy");
	statsLog = CreateLog("logi/setstats");
	eventLog = CreateLog("logi/event");
	ckLog = CreateLog("logi/ck");
	houseLog = CreateLog("logi/domy");
	warnLog = CreateLog("logi/warn");
	nickLog = CreateLog("logi/nick");
}

//end