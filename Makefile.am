###############################################################################
## Makefile for Danish--Norwegian
###############################################################################

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

TARGETS_COMMON =                                               \
    $(TARGETS_PREFIX1) $(TARGETS_PREFIX1n) $(TARGETS_PREFIX1b) \
    $(TARGETS_PREFIX2) $(TARGETS_PREFIX2n) $(TARGETS_PREFIX2b)

TARGETS_PREFIX1 =                                                 \
      $(PREFIX1).prob                                             \
      $(PREFIX1).seg.rlx.bin                                      \
      $(PREFIX1).rlx.bin
TARGETS_PREFIX1n =                                                \
      $(PREFIX1n).automorf.bin                                    \
      $(PREFIX1n).autopgen.bin                                    \
      $(PREFIX1n).autoseq.bin                                     \
      $(PREFIX1n).autobil.bin                                     \
      $(PREFIX1n).autolex.bin                                     \
      $(PREFIX1n).rtx.bin                                         \
      $(PREFIX1n).genprefs.rlx.bin                                \
      $(PREFIX1n).autogen.bin
TARGETS_PREFIX1b =                                                \
      $(PREFIX1b).automorf.bin                                    \
      $(PREFIX1b).autobil.bin                                     \
      $(PREFIX1b).autolex.bin                                     \
      $(PREFIX1b).autoseq.bin                                     \
      $(PREFIX1b).rtx.bin                                         \
      $(PREFIX1b).autogen.bin

TARGETS_PREFIX2 =              \
      $(PREFIX2).autoseq.bin   \
      $(PREFIX2).autobil.bin   \
      $(PREFIX2).autogen.bin   \
      $(PREFIX2).autolex.bin   \
      $(PREFIX2).rtx.bin
TARGETS_PREFIX2n =             \
      $(PREFIX2n).prob         \
      $(PREFIX2n).automorf.bin \
      $(PREFIX2b).seg.rlx.bin  \
      $(PREFIX2n).rlx.bin
TARGETS_PREFIX2b =             \
      $(PREFIX2b).prob         \
      $(PREFIX2b).automorf.bin \
      $(PREFIX2b).seg.rlx.bin  \
      $(PREFIX2b).rlx.bin


# Debug/development goals:
e: modes/$(PREFIX1b).mode	# build just nob-dan
	cd $(AP_SRC1) && ${MAKE} $(LANG1).autogen.bin
	cd $(AP_SRC2b) && ${MAKE} $(LANG2b).automorf.bin  $(LANG2b).seg.rlx.bin $(LANG2b).rlx.bin $(LANG2b).prob
	${MAKE} $(TARGETS_PREFIX2) $(TARGETS_PREFIX2b) $(PREFIX2b).automorf-untrimmed.bin

# Fast build – nearly everything but dictionaries:
r: modes/$(PREFIX1b).mode  \
   $(PREFIX1b).t1x.bin $(PREFIX1b).t2x.bin $(PREFIX1b).t3x.bin \
   $(PREFIX1n).t1x.bin $(PREFIX1n).t2x.bin $(PREFIX1n).t3x.bin \
   $(PREFIX2).t1x.bin  $(PREFIX2).t2x.bin  $(PREFIX2).t3x.bin  \
   $(PREFIX1n).autoseq.bin \
   $(PREFIX1n).rtx.bin     \
   $(PREFIX1b).autoseq.bin \
   $(PREFIX1b).rtx.bin     \
   $(PREFIX2).rtx.bin  \
   $(PREFIX2).autoseq.bin
	cd $(AP_SRC1) && ${MAKE} $(LANG1).seg.rlx.bin $(LANG1).rlx.bin
	cd $(AP_SRC2n) && ${MAKE} $(LANG2n).seg.rlx.bin $(LANG2n).rlx.bin
	cd $(AP_SRC2b) && ${MAKE} $(LANG2b).seg.rlx.bin $(LANG2b).rlx.bin
	${MAKE} $(PREFIX1).seg.rlx.bin $(PREFIX1).rlx.bin $(PREFIX2n).seg.rlx.bin $(PREFIX2n).rlx.bin $(PREFIX2b).seg.rlx.bin $(PREFIX2b).rlx.bin

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
	lt-trim $^ $@
$(PREFIX2b).automorf-untrimmed.bin: $(AP_SRC2b)/$(LANG2b).automorf.bin
	cp $< $@

$(PREFIX2n).automorf.bin: $(AP_SRC2n)/$(LANG2n).automorf.bin $(PREFIX2).autobil.bin
	lt-trim $^ $@
$(PREFIX2n).automorf-untrimmed.bin: $(AP_SRC2n)/$(LANG2n).automorf.bin
	cp $< $@


$(PREFIX1b).autogen.bin: $(AP_SRC2b)/$(LANG2b).autogen.bin
	cp $< $@

$(PREFIX1n).autogen.bin: $(AP_SRC2n)/$(LANG2n).autogen.bin
	cp $< $@

$(PREFIX1n).autopgen.bin: $(AP_SRC2n)/$(LANG2n).autopgen.bin
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

$(PREFIX1).seg.rlx.bin: $(AP_SRC1)/apertium-$(LANG1).$(LANG1).seg.rlx
	cg-comp $< $@

$(PREFIX2b).rlx.bin: $(AP_SRC2b)/apertium-$(LANG2b).$(LANG2b).rlx
	cg-comp $< $@

$(PREFIX2b).seg.rlx.bin: $(AP_SRC2b)/apertium-$(LANG2b).$(LANG2b).seg.rlx
	cg-comp $< $@

$(PREFIX2n).rlx.bin: $(AP_SRC2n)/apertium-$(LANG2n).$(LANG2n).rlx
	cg-comp $< $@

$(PREFIX2n).seg.rlx.bin: $(AP_SRC2n)/apertium-$(LANG2n).$(LANG2n).seg.rlx
	cg-comp $< $@


###############################################################################
## Variant preferences
###############################################################################

$(PREFIX1n).genprefs.rlx.bin: $(AP_SRC2n)/$(LANG2n).prefs.rlx.bin
	cp $< $@


###############################################################################
## Lexical selection rules
###############################################################################

%.autolex.bin: $(BASENAME).%.lrx
	lrx-comp $< $@

###############################################################################
## Separable / discontiguous multiwords
###############################################################################

%.autoseq.bin: $(BASENAME).%.lsx
	lsx-comp lr $< $@

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
# DEPRECATED – but kept around for debug modes while transitioning to rtx

%.t1x.bin: $(BASENAME).%.t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

%.t2x.bin: $(BASENAME).%.t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

%.t3x.bin: $(BASENAME).%.t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@


###############################################################################
## Distribution
###############################################################################

EXTRA_DIST=$(BASENAME).$(PREFIX1).dix  \
	   $(BASENAME).$(PREFIX1b).lrx \
	   $(BASENAME).$(PREFIX1n).lrx \
	   $(BASENAME).$(PREFIX2).lrx \
	   $(BASENAME).$(PREFIX1b).rtx \
	   $(BASENAME).$(PREFIX1n).rtx \
	   $(BASENAME).$(PREFIX2).rtx  \
	   modes.xml

###############################################################################
## Installation
###############################################################################

apertium_dan_nordir=$(prefix)/share/apertium/apertium-$(PREFIX1)/

apertium_dan_nor_DATA=$(TARGETS_COMMON)

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
	t/hash-count
	apertium-regtest test
