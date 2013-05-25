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

# replace this with stripping for dan-nob
.deps/$(PREFIX1a).dix: $(BASENAME).$(PREFIX1).dix
	if [ ! -d .deps ] ; then mkdir .deps ; fi
	cp $(BASENAME).$(PREFIX1).dix $@

.deps/$(PREFIX1b).dix: $(BASENAME).$(PREFIX1).dix
	if [ ! -d .deps ] ; then mkdir .deps ; fi
	cp $(BASENAME).$(PREFIX1).dix $@

$(PREFIX1a).autobil.bin: .deps/$(PREFIX1a).dix 
	lt-comp lr .deps/$(PREFIX1a).dix $@

$(PREFIX1b).autobil.bin: .deps/$(PREFIX1b).dix 
	lt-comp lr .deps/$(PREFIX1b).dix $@

$(PREFIX1a).autolex.bin: $(BASENAME).$(PREFIX1a).lrx
	lrx-comp $(BASENAME).$(PREFIX1a).lrx $@

$(PREFIX1b).autolex.bin: $(BASENAME).$(PREFIX1b).lrx
	lrx-comp $(BASENAME).$(PREFIX1b).lrx $@
$(PREFIX1a).autogen.bin: $(BASENAME).$(LANG2a).dix 
	apertium-validate-dictionary $(BASENAME).$(LANG2a).dix
	lt-comp rl $(BASENAME).$(LANG2a).dix $@ 

$(PREFIX1b).autogen.bin: $(BASENAME).$(LANG2a).dix 
	apertium-validate-dictionary $(BASENAME).$(LANG2a).dix
	lt-comp rl $(BASENAME).$(LANG2a).dix $@ 

###

$(PREFIX2a).automorf.bin: $(BASENAME).$(LANG2a).dix $(BASENAME).$(LANG2).acx
	apertium-validate-dictionary $(BASENAME).$(LANG2a).dix
	lt-comp lr $(BASENAME).$(LANG2a).dix $@ $(BASENAME).$(LANG2).acx

.deps/$(LANG2b).dix:  $(BASENAME).$(LANG2b).dix
	if [ ! -d .deps ] ; then mkdir .deps ; fi
	xsltproc --stringparam alt nn_e alt.xsl $(BASENAME).$(LANG2b).dix > $@

$(PREFIX2b).automorf.bin: .deps/$(LANG2b).dix $(BASENAME).$(LANG2).acx
	apertium-validate-dictionary .deps/$(LANG2b).dix
	lt-comp lr .deps/$(LANG2b).dix $@ $(BASENAME).$(LANG2).acx

$(PREFIX2a).rlx.bin: $(BASENAME).$(LANG2a).rlx 
	cg-comp $(BASENAME).$(LANG2a).rlx $@ 

$(PREFIX2b).rlx.bin: $(BASENAME).$(LANG2b).rlx 
	cg-comp $(BASENAME).$(LANG2b).rlx $@ 

# replace this with stripping for nob-dan
.deps/$(PREFIX2a).dix: $(BASENAME).$(PREFIX1).dix
	if [ ! -d .deps ] ; then mkdir .deps ; fi
	cp $(BASENAME).$(PREFIX1).dix $@

.deps/$(PREFIX2b).dix: $(BASENAME).$(PREFIX1).dix
	if [ ! -d .deps ] ; then mkdir .deps ; fi
	cp $(BASENAME).$(PREFIX1).dix $@

$(PREFIX2a).autobil.bin: .deps/$(PREFIX2a).dix 
	lt-comp rl .deps/$(PREFIX2a).dix $@

$(PREFIX2b).autobil.bin: .deps/$(PREFIX2b).dix 
	lt-comp rl .deps/$(PREFIX2b).dix $@

$(PREFIX2a).autolex.bin: $(BASENAME).$(PREFIX2a).lrx
	lrx-comp $(BASENAME).$(PREFIX2a).lrx $@

$(PREFIX2b).autolex.bin: $(BASENAME).$(PREFIX2b).lrx
	lrx-comp $(BASENAME).$(PREFIX2b).lrx $@

$(PREFIX2).autogen.bin: $(BASENAME).$(LANG1).dix
	lt-comp rl $(BASENAME).$(LANG1).dix $@



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

