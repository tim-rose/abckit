#
# ABC.MK --Rules for working with ABC files.
#
# Contents:
# build:    --c-specific customisations for the "build" target.
# %pdf:     --Build a printable document from an abc file.
# %-8va:    --Shift by octaves
# %-Db.abc: --Transposition rules.
#
#
# build: --c-specific customisations for the "build" target.
#

pre-build:	src-var-defined[ABC_SRC]

# 
# %pdf: --Build a printable document from an abc file.
#
%.pdf: %.abc
	abcm2ps $(ABC_FLAGS) -O $*.ps $*.abc
	pstopdf $*.ps && rm $*.ps
#
# %-8va: --Shift by octaves
#
%+8va.abc: %.abc;	  abc2abc $*.abc -rbt +12 > $@
%-8va.abc: %.abc;	  abc2abc $*.abc -rbt -12 > $@

#
# %-jc.abc --Jazz-chord ligatures (if you have the right font)
#
%-jc.abc: %.abc
	sed -f abc-jazzchord <$*.abc >$@

clean:	clean-abc
clean-abc:
	$(RM) $(ABC_SRC:.abc=.pdf) $(ABC_SRC:.abc=.ps)
	$(RM) $(ABC_SRC:.abc=-[ABCDEFG][.-]*)  $(ABC_SRC:.abc=-[ABCDEFG][+b][.-].*) 
	$(RM) $(ABC_SRC:.abc=[-+]8va.*)

src:	;	mk-filelist -n ABC_SRC *.abc

#
# %-Db.abc: --Transposition rules.
#
# Remarks:
# These rules transpose "for" the specified keyed-instrument, e.g. "x-Bb.abc"
# will transpose for a Bb instrument (trumpet etc.).
#
%-Db.abc:	%.abc; abc-transpose -T Db $*.abc > $@
%-D.abc:	%.abc; abc-transpose -T D $*.abc > $@
%-Eb.abc:	%.abc; abc-transpose -T Eb $*.abc > $@
%-E.abc:	%.abc; abc-transpose -T E $*.abc > $@
%-F.abc:	%.abc; abc-transpose -T F $*.abc > $@
%-F+.abc:	%.abc; abc-transpose -T 'F#' $*.abc > $@
%-G.abc:	%.abc; abc-transpose -T G $*.abc > $@
%-Ab.abc:	%.abc; abc-transpose -T Ab $*.abc > $@
%-A.abc:	%.abc; abc-transpose -T A $*.abc > $@
%-Bb.abc:	%.abc; abc-transpose -T Bb $*.abc > $@
%-B.abc:	%.abc; abc-transpose -T B $*.abc > $@

