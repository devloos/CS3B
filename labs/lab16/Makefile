CC=as
LL=ld
OBJ=obj/putstring.o obj/String_length.o obj/putch.o obj/ascint64.o obj/int64asc.o obj/getstring.o obj/string-copy.o

all: lab16

lab16: string-copy.o lab16.o
	$(LL) -o build/lab16 /usr/lib/aarch64-linux-gnu/libc.so.6 build/lab16.o $(OBJ) -dynamic-linker /lib/ld-linux-aarch64.so.1

lab16.o: lab16.s
	$(CC) -g -o build/lab16.o lab16.s

string-copy.o: string-copy.s
	$(CC) -g -o obj/string-copy.o string-copy.s

clean:
	rm build/*.o
	rm build/lab16
