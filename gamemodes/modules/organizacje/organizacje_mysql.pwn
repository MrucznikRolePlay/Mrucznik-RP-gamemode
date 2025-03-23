//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                organizacje                                                //
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
// Data utworzenia: 15.05.2019
//Opis:
/*
	System organizacji przestêpczych.
*/

//

//------------------<[ MySQL: ]>--------------------

MruMySQL_RemoveOrgAssets(org)
{
    new string[128];
    format(string, sizeof(string), "UPDATE `mru_konta` SET `FMember`=0, `Member`=99, `Rank`=99 WHERE `FMember`='%d'", org);
    mysql_query(string);

    format(string, sizeof(string), "DELETE FROM `mru_cars` WHERE `ownertype`=2 AND `owner`=%d", org);
    mysql_query(string);

    format(string, sizeof(string), "UPDATE `mru_strefy` SET `gang`=0 WHERE `gang`='%d'", org);
    mysql_query(string);
}

WczytajRangi()
{
    new query[512], id, typ, rangi[256],ranga[MAX_RANG][MAX_RANG_LEN];
    mysql_query("SELECT * FROM `mru_nazwyrang`");
    mysql_store_result();

    while(mysql_fetch_row_format(query, "|"))
    {
        sscanf(query, "p<|>dds[256]", id, typ, rangi);
        sscanf(rangi, "p<,>A<s[25]>()[10]", ranga);
        //Assign true rangs
        if(typ == 1)
        {
            for(new i=0;i<MAX_RANG;i++)
            {
                if(strlen(ranga[i]) > 1) format(FracRang[id][i], MAX_RANG_LEN, "%s", ranga[i]);
            }
        }
        else
        {
            for(new i=0;i<MAX_RANG;i++)
            {
                if(strlen(ranga[i]) > 1) format(OrgRank[id][i], MAX_RANG_LEN, "%s", ranga[i]);
				else format(OrgRank[id][i], MAX_RANG_LEN, "Brak");
            }
        }
    }
    mysql_free_result();
    print("Wczytano rangi");
}

WczytajSkiny()
{
    new query[4096], id, typ, skiny[1024],skin[MAX_SKIN_SELECT];
    mysql_query("SELECT * FROM `mru_skins`");
    mysql_store_result();

    while(mysql_fetch_row_format(query, "|"))
    {
        sscanf(query, "p<|>dds[4096]", typ, id, skiny);
        sscanf(skiny, "p<,>A<d>(0)["#MAX_SKIN_SELECT"]", skin);

        if(typ == 1)
        {
            for(new i=0;i<MAX_SKIN_SELECT;i++)
            {
                if(skin[i] > 0) FRAC_SKINS[id][i] = skin[i];
            }
        }
        else
        {
            for(new i=0;i<MAX_SKIN_SELECT;i++)
            {
                if(skin[i] > 0) OrgSkins[id][i] = skin[i];
            }
        }
    }
    mysql_free_result();
    print("Wczytano skiny");
}

AddOrgSkin(org, skin)
{
    new skins[4096];
    for(new i; i<MAX_SKIN_SELECT; i++)
    {
        if(OrgSkins[org][i] == 0)
        {
            OrgSkins[org][i] = skin;
            strcat(skins, sprintf("%d", skin));
            break;
        }
        strcat(skins, sprintf("%d,", OrgSkins[org][i]));
    }

    new query[4096];
    format(query, sizeof(query), "UPDATE `mru_skins` SET skins='%s' WHERE id=%d AND typ=2", skins, org);
    mysql_query(query);
}

RemoveOrgSkin(org, skin)
{
    new skins[4096];
    for(new i; i<MAX_SKIN_SELECT; i++)
    {
        if(OrgSkins[org][i] == 0)
        {
            break;
        }
        if(OrgSkins[org][i] != skin)
        {
            strcat(skins, sprintf("%d,", OrgSkins[org][i]));
        }
        else
        {
            OrgSkins[org][i] = 0;
        }
    }
	skins[strlen(skins)-1] = '\0';

    // move other skins
    new replace;
    for(new i; i<MAX_SKIN_SELECT; i++)
    {
        if(OrgSkins[org][i] == skin)
        {
            replace = true;
        }

        new nextIdx = i + 1;
        if(nextIdx >= MAX_SKIN_SELECT) 
        {
            break;
        }

        if(replace)
        {
            OrgSkins[org][i] = OrgSkins[org][nextIdx];
            OrgSkins[org][nextIdx] = 0;
        }
    }

    new query[4096];
    format(query, sizeof(query), "UPDATE `mru_skins` SET skins='%s' WHERE id=%d AND typ=2", skins, org);
    mysql_query(query);
}

//end