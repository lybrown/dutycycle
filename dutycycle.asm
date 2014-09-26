    icl 'hardware.asm'
    org $2000
period
    dta 180
duty
    dta 180
main
    sei
    mva #0 NMIEN
    mva #$F COLPM0
    mva #$1 GRAFP0
    sta AUDCTL
    mva #3 SKCTL
    mva #4 AUDCTL
    mva #$A8 AUDC1
    sta STIMER
    mva #$A0 AUDC3
loop
    :3 jsr waitframe
    ldx period
    lda duty
    tay
    add #30
    sta HPOSP0
    tya
    stx AUDF1
    sta AUDF3
    sta STIMER
    stx AUDF3
    dec duty
    bne loop
    mva period duty
    bne loop
waitframe
    lda:rne VCOUNT
    :2 sta WSYNC
    rts
    run main
