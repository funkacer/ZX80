   DEVICE ZXSPECTRUM48

   org $8000

start:
    jp print_hello

; Character Codes
ENTER       equ $8D

; ROM routines
ROM_CLS     equ $8DAF
ROM_PRINT   equ $203C

hello:
    db "Hello, world!", ENTER
HELLO_LEN   equ $ - hello

print_hello:
    call ROM_CLS
    ld de, hello
    ld bc, HELLO_LEN
    call ROM_PRINT
    ret

; Deployment
LENGTH      equ $ - start

    ; option 1 - tape
    include TapLib.asm
    MakeTape ZXSPECTRUM48, "hello_world.tap", "hello_world", start, LENGTH, start

    ; option 2 - snapshot
   SAVESNA "hello_world.sna", start
