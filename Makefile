CC=gcc
AS=nasm

C_SOURCES=$(wildcard kernel/*.c drivers/*.c)
AS_SRCS=$(wildcard boot/*.asm)
HEADERS=$(wildcard kernel/*.h drivers/*.h)
OBJ=${C_SOURCES:.c=.o}
AS_FLAGS=-felf32
CC_FLAGS=-m32 -ffreestanding \
				 -nostdlib -nostdinc -fno-builtin \
				 -fno-stack-protector -nostartfiles -nodefaultlibs \
				 -Wall -Wextra -Werror -c
LD_FLAGS=-melf_i386 -Ttext 0x2000 --oformat binary

# default will build all and try to run final image with qemu
run: all
	qemu disk.img
# all: will clean up and build final image
all: clean disk.img
# dependencies for final disk.img
disk.img: boot.bin kernel.bin
	cat $^ > $@
# generel rule for .asm source files; in our specific case that should only be
# the rule for boot.asm which gets directly compiled into binary
%.bin: $(AS_SRCS)
	$(AS) -fbin $< -o ./$@

# general rule for .asm source files translating to .o object files
# special attention needs to be taken on the flags where the format should
# be chosen -felf or -felf32 to avoid output file format mismatches
%.o : %.asm
	$(AS) $(AS_FLAGS) $< -o $@
# general rule for .c .h source and header files translating to .o object files
# special attention needs to be taken on the flags
# -m32 -ffreesanding -Ttext 0x1000 (or use a lst file instead)
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
