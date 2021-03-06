.PHONY:clean edit bless bochs

LINKER_OBJECTS = ./bin/init16.o ./bin/utils16_asm.o ./bin/init32.o ./bin/reset.o \
./bin/utils16_c.o ./bin/utils32_c.o	./bin/gdt16.o

LINKER_SCRIPT = ./sup/linker.ld
LINKER_DEPENDENCIES = init16 init32 reset utils16_asm utils32_c utils16_c gdt16
LINKER_ENTRY_POINT = Reset

C_COMPILER = gcc
C_COMPILER_OPTIONS= -m32 -c -fno-builtin

ASM_COMPILER = nasm
ASM_COMPILER_OPTIONS = -f elf32

OUTPUT = bios.bin 


$(OUTPUT): $(LINKER_DEPENDENCIES)
	@echo Generando $@...
	ld -z max-page-size=0x01000 --oformat=binary -m elf_i386 -T $(LINKER_SCRIPT) -e $(LINKER_ENTRY_POINT) $(LINKER_OBJECTS) -o ./bin/$(OUTPUT) -Map ./sup/bios.map

createDir:
	mkdir -p ./bin

init16: ./src/init16.asm createDir
	@echo Generando $@.asm...
	$(ASM_COMPILER) $(ASM_COMPILER_OPTIONS) ./src/$@.asm -o ./bin/$@.o

init32: ./src/init32.asm createDir
	@echo Generando $@.asm...
	$(ASM_COMPILER) $(ASM_COMPILER_OPTIONS) ./src/$@.asm -o ./bin/$@.o

utils16_asm: ./src/utils16.asm createDir
	@echo Generando utils16.asm...
	$(ASM_COMPILER) $(ASM_COMPILER_OPTIONS) ./src/utils16.asm -o ./bin/$@.o

gdt16: ./src/gdt16.asm createDir
	@echo Generando $@.asm...
	$(ASM_COMPILER) $(ASM_COMPILER_OPTIONS) ./src/$@.asm -o ./bin/$@.o

utils16_c: ./src/utils16.c createDir
	@echo Generando utils16.c...
	$(C_COMPILER) $(C_COMPILER_OPTIONS) ./src/utils16.c -o ./bin/$@.o 

utils32_c: ./src/utils32.c createDir
	@echo Generando utils32.c...
	$(C_COMPILER) $(C_COMPILER_OPTIONS) ./src/utils32.c -o ./bin/$@.o 


reset:  ./src/reset.asm createDir
	@echo Generando $@.asm...
	$(ASM_COMPILER) $(ASM_COMPILER_OPTIONS) ./src/$@.asm -o ./bin/$@.o
bless:
	bless ./bin/bios.bin

hexdump:
	hexdump ./bin/bios.bin

clean:
	rm -f -r ./src/*.lst ./bin/*.elf ./bin/*.o

edit:
	kate ./src/*.asm ./src/*.c ./src/*.cpp ./src/*.h ./src/*.inc ./src/*.lst Makefile linker.lds bochsrc

bochs:
	bochs -f bochsrc