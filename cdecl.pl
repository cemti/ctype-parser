% C Data Types Parser (c) Cristian Cemirtan 2023
number([A|B], B) :- number(A).
text([A|B], B) :- string(A).

sign --> ['signed']; ['unsigned'].
tLength --> ['short']; ['long']; ['long long'].
fType --> ['void']; ['char']; ['int']; ['float']; ['double'].
sType --> (['struct']; ['union']; ['enum']), (text, (scope; []); scope).
qualifier --> (['const']; ['volatile']; ['restrict']), (qualifier; []).
sQualifier --> ['static']; ['auto']; ['register']; ['extern'].
inline --> ['inline'].

typedef --> ['typedef'], variables.

parameters --> ['...'].
parameters --> declaration, ([','], parameters; []).
functionParameters --> ['('], (parameters; []), [')'].
arraySize --> ['['], (number; []), [']'].

% bits: 0 - fType,  1 - struct, 2 - inline, 3 - length/type
parseInitialType(Flags) -->
    (
		fType, { _flagsL = 1 };
		sType, { _flagsL = 4 };
		(tLength; sign), { _flagsL = 2 };
    	inline, { _flagsL = 8 };
    	(qualifier; sQualifier), { _flagsL = 0 }
    ),
    (parseInitialType(_flagsR), { 0 is _flagsL /\ _flagsR, Flags is _flagsL \/ _flagsR }; { Flags is _flagsL }).

initialType(Inline) -->
    parseInitialType(_flags),
    { _flagsT is _flags /\ 7, (_flagsT >= 1, _flagsT =< 4), Inline is (_flags >> 3) /\ 1 }.

initialType --> initialType(_).

postTypeComposite --> (functionParameters; arraySize), (postTypeComposite; []).

postType --> postTypeComposite.
postType --> ['('], postType, [')'], (postTypeComposite; []).
postType --> (text; qualifier; ['*']), (postType; []).

declaration --> initialType, (postType; []).

postTypes --> postType, ([','], postTypes; []).
declarations --> initialType, postTypes, [';'].

variables --> declarations, (variables; []).

scope --> ['{'], (variables; []), ['}'].