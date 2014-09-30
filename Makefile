paddle.run:
paddle.obx: hardware.asm
sweep.run:
sweep.obx: hardware.asm
dutycycle.run:
dutycycle.obx: hardware.asm

atari = altirra

%.run: %.xex
	$(atari) $<

%.xex: %.obx
	cp $< $@

%.obx: %.asm
	xasm /t:$*.lab /l:$*.lst $<
	perl -pi -e 's/^n /  /' $*.lab

.PRECIOUS: %.obx %.xex %.asm
