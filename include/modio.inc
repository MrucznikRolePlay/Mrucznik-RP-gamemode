/*==============================================================================


	Southclaw's Modular Binary IO Library

		Description...


==============================================================================*/


#include <YSI\y_hooks>


#if !defined MODIO_FILE_STRUCTURE_VERSION
	#define MODIO_FILE_STRUCTURE_VERSION (10)
#endif

#if !defined MAX_MODIO_TAGS
	#define MAX_MODIO_TAGS (64)
#endif

#define MAX_MODIO_HEADER_SIZE (MAX_MODIO_TAGS * 2)

#if !defined MAX_MODIO_STACK_SIZE
	#define MAX_MODIO_STACK_SIZE (4096)
#endif

#if !defined MAX_MODIO_SESSION
	#define MAX_MODIO_SESSION (32)
#endif

#if !defined MODIO_DEBUG
	#define MODIO_DEBUG (0)
#endif

#if !defined MAX_FILE_PATH
	#define MAX_FILE_PATH (128)
#endif

#if !defined MODIO_SCRIPT_EXIT_FIX
	#define MODIO_SCRIPT_EXIT_FIX (1)
#endif


// Usage: _T<X,X,X,X> where X is any ASCII character.
// Just shifts the bytes together into a nice 32 bit cell.
// To be used for the tag parameter so you can name tags.
#define _T<%0,%1,%2,%3> (('%0'<<24)|('%1'<<16)|('%2'<<8)|('%3'))


// Quick and dirty debug print. Levels range from 0 to 5
#define dp:%0(%1) if(modio_debug>=%0)printf(%1)


static
		// Write session data
		modio_wHeader			[MAX_MODIO_SESSION][MAX_MODIO_HEADER_SIZE],
		modio_wHeaderIndex		[MAX_MODIO_SESSION],
		modio_wSessionTags		[MAX_MODIO_SESSION][MAX_MODIO_TAGS],
		modio_wSessionTagIndex	[MAX_MODIO_SESSION],
		modio_wStack			[MAX_MODIO_SESSION][MAX_MODIO_STACK_SIZE],
		modio_wStackIndex		[MAX_MODIO_SESSION],
		modio_wSessionPath		[MAX_MODIO_SESSION][MAX_FILE_PATH],
		modio_wActive			[MAX_MODIO_SESSION],
		modio_wFinaliseTimer	[MAX_MODIO_SESSION] = {-1, ...},
		modio_wSessions,
		modio_wSessionLowest,
		modio_wSessionHighest,
		modio_wLastSession = -1,
bool:	modio_wScriptExiting,

		// Read session data
		modio_rStack			[MAX_MODIO_SESSION][MAX_MODIO_STACK_SIZE],
		modio_rStackIndex		[MAX_MODIO_SESSION],
		modio_rSessionPath		[MAX_MODIO_SESSION][MAX_FILE_PATH],
		modio_rActive			[MAX_MODIO_SESSION],
		modio_rFinaliseTimer	[MAX_MODIO_SESSION] = {-1, ...},
		modio_rSessions,
		modio_rSessionLowest,
		modio_rSessionHighest,
		modio_rLastSession,

		// Misc
		modio_debug = MODIO_DEBUG;


forward __modio_finalise_write(session, close_session);
forward __modio_finalise_read(session);


/*==============================================================================

	Writing

==============================================================================*/


stock modio_push(file[], tag, length, data[], forcewrite = false, forceclose = true, autowrite = true)
{
	new session;

	dp:1("[MODIO:PUSH] Pushing to file '%s' forcing write: %d forcing session close: %d", file, forcewrite, forceclose);

	// Check if there are any sessions open
	if(modio_wSessions > 0)
	{
		// Check if this file is already in use
		session = modio_getsession_write(file);

		// If not, register a new session
		if(session == -1)
		{
			session = modio_register_write(file);
			dp:2("[MODIO:SESSION:%02d] Registering new write session", session);
		}
		else
		{
			dp:2("[MODIO:SESSION:%02d] Pushing to existing write session", session);
		}
	}
	else
	{
		// If no sessions are open, register a new one
		session = modio_register_write(file);
		dp:2("[MODIO:SESSION:%02d] Registering first write session", session);
	}

	if(session == -1)
		return 0;

	modio_wLastSession = session;

	if(modio_wActive[session] == 0)
	{
		dp:2("[MODIO:SESSION:%02d] Initializing modio stack push", session);
		modio_wActive[session] = 1;

		modio_wHeader[session][0] = MODIO_FILE_STRUCTURE_VERSION;
		modio_wHeader[session][1] = 0;
		modio_wHeaderIndex[session] = 3;
	}

	// Ensure the data doesn't violate the stack size
	if(modio_wStackIndex[session] + length >= MAX_MODIO_STACK_SIZE - 1)
	{
		printf("ERROR: Modio stack violation while trying to push %d cells (%d/%d)", length, modio_wStackIndex[session] + length, MAX_MODIO_STACK_SIZE);
		return 0;
	}

	// Check if the tag has already been used
	dp:4("[MODIO:SESSION:%02d] modio_wSessionTagIndex: %d", session, modio_wSessionTagIndex[session]);
	if(modio_wSessionTagIndex[session] > 0)
	{
		for(new i; i < modio_wSessionTagIndex[session]; i++)
		{
			dp:5("[MODIO:SESSION:%02d] Loop (%d/%d) comparing tags: %d == %d", session, i, modio_wSessionTagIndex[session], tag, modio_wSessionTags[session][i]);
			if(tag == modio_wSessionTags[session][i])
			{
				printf("ERROR: Attempted to overwrite tag: '%d' in file '%s' for session %d", tag, file, session);
				return -1;
			}
		}
	}

	// Add the tag data to the tag list
	modio_wSessionTags[session][modio_wSessionTagIndex[session]++] = tag;

	// Concatenate the tag, 4 packed characters into 1 32 bit cell
	modio_wStack[session][modio_wStackIndex[session]] = tag;
	modio_wStackIndex[session]++;

	// Concatenate the length of the data chunk
	modio_wStack[session][modio_wStackIndex[session]] = length;
	modio_wStackIndex[session]++;

	// Concatenate the data chunk
	new i;
	while(i < length)
	{
		modio_wStack[session][modio_wStackIndex[session]] = data[i];
		modio_wStackIndex[session]++;
		i++;
	}

	dp:1("[MODIO:SESSION:%02d] Pushing: %d cells under '%d' session: %d remaining: %d phys: %d tags: %d", session, length, tag, modio_wStackIndex[session], MAX_MODIO_STACK_SIZE - modio_wStackIndex[session], modio_wHeaderIndex[session] + modio_wStackIndex[session], modio_wSessionTagIndex[session]);

	if(forcewrite)
	{
		dp:2("[MODIO:SESSION:%02d] Forcing write (forcewrite)", session);
		modio_finalise_write(session, forceclose);
		return 1;
	}

	if(modio_wScriptExiting)
	{
		dp:2("[MODIO:SESSION:%02d] Forcing write (modio_wScriptExiting)", session);
		modio_finalise_write(session, 0);
		return 1;
	}

	if(autowrite)
	{
		if(modio_wFinaliseTimer[session] == -1)
		{
			dp:2("[MODIO:SESSION:%02d] Setting timer", session);
			modio_wFinaliseTimer[session] = SetTimerEx("__modio_finalise_write", 50, 0, "dd", session, forceclose);
		}
	}

	return 1;
}

stock modio_register_write(file[])
{
	if(modio_wSessions == MAX_MODIO_SESSION)
	{
		printf("ERROR: modio_wSessions has reached limit of %d, please increase MAX_MODIO_SESSION.", MAX_MODIO_SESSION);
		return -1;
	}

	new session = -1;

	// Clumsy way of finding the next inactive session
	for(new i; i <= modio_wSessionHighest + 1; i++)
	{
		dp:5("[MODIO:REGISTER:WRITE] Searching for next inactive session. Current: %d highest: %d", i, modio_wSessionHighest);
		if(!modio_wActive[i])
		{
			session = i;
			break;
		}
	}

	if(session == -1)
		return -1;

	modio_wSessionPath[session][0] = EOS;
	strcat(modio_wSessionPath[session], file);

	if(session > modio_wSessionHighest)
		modio_wSessionHighest = session;

	else if(session < modio_wSessionLowest)
		modio_wSessionLowest = session;

	modio_wSessions++;

	return session;
}

stock modio_getsession_write(file[])
{
	dp:2("[MODIO:GETSESSION:WRITE] Getting session ID for '%s'.", file);

	// Loop through the files, but start with the last used one as that is most
	// likely to be the required file.
	new
		i,
		session = modio_wLastSession == -1 ? modio_wSessionLowest : modio_wLastSession;

	while(i < modio_wSessions)
	{
		dp:5("[MODIO:GETSESSION:WRITE] Comparing '%s' with '%s' (session: %d)", file, modio_wSessionPath[session], session);
		if(modio_wActive[session])
		{
			if(!strcmp(file, modio_wSessionPath[session]))
			{
				dp:4("[MODIO:GETSESSION:WRITE] Compared '%s' with '%s' returning session %d", file, modio_wSessionPath[session], session);
				return session;
			}

			i++;
		}

		session++;

		if(session > modio_wSessionHighest)
			session = 0;
	}

	return -1;
}

#if MODIO_SCRIPT_EXIT_FIX == 1

	#if defined FILTERSCRIPT

		hook OnFilterScriptExit()
		{
			dp:1("[MODIO:HOOK] OnFilterScriptExit");

			modio_wScriptExiting = true;

			return 1;
		}
	/*
		public OnFilterScriptExit()
		{
			dp:1("[MODIO:HOOK] OnFilterScriptExit");

			#if defined modio_OnFilterScriptExit
				return modio_OnFilterScriptExit();
			#else
				return 1;
			#endif
		}
		#if defined _ALS_OnFilterScriptExit
			#undef OnFilterScriptExit
		#else
			#define _ALS_OnFilterScriptExit
		#endif
		 
		#define OnFilterScriptExit modio_OnFilterScriptExit
		#if defined modio_OnFilterScriptExit
			forward modio_OnFilterScriptExit();
		#endif
	*/
	#else

		hook OnGameModeExit()
		{
			dp:1("[MODIO:HOOK] OnGameModeExit");

			modio_wScriptExiting = true;

			return 1;
		}
	/*
		public OnGameModeExit()
		{
			dp:1("[MODIO:HOOK] OnGameModeExit");

			#if defined modio_OnGameModeExit
				return modio_OnGameModeExit();
			#else
				return 1;
			#endif
		}
		#if defined _ALS_OnGameModeExit
			#undef OnGameModeExit
		#else
			#define _ALS_OnGameModeExit
		#endif
		 
		#define OnGameModeExit modio_OnGameModeExit
		#if defined modio_OnGameModeExit
			forward modio_OnGameModeExit();
		#endif
	*/
	#endif

#endif

public __modio_finalise_write(session, close_session)
{
	modio_finalise_write(session, close_session);
}

modio_finalise_write(session, close_session = 1)
{
	dp:1("[MODIO:SESSION:%02d] Finalising write session for '%s'.", session, modio_wSessionPath[session]);

	if(!(0 <= session < MAX_MODIO_SESSION))
	{
		printf("ERROR: Tried to finalise invalid session (%d)", session);
		return;
	}

	// First tag physpos not offset from the start of the body.
	modio_wHeader[session][3] = modio_wSessionTags[session][0];
	modio_wHeader[session][4] = 0;
	modio_wHeaderIndex[session] = 5;

	dp:5("[MODIO:SESSION:%02d] Header tag 0: %d", session, modio_wHeader[session][4]);

	// i = tag index, j = tag physpos, k = data physpos
	// This loop starts on tag 1 at physpos 5 since the first tag is set above.
	for(new i = 1, j = 5; i < modio_wSessionTagIndex[session]; i++, j += 2)
	{
		// This cell contains the tag
		modio_wHeader[session][j] = modio_wSessionTags[session][i];

		// The next cell contains the tag's data's offset from the top of the
		// body of the file (the first tag is always at position 0)
		// I've never indented code like this but it makes it easier to comment!
		modio_wHeader[session][j + 1] =
			// This position is offset from the position of the previous tag
			// We start by getting that position from the previous cell
			modio_wHeader[session][j - 1] +
			// Then the size of that block needs to be added
			// The size of a block is stored right after the tag in the body.
			modio_wStack[session][
				// We use the previous cell again to get the position of the
				// block in the file
				modio_wHeader[session][j - 1] +
				// Then add 1 because the size of the block is in the next cell
				1
			] +
			// Then add 2 since the size of the block is only the size of the
			// data IN the block, the extra 2 cells contain the tag and the
			// block size.
			2;

		// Advance the header index by 2 (one for the tag and one for the pos)
		modio_wHeaderIndex[session] += 2;

		dp:5("[MODIO:SESSION:%02d] Header tag %d: %d offset: %d", session, i, modio_wHeader[session][j], modio_wStack[session][ modio_wHeader[session][j - 3] + 1 ]);
	}

	dp:1("[MODIO:SESSION:%02d] storing: header of size: %d, stack of size %d, tags: %d", session, modio_wHeaderIndex[session], modio_wStackIndex[session], modio_wSessionTagIndex[session]);

	// Assign sizes; done afterwards so wHeaderIndex is the correct value.
	modio_wHeader[session][1] = modio_wHeaderIndex[session] + modio_wStackIndex[session];
	modio_wHeader[session][2] = modio_wSessionTagIndex[session];

	// Write the 'stack' array to the file and free it.
	new File:file = fopen(modio_wSessionPath[session], io_write);

	if(!file)
	{
		printf("ERROR: Opening of '%s' failed.", modio_wSessionPath[session]);
		return;
	}

	// Write the header
	fblockwrite(file, modio_wHeader[session], modio_wHeaderIndex[session]);

	// Write the body
	fblockwrite(file, modio_wStack[session], modio_wStackIndex[session]);

	fclose(file);

	if(modio_debug >= 4)
	{
		for(new i; i < modio_wHeaderIndex[session]; i++)
			printf("[MODIO:SESSION:%02d] HEAD: [%02d]: %d", session, i, modio_wHeader[session][i]);

		for(new i; i < modio_wStackIndex[session]; i++)
			printf("[MODIO:SESSION:%02d] BODY: [%02d] [%02d]: %d", session, i+modio_wHeaderIndex[session], i, modio_wStack[session][i]);
	}

	if(close_session)
		modio_close_session_write(session);
}

stock modio_close_session_write(session)
{
	dp:1("[MODIO:SESSION:%02d] Closing write session for '%s'.", session, modio_wSessionPath[session]);

	if(!(0 <= session < MAX_MODIO_SESSION))
	{
		print("ERROR: Tried to close invalid session.");
		return 0;
	}

	KillTimer(modio_wFinaliseTimer[session]);

	modio_wHeaderIndex[session] = 0;
	modio_wSessionTagIndex[session] = 0;
	modio_wStackIndex[session] = 0;
	modio_wSessionPath[session][0] = EOS;
	modio_wActive[session] = 0;
	modio_wFinaliseTimer[session] = -1;

	modio_wSessions--;

	if(session == modio_wSessionHighest)
	{
		while(modio_wSessionHighest > modio_wSessionLowest && !modio_wActive[modio_wSessionHighest])
			modio_wSessionHighest--;

		dp:2("[MODIO:SESSION:%02d] New highest write session ID: %d", session, modio_wSessionHighest);
	}
	else if(session == modio_wSessionLowest)
	{
		while(modio_wSessionLowest < modio_wSessionHighest && !modio_wActive[modio_wSessionLowest])
			modio_wSessionLowest++;

		dp:2("[MODIO:SESSION:%02d] New lowest write session ID: %d", session, modio_wSessionLowest);
	}

	modio_wLastSession = -1;

	if(modio_wSessions < 0)
		modio_wSessions = 0;

	return 1;
}


/*==============================================================================

	Reading

==============================================================================*/


stock modio_read(file[], tag, data[], forceclose = false, autoclose = true)
{
	if(!fexist(file))
		return 0;

	new session;

	dp:1("[MODIO:READ] Reading file '%s'.", file);

	// Check if there are any sessions open
	if(modio_rSessions > 0)
	{
		// Check if this file is already in use
		session = modio_getsession_read(file);

		// If not, register a new session
		if(session == -1)
		{
			session = modio_register_read(file);
			dp:2("[MODIO:SESSION:%02d] Registering new read session", session);
		}
		else
		{
			dp:2("[MODIO:SESSION:%02d] Using existing read session", session);
		}
	}
	else
	{
		// If no sessions are open, register a new one
		session = modio_register_read(file);
		dp:2("[MODIO:SESSION:%02d] Registering first read session", session);
	}

	if(session == -1)
		return 0;

	modio_rLastSession = session;

	if(modio_rActive[session] == 0)
	{
		dp:2("[MODIO:SESSION:%02d] Initializing modio stack pull", session);
		modio_rActive[session] = 1;

		new
			File:f,
			tmp[2];

		f = fopen(file, io_read);

		if(!f)
		{
			printf("ERROR: Opening of '%s' failed.", file);
			return 0;
		}

		fblockread(f, tmp, 2);

		if(tmp[0] != MODIO_FILE_STRUCTURE_VERSION)
		{
			printf("ERROR: File structure version (%d) does not match modio version (%d)", tmp[0], MODIO_FILE_STRUCTURE_VERSION);
			fclose(f);
			modio_finalise_read(session);
			return 0;
		}

		modio_rStackIndex[session] = fblockread(f, modio_rStack[session], tmp[1]) + 2;

		if(modio_debug >= 4)
		{
			printf("[MODIO:SESSION:%02d] READ [00]: %d", session, tmp[0]);
			printf("[MODIO:SESSION:%02d] READ [01]: %d", session, tmp[1]);

			for(new i; i < modio_rStackIndex[session]; i++)
				printf("[MODIO:SESSION:%02d] READ [%02d]: %d", session, i, modio_rStack[session][i]);
		}

		fclose(f);

		dp:2("[MODIO:SESSION:%02d] Extracting '%s': %d tags, size: %d", session, file, modio_rStack[session][0], modio_rStackIndex[session]);
	}

	// Search for the tag in the header
	new physpos = -1;
	for(new i; i < modio_rStack[session][0]; i++)
	{
		dp:5("[MODIO:SESSION:%02d] Loop (%d/%d) comparing tags: %d == %d", session, i, modio_rStack[session][0], tag, modio_rStack[session][(i * 2) + 1]);

		if(modio_rStack[session][(i * 2) + 1] == tag)
		{
			physpos = modio_rStack[session][(i * 2) + 2] + (modio_rStack[session][0] * 2) + 1;
			dp:5("[MODIO:SESSION:%02d] Found tag, headersize: %d, physpos: %d", session, (modio_rStack[session][0] * 2) + 1, physpos);
			break;
		}
	}

	dp:1("[MODIO:SESSION:%02d] Reading '%d': %d cells from physpos %d", session, tag, modio_rStack[session][physpos + 1], physpos);

	if(physpos > -1)
	{
		// Extract the data from the physical position
		// Could use memcpy here but it needs a speed test
		for(new i; i < modio_rStack[session][physpos + 1]; i++)
			data[i] = modio_rStack[session][physpos + 2 + i];
	}
	else
	{
		printf("ERROR: Tag '%d' not found in buffer.", tag);
		return 0;
	}

	if(forceclose)
	{
		dp:2("[MODIO:SESSION:%02d] Force-closing read session.", session);
		modio_finalise_read(session);
	}
	else if(autoclose)
	{
		// Close the session after any other reads
		if(modio_rFinaliseTimer[session] == -1)
			modio_rFinaliseTimer[session] = SetTimerEx("__modio_finalise_read", 50, 0, "d", session);
	}

	// Return the amount of cells read
	return modio_rStack[session][physpos + 1];
}

public __modio_finalise_read(session)
{
	modio_finalise_read(session);
}

modio_finalise_read(session)
{
	dp:1("[MODIO:SESSION:%02d] Finalising read session for '%s'.", session, modio_rSessionPath[session]);
	KillTimer(modio_rFinaliseTimer[session]);

	modio_rStackIndex[session] = 0;
	modio_rSessionPath[session][0] = EOS;
	modio_rActive[session] = 0;
	modio_rFinaliseTimer[session] = -1;

	modio_rLastSession = 0;

	if(session == modio_rSessionHighest)
	{
		while(modio_rSessionHighest > 0 && !modio_rActive[modio_rSessionHighest])
			modio_rSessionHighest--;

		dp:2("[MODIO:SESSION:%02d] New highest read session ID: %d", modio_rSessionHighest);
	}
	else if(session == modio_rSessionLowest)
	{
		while(modio_rSessionLowest < modio_rSessionHighest && !modio_rActive[modio_rSessionLowest])
			modio_rSessionLowest++;

		dp:2("[MODIO:SESSION:%02d] New lowest read session ID: %d", session, modio_rSessionLowest);
	}

	modio_rSessions--;
}

stock modio_register_read(file[])
{
	dp:1("[MODIO:SESSION:%02d] Registering new session.", modio_rSessions);

	if(modio_rSessions == MAX_MODIO_SESSION)
	{
		printf("ERROR: modio_rSessions has reached limit of %d, please increase MAX_MODIO_SESSION.", MAX_MODIO_SESSION);
		return -1;
	}

	new session = -1;

	// Clumsy way of finding the next inactive session
	for(new i; i <= modio_rSessionHighest + 1; i++)
	{
		dp:5("[MODIO:REGISTER:READ] Searching for next inactive session. Current: %d highest: %d", i, modio_rSessionHighest);
		if(!modio_rActive[i])
		{
			session = i;
			break;
		}
	}

	if(session == -1)
		return -1;

	modio_rSessionPath[session][0] = EOS;
	strcat(modio_rSessionPath[session], file);

	if(session > modio_rSessionHighest)
		modio_rSessionHighest = session;

	else if(session < modio_rSessionLowest)
		modio_rSessionLowest = session;

	modio_rSessions++;

	return session;
}

stock modio_getsession_read(file[])
{
	// Loop through the files, but start with the last used one as that is most
	// likely to be the required file.
	new
		i,
		session = modio_rLastSession;

	while(i < modio_rSessions)
	{
		if(modio_rActive[session])
		{
			if(!strcmp(file, modio_rSessionPath[session]))
			{
				dp:4("[MODIO:GETSESSION:READ] Compared '%s' with '%s' returning session %d", file, modio_rSessionPath[session], session);
				return session;
			}
		}

		session++;

		if(session == modio_rSessionHighest)
			session = 0;

		i++;
	}

	return -1;
}

#undef dp
