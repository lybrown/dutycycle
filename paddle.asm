    icl 'hardware.asm'
    org $2000
period
    dta 211
duty
    dta 0
lastpot
    dta 1
main
    sei
    mva #0 NMIEN
    sta AUDCTL
    mva #3 SKCTL
    mva #4 AUDCTL
    sta STIMER
    mva #$A8 AUDC1
    mva #$A0 AUDC3
    mva period AUDF1
    sub #5
    sta AUDF3
    sta STIMER
    mva period AUDF3
    mva #$F COLPM0
    mva #$1 GRAFP0
    mva POT0 lastpot
loop
    :1 jsr waitframe
    lda POT0
    sta POTGO
    tax
    sub lastpot
    stx lastpot
    add period
    ldx PORTA
    cpx #~8
    sne:add #1
    cpx #~4
    sne:sub #1
    sta AUDF1
    mva #0 IRQEN
    mva #1 IRQEN
wait
    lda IRQST
    and #1
    bne wait
reset
    mva period AUDF1
    jmp loop

waitframe
    lda:rne VCOUNT
    :2 sta WSYNC
    rts
    run main
