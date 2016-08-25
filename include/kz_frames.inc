/*##############################################################################


						###############################
						#                             #
						#    FRAMES CREATOR BY YOM    #
						#                             #
						###############################


- Informations about this file:
===============================

	-	This include file allow you to create frames just by writing
		Frame("My frame"); or Frame("My frame", .type=SIMPLE_2);
		or Frame("My frame", 5, DOUBLE_1); (see the example below)

	-	There is a default start position (which is 2) that you can alter by
		modifying the value of '#define frame_start'. Also you can change this
		position into the function itself, by adding an optional parameter like
		Frame("My frame",1); . Try it because i can't explain clearly :)
		
	-	The string is limited to 256 characters, and the start position to 32.

	-	To make frame without any bugs, follow these instructions (for Windows):
		- Start -> Run -> cmd,
		- Right click on the top of the window and choose Properties,
		- In Configuration -> Buffer memory size -> change the values to 300.
		- You can change the window size and colors if you want...
		- Click on OK, choose 'Save properties for all windows', then OK.

	-	The idea comes from Mabako's Master Eye script, thanks to him. In a
		first try i made this function using #define, it was a bit bugged and
		not so 'powerful' than now.
		
	-	Pretty useless include, because only you can see the frames :)



- Copyright:
============

	-	Yom Productions © ®.
	-	You can use this script and distribute it but,
	-	You WILL NOT sell it or tell it is your own work.



- Versions changes:
===================
	- 1.1 :	Changed frame functions to a single function
	- 1.0 :	Initial release.
	
	
- Example of usage:
=================

Copy/Paste that into a empty script, compile it as test.amx, change server.cfg then run your server:


#include a_samp
#include yom_frames

public OnFilterScriptInit()
{
	print("\n");
	Frame(" FIRST, LOOK AT THE CODE AS WELL AS THE SERVER WINDOW, SO YOU WILL UNDERSTAND BETTER ", 0);
	print("\n");
	Frame("First test frame, start at default position and with default type");
	Frame("Second test frame, start at position 4 and with type 'SIMPLE_2'", 4, SIMPLE_2);
	Frame("Third test frame, start at position 0 and type 'DOUBLE_1'", 0, DOUBLE_1);
	Frame("Same as third test, but notice (in the code) how you can change arguments positions.", .type=DOUBLE_1, .start=0);
	print("\n");
}


##############################################################################*/

// Change this number as you like, this is the default start position
#define frame_start 2

//These are the available frame types
enum
{
	SIMPLE_1 = 1,
	SIMPLE_2,
	DOUBLE_1
}


/*########################### Native definitions #############################*/

/*
native Frame(string[], start=frame_start, type=SIMPLE_1);
*/


/*############################# Main function ################################*/

stock Frame(string[], start=frame_start, type=SIMPLE_1)
{
	new string_len = strlen(string),
		frame_beg = start,
		frame_len = string_len + start + 1,
		frame_str[290],
		frame_spc[34],
		frame_chr[6],
		frame_idx;

	if (start < 0 || start > 32 || string_len > 256)
		return printf ("Error: couldn't create the frame for:\n%s\n\
						start:%d/32 - strlen:%d/256",string,start,string_len);

	start +=1;

	if (type == SIMPLE_1)
		frame_chr = {218,191,196,179,192,217};

	else if (type == SIMPLE_2)
		frame_chr = {'+','+','-','|','+','+'};

	else if (type == DOUBLE_1)
		frame_chr = {201,187,205,186,200,188};



	for(frame_idx = 0; frame_idx < frame_len; frame_idx++)
		frame_str[frame_idx] = ' ';

	frame_str[frame_beg] = frame_chr[0];
	frame_str[frame_len] = frame_chr[1];

	for(frame_idx = start; frame_idx < frame_len; frame_idx++)
		frame_str[frame_idx] = frame_chr[2];

	print(frame_str);


	
	for(frame_idx = 0; frame_idx < frame_len; frame_idx++)
		frame_str[frame_idx] = string[frame_idx];

	for(frame_idx = 0; frame_idx < start; frame_idx++)
		frame_spc[frame_idx] = ' ';

	strins(frame_str,frame_spc,0);
	frame_str[frame_beg] = frame_str[frame_len] = frame_chr[3];

	print(frame_str);



	for(frame_idx = 0; frame_idx < frame_len; frame_idx++)
		frame_str[frame_idx] = ' ';

	frame_str[frame_beg] = frame_chr[4];
	frame_str[frame_len] = frame_chr[5];

	for(frame_idx = start; frame_idx < frame_len; frame_idx++)
		frame_str[frame_idx] = frame_chr[2];

	print(frame_str);

	return 1;
}
