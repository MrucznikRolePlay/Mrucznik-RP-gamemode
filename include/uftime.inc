//-------------------------------------------------------------------------------

stock ConvertSeconds(time) //By El Presy
{
	new string[40];
	if(time < 60)
	    format(string, sizeof(string), "%d seconds", time);
 	else if(time == 60)
 	    string = "1 minute";
	else if(time > 60 && time < 3600){
	    new Float: minutes;
	    new seconds;
	    minutes = time / 60;
	    seconds = time % 60;
	    format(string, sizeof(string), "%.0f minutes and %d seconds", minutes, seconds);
	}else if(time == 3600)
	    string = "1 hour";
	else if(time > 3600){
	    new Float: hours;
	    new minutes_int;
	    new Float: minutes;
	    new seconds;
	    hours = time / 3600;
	    minutes_int = time % 3600;
	    minutes = minutes_int / 60;
	    seconds = minutes_int % 60;
	    format(string, sizeof(string), "%.0f hours, %.0f minutes and %d seconds", hours, minutes, seconds);
	}
	return string;
}
native ConvertSeconds(time);

//-------------------------------------------------------------------------------

stock timeconvert_seconds(time) //By Sacky
{
new minutes;
new seconds;
new string[256];
if(time > 60){
minutes = floatround(time/60);
seconds = floatround(time - minutes*60);
format(string,sizeof(string),"~b~%d:%d",minutes,seconds);
}
else{
seconds = floatround(time);
format(string,sizeof(string),"~b~%d",seconds);
}
return string;
}
native timeconvert_seconds(time);

//-------------------------------------------------------------------------------

stock timeconvert(Time, &Minutes, &Seconds, &MSeconds) // by Dabombber
{
	new Float:fTime = floatdiv(Time, 60000);
    Minutes = floatround(fTime, floatround_tozero);
    Seconds = floatround(floatmul(fTime - Minutes, 60), floatround_tozero);
    MSeconds = floatround(floatmul(floatmul(fTime - Minutes, 60) - Seconds, 1000), floatround_tozero);
}
native timeconvert(Time, &Minutes, &Seconds, &MSeconds);

//-------------------------------------------------------------------------------

stock time(timestamp,monthlengh = 30) //by [NB]Boylett
{
new ctime[7];
ctime[6] = timestamp;
while((ctime[6] - 60) >= 0)
{
    ctime[6] -= 60;
    ctime[5]++;
}
while((ctime[5] - 60) >= 0)
{
    ctime[5] -= 60;
    ctime[4]++;
}
while((ctime[4] - 24) >= 0)
{
    ctime[4] -= 24;
    ctime[3]++;
}
while((ctime[3] - 7) >= 0)
{
    ctime[3] -= 7;
    ctime[2]++;
}
while((ctime[2] - monthlengh) >= 0)
{
    ctime[2] -= monthlengh;
    ctime[1]++;
}
while((ctime[1] - 12) >= 0)
{
    ctime[1] -= 12;
    ctime[0]++;
}
return ctime;
}
native time(timestamp,monthlengh = 30);

//-------------------------------------------------------------------------------

stock GetWeekdayNum(d,m,y) //by d.wine
{
m-=2;
if(m<=0)
{
y--;
m+=12;
}
new cen = y/100;
y=getrem(y,100);
new w = d + ((13*m-1)/5) + y + (y/4) + (cen/4) - 2*cen;
w=getrem(w,7);
if (w==0) w=7;
return w;
}
native GetWeekdayNum(d,m,y);

//-------------------------------------------------------------------------------

stock GetWeekday(d,m,y) //by d.wine
{
new wd[7][16]=
{
"Monday",
"Tuesday",
"Wednesday",
"Thursday",
"Friday",
"Saturday",
"Sunday"
};
return wd[GetWeekdayNum(d,m,y)-1];
}
native GetWeekday(d,m,y);

//-------------------------------------------------------------------------------

stock GetTodayWeekdayNum() //by d.wine
{
new y,m,d;
getdate(y,m,d);
return GetWeekdayNum(d,m,y);
}
native GetTodayWeekdayNum();

//-------------------------------------------------------------------------------
/*
stock GetTodayWeekday() //by d.wine
{
new y,m,d;
getdate(y,m,d);
new day[16];
day = GetWeekday(d,m,y);
return day;
}
native GetTodayWeekday();
*/
//-------------------------------------------------------------------------------

stock getrem(a,b) //by d.wine
{
new div = a/b;
new left = a-b*div;
return left;
}
native getrem(a,b);

//-------------------------------------------------------------------------------

stock RealTime() //by Sacky
{
	new hour,minute,second;
	gettime(hour,minute,second);
	SetWorldTime(hour);
}
native RealTime();

//-------------------------------------------------------------------------------

stock Wait(time) //by Unnamed
{
	new stamp = tickcount();
    while (tickcount() - stamp < time){}
    return 1;
}
native Wait(time);

//-------------------------------------------------------------------------------

stock GetWorldTime() //by !damo!spiderman
{
 new buffer[6], worldtime;
 GetServerVarAsString("worldtime", buffer, 6);
 worldtime = strval(buffer);
 return worldtime;
}
native GetWorldTime();

//-------------------------------------------------------------------------------

stock ConvertMS(time) //by Pixels^ and Xtreme
{
  new string[256];	
  format(string,sizeof(string),"%d",time/1000);
  return string;
}
native ConvertMS(time);

//-------------------------------------------------------------------------------

stock ConvertSecondsEx(time) //by Pixels^ and Xtreme
{
  new string[256];
  format(string,sizeof(string),"%d",time * 1000);
  return string;
}
native ConvertSecondsEx(time);

//-------------------------------------------------------------------------------

stock ConvertMinutes(time) //by Pixels^ and Xtreme
{
  new string[256];
  format(string,sizeof(string),"%d",time / 60);
  return string;
}
native ConvertMinutes(time);

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
