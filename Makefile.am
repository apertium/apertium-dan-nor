VERSION=0.1.0
LANG1=dan
LANG2=nor
LANG2a=nob
LANG2b=nno

# dan-nor
PREFIX1=$(LANG1)-$(LANG2)
# dan-nob
PREFIX1a=$(LANG1)-$(LANG2a)
# dan-nno
PREFIX1b=$(LANG1)-$(LANG2b)
# nor-dan
PREFIX2=$(LANG2)-$(LANG1)
# nob-dan
PREFIX2a=$(LANG2a)-$(LANG1)
# nno-dan
PREFIX2b=$(LANG2b)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON = \
      $(PREFIX1).automorf.bin \
      $(PREFIX1).rlx.bin \
      $(PREFIX1a).autobil.bin \
      $(PREFIX1b).autobil.bin \
      $(PREFIX1a).autolex.bin \
      $(PREFIX1b).autolex.bin \
      $(PREFIX1a).autogen.bin \
      $(PREFIX1b).autogen.bin \
      $(PREFIX2a).automorf.bin \
      $(PREFIX2b).automorf.bin \
      $(PREFIX2a).rlx.bin \
      $(PREFIX2b).rlx.bin \
      $(PREFIX2a).autobil.bin \
      $(PREFIX2b).autobil.bin \
      $(PREFIX2a).autolex.bin \
      $(PREFIX2b).autolex.bin \
      $(PREFIX2).autogen.bin



$(PREFIX1).automorf.bin: $(BASENAME).$(LANG1).dix $(BASENAME).$(LANG1).acx
	apertium-validate-dictionary $(BASENAME).$(LANG1).dix
	lt-comp lr $(BASENAME).$(LANG1).dix $@ $(BASENAME).$(LANG1).acx

$(PREFIX1).rlx.bin: $(BASENAME).$(LANG1).rlx 
	cg-comp $(BASENAME).$(LANG1).rlx $@ 



EXTRA_DIST= \
    $(BASENAME).$(LANG1).dix

apertium_dan_nordir=$(prefix)/share/apertium/apertium-$(PREFIX1)/
apertium_dan_normodesdir=$(prefix)/share/apertium/modes/


apertium_dan_nor_DATA=$(TARGETS_COMMON) \
    $(PREFIX1).prob \
    $(PREFIX2a).prob \
    $(PREFIX2b).prob \
    modes.xml 

CLEANFILES = $(TARGETS_COMMON) 
clean-local: 
	-rm -rf .deps modes

