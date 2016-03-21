###############################################################################
## Makefile for Danish--Norwegian
###############################################################################

VERSION=1.2.2
LANG1=dan
LANG2=nor
LANG2n=nno
LANG2b=nob

# dan-nor
PREFIX1=$(LANG1)-$(LANG2)
# dan-nob
PREFIX1b=$(LANG1)-$(LANG2b)
# dan-nno
PREFIX1n=$(LANG1)-$(LANG2n)
# nor-dan
PREFIX2=$(LANG2)-$(LANG1)
# nob-dan
PREFIX2b=$(LANG2b)-$(LANG1)
# nno-dan
PREFIX2n=$(LANG2n)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON = \
      $(PREFIX1).prob \
      $(PREFIX1).rlx.bin \
      $(PREFIX1b).autobil.bin \
      $(PREFIX1b).autogen.bin \
      $(PREFIX1b).autolex.bin \
      $(PREFIX1b).automorf.bin \
      $(PREFIX1b).t1x.bin $(PREFIX1b).t2x.bin $(PREFIX1b).t3x.bin \
      $(PREFIX1n).autobil.bin \
      $(PREFIX1n).autogen.bin \
      $(PREFIX1n).autolex.bin \
      $(PREFIX1n).automorf.bin \
      $(PREFIX1n).t1x.bin $(PREFIX1n).t2x.bin $(PREFIX1n).t3x.bin \
      $(PREFIX2n).prob \
      $(PREFIX2b).prob \
      $(PREFIX2b).automorf.bin \
      $(PREFIX2n).automorf.bin \
      $(PREFIX2b).rlx.bin \
      $(PREFIX2n).rlx.bin \
      $(PREFIX2).autobil.bin \
      $(PREFIX2b).autolex.bin \
      $(PREFIX2n).autolex.bin \
      $(PREFIX2).autogen.bin \
      $(PREFIX2).t1x.bin $(PREFIX2).t2x.bin $(PREFIX2).t3x.bin


# This include defines goals for install-modes, .deps/.d and .mode files:
@ap_include@

###############################################################################
## Monolingual dictionaries
###############################################################################

# Danish

$(PREFIX1b).automorf.bin: $(AP_SRC1)/$(LANG1).automorf.bin $(PREFIX1b).autobil.bin
	lt-trim $^ $@

$(PREFIX1n).automorf.bin: $(AP_SRC1)/$(LANG1).automorf.bin $(PREFIX1n).autobil.bin
	lt-trim $^ $@

$(PREFIX2).autogen.bin: $(AP_SRC1)/$(LANG1).autogen.bin
	cp $< $@


# Norwegian

$(PREFIX2b).automorf.bin: $(AP_SRC2b)/$(LANG2b).automorf.bin $(PREFIX2).autobil.bin
	lt-trim $(AP_SRC2b)/$(LANG2b).automorf.bin $(PREFIX2).autobil.bin $@

$(PREFIX2n).automorf.bin: $(AP_SRC2n)/$(LANG2n).automorf.bin $(PREFIX2).autobil.bin
	lt-trim $(AP_SRC2n)/$(LANG2n).automorf.bin $(PREFIX2).autobil.bin $@


$(PREFIX1b).autogen.bin: $(AP_SRC2b)/$(LANG2b).autogen.bin
	cp $< $@

$(PREFIX1n).autogen.bin: $(AP_SRC2n)/$(LANG2n).autogen.bin
	cp $< $@



###############################################################################
## Disambiguation models
###############################################################################

$(PREFIX1).prob: $(AP_SRC1)/$(LANG1).prob
	cp $< $@

$(PREFIX2b).prob: $(AP_SRC2b)/$(LANG2b).prob
	cp $< $@

$(PREFIX2n).prob: $(AP_SRC2n)/$(LANG2n).prob
	cp $< $@

###############################################################################
## Disambiguation rules
###############################################################################

$(PREFIX1).rlx.bin: $(AP_SRC1)/apertium-$(LANG1).$(LANG1).rlx
	cg-comp $< $@

$(PREFIX2b).rlx.bin: $(AP_SRC2b)/apertium-$(LANG2b).$(LANG2b).rlx
	cg-comp $< $@

$(PREFIX2n).rlx.bin: $(AP_SRC2n)/apertium-$(LANG2n).$(LANG2n).rlx
	cg-comp $< $@


###############################################################################
## Lexical selection rules
###############################################################################

$(PREFIX1b).autolex.bin: $(BASENAME).$(PREFIX1b).lrx
	lrx-comp $< $@

$(PREFIX1n).autolex.bin: $(BASENAME).$(PREFIX1n).lrx
	lrx-comp $< $@

$(PREFIX2b).autolex.bin: $(BASENAME).$(PREFIX2b).lrx
	lrx-comp $< $@

$(PREFIX2n).autolex.bin: $(BASENAME).$(PREFIX2n).lrx
	lrx-comp $< $@

###############################################################################
## Bilingual dictionaries
###############################################################################

$(PREFIX1b).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp --var-right=nob lr $< $@

$(PREFIX1n).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp --var-right=nno lr $< $@

$(PREFIX2).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp rl $< $@


###############################################################################
## Structural transfer rules
###############################################################################

$(PREFIX1b).t1x.bin: $(BASENAME).$(PREFIX1b).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX1b).t2x.bin: $(BASENAME).$(PREFIX1b).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX1b).t3x.bin: $(BASENAME).$(PREFIX1b).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@


$(PREFIX1n).t1x.bin: $(BASENAME).$(PREFIX1n).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX1n).t2x.bin: $(BASENAME).$(PREFIX1n).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX1n).t3x.bin: $(BASENAME).$(PREFIX1n).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@



$(PREFIX2).t1x.bin: $(BASENAME).$(PREFIX2).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX2).t2x.bin: $(BASENAME).$(PREFIX2).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX2).t3x.bin: $(BASENAME).$(PREFIX2).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@


###############################################################################
## Distribution
###############################################################################

EXTRA_DIST=$(BASENAME).$(PREFIX1).dix \
	   $(BASENAME).$(PREFIX1b).lrx \
	   $(BASENAME).$(PREFIX1n).lrx \
	   $(BASENAME).$(PREFIX2b).lrx \
	   $(BASENAME).$(PREFIX2n).lrx \
	   $(BASENAME).$(PREFIX1n).t1x \
	   $(BASENAME).$(PREFIX1b).t1x \
	   $(BASENAME).$(PREFIX1n).t2x \
	   $(BASENAME).$(PREFIX1b).t2x \
	   $(BASENAME).$(PREFIX1n).t3x \
	   $(BASENAME).$(PREFIX1b).t3x \
	   $(BASENAME).$(PREFIX2).t1x \
	   $(BASENAME).$(PREFIX2).t2x \
	   $(BASENAME).$(PREFIX2).t3x \
	   $(BASENAME).$(LANG1).acx \
	   $(BASENAME).$(LANG2).acx \
	   modes.xml

###############################################################################
## Installation
###############################################################################

apertium_dan_nordir=$(prefix)/share/apertium/apertium-$(PREFIX1)/

apertium_dan_nor_DATA=$(TARGETS_COMMON) \
	$(BASENAME).$(PREFIX1n).t1x \
	$(BASENAME).$(PREFIX1b).t1x \
	$(BASENAME).$(PREFIX1n).t2x \
	$(BASENAME).$(PREFIX1b).t2x \
	$(BASENAME).$(PREFIX1n).t3x \
	$(BASENAME).$(PREFIX1b).t3x \
	$(BASENAME).$(PREFIX2).t1x  \
	$(BASENAME).$(PREFIX2).t2x  \
	$(BASENAME).$(PREFIX2).t3x

# All modes are created by the same goal, listing several will just give problems with make -j2
noinst_DATA=modes/$(PREFIX1b).mode

install-data-local: install-modes


###############################################################################
## Cleanup
###############################################################################

CLEANFILES = $(TARGETS_COMMON)
clean-local:
	-rm -rf .deps modes

###############################################################################
## Test
###############################################################################

test: all
	echo "Såg ho ikkje orda?" | apertium -d . nno-dan | tee .test-mt
	@echo "Så hun ikke ordene?" > .test-ref
	@diff .test-ref .test-mt
	echo "Jeg har åler i min luftputebåt" | apertium -d . nob-dan | tee .test-mt
	@echo "Jeg har åle i min luftpudebåd" > .test-ref
	@diff .test-ref .test-mt
	@rm .test-ref .test-mt
