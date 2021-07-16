   DEVICE ZXSPECTRUM48

   org $8000
   jp start

start:
    call $0DAF  ; ROM address for "Clear Screen" routine
    ld a,$D6
    ld ($5800),a
    ld hl, $5800
    ld de, 704

restart:
    ld b, 0
    ld c, 0
loop:
    ld a,"A"         ; A = byte at address in HL (register,register indirect)
    rst $10
    ;ld a, $D6
    ld a, c
    ld (hl),a
    inc hl
    ;inc ix
    inc c
    dec de              ;decrease BC. this instruction does not affect flags
    ld a, d             ;so we have to check condition (BC equals 0) in different way
    or e                ;if B and C are equal to zero then result of (B OR C) is zero too
    ;jp nz, loop         ;if not zero then repeat
    jr z, end
    dec b
    jr nz, loop
    jr restart


end:

    ret

; Deployment: Snapshot
   SAVESNA "video_1_1.sna", start
