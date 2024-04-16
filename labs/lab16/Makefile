CC=as
LL=ld
OBJ=obj/putstring.o obj/String_length.o obj/putch.o obj/ascint64.o obj/int64asc.o obj/getstring.o

all: lab16

lab16: lab16.o
	$(LL) -o build/lab16 build/lab16.o $(OBJ)

lab16.o: lab16.s
	$(CC) -g -o build/lab16.o lab16.s

clean:
	rm build/*.o
	rm build/lab16
