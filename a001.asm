    DEVICE ZXSPECTRUM48

    org $8000

    jp start             ; jump over data to code (extended immediate)

string:
    db "hello"

STRING_LENGTH  = 5

ROM_CLS        = $0DAF  ; ROM address for "Clear Screen" routine
COLOR_ATTR     = $5800  ; start of color attribute memory
ENTER          = $0D    ; Character code for Enter key
BLACK_WHITE    = $47    ; black paper, white ink

start:
    im 1                 ; Set interrupt mode to 1 (interrupt mode)
    call ROM_CLS         ; Call clear screen routine from ROM (extended immediate)
    ld hl,string         ; HL = address of string (register,extended immediate)
    ld b,STRING_LENGTH   ; B = length of string (register,immediate)

loop:
    ld a,(hl)            ; A = byte at address in HL (register,register indirect)
    rst $10              ; print character code in A (modified page zero)
    inc hl               ; increment HL to address of next character (register)
    dec b                ; decrement B (register)
    jr nz,loop           ; if B not zero, jump back to top of loop (condition,relative)
    ld a,ENTER           ; A = Enter character code (register,immediate)
    rst $10              ; print Enter for new line (modified page zero)

    ld a,$D6
    ld ($5800),a
    ld ($5801),a
    ld ($5802),a
    ld ($5803),a
    ld ($5804),a

    ret

; Deployment: Snapshot
   SAVESNA "a001.sna", start
