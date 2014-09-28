    icl 'hardware.asm'
    org $2000
period
    dta 80
duty
    dta 80
main
    sei
    mva #0 NMIEN
    sta AUDCTL
    mva #3 SKCTL
    mva #4 AUDCTL
    sta STIMER
    mva #$A8 AUDC1
    mva #$A0 AUDC3
    mva #$F COLPM0
    mva #$1 GRAFP0
loop
    :9 jsr waitframe
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
