   DEVICE ZXSPECTRUM48

   org $8000

start:
   ld a,$D6
   ld ($5800),a
   ld ($5801),a
   ret

; Deployment: Snapshot
   SAVESNA "load_jc.sna", start
