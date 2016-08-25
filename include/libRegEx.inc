				///////////////////////////////////////////////////////////////////////////
				//				Author:	Koala											 //
				//				Release Website: Gta-Mp.ro								 //
				//				Release Date: 18/07/2014								 //
				//				Credits: -maddinat0r (Got the SDK from his github)		 //
				//						 -Incognito (I learned a lot from his github)	 //
				//						 -K.Kosako (Author of Oniguruma library)		 //
				//				Description: This plugins allows PAWN programers to		 //
				//							use the basic regex functions.				 //
				//                                                                       //
				//						Regular Expresion Library						 //
				//												v0.2                     //
				//                                                                       //
				//                                                                       //
				//                                                                       //
				//                                                                       //
				///////////////////////////////////////////////////////////////////////////



#if defined _REGEX_INC
	#endinput
#endif
#define _REGEX_INC

#pragma library libRegEx
//SYNTAXES
#define SYNTAX_PERL 			1
#define SYNTAX_RUBY 			2
#define SYNTAX_JAVA 			3
#define SYNTAX_GNU 				4
#define SYNTAX_GREP 			5
#define SYNTAX_EMACS 			6
#define SYNTAX_POSIX_EXTENDED 	7
#define SYNTAX_POSIX_BASIC 		8

//EXREPLACEALL
#define regex_exreplaceall(%0,%1,%2)				\
	do												\
	{												\
		regex_exreplace((%0),%1,(%2));				\
	}												\
	while(regex_exreplace((%0),%1,(%2))>=0)			
//===============================NATIVES===============================//
	//==========================FUNCTIONS==========================//
native regex_match(const string[], const RegularExpression[]);
native regex_search(const string[], const RegularExpression[], &startpos, &endpos);
native regex_replace(const string[], const RegularExpression[], const replacer[]);

native regex_end();
native regex_syntax(syntax);
native regex_exbuild(const RegularExpression[]);
native regex_set(const string[], RegularExpression);

native regex_exmatch(const string[], RegularExpression);
native regex_exsearch(const string[], RegularExpression, &startpos, &endpos);
native regex_exreplace(const string[], RegularExpression, const replacer[]);
	//==========================FUNCTIONS==========================//

	//===========================DETAILS==========================//
/*
*
*	Added since v0.2
	->regex_end() - This goes in your OnGameModeExit. It is important to put this function there if you don't want to deal with
					memory leackage problems. You can't use the regex functions after this function is called.
					
	->regex_syntax(syntax) - This usually goes in your OnGameModeInit, as it specifies the default syntax which will be used in 
							regex_exbuild. If it is needed, this can be used more times in your script.
		*syntax - This is a number from 1 to 8. I defined those in this include but if u're too lazy to scroll, let me help:
		**#define SYNTAX_PERL 					1
		**#define SYNTAX_RUBY 					2
		**#define SYNTAX_JAVA 					3
		**#define SYNTAX_GNU 					4
		**#define SYNTAX_GREP 					5
		**#define SYNTAX_EMACS 					6
		**#define SYNTAX_POSIX_EXTENDED 		7
		**#define SYNTAX_POSIX_BASIC 			8
	
	->regex_exbuild(const RegularExpression[]) - This function builds the regular expression and returns an unique number from 0-100.
											It is important that you store that number in a Global Variable so you can use it 
											anywhere in your script. As you can figure out, there's a limit of 100
											regex expressions that can be built. Also, if you build the expressions with this,
											it will use the syntax that you specified in regex_syntax. If none was specified, it
											will use the RUBY syntax. As character encoding, it uses UTF8.
		*const RegularExpression[] - The string that contains the Regular Expression(RegEx) syntax that will be built
		**Returns an unique number from 0-100 wich you'll need to store in an g-variable.
	
	->regex_set(const string[], RegularExpression) - Modifies an already created(with regex_exbuild) regex.
		*const string[] - The string that contains the Regular Expression(RegEx) syntax.
		**RegularExpression - The number(returned from regex_exbuild) that indicates the regex construction you want to change.
	
	->regex_exmatch(const string[], RegularExpression) - Same as regex_match, only that it uses a regex syntax already created with
														regex_exbuild. This is way faster.
														
	->regex_exsearch(const string[], RegularExpression, &startpos, &endpos) - Same as regex_search, only that it uses a regex syntax
																			already created with regex_exbuild. This is way faster.
	
	->regex_exreplace(const string[], RegularExpression, const replacer[]) - Same as regex_replace, only that it uses a regex syntax
																			already created with regex_exbuild. This is way faster.
																			
	->regex_exreplaceall(const string[], RegularExpression, const replacer[]) - Same as regex_exreplace, only that this replaces
																			all the substrings that are matching the regex. This
																			function is a simple define wich you can see up in this
																			include. This function stands only as an example. You
																			can do one on your own and use it.
	
****Added since v0.1 - I left those in the plugin only for testing purpose. I recommend you use the ones that i added in v0.2
	
	->regex_match(const string[], const RegularExpression[]) - Check if a string matches a regex.
		*const string[] - The string that you want to check.
		*const RegularExpression[] - The string that contains the Regular Expression(RegEx) syntax.
		**This function normally returns the length of the matching string. So the correct statement to check if a string
		 matches a regular expression is "if(regex_match(string, regex)>=0)".
		***In case that this function won't function correctly, it will return a value < 0 and you'll see an error in the
		  server log, that describes the problem. (Ex: "[REGEX ERROR]: unmatched close parenthesis").
		  
	->regex_search(const string[], const RegularExpression[], &startpos, &endpos) - Get the first and the last position of the first sub-string of the string,
																					that matches the regex.
		*const string[] - The string that you want to search in
		*const RegularExpression[] - The string that contains the Regular Expression(RegEx) syntax.
		*&startpos - An integer variable passed by reference that will contain the first(start) position of the first sub-string that matches
		 the search. If none is found, it will be -1.
		*&endpos - An integer variable passed by reference that will contain the last(end) position of the first sub-string that matches
		 the search. If none is found, it will be -1.
		**This function normally returns 1.
		***In case that this function won't function correctly, it will return -1 and you'll see an error in the
		  server log, that describes the problem. (Ex: "[REGEX ERROR]: unmatched close parenthesis").
		  
	->regex_replace(const string[], const RegularExpression[], const replacer[]) - Replace a sub-string of a string
		*const string[] - The string that you want to replace in
		*const RegularExpression[] - The string that contains the Regular Expression(RegEx) syntax.
		*const replacer[] - The string that you want to replace the sub-string found with.
		**This function normally returns the first position of the matching sub-string.
		***In case that this function won't function correctly, it will return -1 and you'll see an error in the
		  server log, that describes the problem. (Ex: "[REGEX ERROR]: unmatched close parenthesis").
		****The Oniguruma library is not providing a default function to do this, so i implemented a basic one
		   by myself.
*
*
*/
	//===========================DETAILS==========================//
//===============================NATIVES===============================//