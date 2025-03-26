AS=nasm
ASFLAGS=-felf64

.PHONY:clean

build: main.o
	ld $< -o main

main.o: main.asm
	$(AS) $< $(ASFLAGS) -o $@

clean:
	rm -f main main.o
