//regexps.pwn

new Regex:NICK_REGEXP;
new Regex:OPIS_CHARACTERS_REGEXP;

//CheckEmoji
new Regex:REGEX_LAUGH;
new Regex:REGEX_TONGUE;
new Regex:REGEX_XD;
new Regex:REGEX_WINK;
new Regex:REGEX_WINKLAUGH;
new Regex:REGEX_WINKTONGUE;
new Regex:REGEX_SMILE;
new Regex:REGEX_SAD;
new Regex:REGEX_O;
new Regex:REGEX_KISS;
new Regex:REGEX_V;
new Regex:REGEX_S;
new Regex:REGEX_3;
new Regex:REGEX_o_O;

InitRegexps()
{
	NICK_REGEXP = Regex_New("^[A-Z]{1}[a-z]{1,}(_[A-Z]{1}[a-z]{1,}([A-HJ-Z]{1}[a-z]{1,})?){1,2}$");

	OPIS_CHARACTERS_REGEXP = Regex_New("([^a-zA-Z0-9πÊÍ≥ÒÛúøü•∆ £—”åØè |\\//@:;+?!,.&\\(\\)\\[\\]\\-])");

	//CheckEmoji
	REGEX_LAUGH = Regex_New(":[dD]+");
	REGEX_TONGUE = Regex_New(":[pP]+");
	REGEX_XD = Regex_New("[xX][dD]+");
	REGEX_WINK = Regex_New(";\\)+");
	REGEX_WINKLAUGH = Regex_New(";[dD]+");
	REGEX_WINKTONGUE = Regex_New(";[pP]+");
	REGEX_SMILE = Regex_New(":\\)+");
	REGEX_SAD = Regex_New(":\\(+");
	REGEX_O = Regex_New(":[oO]+");
	REGEX_KISS = Regex_New(":\\*+");
	REGEX_V = Regex_New(":[vV]+");
	REGEX_S = Regex_New(":[sS]+");
	REGEX_3 = Regex_New(":3+");
	REGEX_o_O = Regex_New("[oO]_[oO]");
}