cd i37h
call make
cd ..
fasm fsdrv.asm fsdrv.bin
cd nsetdrv
del fsdrv.bin
cd ..
copy fsdrv.bin .\nsetdrv\fsdrv.bin
cd nsetdrv
call maken
setdrv