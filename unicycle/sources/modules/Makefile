imem: imem.s
	riscv64-unknown-elf-as imem.s -o imem.out
	riscv64-unknown-elf-objdump -S imem.out > imem.objdump
	tail -n +8 imem.objdump | cut -f 2 > imem.h
