//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ skin ]-------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

/*
YCMD:clothes(playerid, params[]) return cmd_skin(playerid, help);
YCMD:skin(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(GetPlayerFraction(playerid) >= 1)
        {
            if(IsAtClothShop(playerid))
			{
			    if(PlayerInfo[playerid][pMember] == 1) { ChosenSkin[playerid] = 280; SetPlayerSkin(playerid, 280); }
				else if(PlayerInfo[playerid][pMember] == 2) { ChosenSkin[playerid] = 286; SetPlayerSkin(playerid, 286); }
				else if(PlayerInfo[playerid][pMember] == 3) { ChosenSkin[playerid] = 287; SetPlayerSkin(playerid, 287); }
				else if(PlayerInfo[playerid][pMember] == 4) { ChosenSkin[playerid] = 70; SetPlayerSkin(playerid, 70); }
				else if(PlayerInfo[playerid][pMember] == 5) { ChosenSkin[playerid] = 258; SetPlayerSkin(playerid, 120); }
				else if(PlayerInfo[playerid][pMember] == 6) { ChosenSkin[playerid] = 120; SetPlayerSkin(playerid, 258); }
				else if(PlayerInfo[playerid][pMember] == 7) { ChosenSkin[playerid] = 163; SetPlayerSkin(playerid, 163); }
				else if(PlayerInfo[playerid][pMember] == 8) { ChosenSkin[playerid] = 127; SetPlayerSkin(playerid, 127); }
				else if(PlayerInfo[playerid][pMember] == 9) { ChosenSkin[playerid] = 148; SetPlayerSkin(playerid, 148); }
				else if(PlayerInfo[playerid][pMember] == 10) { ChosenSkin[playerid] = 255; SetPlayerSkin(playerid, 255); }
				else if(PlayerInfo[playerid][pMember] == 11) { ChosenSkin[playerid] = 59; SetPlayerSkin(playerid, 59); }
				else if(PlayerInfo[playerid][pMember] == 12) { ChosenSkin[playerid] = 270; SetPlayerSkin(playerid, 270); }
				else if(PlayerInfo[playerid][pMember] == 13) { ChosenSkin[playerid] = 103; SetPlayerSkin(playerid, 103); }
				else if(PlayerInfo[playerid][pMember] == 14) { ChosenSkin[playerid] = 108; SetPlayerSkin(playerid, 108); }
				else if(PlayerInfo[playerid][pMember] == 15) { ChosenSkin[playerid] = 8; SetPlayerSkin(playerid, 8); }//NoA
				else { return 1; }
				GetPlayerPos(playerid, ChangePos[playerid][0],ChangePos[playerid][1],ChangePos[playerid][2]);
				ChangePos2[playerid][0] = GetPlayerInterior(playerid);
				ChangePos2[playerid][1] = 1;
			    SetPlayerInterior(playerid,0);
				new rand = random(sizeof(gInviteSpawns));
				SetPlayerPosEx(playerid, gInviteSpawns[rand][0], gInviteSpawns[rand][1], gInviteSpawns[rand][2]); // Warp the player
				SetPlayerFacingAngle(playerid, gInviteSpawns[rand][3]);
				SetPlayerCameraPos(playerid,gInviteSpawns[rand][0] + 3, gInviteSpawns[rand][1], gInviteSpawns[rand][2]);
				SetPlayerCameraLookAt(playerid,gInviteSpawns[rand][0], gInviteSpawns[rand][1], gInviteSpawns[rand][2]);
				TogglePlayerControllable(playerid, 0);
				SelectChar[playerid] = 255;
				SelectCharID[playerid] = PlayerInfo[playerid][pMember];
				SelectCharPlace[playerid] = 1;
				//PlayerInfo[playerid][pModel] = ChosenSkin[playerid];
		    	PlayerInfo[playerid][pSkin] = ChosenSkin[playerid];
			    SendClientMessage(playerid, COLOR_LIGHTRED, "* U¿yj 'next' aby zobaczyæ nastêpny skin.");
			    SendClientMessage(playerid, COLOR_LIGHTRED, "* Jeœli zdecydowa³eœ siê na konkretny skin wpisz 'gotowe'.");
			    SendClientMessage(playerid, COLOR_LIGHTRED, "* Je¿eli nie ma tu wszytkich skinów twojej frakcji u¿yj /uniform w sklepie z ciuchami");
                SendClientMessage(playerid, COLOR_LIGHTRED, "* U¿yj /uniform w sklepie z ciuchami aby zmieniæ ubranie robocze.");
            }
			else
			{
				SendClientMessage(playerid, COLOR_GRAD2, "   Nie jesteœ w sklepie z ubraniami !");
				return 1;
			}
        }
        else
        {
            SendClientMessage(playerid,COLOR_GREY, "   Nie jesteœ we frakcji !");
            return 1;
        }
    }
    return 1;
}
*/
