.global gdt_flush
.type gdt_flush, @function

gdt_flush:
    mov 4(%esp), %eax       # pointer to gdt
    lgdt (%eax)

    mov $0x10, %ax          # Reload segment registers
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %ss

    ljmp $0x08, $flush_cs   # far jump to reload CS

flush_cs:
    ret
