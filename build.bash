
rm -r build
mkdir -p build
nasm -felf32 src/boot.asm -o build/boot.o
i686-elf-gcc -c src/kernel.c -o build/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include
i686-elf-gcc -c src/terminal.c -o build/terminal.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include
i686-elf-gcc -T src/linker.ld -o build/zeroos.bin -ffreestanding -O2 -nostdlib build/boot.o build/kernel.o build/terminal.o -lgcc -I./include

if grub-file --is-x86-multiboot build/zeroos.bin; then
    echo Success: multiboot confirmed
else
    echo Error: not multiboot
fi

rm -r isodir
mkdir -p isodir/boot/grub
cp build/zeroos.bin isodir/boot/zeroos.bin
cp src/grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o build/zeroos.iso isodir

qemu-system-i386 -cdrom build/zeroos.iso -serial stdio