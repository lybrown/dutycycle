    icl 'hardware.asm'
    org $2000
period
    dta 211
duty
    dta 0
dir
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
    mva #2 dir
loop
    :1 jsr waitframe
    lda period
    tax
    add dir
    sta AUDF1
    mva #0 IRQEN
    mva #1 IRQEN
wait
    lda IRQST
    and #1
    bne wait
reset
    stx AUDF1
    lda dir
    add:sta duty
    beq pong
    cmp #202
    bne donepong
pong
    lda #$FC
    eor:sta dir
donepong
    jmp loop

waitframe
    lda:rne VCOUNT
    :2 sta WSYNC
    rts
    run main
