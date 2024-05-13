CC=g++ -O3
OBJ=obj/putstring.o obj/String_length.o obj/putch.o obj/ascint64.o obj/int64asc.o obj/getstring.o obj/hex64asc.o obj/menu.o build/main.o obj/algorithms.o obj/asm-algorithms.o

all: main

main: menu.o algorithms.o asm-algorithms.o main.o
	$(CC) -o build/main $(OBJ) 

menu.o: src/menu.cpp
	$(CC) -c src/menu.cpp -o obj/menu.o

algorithms.o: src/algorithms.cpp
	$(CC) -c src/algorithms.cpp -o obj/algorithms.o

asm-algorithms.o: src/asm-algorithms.s
	as -g -o obj/asm-algorithms.o src/asm-algorithms.s

main.o: src/main.cpp
	$(CC) -c src/main.cpp -o build/main.o

clean:
	rm build/*.o
	rm build/main
