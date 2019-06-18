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


	//old
	warningLog = CreateLog("logi/warning", INFO | WARNING | ERROR, false);
	commandLog = CreateLog("logi/command", INFO | WARNING | ERROR, false);
	payLog = CreateLog("logi/pay", INFO | WARNING | ERROR, false);
	premiumLog = CreateLog("logi/premium", INFO | WARNING | ERROR, false);
	admindutyLog = CreateLog("logi/adminduty", INFO | WARNING | ERROR, false);
	admindutyMaszLog = CreateLog("logi/admindutymasz", INFO | WARNING | ERROR, false);
	nickLog = CreateLog("logi/nick", INFO | WARNING | ERROR, false);
}

//end