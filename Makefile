
all: disk.img

run: disk.img
	qemu $<

disk.img: boot.bin kernel.bin
	cat $^ > $@ 	

boot: boot.bin

kernel: kernel.bin

boot.bin: ./boot/boot.asm
	nasm -fbin $< -o ./$@

kernel.o: ./kernel/kernel.c
	gcc -ffreestanding -c $< -o ./$@

kernel.bin: kernel.o
	ld -Ttext 0x1000 --oformat binary $< -o ./$@

clean:
	rm -f ./*.o
	rm -f ./*.bin
