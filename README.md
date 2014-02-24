dynamic
=======

Dynamic programming algorithms implementations.

From the main file:

This module is an implementation of many dynamic algorithms, using the language Haskell.
The combination of varying-indexed arrays (e.g., dims can be ((0,0), (n,m)) or ((1,1), (n,m)) etc.)
and list comprehensions---essentially allowing for very concise nested for-loops---unite to
lead to very terse, but expressive code.

Moreover, the arrays in Haskell are fittingly "write-once", very befitting of dynamic programming.

But most importantly, it seems to me that Haskell's syntax leads to a very nice division of concern.
In defining the array we can express the order of iteration (sometimes very important) within the list
comprehension, and express the actual sub-problem recurrence in a separate clause.

Here, for instance, all of the "recurrences" present in the dynamic programming algorithms are isolated
in the "where" clauses---thus a single line captures the real "magic" of dynamic programming.

Terseness rarely helps students, but I hope that---in conjunction with more verbose implementations as
shown in textbooks and online---these minimalist implementations provide a useful perspective.

For now, all these algorithms are from the Dasgupta Papadimitriou Vazirani textbook, but I intend to add more.
Note that these functions simply return the TABLE, it is up to the user to use that table to extract the solution.
