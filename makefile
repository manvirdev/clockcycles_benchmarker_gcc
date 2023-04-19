SFLAGS = -S -O2
OFLAGS = -g -c
CFLAGS = -o x
	
all: x	

x: main.o sumPlus.o 
	gcc $(CFLAGS) main.o sumPlus.o -lm

main.o:	main.s
	gcc $(OFLAGS) main.s

main.s:	main.c
	gcc $(SFLAGS)  main.c

sumPlus.o: sumPlus.s
	gcc $(OFLAGS) sumPlus.s

clean:	
	rm -f *.o x
