    DEVICE ZXSPECTRUM48

    org $8000

last_k = 23560
ROM_CLS = $0DAF

start:
    im 1
    ld b, 255

loop:
    ld hl, last_k
    ld a, (hl)
    cp 112
    jr z, cls
    rst $10
    dec b
    jr z, cls
    jr loop

cls:
    call ROM_CLS
    ld hl,last_k
    ld a,(hl)            ; A = byte at address in HL (register,register indirect)
    rst $10
    jr start

    ret

; Deployment: Snapshot
   SAVESNA "colors3.sna", start
