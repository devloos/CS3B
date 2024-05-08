CC=as
LL=ld
OBJ=obj/putstring.o obj/String_length.o obj/putch.o obj/ascint64.o obj/int64asc.o obj/getstring.o obj/hex64asc.o obj/print.o 

all: rasm5

rasm5: print.o rasm5.o 
	$(LL) -o build/rasm5 --entry=_main /usr/lib/aarch64-linux-gnu/libc.so.6 build/rasm5.o $(OBJ) -dynamic-linker /lib/ld-linux-aarch64.so.1

print.o: src/print.s
	$(CC) -g -o obj/print.o src/print.s

rasm5.o: src/rasm5.s
	$(CC) -g -o build/rasm5.o src/rasm5.s

clean:
	rm build/*.o
	rm build/rasm5
