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
      $(PREFIX1b).t1x.bin \
      $(PREFIX1a).t1x.bin \
      $(PREFIX1b).autogen.bin \
      $(PREFIX2a).automorf.bin \
      $(PREFIX2b).automorf.bin \
      $(PREFIX2a).rlx.bin \
      $(PREFIX2b).rlx.bin \
      $(PREFIX2a).autobil.bin \
      $(PREFIX2b).autobil.bin \
      $(PREFIX2a).autolex.bin \
      $(PREFIX2b).autolex.bin \
      $(PREFIX2).autogen.bin \
      $(PREFIX2).t1x.bin


# Use this goal for creating .deps, otherwise make -j2 will give problems:
.deps/.d:
	if [ ! -d .deps ]; then mkdir .deps; fi
	touch $@

# Prevent the .d file from being removed automatically:
.PRECIOUS: .deps/.d


$(PREFIX1).automorf.bin: $(BASENAME).$(LANG1).dix $(BASENAME).$(LANG1).acx
	apertium-validate-dictionary $(BASENAME).$(LANG1).dix
	lt-comp lr $(BASENAME).$(LANG1).dix $@ $(BASENAME).$(LANG1).acx

$(PREFIX1).rlx.bin: $(BASENAME).$(LANG1).rlx 
	cg-comp $< $@ 

# replace this with stripping for dan-nob
.deps/$(PREFIX1a).dix: $(BASENAME).$(PREFIX1).dix .deps/.d alt.xsl
	xsltproc --stringparam alt nob alt.xsl $< > $@

.deps/$(PREFIX1b).dix: $(BASENAME).$(PREFIX1).dix .deps/.d alt.xsl
	xsltproc --stringparam alt nno alt.xsl $< > $@

$(PREFIX1a).autobil.bin: .deps/$(PREFIX1a).dix 
	lt-comp lr $< $@

$(PREFIX1b).autobil.bin: .deps/$(PREFIX1b).dix 
	lt-comp lr $< $@

$(PREFIX1a).autolex.bin: $(BASENAME).$(PREFIX1a).lrx
	lrx-comp $< $@

$(PREFIX1b).autolex.bin: $(BASENAME).$(PREFIX1b).lrx
	lrx-comp $< $@
$(PREFIX1a).autogen.bin: $(BASENAME).$(LANG2a).dix 
	apertium-validate-dictionary $<
	lt-comp rl $< $@ 

$(PREFIX1b).autogen.bin: $(BASENAME).$(LANG2a).dix 
	apertium-validate-dictionary $<
	lt-comp rl $< $@ 

$(PREFIX1a).t1x.bin: $(BASENAME).$(PREFIX1a).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX1b).t1x.bin: $(BASENAME).$(PREFIX1b).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@


###

$(PREFIX2a).automorf.bin: $(BASENAME).$(LANG2a).dix $(BASENAME).$(LANG2).acx
	apertium-validate-dictionary $(BASENAME).$(LANG2a).dix
	lt-comp lr $(BASENAME).$(LANG2a).dix $@ $(BASENAME).$(LANG2).acx

.deps/$(LANG2b).dix:  $(BASENAME).$(LANG2b).dix .deps/.d alt.xsl
	xsltproc --stringparam alt nn_e alt.xsl $< > $@

$(PREFIX2b).automorf.bin: .deps/$(LANG2b).dix $(BASENAME).$(LANG2).acx
	apertium-validate-dictionary .deps/$(LANG2b).dix
	lt-comp lr .deps/$(LANG2b).dix $@ $(BASENAME).$(LANG2).acx

$(PREFIX2a).rlx.bin: $(BASENAME).$(LANG2a).rlx 
	cg-comp $< $@ 

$(PREFIX2b).rlx.bin: $(BASENAME).$(LANG2b).rlx 
	cg-comp $< $@ 

# replace this with stripping for nob-dan
.deps/$(PREFIX2a).dix: $(BASENAME).$(PREFIX1).dix .deps/.d alt.xsl
	xsltproc --stringparam alt '*' alt.xsl $< > $@

.deps/$(PREFIX2b).dix: $(BASENAME).$(PREFIX1).dix .deps/.d alt.xsl
	xsltproc --stringparam alt '*' alt.xsl $< > $@

$(PREFIX2a).autobil.bin: .deps/$(PREFIX2a).dix 
	lt-comp rl $< $@

$(PREFIX2b).autobil.bin: .deps/$(PREFIX2b).dix 
	lt-comp rl $< $@

$(PREFIX2a).autolex.bin: $(BASENAME).$(PREFIX2a).lrx
	lrx-comp $< $@

$(PREFIX2b).autolex.bin: $(BASENAME).$(PREFIX2b).lrx
	lrx-comp $< $@

$(PREFIX2).autogen.bin: $(BASENAME).$(LANG1).dix
	lt-comp rl $< $@

$(PREFIX2).t1x.bin: $(BASENAME).$(PREFIX2).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@


modes/$(PREFIX1a).mode: modes.xml
	apertium-validate-modes modes.xml
	apertium-gen-modes modes.xml
	cp *.mode modes/

EXTRA_DIST=$(BASENAME).$(LANG1).dix \
	   $(BASENAME).$(PREFIX1).dix \
	   $(BASENAME).$(LANG2a).dix $(BASENAME).$(LANG2b).dix \
	   $(BASENAME).$(LANG1).rlx \
	   $(BASENAME).$(LANG2a).rlx $(BASENAME).$(LANG2b).rlx \
	   $(BASENAME).$(PREFIX1a).lrx \
	   $(BASENAME).$(PREFIX1b).lrx \
	   $(BASENAME).$(PREFIX2a).lrx \
	   $(BASENAME).$(PREFIX2b).lrx \
           $(PREFIX1).prob \
           $(PREFIX2a).prob $(PREFIX2b).prob \
	   $(BASENAME).$(PREFIX1a).t1x \
	   $(BASENAME).$(PREFIX1b).t1x \
	   $(BASENAME).$(PREFIX2).t1x \
	   $(BASENAME).$(LANG1).acx \
	   $(BASENAME).$(LANG2).acx \
	   modes.xml alt.xsl

# Not used it seems:
#	   $(BASENAME).$(PREFIX2).t2x

apertium_dan_nordir=$(prefix)/share/apertium/apertium-$(PREFIX1)/
apertium_dan_normodesdir=$(prefix)/share/apertium/modes/


apertium_dan_nor_DATA=$(TARGETS_COMMON) \
    $(PREFIX1).prob \
    $(PREFIX2a).prob \
    $(PREFIX2b).prob \
    modes.xml 

# All modes are created by the same goal, listing several will just give problems with make -j2
noinst_DATA=modes/$(PREFIX1a).mode

install-data-local:
	mv modes modes.bak
	apertium-gen-modes modes.xml apertium-$(PREFIX1)
	rm -rf modes
	mv modes.bak modes
	test -d $(DESTDIR)$(apertium_dan_normodesdir) || mkdir $(DESTDIR)$(apertium_dan_normodesdir)
	$(INSTALL_DATA) $(PREFIX1a).mode $(DESTDIR)$(apertium_dan_normodesdir)
	$(INSTALL_DATA) $(PREFIX1b).mode $(DESTDIR)$(apertium_dan_normodesdir)
	$(INSTALL_DATA) $(PREFIX2a).mode $(DESTDIR)$(apertium_dan_normodesdir)
	$(INSTALL_DATA) $(PREFIX2b).mode $(DESTDIR)$(apertium_dan_normodesdir)
	rm $(PREFIX1a).mode $(PREFIX1b).mode $(PREFIX2a).mode $(PREFIX2b).mode
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1a).t1x $(DESTDIR)$(apertium_dan_nordir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1b).t1x $(DESTDIR)$(apertium_dan_nordir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX2).t1x $(DESTDIR)$(apertium_dan_nordir)

CLEANFILES = $(TARGETS_COMMON) 
clean-local: 
	-rm -rf .deps modes

