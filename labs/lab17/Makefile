CC=g++
OBJ=obj/string.o

all: lab17

lab17: lab17.o string.o 
	$(CC) -o build/lab17 build/lab17.o $(OBJ)

lab17.o: src/lab17.cpp
	$(CC) -c -o build/lab17.o src/lab17.cpp

string.o: src/string.s
	$(CC) -c -o obj/string.o src/string.s

clean:
	rm build/*.o
	rm build/lab17
