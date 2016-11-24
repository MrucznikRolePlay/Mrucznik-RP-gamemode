/*
# Selling of this is not aloud
# XFuncs No warrenties given
# Created by Pixels^ and X-Treme
*/

#if defined _XFuncs_included
  #endinput
#endif

stock SetPlayerMoney(playerid,howmuch) {
  new money = GetPlayerMoney(playerid); 
  GivePlayerMoney(playerid,howmuch-money);
}

stock SetTeamPos(team,Float:x,Float:y,Float:z) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerPos(i,x,y,z);
      }
    }
  }
}

stock SetTeamInterior(team,interiorid) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerInterior(i,interiorid);
      }
    }
  }
}

stock SendMessageForTeam(team,color,const string[]) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SendClientMessage(i,color,string);
      }
    }
  }
}    
  
stock GameTextForTeam(team,const string[],style,time) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        GameTextForPlayer(i,string[],style,time);
      }
    }
  }
}   

stock SendAdminMessage(text[],color) {
  for(new i = 0; i < MAX_PLAYERS; i++) {
    if(IsPlayerConnected  && IsPlayerAdmin) {
      SendClientMessage(i,color,text[0])
    }
  }
}          	

stock SetTeamHealth(team,Float:Health) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerHealth(i,Health);
      }
    }
  }
}

stock KillTeam(team) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerHealth(i,0);
      }
    }
  }
}

stock KickAll() {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i) && IsPlayerAdmin(i) == 0) {
        Kick(i);
     }
  }
}

stock DisableCheckpoints() {
	for(new i = 0; i < MAX_PLAYERS; i++) DisablePlayerCheckpoint ;
}

stock SetCheckpoint(Float:x,Float:y,Float:z,Float:size) {
  for(new i=0; i<MAX_PLAYERS; i++) {  
    if(IsPlayerConnected(i)) {
      SetPlayerCheckpoint(i,x,y,z,size);
    }
  }
}

stock ReturnCoords(playerid) {
	new Float:X,Float:Y,Float:Z,Float:A,string[256];
	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,A);
	format(string,sizeof(string),"X: %0.2f || Y: %0.2f || Z: %0.2f || Angle: %0.2f",X,Y,Z,A);
	SendClientMessage(playerid,0xFFFF00AA,string);
}

stock SetgTeam(playerid,team) {
  if(IsPlayerConnected(playerid)) {
    gTeam[playerid] = team;
  }
  else {
    return false;
}

stock ColorAll(color) {
	for(new i=0; i < MAX_PLAYERS; i++) SetPlayerColor(i,color);
}

stock SetTeamColor(team,color) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerColor(i,color);
      }
    }
  }
}

stock SetTeamCheckpoint(team,Float:x,Float:y,Float:z,Float:size) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerCheckpoint(i,x,y,z,size);
      }
    }
  }
}

stock DisableTeamCheckpoint(team) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        DisablePlayerCheckpoint(i);
      }
    }
  }
}

stock SetTeamMoney(team,howmuch) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        GivePlayerMoney(playerid,howmuch-GetPlayerMoney(i));
      }
    }
  }
}

stock ResetTeamMoney(team) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        GivePlayerMoney(playerid,-GetPlayerMoney(i));
      }
    }
  }
}

stock GiveTeamMoney(team,howmuch) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        GivePlayerMoney(playerid,howmuch);
      }
    }
  }
}

stock PlaySoundForTeam(team,soundid) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        PlayerPlaySound(playerid,soundid,0,0,0);
      }
    }
  }
}

stock CheckDivisible(dividend,divisor)
	if (dividend / divisor) == 1 {
		return true;
	}
	else {
		return false;
	}
}

stock GetRemainder(dividend,divisor) {
	return (dividend % divisor)
}

stock Ratio(data1,data2) {
  new string[256];
  new Float:ratio = floatdiv(data1,data2);
  format(string,sizeof(string),"%.2f",ratio);
  return string;
}

stock GiveWeapon(playerid,w1,a1,w2,a2,w3,a3) {
  GivePlayerWeapon(playerid,w1,a1);
  GivePlayerWeapon(playerid,w2,a2);
  GivePlayerWeapon(playerid,w3,a3);
}

stock SetPosInteriorAngle(playerid,Float:x,Float:y,Float:z,Float:angle,interiorid) {
  SetPlayerInterior(playerid,interiorid);
  SetPlayerFacingAngle(playerid,angle);
  SetPlayerPos(playerid,x,y,z);	
}

stock GiveTeamWeapon(team,w1,a1) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        GivePlayerWeapon(i,w1,a1);
      }
    }
  }
}

stock SetTeamCameraPos(team,Float:x,Float:y,Float:z) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        SetPlayerCameraPos(i,x,y,z);
      }
    }
  }
}

stock FreezeTeam(team,bool:toggle) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        if(toggle == true) {
          TogglePlayerControllable(i,0);
        }
        else {
          TogglePlayerControllable(i,1);
        }
      }
    }
  }
}


stock ToggleTeamVisibility(team,bool:visible) {
  new color = GetPlayerColor(i); 
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        if(toggle == true) {
          SetPlayerColor(i,0xFF000000);
        }
        else {
          SetPlayerColor(i,color);
        }
      }
    }
  }


stock SpamTeam(team) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
        for(new s=0; s<12; s++) {
          SendClientMessage(i,0xFFFF00AA,"spam spam spam spam");
        }
      }
    }
  }


stock KickTeam(team) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          Kick(i);
        }
      }
    }
  }


stock BanTeam(team) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          Ban(i);
      }
    }
  }
}


Stock SetTeamSpawnInfo(team,modelid,Float:x,Float:y,Float:z,Float:angle,w1,a1,w2,a2,w3,a3) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          SetSpawnInfo(i,-1,modelid,x,y,z,angle,w1,a1,w2,a2,w3,a3);
      }
    }
  }
}

stock SetTeamScore(team,score) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          SetPlayerScore(i,score);
        }
      }
    }
  }

stock IsTeamInCheckpoint(team) {
  new t = 0;
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          if(IsPlayerInCheckpoint(i) {
            t++;
          }
        }
      }
    }
  return t;
}

stock SetTeamWorldBounds(team,Float:xmin,Float:xmax,Float:ymin,Float:ymax) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          SetPlayerWorldBounds(i,xmin,xmax,ymin,ymax);
        }
      }
    }
  }

stock SetTeamFacingAngle(team,Float:angle) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          SetPlayerFacingAngle(i,angle);
        }
      }
    }
  }

stock SetVehicleParamsForTeam(team,vehicleid,objective,locked) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          SetVehicleParamsForPlayer(vehicleid,i,objective,locked);
        }
      }
    }
  }

stock GetTeamPlayerAmount(team) {
  new a = 0;
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(gTeam[i] == team) {
          Sa++;
        }
      }
    }
  }
  return a;
}

stock GameTextForAdmin(const string[],style,time) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(IsPlayerAdmin(i)) {
        GameTextForPlayer(i,string[0],style,time);
      }
    }
  }
}

stock SetCheckpointForAdmin(Float:x,Float:y,Float:z,Float:size) { 
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(IsPlayerAdmin(i)) {
        SetPlayerCheckpoint(i,x,y,z,size);
      }
    }
  }
}

stock DisableCheckpointForAdmin() {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(IsPlayerAdmin(i)) {
        DisablePlayerCheckpoint(i);
      }
    }
  }
}

stock SetAdminColor(color) {
  for(new i=0; i<MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i)) {
      if(IsPlayerAdmin(i)) {
        SetPlayerColor(i,color);
      }
    }
  }
}

stock Respect(playerid,bool:amount) {
  if(r == 0) { 
    return false;
  }
  if(amount == true) {
    Respect[playerid]++;
  }
  else {
    Respect[playerid]--;
  }
}

stock SetRespect(playerid,amount) {
  if(r == 0) { 
    return false;
  }
  Respect[playerid] = amount;
}

stock ResetRespect(playerid) {
  if(r == 0) { 
    return false;
  }
  Respect[playerid] = 0;
}

stock SaveRespect(playerid) {
 if(r == 0) { 
   return false;
 }
 GetPlayerName(playerid,p,24);
 dini_Create(udb_encode(p));
 return dini_IntSet(udb_encode(p),"Respect",Respect[playerid]);
}

stock ShowRespect(playerid) {
  format(string,sizeof(string),"*%d*",Respect[playerid]);
  return string;
}

stock Respect(bool:toggle) {
  if(toggle == true) {
    r = 0;
  }
  else {
    r = 1;
}

stock ShowRatio(playerid,data1,data2) {
  new string[256];
  new Float:ratio = floatdiv(data1,data2);
  format(string,sizeof(string),"%.2f",ratio);
  return SendClientMessage(playerid,0xFFFF00AA,string);
}

stock ClearChat() {
  for(new i=0; i<12; i++) {
    SendClientMessageToAll(0xFFFF00AA,"");
  }
}

stock IsColor(playerid,color) {
  if(color == GetPlayerColor(playerid)) {
    return true;
  }
  else {
    return false;
  }
}

stock IsgTeam(playerid,team) {
  if(gTeam[playerid] == team) {
    return true;
  }
  else {
    return false;
  }
}  

stock IsHealth(playerid,Float:Health) {
  new Float:hlth;
  if(GetPlayerHealth(playerid,hlth) == Health) {
    return true;
  }
  else {
    return false;
}

stock IsScore(playerid,score) {
  if(GetPlayerScore(playerid) == score) {
    return true;
  }
  else {
    return false;
}

stock ConvertMS(time) {
  new string[256];	 
  format(string,sizeof(string),"%d",time/1000);
  return string;
}

stock QuadFormula(a,b,c) {
  new Float:yos, Float:neg, string[256];
  yos = ((-1*b) + (floatsqroot((B^2)*(4*a*c)) / (2*a))
  neg = ((-1*b) - (floatsqroot((B^2)*(4*a*c)) / (2*a))
  format(string,sizeof(string),"%.2f, %.2f",yos,neg);
  return string;
}

stock multiply(data1,data2) {
  format(string,sizeof(string),"%d",data1 * data2);
  return string;
}

stock ConvertSeconds(time) {
  format(string,sizeof(string),"%d",time * 1000);
  return string;
}

stock ConvertMinutes(time) {
  format(string,sizeof(string),"%d",time / 60);
  return string;
}

stock IntDivide(data1,data2) {
  format(string,sizeof(string),"%0.f",data1 / data2);
  return string;
}

stock Add(data1,data2) {
  format(string,sizeof(string),"%d",data1 + data2);
  return string;
}

stock Subtract(data1,data2) {
  format(string,sizeof(string),"%d",data1 - data2);
  return string;
}

stock AddScore(playerid,score) {
  SetPlayerScore(playerid,GetPlayerScore(playerid) + score);
  return 1;
}

stock Divide(data1,data2) {
  format(string,sizeof(string),"%d",data1 - data2);
  return string;
}

stock Square(Float:num) {
  format(string,sizeof(string),"%.2f",floatsqroot(num));
  return string;
}

stock FloatDecrease(Float:data1,Float:data2) {
  format(string,sizeof(string),"%.2f",floatsub(data1, data2));
  return string;
}

stock Factorial(value) {
  new data;
  for(new i = 0; i <= value; i++) data *= i;
  return data;
}

stock SearchAndDelete(const string[],const sub[]) {
  new tmp[256];
  if(strfind(string[0], sub[0], true)) {
    tmp = strlen(sub[0]);
    strdel(string[0], sub[0], strval(tmp));
    return true;
  }
  else {
    return false;
  }
}

stock IsSize(const string[],size) {
  if(sizeof(string[0]) == size) {
    return true;
  }
  else {
    return false;
  }
}

stock CombineString(const string[], const str[]) {
  strins(string[0], str[0], str[]);
}

stock IsStringLength(const string[], length) {
  if(strlen(string[0]) == length) {
    return true;
  }
  else {
    return false;
  }
}

stock IsFloatSize(Float:value,size) {
  if(floatabs(value) == size) {
    return true;
  }
  else { 
    return false
  }
}

stock IsFloatBigger(float:data1,Float:data2) {
  if(data1 > data2) {
    return true;
  }
  else {
    return false;
  }
}

stock IsFloatSmaller(float:data1,Float:data2) {
  if(data1 < data2) {
    return true;
  }
  else {
    return false;
  }
}

stock Strsub(const string[], const sub[]) {
  if(strfind(string[0], sub[0], true)) {
    return true;
  }
  else {
    return false;
  }
}

stock FloatMutliply(Float:data1,Float:data2) {
  format(string,sizeof(string),"%.2f",floatmul(dasta1,data2));
  return string;
}

stock FloatDivide(Float:data1,Float:data2) {
  format(string,sizeof(string),"%.2f",floatdiv(dasta1,data2));
  return string;
} 

stock MulStrings(const string[], const str[]) {
  tmp = strlen(string[0]);
  tmp1 = strlen(strp[0]);
  format(string,sizeof(string),"%d",strval(tmp) * strval(tmp1));
  return string;
}

stock MultiNumeric(d1,d2,d3,d4,d5,d6) {
  format(string,sizeof(string),"%d",d1 * d2 * d3 * d4 * d5 * d6);
  return string;
}

stock NumLength(data1) {
  return strlen(data1);
}    

stock NumExt(const string[], const sub[])
  tmp = strlen(sub[0]); 
  tmp2 = strmid(string[0], sub[0], sub[0], strval(tmp));
  format(string,sizeof(string),"%d",strval(tmp2));
  return string;
}

stock CreateAndIntSet(filename[],key[],val[]) {
  new File:f;
  if (fexist(filename)) return false;
  f=fopen(filename,io_write);
  fclose(f);
  if (key[0]==0) {
    return false;
  }
  format(tmpres,sizeof(tmpres),"%s.part",filename);
  fohnd=fopen(filename,io_read);
  format(tmpres,sizeof(tmpres),"%s=%s",key,value);
  fwrite(fwhnd,tmpres);
  fwrite(fwhnd,"\r\n");
}

stock CreateAndFloatSet(filename[],key[],Float:value) {
   new string[MAX_STRING];
   format(string,sizeof(valuestring),"%f",value);
   return CreateAndIntSet(filename,key,string);
}

stock CreateAndNumSet(filename[],key[],Float:value) {
   new string[MAX_STRING];
   format(string,sizeof(valuestring),"%d",value);
   return CreateAndIntSet(filename,key,string);
}
