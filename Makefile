CC=gcc
AS=nasm

C_SOURCES=$(wildcard kernel/*.c drivers/*.c)
HEADERS=$(wildcard kernel/*.h drivers/*.h)
OBJ=${C_SOURCES:.c=.o}

run: all
	qemu disk.img

all: clean disk.img

disk.img: boot.bin kernel.bin
	cat $^ > $@

boot.bin: ./boot/boot.asm
	nasm -fbin $< -o ./$@

kernel_entry.o: ./kernel/kernel_entry.asm
	nasm -felf $< -o $@

kernel.o: kernel/kernel.c
	gcc -m32 -ffreestanding -c $< -o ./$@

low_level.o: kernel/low_level.c
	gcc -m32 -ffreestanding -c $< -o ./$@

kernel.bin: kernel_entry.o kernel.o low_level.o
	ld -melf_i386 -Ttext 0x1000 --oformat binary $^ -o ./$@

clean:
	rm -f ./*.o
	rm -f ./*.bin
