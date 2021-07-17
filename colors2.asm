    DEVICE ZXSPECTRUM48

    org $8000

    jp start             ; jump over data to code (extended immediate)

string:
    db "abcdefghijklmnopqrstuvwxyz012345"

eostring equ $

stringg defb 16,2,17,6,22,3,11, "HELLO!"

eostringg equ $

udgs defb 0,24,60,126,126,60,24,0

colors:
    db $01
    db $02
    db $03
    db $04
    db $05
    db $06
    db $07
    db $08
    db $19
    db $0A
    db $0B
    db $8C
    db $0D
    db $0E
    db $0F

board
    defb 22,10,12
    defb 16,7,17,1
    defb 144,144,144,144,144,144,144

eoboard equ $

STRING_LENGTH  = eostring - string
LINES = 22

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

last_k equ 23560

start:
    call ROM_CLS         ; Call clear screen routine from ROM (extended immediate)
    ld c,LINES
    ld ix,COLOR_ATTR         ; IX = address of string (register,extended immediate)

line:
    ld hl,string         ; HL = address of string (register,extended immediate)
    ld b,STRING_LENGTH   ; B = length of string (register,immediate)
    ld de,colors

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

    dec c                ; decrement B (register)
    jr nz,line

    ld b, 50
    ld hl, udgs
    ld (23675), hl
    ld a,2
    call 5633
    ld de, stringg
    ld bc, eostringg-stringg
    call 8252

move:
    ld a, 144
    rst 16
    dec b
    jr nz, move

    ld b, 100

wait:
    ld hl, last_k
    ld a, (hl)
    cp 112
    jr z, cls
    jr wait

cls:
    call ROM_CLS

    ret

; Deployment: Snapshot
   SAVESNA "colors2.sna", start
