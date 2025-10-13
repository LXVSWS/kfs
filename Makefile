NAME	= kernel
SRCS	= kernel.c
OBJS	= $(SRCS:.c=.o)

CC		= @ gcc
LD		= @ ld
RM		= @ rm -f

CFLAGS	= -m32 -fno-builtin -fno-stack-protector -nostdlib -nodefaultlibs -c
LDFLAGS	= -m elf_i386 -T linker.ld

%.o: %.c
			$(CC) $(CFLAGS) $< -o $@

$(NAME):	$(OBJS)
			$(LD) $(LDFLAGS) $(OBJS) -o $(NAME)

all:		$(NAME)

clean:
			$(RM) $(OBJS)

fclean:		clean
			$(RM) $(NAME)

re:			fclean all

.PHONY:		all clean fclean re
