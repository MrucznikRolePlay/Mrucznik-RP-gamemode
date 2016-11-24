enum E_SSCANF_ERROR
{
	OK,
	ERROR_NOT_INITIALISED, // "UNFORMAT_Init" not yet called.
	ERROR_MISSING_PARAMETERS, // Not enough parameters given.
	ERROR_NO_SPECIFIER, // No specifier passed.
	ERROR_NO_COMPILE, // Unspecified compilation error.
	ERROR_UNKNOWN_ERROR, // Generic catch-all.
	ERROR_MEMORY_ALLOCATION_FAIL, // std::bad_alloc (untested).
	ERROR_NAN, // Could not evaluate the string as a number.
	ERROR_INVALID_ESCAPE, // Found '\\Q', where 'Q' is not valid.
	ERROR_UNCLOSED_CHARACTER_LIT, // Found 'a, with no close '.
	ERROR_NO_DEFAULT_START, // No ( on defaults.
	ERROR_NO_DEFAULT_END, // No ) on defaults.
	ERROR_NO_GROUP_END, // No ) on groupings.
	ERROR_NO_ARRAY_START, // No [ on arrays.
	ERROR_NO_ARRAY_END, // No ] on arrays.
	ERROR_NO_PARAM_START, // No < on parameters.
	ERROR_NO_PARAM_END, // No > on parameters.
	ERROR_NO_STRING_END, // No ' on stringa.
	ERROR_INVALID_ARRAY_SIZE, // [] or [0].
	ERROR_EXPECTED_A_GOT_B_1, // Expected "A", got "B".
	ERROR_EXPECTED_A_GOT_B_2, // Expected "A", got "B".
	ERROR_RAN_TRIVIAL, // Called "Run" on a trivial specifier.
	ERROR_INVALID_MEMORY, // There's no valid memory location available;
	ERROR_NO_STRING_MATCH, // Can't match "'xyz'".
	ERROR_NO_STRING_LITERAL, // Found '' as a string literal.
	ERROR_UNKNOWN_SPECIFIER, // Found an unrecognised letter.
	ERROR_INVALID_SPECIFIER, // Letter out of range.
	ERROR_DUPLICATE_SPECIFIER, // Two things the same.
	ERROR_PARSE_SEQUENTIAL_GROUP, // Tried to call "ReadToken" on "SequentialGroup",
	ERROR_NO_CHILD, // "-" "Run" called with no child set up.
	ERROR_NO_CHILDREN, // Alt branch with no children.
	ERROR_OUT_OF_VARIABLES
}

stock UNFORMAT_GetError(E_SSCANF_ERROR:error)
{
	static const
		scErrors[E_SSCANF_ERROR][32] =
			{
				"OK",
				"ERROR_NOT_INITIALISED", // "UNFORMAT_Init" not yet called.
				"ERROR_MISSING_PARAMETERS", // Not enough parameters given.
				"ERROR_NO_SPECIFIER", // No specifier passed.
				"ERROR_NO_COMPILE", // Unspecified compilation error.
				"ERROR_UNKNOWN_ERROR", // Generic catch-all.
				"ERROR_MEMORY_ALLOCATION_FAIL", // std::bad_alloc (untested).
				"ERROR_NAN", // Could not evaluate the string as a number.
				"ERROR_INVALID_ESCAPE", // Found '\\Q'", where 'Q' is not valid.
				"ERROR_UNCLOSED_CHARACTER_LIT", // Found 'a", with no close '.
				"ERROR_NO_DEFAULT_START", // No ( on defaults.
				"ERROR_NO_DEFAULT_END", // No ) on defaults.
				"ERROR_NO_GROUP_END", // No ) on groupings.
				"ERROR_NO_ARRAY_START", // No [ on arrays.
				"ERROR_NO_ARRAY_END", // No ] on arrays.
				"ERROR_NO_PARAM_START", // No < on parameters.
				"ERROR_NO_PARAM_END", // No > on parameters.
				"ERROR_NO_STRING_END", // No ' on stringa.
				"ERROR_INVALID_ARRAY_SIZE", // [] or [0].
				"ERROR_EXPECTED_A_GOT_B_1", // Expected "A"", got "B".
				"ERROR_EXPECTED_A_GOT_B_2", // Expected "A"", got "B".
				"ERROR_RAN_TRIVIAL", // Called "Run" on a trivial specifier.
				"ERROR_INVALID_MEMORY", // There's no valid memory location available;
				"ERROR_NO_STRING_MATCH", // Can't match "'xyz'".
				"ERROR_NO_STRING_LITERAL", // Found '' as a string literal.
				"ERROR_UNKNOWN_SPECIFIER", // Found an unrecognised letter.
				"ERROR_INVALID_SPECIFIER", // Letter out of range.
				"ERROR_DUPLICATE_SPECIFIER", // Two things the same.
				"ERROR_PARSE_SEQUENTIAL_GROUP", // Tried to call "ReadToken" on "SequentialGroup"",
				"ERROR_NO_CHILD", // "-" "Run" called with no child set up.
				"ERROR_NO_CHILDREN", // Alt branch with no children.
				"ERROR_OUT_OF_VARIABLES" // No place to store remaining specifiers.
			},
		scFail[32] = "ERROR_UNKNOWN_ERROR";
	if (OK <= error < E_SSCANF_ERROR) return scErrors[error];
	return scFail;
}

stock UNFORMAT_PrintError(E_SSCANF_ERROR:error)
{
	static const
		scErrors[E_SSCANF_ERROR][50] =
			{
				"",
				"System not initialised.",
				"Insufficient parameters.",
				"Missing required specifier.",
				"Unknown compilation error.",
				"Unknown error.",
				"std::bad_alloc thrown.",
				"Input is not a number.",
				"Invalid escape sequence.",
				"Unclosed character literal.",
				"No default value found.",
				"Unclosed default value.",
				"Unclosed group.",
				"No array size found.",
				"Unclosed array size.",
				"Missing requried specifier parameter.",
				"Unclosed specifier parameter.",
				"Unclosed string literal.",
				"Invalid array size.",
				"Expected <string> got <char>.",
				"Expected <char> got <char>.",
				"Attempted to \"Run\" a Trivial Specifier.",
				"Cannot write to location.",
				"No string literal match found.",
				"Empty string literal given.",
				"Unknown format specifier '?'.",
				"Invalid specifier.",
				"Duplicate specifier.",
				"Tried to call \"ReadToken\" on a Sequential Group.",
				"Attempted to \"Run\" a specifier with no child.",
				"Empty alt branch.",
				"Insufficient destination variables given."
			},
		scFail[50] = "Unknown error.";
	if (OK <= error < E_SSCANF_ERROR) return scErrors[error];
	return scFail;
}

native E_SSCANF_ERROR:unformat(const input[], const format[], {Float, _}:...);

