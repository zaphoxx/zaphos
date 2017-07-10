CC=gcc
AS=nasm

C_SOURCES=$(wildcard kernel/*.c drivers/*.c)
AS_SRCS=$(wildcard boot/*.asm)
HEADERS=$(wildcard kernel/*.h drivers/*.h)
OBJ=${C_SOURCES:.c=.o}
AS_FLAGS=-felf
CC_FLAGS=-m32 -ffreestanding -Ttext 0x1000 -c
LD_FLAGS=-melf_i386 -Ttext 0x1000 --oformat binary

run: all
	qemu disk.img

all: clean disk.img clean

disk.img: boot.bin kernel.bin
	cat $^ > $@

%.bin: $(AS_SRCS)
	$(AS) -fbin $< -o ./$@

%.o : %.asm
#kernel_entry.o: ./kernel/kernel_entry.asm
	$(AS) $(AS_FLAGS) $< -o $@
# NOTE: you can not just use %.o : %.c %.h 
%.o:%.c $(HEADERS)
#kernel.o: kernel/kernel.c
	$(CC) $(CC_FLAGS) $< -o $@ 							# make sure to use the -m32 with gcc
																					# and -melf_i386 with ld to align the
																					# object file formats

#low_level.o: kernel/low_level.c
#	gcc -m32 -ffreestanding -c $< -o ./$@

kernel.bin: kernel_entry.o $(OBJ)#kernel.o low_level.o
	ld $(LD_FLAGS) $^ -o ./$@

clean:
	rm -f ./*.o ./kernel/*.o
	rm -f ./*.bin ./boot/*.bin
	rm -f ./*.img
