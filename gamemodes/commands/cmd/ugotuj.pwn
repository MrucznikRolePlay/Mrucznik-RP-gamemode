//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ ugotuj ]------------------------------------------------//
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



YCMD:ugotuj(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(IsAtCookPlace(playerid))
        {
            new x_nr[16];
			if( sscanf(params, "s[16]", x_nr))
			{
				sendTipMessage(playerid, "U¿yj /gotuj [nazwa]");
				sendTipMessage(playerid, "Dostêpne nazwy: OstatniaRyba, Ryba.");
				return 1;
			}
			if(strcmp(x_nr,"ostatniaryba",true) == 0)
			{
			    if(Fishes[playerid][pLastFish] > 0)
        		{
				    new found = 0;
				    if(Cooking[playerid][pCWeight1] == 0)
				    {
					    format(string, sizeof(string), "Gotowana  %s", FishNames[Fishes[playerid][pFishID]]);
					    strmid(Cooking[playerid][pCook1], string, 0, strlen(string));
					    Cooking[playerid][pCWeight1] = Fishes[playerid][pLastWeight];
					    Cooking[playerid][pCookID1] = Fishes[playerid][pFishID];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook1],Cooking[playerid][pCWeight1]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    found = 1;
				    }
				    else if(Cooking[playerid][pCWeight2] == 0)
				    {
					    format(string, sizeof(string), "Gotowana  %s", FishNames[Fishes[playerid][pFishID]]);
					    strmid(Cooking[playerid][pCook2], string, 0, strlen(string));
					    Cooking[playerid][pCWeight2] = Fishes[playerid][pLastWeight];
					    Cooking[playerid][pCookID2] = Fishes[playerid][pFishID];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook2],Cooking[playerid][pCWeight2]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    found = 1;
				    }
				    else if(Cooking[playerid][pCWeight3] == 0)
				    {
					    format(string, sizeof(string), "Gotowana  %s", FishNames[Fishes[playerid][pFishID]]);
					    strmid(Cooking[playerid][pCook3], string, 0, strlen(string));
					    Cooking[playerid][pCWeight3] = Fishes[playerid][pLastWeight];
					    Cooking[playerid][pCookID3] = Fishes[playerid][pFishID];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook3],Cooking[playerid][pCWeight3]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    found = 1;
				    }
				    else if(Cooking[playerid][pCWeight4] == 0)
				    {
					    format(string, sizeof(string), "Gotowana  %s", FishNames[Fishes[playerid][pFishID]]);
					    strmid(Cooking[playerid][pCook4], string, 0, strlen(string));
					    Cooking[playerid][pCWeight4] = Fishes[playerid][pLastWeight];
					    Cooking[playerid][pCookID4] = Fishes[playerid][pFishID];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook4],Cooking[playerid][pCWeight4]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    found = 1;
				    }
				    else if(Cooking[playerid][pCWeight5] == 0)
				    {
					    format(string, sizeof(string), "Gotowana  %s", FishNames[Fishes[playerid][pFishID]]);
					    strmid(Cooking[playerid][pCook5], string, 0, strlen(string));
					    Cooking[playerid][pCWeight5] = Fishes[playerid][pLastWeight];
					    Cooking[playerid][pCookID5] = Fishes[playerid][pFishID];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook5],Cooking[playerid][pCWeight5]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    found = 1;
				    }
				    else
				    {
				        sendTipMessageEx(playerid, COLOR_GREY, "Nie masz ju¿ miejsca na swoje potrawy !");
				        return 1;
				    }
				    if(found)
				    {
				        ClearFishID(playerid, Fishes[playerid][pLastFish]);
			            Fishes[playerid][pLastFish] = 0;
			            Fishes[playerid][pFishID] = 0;
				    }
			    }
			    else
			    {
			        sendTipMessageEx(playerid, COLOR_GREY, "Nie z³apa³eœ ¿adnej ryby !");
			        return 1;
			    }
			}
			else if(strcmp(x_nr,"ryba",true) == 0)
			{
			    new found = 0, fishid;

				if( sscanf(params, "{s[16]}d", x_nr, fishid))
				{
					sendTipMessage(playerid, "U¿yj /gotuj ryba [id]");
					return 1;
				}

				if(fishid < 1 || fishid > 5) { sendTipMessageEx(playerid, COLOR_GREY, "Numer od 1 do 5!"); return 1; }
				else if(fishid == 1 && Fishes[playerid][pWeight1] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(1) !"); return 1; }
				else if(fishid == 2 && Fishes[playerid][pWeight2] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(2) !"); return 1; }
				else if(fishid == 3 && Fishes[playerid][pWeight3] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(3) !"); return 1; }
				else if(fishid == 4 && Fishes[playerid][pWeight4] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(4) !"); return 1; }
				else if(fishid == 5 && Fishes[playerid][pWeight5] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(5) !"); return 1; }
				if(Cooking[playerid][pCWeight1] == 0)
				{
				    if(fishid == 1)
				    {
					    format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish1]);
					    strmid(Cooking[playerid][pCook1], string, 0, strlen(string));
					    Cooking[playerid][pCWeight1] = Fishes[playerid][pWeight1];
					    Cooking[playerid][pCookID1] = Fishes[playerid][pFid1];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook1],Cooking[playerid][pCWeight1]);
				    	SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
				    }
					else if(fishid == 2)
				 	{
					    format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish2]);
					    strmid(Cooking[playerid][pCook1], string, 0, strlen(string));
					    Cooking[playerid][pCWeight1] = Fishes[playerid][pWeight2];
					    Cooking[playerid][pCookID1] = Fishes[playerid][pFid2];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook1],Cooking[playerid][pCWeight1]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					}
					else if(fishid == 3)
					{
					    format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish3]);
					    strmid(Cooking[playerid][pCook1], string, 0, strlen(string));
					    Cooking[playerid][pCWeight1] = Fishes[playerid][pWeight3];
					    Cooking[playerid][pCookID1] = Fishes[playerid][pFid3];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook1],Cooking[playerid][pCWeight1]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					}
					else if(fishid == 4)
					{
					    format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish4]);
					    strmid(Cooking[playerid][pCook1], string, 0, strlen(string));
					    Cooking[playerid][pCWeight1] = Fishes[playerid][pWeight4];
					    Cooking[playerid][pCookID1] = Fishes[playerid][pFid4];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook1],Cooking[playerid][pCWeight1]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					}
					else if(fishid == 5)
					{
					    format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish5]);
					    strmid(Cooking[playerid][pCook1], string, 0, strlen(string));
					    Cooking[playerid][pCWeight1] = Fishes[playerid][pWeight5];
					    Cooking[playerid][pCookID1] = Fishes[playerid][pFid5];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook1],Cooking[playerid][pCWeight1]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					}
					found = 1;
	    		}
				else if(Cooking[playerid][pCWeight2] == 0)
				{
					if(fishid == 1)
				    {
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish1]);
						strmid(Cooking[playerid][pCook2], string, 0, strlen(string));
						Cooking[playerid][pCWeight2] = Fishes[playerid][pWeight1];
						Cooking[playerid][pCookID2] = Fishes[playerid][pFid1];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook2],Cooking[playerid][pCWeight2]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 2)
					{
					    format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish2]);
					    strmid(Cooking[playerid][pCook2], string, 0, strlen(string));
					    Cooking[playerid][pCWeight2] = Fishes[playerid][pWeight2];
					    Cooking[playerid][pCookID2] = Fishes[playerid][pFid2];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook2],Cooking[playerid][pCWeight2]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					}
					else if(fishid == 3)
					{
					    format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish3]);
					    strmid(Cooking[playerid][pCook2], string, 0, strlen(string));
					    Cooking[playerid][pCWeight2] = Fishes[playerid][pWeight3];
					    Cooking[playerid][pCookID2] = Fishes[playerid][pFid3];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook2],Cooking[playerid][pCWeight2]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					}
					else if(fishid == 4)
					{
					    format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish4]);
					    strmid(Cooking[playerid][pCook2], string, 0, strlen(string));
					    Cooking[playerid][pCWeight2] = Fishes[playerid][pWeight4];
					    Cooking[playerid][pCookID2] = Fishes[playerid][pFid4];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook2],Cooking[playerid][pCWeight2]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					}
					else if(fishid == 5)
					{
					    format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish5]);
					    strmid(Cooking[playerid][pCook2], string, 0, strlen(string));
					    Cooking[playerid][pCWeight2] = Fishes[playerid][pWeight5];
					    Cooking[playerid][pCookID2] = Fishes[playerid][pFid5];
					    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook2],Cooking[playerid][pCWeight2]);
					    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					}
					found = 1;
	    		}
				else if(Cooking[playerid][pCWeight3] == 0)
				{
					if(fishid == 1)
				    {
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish1]);
						strmid(Cooking[playerid][pCook3], string, 0, strlen(string));
						Cooking[playerid][pCWeight3] = Fishes[playerid][pWeight1];
						Cooking[playerid][pCookID3] = Fishes[playerid][pFid1];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook3],Cooking[playerid][pCWeight3]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 2)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish2]);
						strmid(Cooking[playerid][pCook3], string, 0, strlen(string));
						Cooking[playerid][pCWeight3] = Fishes[playerid][pWeight2];
						Cooking[playerid][pCookID3] = Fishes[playerid][pFid2];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook3],Cooking[playerid][pCWeight3]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					}
					else if(fishid == 3)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish3]);
						strmid(Cooking[playerid][pCook3], string, 0, strlen(string));
						Cooking[playerid][pCWeight3] = Fishes[playerid][pWeight3];
						Cooking[playerid][pCookID3] = Fishes[playerid][pFid3];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook3],Cooking[playerid][pCWeight3]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 4)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish4]);
						strmid(Cooking[playerid][pCook3], string, 0, strlen(string));
						Cooking[playerid][pCWeight3] = Fishes[playerid][pWeight4];
						Cooking[playerid][pCookID3] = Fishes[playerid][pFid4];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook3],Cooking[playerid][pCWeight3]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 5)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish5]);
						strmid(Cooking[playerid][pCook3], string, 0, strlen(string));
						Cooking[playerid][pCWeight3] = Fishes[playerid][pWeight5];
						Cooking[playerid][pCookID3] = Fishes[playerid][pFid5];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook3],Cooking[playerid][pCWeight3]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					found = 1;
				}
				else if(Cooking[playerid][pCWeight4] == 0)
				{
					if(fishid == 1)
				    {
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish1]);
						strmid(Cooking[playerid][pCook4], string, 0, strlen(string));
						Cooking[playerid][pCWeight4] = Fishes[playerid][pWeight1];
						Cooking[playerid][pCookID4] = Fishes[playerid][pFid1];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook4],Cooking[playerid][pCWeight4]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 2)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish2]);
						strmid(Cooking[playerid][pCook4], string, 0, strlen(string));
						Cooking[playerid][pCWeight4] = Fishes[playerid][pWeight2];
						Cooking[playerid][pCookID4] = Fishes[playerid][pFid2];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook4],Cooking[playerid][pCWeight4]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 3)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish3]);
						strmid(Cooking[playerid][pCook4], string, 0, strlen(string));
						Cooking[playerid][pCWeight4] = Fishes[playerid][pWeight3];
						Cooking[playerid][pCookID4] = Fishes[playerid][pFid3];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook4],Cooking[playerid][pCWeight4]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 4)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish4]);
						strmid(Cooking[playerid][pCook4], string, 0, strlen(string));
						Cooking[playerid][pCWeight4] = Fishes[playerid][pWeight4];
						Cooking[playerid][pCookID4] = Fishes[playerid][pFid4];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook4],Cooking[playerid][pCWeight4]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 5)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish5]);
						strmid(Cooking[playerid][pCook4], string, 0, strlen(string));
						Cooking[playerid][pCWeight4] = Fishes[playerid][pWeight5];
						Cooking[playerid][pCookID4] = Fishes[playerid][pFid5];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook4],Cooking[playerid][pCWeight4]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					}
					found = 1;
	    		}
				else if(Cooking[playerid][pCWeight5] == 0)
				{
					if(fishid == 1)
				    {
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish1]);
						strmid(Cooking[playerid][pCook5], string, 0, strlen(string));
						Cooking[playerid][pCWeight5] = Fishes[playerid][pWeight1];
						Cooking[playerid][pCookID5] = Fishes[playerid][pFid1];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook5],Cooking[playerid][pCWeight5]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 2)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish2]);
						strmid(Cooking[playerid][pCook5], string, 0, strlen(string));
						Cooking[playerid][pCWeight5] = Fishes[playerid][pWeight2];
						Cooking[playerid][pCookID5] = Fishes[playerid][pFid2];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook5],Cooking[playerid][pCWeight5]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 3)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish3]);
						strmid(Cooking[playerid][pCook5], string, 0, strlen(string));
						Cooking[playerid][pCWeight5] = Fishes[playerid][pWeight3];
						Cooking[playerid][pCookID5] = Fishes[playerid][pFid3];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook5],Cooking[playerid][pCWeight5]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 4)
					{
						format(string, sizeof(string), "Gotowana  %s", Fishes[playerid][pFish4]);
						strmid(Cooking[playerid][pCook5], string, 0, strlen(string));
						Cooking[playerid][pCWeight5] = Fishes[playerid][pWeight4];
						Cooking[playerid][pCookID5] = Fishes[playerid][pFid4];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook5],Cooking[playerid][pCWeight5]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					else if(fishid == 5)
					{
						format(string, sizeof(string), "Gotowana %s", Fishes[playerid][pFish5]);
						strmid(Cooking[playerid][pCook5], string, 0, strlen(string));
						Cooking[playerid][pCWeight5] = Fishes[playerid][pWeight5];
						Cooking[playerid][pCookID5] = Fishes[playerid][pFid5];
						format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook5],Cooking[playerid][pCWeight5]);
						SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
		    		}
					found = 1;
				}
				else
				{
					sendTipMessageEx(playerid, COLOR_GREY, "Nie masz ju¿ miejsca na swoje potrawy !");
				    return 1;
	    		}
				if(found)
				{
				    ClearFishID(playerid, fishid);
					Fishes[playerid][pLastFish] = 0;
		   			Fishes[playerid][pFishID] = 0;
				}
			}
			else if(strcmp(x_nr,"kurczak",true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,369.9786,-4.0798,1001.8589))
			    {//Cluckin Bell
			        if(Groceries[playerid][pChicken] != 0)
			        {
			            if(Cooking[playerid][pCWeight1] == 0)
					    {
						    format(string, sizeof(string), "Gotowany kurczak");
						    strmid(Cooking[playerid][pCook1], string, 0, strlen(string));
						    Cooking[playerid][pCWeight1] = Groceries[playerid][pChicken];
						    Cooking[playerid][pCookID1] = 30;
						    Groceries[playerid][pChickens] = 0; Groceries[playerid][pChicken] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹cego %d KG.",Cooking[playerid][pCook1],Cooking[playerid][pCWeight1]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight2] == 0)
					    {
						    format(string, sizeof(string), "Gotowany kurczak");
						    strmid(Cooking[playerid][pCook2], string, 0, strlen(string));
						    Cooking[playerid][pCWeight2] = Groceries[playerid][pChicken];
						    Cooking[playerid][pCookID2] = 30;
						    Groceries[playerid][pChickens] = 0; Groceries[playerid][pChicken] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹cego %d KG.",Cooking[playerid][pCook2],Cooking[playerid][pCWeight2]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight3] == 0)
					    {
						    format(string, sizeof(string), "Gotowany kurczak");
						    strmid(Cooking[playerid][pCook3], string, 0, strlen(string));
						    Cooking[playerid][pCWeight3] = Groceries[playerid][pChicken];
						    Cooking[playerid][pCookID3] = 30;
						    Groceries[playerid][pChickens] = 0; Groceries[playerid][pChicken] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹cego %d KG.",Cooking[playerid][pCook3],Cooking[playerid][pCWeight3]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight4] == 0)
					    {
						    format(string, sizeof(string), "Gotowany kurczak");
						    strmid(Cooking[playerid][pCook4], string, 0, strlen(string));
						    Cooking[playerid][pCWeight4] = Groceries[playerid][pChicken];
						    Cooking[playerid][pCookID4] = 30;
						    Groceries[playerid][pChickens] = 0; Groceries[playerid][pChicken] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹cego %d KG.",Cooking[playerid][pCook4],Cooking[playerid][pCWeight4]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight5] == 0)
					    {
						    format(string, sizeof(string), "Gotowany kurczak");
						    strmid(Cooking[playerid][pCook5], string, 0, strlen(string));
						    Cooking[playerid][pCWeight5] = Groceries[playerid][pChicken];
						    Cooking[playerid][pCookID5] = 30;
						    Groceries[playerid][pChickens] = 0; Groceries[playerid][pChicken] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹cego %d KG.",Cooking[playerid][pCook5],Cooking[playerid][pCWeight5]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else
					    {
					        sendTipMessageEx(playerid, COLOR_GREY, "Nie masz ju¿ miejsca na swoje potrawy !");
					        return 1;
					    }
			        }
			        else
			        {
			            sendTipMessageEx(playerid, COLOR_GREY, "Nie masz przy sobie kurczaka !");
			            return 1;
			        }
			    }
			    else
			    {
			        sendTipMessageEx(playerid, COLOR_GREY, "Musisz byæ w  Cluckin Bell aby to ugotowaæ !");
				    return 1;
			    }
			}
			else if(strcmp(x_nr,"hamburger",true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,376.4466,-60.9574,1001.5078) || PlayerToPoint(3.0,playerid,378.1215,-57.4928,1001.5078))
				{//Burgershot
				    if(Groceries[playerid][pHamburger] != 0)
			        {
			            if(Cooking[playerid][pCWeight1] == 0)
					    {
						    format(string, sizeof(string), "Hamburgera z frytkami");
						    strmid(Cooking[playerid][pCook1], string, 0, strlen(string));
						    Cooking[playerid][pCWeight1] = Groceries[playerid][pHamburger];
						    Cooking[playerid][pCookID1] = 30;
						    Groceries[playerid][pHamburgers] = 0; Groceries[playerid][pHamburger] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹cego %d KG.",Cooking[playerid][pCook1],Cooking[playerid][pCWeight1]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight2] == 0)
					    {
						    format(string, sizeof(string), "Hamburgera z frytkami");
						    strmid(Cooking[playerid][pCook2], string, 0, strlen(string));
						    Cooking[playerid][pCWeight2] = Groceries[playerid][pHamburger];
						    Cooking[playerid][pCookID2] = 30;
						    Groceries[playerid][pHamburgers] = 0; Groceries[playerid][pHamburger] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹cego %d KG.",Cooking[playerid][pCook2],Cooking[playerid][pCWeight2]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight3] == 0)
					    {
						    format(string, sizeof(string), "Hamburgera z frytkami");
						    strmid(Cooking[playerid][pCook3], string, 0, strlen(string));
						    Cooking[playerid][pCWeight3] = Groceries[playerid][pHamburger];
						    Cooking[playerid][pCookID3] = 30;
						    Groceries[playerid][pHamburgers] = 0; Groceries[playerid][pHamburger] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹cego %d KG.",Cooking[playerid][pCook3],Cooking[playerid][pCWeight3]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight4] == 0)
					    {
						    format(string, sizeof(string), "Hamburgera z frytkami");
						    strmid(Cooking[playerid][pCook4], string, 0, strlen(string));
						    Cooking[playerid][pCWeight4] = Groceries[playerid][pHamburger];
						    Cooking[playerid][pCookID4] = 30;
						    Groceries[playerid][pHamburgers] = 0; Groceries[playerid][pHamburger] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹cego %d KG.",Cooking[playerid][pCook4],Cooking[playerid][pCWeight4]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight5] == 0)
					    {
						    format(string, sizeof(string), "Hamburgera z frytkami");
						    strmid(Cooking[playerid][pCook5], string, 0, strlen(string));
						    Cooking[playerid][pCWeight5] = Groceries[playerid][pHamburger];
						    Cooking[playerid][pCookID5] = 30;
						    Groceries[playerid][pHamburgers] = 0; Groceries[playerid][pHamburger] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹cego %d KG.",Cooking[playerid][pCook5],Cooking[playerid][pCWeight5]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else
					    {
					        sendTipMessageEx(playerid, COLOR_GREY, "Nie masz ju¿ miejsca na swoje potrawy !");
					        return 1;
					    }
			        }
			        else
			        {
			            sendTipMessageEx(playerid, COLOR_GREY, "Nie masz ze sob¹ Hamburgera !");
			            return 1;
			        }
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_GREY, "Musisz byæ w Burger Shocie aby to ugotowaæ !");
				    return 1;
				}
			}
			else if(strcmp(x_nr,"pizza",true) == 0)
			{
			    if(PlayerToPoint(3.0,playerid,374.1185,-113.6361,1001.4922) || PlayerToPoint(3.0,playerid,377.7971,-113.7668,1001.4922))
				{//Well Stacked Pizza
				    if(Groceries[playerid][pPizza] != 0)
			        {
			            if(Cooking[playerid][pCWeight1] == 0)
					    {
						    format(string, sizeof(string), "Pizzê");
						    strmid(Cooking[playerid][pCook1], string, 0, strlen(string));
						    Cooking[playerid][pCWeight1] = Groceries[playerid][pHamburger];
						    Cooking[playerid][pCookID1] = 30;
						    Groceries[playerid][pPizzas] = 0; Groceries[playerid][pPizza] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook1],Cooking[playerid][pCWeight1]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight2] == 0)
					    {
						    format(string, sizeof(string), "Pizzê");
						    strmid(Cooking[playerid][pCook2], string, 0, strlen(string));
						    Cooking[playerid][pCWeight2] = Groceries[playerid][pHamburger];
						    Cooking[playerid][pCookID2] = 30;
						    Groceries[playerid][pPizzas] = 0; Groceries[playerid][pPizza] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook2],Cooking[playerid][pCWeight2]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight3] == 0)
					    {
						    format(string, sizeof(string), "Pizzê");
						    strmid(Cooking[playerid][pCook3], string, 0, strlen(string));
						    Cooking[playerid][pCWeight3] = Groceries[playerid][pHamburger];
						    Cooking[playerid][pCookID3] = 30;
						    Groceries[playerid][pPizzas] = 0; Groceries[playerid][pPizza] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook3],Cooking[playerid][pCWeight3]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight4] == 0)
					    {
						    format(string, sizeof(string), "Pizzê");
						    strmid(Cooking[playerid][pCook4], string, 0, strlen(string));
						    Cooking[playerid][pCWeight4] = Groceries[playerid][pHamburger];
						    Cooking[playerid][pCookID4] = 30;
						    Groceries[playerid][pPizzas] = 0; Groceries[playerid][pPizza] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook4],Cooking[playerid][pCWeight4]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else if(Cooking[playerid][pCWeight5] == 0)
					    {
						    format(string, sizeof(string), "Pizzê");
						    strmid(Cooking[playerid][pCook5], string, 0, strlen(string));
						    Cooking[playerid][pCWeight5] = Groceries[playerid][pHamburger];
						    Cooking[playerid][pCookID5] = 30;
						    Groceries[playerid][pPizzas] = 0; Groceries[playerid][pPizza] = 0;
						    format(string, sizeof(string), "* Stworzy³eœ %s, wa¿¹c¹ %d KG.",Cooking[playerid][pCook5],Cooking[playerid][pCWeight5]);
						    SendClientMessage(playerid,COLOR_LIGHTBLUE, string);
					    }
					    else
					    {
					        sendTipMessageEx(playerid, COLOR_GREY, "Nie masz ju¿ miejsca na swoje potrawy !");
					        return 1;
					    }
			        }
			        else
			        {
			            sendTipMessageEx(playerid, COLOR_GREY, "Nie masz pizzy ze sob¹ !");
			            return 1;
			        }
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_GREY, "Musisz byæ w pizzeri aby to ugotowaæ !");
				    return 1;
				}
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Z³a nazwa !");
			    return 1;
			}
        }
        else
        {
            sendErrorMessage(playerid, "Nie jesteœ w miejscu przeznaczonym do gotowania (Cluckin Bell / Burger Shot / Pizzeria).");
            return 1;
        }
    }
    return 1;
}

