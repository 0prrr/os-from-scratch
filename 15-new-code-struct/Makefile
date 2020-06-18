# 通配符匹配文件夹中所有的 C 源文件；C_SOURCES 宏将扩展为所有的 C 源文件
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)

# 通配符匹配文件夹中所有的头文件；HEADERS 宏将扩展为所有的头文件
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# 通过这样的形式，将所有 C 源文件的扩展名替换为 .o，比如 kernel.c 变成 kernel.o；
# OBJ 宏将扩展为所有的 .o 目标文件
OBJ = ${C_SOURCES:.c=.o}

# 修改路径，指向你机器上编译好的交叉编译器
CC = /home/opr/opt/cross/bin/i686-elf-gcc
# 修改路径，指向你机器上的 gdb
GDB = /usr/bin/gdb
# -g: 编译时带上默认 debug 信息；debug 是分级的，更多信息大家可以参考
# https://www.rapidtables.com/code/linux/gcc/gcc-g.html
CFLAGS = -g

# 默认目标
os-image: boot/boot_sector.bin kernel.bin
	cat $^ > $@

# 默认目标将运行这个 run
run: os-image
	qemu-system-i386 -fda $<

kernel.bin: boot/kernel_entry.o ${OBJ}
	i686-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

# kernel.gdb 用于内核 debug，我们没有指定 --oformat 因为该参数会去除掉所有的
# debug 信息，包括符号表
kernel.gdb: boot/kernel_entry.o ${OBJ}
	i686-elf-ld -o $@ -Ttext 0x1000 $^

# 启动 QEMU 并使用 -s 参数连接 gdb，-s 参数会让 qemu 监听 TCP 1234 端口，等待 gdb 连接
# 然后启动 gdb，-ex 执行命令，首先连接 1234 端口，然后加载上一步编译好的带有符号表的 debug 文件，即可开始 debug
debug: os-image kernel.gdb
	qemu-system-i386 -s -fda os-image &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.gdb"

# % 在这里的意思是，要编译一个 .o 文件，一定用文件名相同的 .c 文件去编译
# 比如要编译 kernel.o，那么一定要找到 kernel.c 去编译
%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

clean:
	rm -rf *.bin *.o os-image *.elf *.gdb
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o
