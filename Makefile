
all: disk.img

run: disk.img
	qemu $<

disk.img: boot.bin kernel.bin
	cat $^ > $@ 	

boot: boot.bin

kernel: kernel.bin

boot.bin: ./boot/boot.asm
	nasm -fbin $< -o ./$@

kernel_entry.o: ./kernel/kernel_entry.asm
	nasm -felf $< -o $@

kernel.o: ./kernel/kernel.c
	gcc -m32 -ffreestanding -c $< -o ./$@

kernel.bin: kernel_entry.o kernel.o
	ld -m elf_i386 -Ttext 0x1000 --oformat binary $^ -o ./$@

clean:
	rm -f ./*.o
	rm -f ./*.bin
