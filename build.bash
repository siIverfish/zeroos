nasm -felf32 boot.asm -o boot.o
i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -T linker.ld -o zeroos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

if grub-file --is-x86-multiboot zeroos.bin; then
    echo Success: multiboot confirmed
else
    echo Error: not multiboot
fi

mkdir -p isodir/boot/grub
cp zeroos.bin isodir/boot/zeroos.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o zeroos.iso isodir

qemu-system-i386 -cdrom zeroos.iso