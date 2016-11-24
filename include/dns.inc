/*
 * Copyright (C) 2012 Incognito
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <a_samp>

// Natives

native dns(const host[], extra = 0);
native rdns(const ip[], extra = 0);

// Callbacks

forward OnDNS(host[], ip[], extra);
forward OnReverseDNS(ip[], host[], extra);

// Stock Function

stock GetPlayerHost(playerid)
{
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	rdns(ip, playerid);
	return 1;
}
