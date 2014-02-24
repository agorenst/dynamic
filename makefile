all: Dynamic.hs
	ghc Dynamic.hs
clean:
	rm -f *.hi *.o Dynamic
