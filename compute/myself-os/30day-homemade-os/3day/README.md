nasm -f elf -o ./naskfunc.o ./naskfunc.asm
gcc -m32 -c  -o ./bootpack.o ./bootpack.c
ld -m elf_i386 -o ./bootpack.bin bootpack.o naskfunc.o
cat ./asmhead.bin ./bootpack.bin > ./kernel.img