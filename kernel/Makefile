# $@ = target file
# $< = first dependency
# $^ = all dependencies

CC = /usr/local/i386elfgcc/bin/i386-elf-gcc
LD = /usr/local/i386elfgcc/bin/i386-elf-ld

all: run

kernel.bin: kentry.o kernel.o
	$(LD) -o $@ -Ttext 0x1000 $^ --oformat binary

kentry.o: kentry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	$(CC) -ffreestanding -c $< -o $@

bootsec.bin: bootsec.asm
	nasm $< -f bin -o $@

osimg.bin: bootsec.bin kernel.bin
	cat $^ > $@

run: osimg.bin
	qemu-system-i386 $<

clean:
	rm *.bin *.o *.dis