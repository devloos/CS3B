CC=as
LL=ld
OBJ=obj/putstring.o obj/String_length.o obj/putch.o obj/ascint64.o obj/int64asc.o obj/getstring.o obj/hex64asc.o obj/shiv-functions.o obj/carlos-functions.o obj/linked-list.o

all: rasm4

rasm4: rasm4.o shiv-functions.o carlos-functions.o linked-list.o
	$(LL) -o build/rasm4 --entry=_main /usr/lib/aarch64-linux-gnu/libc.so.6 build/rasm4.o $(OBJ) -dynamic-linker /lib/ld-linux-aarch64.so.1

shiv-functions.o: src/functions/shiv-functions.s
	$(CC) -g -o obj/shiv-functions.o src/functions/shiv-functions.s

carlos-functions.o: src/functions/carlos-functions.s
	$(CC) -g -o obj/carlos-functions.o src/functions/carlos-functions.s

linked-list.o: src/linked-list.s
	$(CC) -g -o obj/linked-list.o src/linked-list.s

rasm4.o: src/rasm4.s
	$(CC) -g -o build/rasm4.o src/rasm4.s

clean:
	rm build/*.o
	rm build/rasm4
