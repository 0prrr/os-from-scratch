all: run

kernel.bin: kernel_entry.o kernel.o
	i686-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	i686-elf-gcc -ffreestanding -c $< -o $@

boot_sector.bin: boot_sector.asm
	nasm $< -f bin -o $@

os-image: boot_sector.bin kernel.bin
	cat $^ > $@

run: os-image
	qemu-system-i386 -fda $<

clean:
	rm *.bin *.o
