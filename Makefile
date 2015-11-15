.PHONY:clean edit bless bochs

LINKER_OBJECTS = ./bin/init16.o ./bin/utils16.o ./bin/init32.o ./bin/reset.o
LINKER_SCRIPT = ./linker.lds
LINKER_DEPENDENCIES = init16 init32 reset utils16
LINKER_ENTRY_POINT = Reset

C_COMPILER = gcc
C_COMPILER_OPTIONS= -m32 -c

ASM_COMPILER = nasm
ASM_COMPILER_OPTIONS = -f elf32

OUTPUT = bios.bin 


$(OUTPUT): $(LINKER_DEPENDENCIES)
	@echo Generando $@...
	ld -z max-page-size=0x01000 --oformat=binary -m elf_i386 -T $(LINKER_SCRIPT) -e $(LINKER_ENTRY_POINT) $(LINKER_OBJECTS) -o ./bin/$(OUTPUT)


init16: ./src/init16.asm
	@echo Generando $@.asm...
	$(ASM_COMPILER) $(ASM_COMPILER_OPTIONS) ./src/$@.asm -o ./bin/$@.o

init32: ./src/init32.asm
	@echo Generando $@.asm...
	$(ASM_COMPILER) $(ASM_COMPILER_OPTIONS) ./src/$@.asm -o ./bin/$@.o

utils16: ./src/utils16.asm
	@echo Generando $@.asm...
	$(ASM_COMPILER) $(ASM_COMPILER_OPTIONS) ./src/$@.asm -o ./bin/$@.o

reset:  ./src/reset.asm
	@echo Generando $@.asm...
	$(ASM_COMPILER) $(ASM_COMPILER_OPTIONS) ./src/$@.asm -o ./bin/$@.o
bless:
	bless ./bin/bios.bin

clean:
	rm -f -r ./src/*.lst ./bin/*.elf ./bin/*.o

edit:
	kate ./src/*.asm ./src/*.c ./src/*.cpp ./src/*.h ./src/*.inc ./src/*.lst Makefile linker.lds bochsrc

bochs:
	bochs -f bochsrc