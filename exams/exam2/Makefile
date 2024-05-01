CC=as
LL=ld
OBJ=obj/putstring.o obj/String_length.o obj/putch.o obj/ascint64.o obj/int64asc.o obj/getstring.o obj/hex64asc.o obj/string.o

all: EXAM2

EXAM2: EXAM2.o string.o
	$(LL) -o build/EXAM2 /usr/lib/aarch64-linux-gnu/libc.so.6 build/EXAM2.o $(OBJ) -dynamic-linker /lib/ld-linux-aarch64.so.1

string.o: string.s
	$(CC) -g -o obj/string.o string.s

EXAM2.o: EXAM2.s
	$(CC) -g -o build/EXAM2.o EXAM2.s

clean:
	rm build/*.o
	rm build/EXAM2
