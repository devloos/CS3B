CC=as
LL=ld
OBJ=obj/putstring.o obj/String_length.o obj/putch.o obj/ascint64.o obj/int64asc.o obj/getstring.o

all: lab15

lab15: lab15.o
	$(LL) -o build/lab15 build/lab15.o $(OBJ)

lab15.o: lab15.s
	$(CC) -g -o build/lab15.o lab15.s

clean:
	rm build/*.o
	rm build/lab15
