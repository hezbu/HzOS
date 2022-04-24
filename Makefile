.PHONY:clean edit bless bochs

LINKER_OBJECTS = ./bin/init16.o ./bin/reset.o
LINKER_SCRIPT = ./linker.lds
LINKER_DEPENDENCIES = init16 reset
LINKER_ENTRY_POINT = Reset
OUTPUT = bios.bin 


$(OUTPUT): $(LINKER_DEPENDENCIES)
	@echo Generando $@...
	ld -z max-page-size=0x01000 --oformat=binary -m elf_i386 -T $(LINKER_SCRIPT) -e $(LINKER_ENTRY_POINT) $(LINKER_OBJECTS) -o ./bin/$(OUTPUT)


init16: ./src/init16.asm
	mkdir -p ./bin
	@echo Generando $@.asm...
	nasm -f elf32 ./src/$@.asm -o ./bin/$@.o

reset:  ./src/reset.asm
	mkdir -p ./bin
	@echo Generando $@.asm...
	nasm -f elf32 ./src/$@.asm -o ./bin/$@.o
bless:
	bless ./bin/bios.bin

clean:
	rm -f -r ./src/*.lst ./bin/*.elf ./bin/*.o

edit:
	kate ./src/*.asm ./src/*.c ./src/*.cpp ./src/*.h ./src/*.inc ./src/*.lst Makefile linker.lds bochsrc

bochs:
	bochs -f bochsrc