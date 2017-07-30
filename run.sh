#!/bin/bash
nasm -f bin kernel.asm -o kernel.bin
nasm -f bin boot.asm -o boot.bin
cd /home/iman/is-os
sudo dd if=boot.bin of=disk.img conv=notrunc
sudo qemu-system-x86_64 -fda disk.img -boot a

