NAME	= kernel.bin
CSRCS	= kernel.c
ASRCS	= boot.s
ISO		= kfs.iso

OBJS	= $(CSRCS:.c=.o) $(ASRCS:.s=.o)

CC		= gcc
LD		= ld
RM		= rm -rf
BOOT	= boot

CFLAGS	= -m32 -fno-builtin -fno-stack-protector -nostdlib -nodefaultlibs -ffreestanding -c
ASFLAGS	= -m32 -c
LDFLAGS	= -m elf_i386 -T linker.ld

%.o: %.c
			$(CC) $(CFLAGS) $< -o $@

%.o: %.s
			$(CC) $(ASFLAGS) $< -o $@

$(NAME):	$(OBJS)
			$(LD) $(LDFLAGS) $(OBJS) -o $(NAME)

all:		$(NAME)

clean:
			$(RM) $(OBJS)

fclean:		clean
			$(RM) $(NAME) $(BOOT)

re:			fclean all

run:		$(ISO)
			qemu-system-i386 -cdrom $(ISO)

iso:		$(NAME)
			mkdir -p $(BOOT)/grub
			cp $(NAME) $(BOOT)
			echo 'menuentry "kfs" {\n\tmultiboot /$(BOOT)/$(NAME)\n}' > $(BOOT)/grub/grub.cfg
			grub-mkrescue -o $(ISO) .

.PHONY:		all clean fclean re run iso
