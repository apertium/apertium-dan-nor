LANG1=da
LANG2=nb
BASENAME=apertium-$(LANG1)-$(LANG2)
PREFIX1=$(LANG1)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)

all: modes
	# Danish -> Bokmål

	lt-comp lr $(BASENAME).$(LANG1).dix $(PREFIX1).automorf.bin
	lt-comp lr $(BASENAME).$(PREFIX1).dix $(PREFIX1).autobil.bin
	lt-comp rl $(BASENAME).$(LANG2).dix $(PREFIX1).autogen.bin
	apertium-validate-transfer $(BASENAME).$(PREFIX1).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t1x $(PREFIX1).t1x.bin

	# Bokmål -> Danish

	lt-comp lr $(BASENAME).$(LANG2).dix $(PREFIX2).automorf.bin 
	lt-comp rl $(BASENAME).$(PREFIX1).dix $(PREFIX2).autobil.bin
	lt-comp rl $(BASENAME).$(LANG1).dix $(PREFIX2).autogen.bin
	cg-comp $(BASENAME).$(PREFIX2).rlx $(PREFIX2).rlx.bin
	apertium-validate-transfer $(BASENAME).$(PREFIX2).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t1x $(PREFIX2).t1x.bin

modes: 
	apertium-gen-modes modes.xml
	cp *.mode modes/
 
clean:
	rm -f *.bin 
	rm -r modes/

