#if defined _xtime_included
#endinput
#endif

#define _xtime_included
#pragma library xtime

/*
native GetMonthString(month);
native IsValidMonth(month);
native getday();
native gethour();
native getminute();
native getmonth();
native getsecond();
native getyear();
native RandomMonth();
native IsValidDay(day);
native RandomDay();
native GetDayString();
*/

new Months[12][] = {
{"Januray"},
{"February"},
{"March"},
{"April"},
{"May"},
{"June"},
{"July"},
{"August"},
{"September"},
{"October"},
{"November"},
{"Decembre"}
};

new Days[7][] = {
{"Monday"},
{"Tuesday"},
{"Wednesday"},
{"Thursday"},
{"Friday"},
{"Saturday"},
{"Sunday"}
};

gethour()
{
	new hour;
	gettime(hour);
	return hour;
}

getminute()
{
	new p, minute;
	gettime(p, minute);
	return minute;
}

getsecond()
{
	new p, second;
	gettime(p, p, second);
	return second;
}

getyear()
{
	new year;
	getdate(year);
	return year;
}

getmonth()
{
	new p, month;
	gettime(p, month);
	return month;
}

getday()
{
	new p, day;
	gettime(p, p, day);
	return day;
}

GetMonthString(month)
{
	return Months[month];
}

bool:IsValidMonth(month)
{
	if(month >= 0 && month <= 11) return true; // start at 0, so we can use arrays easier
	return false;
}

bool:IsValidDay(day)
{
	if(day >= 0 && day <= 6) return true; // start at 0, so we can use arrays easier
	return false;
}

GetDayString(day)
{
	return Days[day];
}

RandomMonth()
{
	return Months[random(12)];
}

RandomDay()
{
	return Days[random(7)];
}

#pragma unused GetMonthString
#pragma unused IsValidMonth
#pragma unused getday
#pragma unused gethour
#pragma unused getminute
#pragma unused getmonth
#pragma unused getsecond
#pragma unused getyear
#pragma unused RandomMonth
#pragma unused IsValidDay
#pragma unused RandomDay
#pragma unused GetDayString
