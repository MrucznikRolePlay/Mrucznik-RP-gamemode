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

stock Redis_IncrBy(const key[], value)
{
	new string[128];
	format(string, sizeof(string), "INCRBY %s %d", key, value);
	Redis_Command(RedisClient, string);
}

stock Redis_Delete(const key[])
{
	new string[128];
	format(string, sizeof(string), "DEL %s", key);
	Redis_Command(RedisClient, string);
}

// Expires key, default ttl = 1 month.
stock Redis_Expire(const key[], ttl=2629800)
{
	new string[128];
	format(string, sizeof(string), "EXPIRE %s %d", key, ttl);
	Redis_Command(RedisClient, string);
}

// ------------[ Redis with Cache ]------------
// -------[ use when key is read often ]-------
stock CRedis_GetInt(const key[], &value)
{
	if(MAP_contains_str(RedisCache_Int, key))
	{
		value = MAP_get_str_val(RedisCache_Int, key);
		return;
	}

	return Redis_GetInt(RedisClient, key, value);
}

stock CRedis_GetFloat(const key[], &Float:value)
{
	if(MAP_contains_str(RedisCache_Float, key))
	{
		value = MAP_get_str_val(RedisCache_Float, key);
		return;
	}

	return Redis_GetFloat(RedisClient, key, value);
}

stock CRedis_GetString(const key[], value[], len = sizeof(value))
{
	if(MAP_contains_str(RedisCache_String, key))
	{
		MAP_get_str_arr(RedisCache_Float, key, value, len);
		return;
	}

	return Redis_GetString(RedisClient, key, value, len);
}

stock CRedis_SetInt(const key[], value)
{
	MAP_insert_str_val(RedisCache_Int, key, value);
	return Redis_SetInt(RedisClient, key, value);
}

stock CRedis_SetFloat(const key[], Float:value)
{
	MAP_insert_str_val(RedisCache_Int, key, value);
	return Redis_SetFloat(RedisClient, key, value);
}

stock CRedis_SetString(const key[], const value[], len = sizeof(value))
{
	MAP_insert_str_arr(RedisCache_Int, key, value, len);
	return Redis_SetString(RedisClient, key, value);
}

stock CRedis_IncrBy(const key[], value)
{
	new currentVal = MAP_get_str_val(RedisCache_Int, key);
	new newVal = currentVal + value;
	MAP_insert_str_val(RedisCache_Int, key, newVal);
	return Redis_SetInt(RedisClient, key, newVal);
}

//end