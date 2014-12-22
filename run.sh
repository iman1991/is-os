#!/bin/bash
nasm -f bin kernel.asm -o kernel.bin
nasm -f bin boot.asm -o boot.bin
sudo dd if=boot.bin of=disk.img conv=notrunc
sudo qemu -fda disk.img -boot a

