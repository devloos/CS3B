link: main
	@echo "Linking files now..."
	g++ -o main main.o

main: main.s
	@echo "Compiling main.s..."
	g++ -c -o main.o main.s

clean:
	@echo "Cleaning Directory..."
	rm main.o main
