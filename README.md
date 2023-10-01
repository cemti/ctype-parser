# Introducere
Programul, scris în limbajul Prolog (<b>SWI-Prolog</b>), implementează un set de fapte și reguli, ce reprezintă vocabularul limbajului C utilizat pentru a compune un tip de date.
În această implementare, un tip de date se descompune în două părți: tipul inițial și post-tip:
<ul>
<li>Tipul inițial cuprinde tipul de date fundamental (int, char, etc.), lungimea tipului, specificatorul de semn și lungime, și specificatorii de acces și stocare;</li>
<li>Post-tipul cuprinde denumirea variabilei, asteriscuri (pointeri), seturi de argumente, și lungimile de tablou.</li>
</ul>
Vedeți articolul publicat: https://ibn.idsi.md/vizualizare_articol/186077

# Testare
<pre>
?- phrase(declarations, [int, *, "a", ',', '(', *, "b", ')', ';']).
true.

?- phrase(declarations, [struct, "nume", '{', int, "camp", ';', '}', "structura", ';']).
true.

?- phrase(initialType, [const, volatile, int]).
true.

?- phrase(initialType, [const, int, int]).
false.

?- phrase(declaration, [int, "main", '(', int, "argc", ',', char, *, "argv", '[', ']', ')']).
true.

?- phrase(declaration, [int, "main", '(', int, "argc", ',', char, *, "argv", '[', int, ']', ')']).
false.

?- phrase(declaration, [int, '(', '*', B, C, ']' ]).
B = ')',
C = '[' ;
false.

?- phrase(sType, [struct, "test", A, int, "camp", B, C]).
A = '{',
B = (;),
C = '}' .
</pre>
