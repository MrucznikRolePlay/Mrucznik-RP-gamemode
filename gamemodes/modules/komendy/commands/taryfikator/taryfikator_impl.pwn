//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_taryfikator_Impl(playerid)
{
    ShowPlayerDialogEx(playerid,68,DIALOG_STYLE_LIST,"Kodeks wykroczeñ: wybierz dzia³","Wykroczenia przeciwko porz¹dkowi i bezpieczeñstwu publicznemu\nPosiadanie nielegalnych przedmiotów\nWykroczenia przeciwko mieniu i zdrowiu\nWykroczenia przeciwko godnoœci osobistej\nUtrudnianie dzia³añ policji\nWykroczenia przeciwko bezpieczeñstwu w ruchu drogowym\nNiew³aœciwe korzystanie z drogi\nInformacje","Wybierz","WyjdŸ");
	return 1;
}

//end
