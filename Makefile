.PHONY:clean edit

reset:  ./src/reset.asm
	@echo Generando reset.asm...
	nasm -f elf32 ./src/$@.asm -o ./bin/$@.o

clean:
	rm -f -r ./src/*.lst ./bin/*.elf ./bin/*.o

edit:
	kate ./src/*.asm ./src/*.c ./src/*.cpp ./src/*.h ./src/*.inc ./src/*.lst Makefile linker.lds