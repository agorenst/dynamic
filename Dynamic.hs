import Data.Array

{-
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
-}


{-
The matrix-chain algorithm as described in DPV.
The input format is a bit unintuitive:
for the list: "example = [50, 20, 1, 10, 100]", that means we want to multiply a list of matrices
of the form 50x20 * 20x1 * 1x10 * 10x100. Observe that a length-n list implies there are n-1 matrices.
-}
matrixChain m =
    let n = length m-1 -- number of matrices
        c = array ((1,1), (n,n))
            ([((i,i), 0) | i <- [1..n]] ++ -- base case
             [((j,i), -1) | i <- [1..n], j <- [i+1..n]] ++ -- if we want to print the whole matrix, we need to define every elt
             [((i,i+s), recurrence i (i+s)) | s <- [1..n-1], i <- [1..n-s]])
                where recurrence i j = minimum [ c!(i,k) + c!(k+1,j) + m!!(i-1) * m!!j * m!!k | k <- [i..j-1]]
        in c

clrsexample = [30,35,15,5,10,20,25]
example = [50, 20, 1, 10, 100]


{-
Edit distance as described in DPV
-}
editDistance diff x y =
    let m = length x
        n = length y
        e = array ((0,0), (m,n))
              ([((i,0), i) | i <- [0..m]] ++ [((0,j),j) | j <- [0..n]] ++
               [((i,j), (recurrence i j)) | i <- [1..m], j <- [1..n]])
                    where recurrence i j = minimum [e!(i-1,j)+1, e!(i,j-1)+1, e!(i-1,j-1) + (diff (x!!(i-1)) (y!!(j-1)))]
    in e

{- The "cost" function when two characters in a string differ, used in editdistance. -}
diff :: Char -> Char -> Int
diff char1 char2 = if char1 == char2 then 0 else 1

editdistanceexample = print $ editDistance diff "polynomial" "exponential" --chainMatrix clrsexample

{- The standard algorithm. -}
longestIncreasingSubsequence x =
    let n = length x
        l = array (1, n) [(j, recurrence j) | j <- [1..n]]
                -- we add 0 to the list as the "base case" indicating we don't have an valid prefixes
                where recurrence j = 1 + maximum (0:[l!i | i <- [1..j], x!!(i-1) < x!!(j-1)])
        in l

lisexample = [5,2,8,6,3,6,9]


{-
Knapsack, our psuedopolynomial algorithm.
A point of frustration: the recurrence here we have to explicitly extract the
item's weight and value (uj, vj) and pass it into the recurrence. Is there a better way?
-}
-- items = [(weight, value)]
knapsack w items =
    let n = length items
        k = array ((0,0), (w, n))
            ([((0,j), 0) | j <- [0..n]] ++ [((i,0),0) | i <- [0..w]] ++
             [((u,j), recurrence uj vj u j) | j <- [1..n], u <- [1..w], let (uj, vj) = items!!(j-1)])
                where recurrence uj vj u j = if uj > u then k!(u, j-1) else maximum [k!(u,j-1), (k!(u-uj, j-1) + vj)]
                    --let (uj, vj) = items!!(j-1) in
    in k

itemsexample = [(6, 30), (3,14), (4, 16), (2, 9)]
-- found this one in an online lecture. It was provided with a solution.
otherexample = [(5, 10), (4, 40), (6, 30), (3, 50)]



-- fairly staid, really just a way of testing.
--main = print $ longestIncreasingSubsequence lisexample
main = print $ knapsack 10 otherexample
