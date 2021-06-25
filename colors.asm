    DEVICE ZXSPECTRUM48

    org $8000

    jp start             ; jump over data to code (extended immediate)

string:
    db "Hello_world!"
colors:
    db $47
    db $78
    db $79
    db $7A
    db $7B
    db $7C
    db $7D
    db $7E
    db $70
    db $38
    db $07
    db $D6

STRING_LENGTH  = 12

ROM_CLS        = $0DAF  ; ROM address for "Clear Screen" routine
COLOR_ATTR     = $5800  ; start of color attribute memory
ENTER          = $0D    ; Character code for Enter key
BLACK_WHITE    = $47    ; black paper, white ink
WHITE_BLACK    = $78    ; white paper, black ink
WHITE_BLUE     = $79    ; white paper, blue ink
WHITE_RED      = $7A    ; white paper, red ink
WHITE_MAGENTA  = $7B    ; white paper, magenta ink
WHITE_GREEN    = $7C    ; white paper, green ink
WHITE_CYAN     = $7D    ; white paper, cyan ink
WHITE_YELLOW   = $7E    ; white paper, yellow ink
WHITE_WHITE    = $7F    ; white paper, white ink

start:
    im 1                 ; Set interrupt mode to 1 (interrupt mode)
    call ROM_CLS         ; Call clear screen routine from ROM (extended immediate)
    ld hl,string         ; HL = address of string (register,extended immediate)
    ld b,STRING_LENGTH   ; B = length of string (register,immediate)
    ld de,colors
    ld ix,COLOR_ATTR         ; IX = address of string (register,extended immediate)

loop:
    ld a,(hl)            ; A = byte at address in HL (register,register indirect)
    rst $10              ; print character code in A (modified page zero)
    inc hl               ; increment HL to address of next character (register)
    dec b                ; decrement B (register)
    ld a, (de)           ; load color to A (register)
    ld (ix),a            ; load A to current color attribute memory address
    inc ix
    inc de               ; increment color attribute memory address
    jr nz,loop           ; if B not zero, jump back to top of loop (condition,relative)
    ld a,ENTER           ; A = Enter character code (register,immediate)
    rst $10              ; print Enter for new line (modified page zero)

    ret

; Deployment: Snapshot
   SAVESNA "colors.sna", start
