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

	serverLog = CreateLog("logi/server", E_LOGLEVEL:DEBUG | INFO | WARNING | ERROR, false);
	commandLog = CreateLog("logi/command", INFO, false);
	chatLog = CreateLog("logi/chat", INFO, false);
	damageLog = CreateLog("logi/damage", INFO, false);
	connectLog = CreateLog("logi/connect", INFO, false);

	//old
	admindutyLog = CreateLog("logi/adminduty", INFO, false);
	admindutyMaszLog = CreateLog("logi/admindutymasz", INFO, false);
}

//end