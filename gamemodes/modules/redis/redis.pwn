//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   redis                                                   //
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
// Data utworzenia: 24.03.2024
//Opis:
/*
	Baza danych key-value redis
*/

//

//-----------------<[ Funkcje: ]>-------------------
ConnectToRedis()
{

	new file[64];
	new host[32], password[128], port;
	format(file, sizeof(file), "redis.ini");
	if(dini_Exists(file)) 
	{
		strcat(host, dini_Get(file, "host"));
		port = dini_Int(file, "port");
		strcat(password, dini_Get(file, "password"));
	}

	Redis_Connect(host, port, password, RedisClient);

	new mrucznikRedis;
	Redis_GetInt(RedisClient, "server:mrucznik-redis", mrucznikRedis);
	if(mrucznikRedis != 1)
	{
		printf("cannot connect to redis or redis key server:mrucznik-redis is not 1");
		SendRconCommand("exit");
		return;
	}
	printf("REDIS: Po³¹czono siê z baz¹ redis");
	return;
}

Redis_IncrBy(const key[], value)
{
	new string[128];
	format(string, sizeof(string), "INCRBY %s %d", key, value);
	Redis_Command(RedisClient, string);
}

// Expires key, default ttl = 1 month.
Redis_Expire(const key[], ttl=2629800)
{
	new string[128];
	format(string, sizeof(string), "EXPIRE %s %d", key, ttl);
	Redis_Command(RedisClient, string);
}

//end