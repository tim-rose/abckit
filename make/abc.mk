#
# ABC.MK --Rules for working with ABC files.
#
# Contents:
# pre-build: --Ensure that the "ABC_SRC" macro is defined.
# %pdf:      --Build a printable document from an abc file.
# %-8va:     --Shift the key of a tune by an entire octave.
# %-Db.abc:  --Transposition rules.
# src-abc:   --Define the "ABC_SRC" macro.
#
#
# pre-build: --Ensure that the "ABC_SRC" macro is defined.
#
pre-build:	src-var-defined[ABC_SRC]

#
# %pdf: --Build a printable document from an abc file.
#
%.pdf: %.abc
	abcm2ps $(ABC_FLAGS) -O $*.ps $*.abc
	pstopdf $*.ps && rm $*.ps

#
# %-8va: --Shift the key of a tune by an entire octave.
#
%+8va.abc: %.abc;	  abc2abc $*.abc -rbt +12 > $@
%-8va.abc: %.abc;	  abc2abc $*.abc -rbt -12 > $@

#
# %-jc.abc --Apply Jazz-chord ligatures (assumes you have the right font).
#
%-jc.abc: %.abc
	sed -f abc-jazzchord <$*.abc >$@

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

#
# clean-abc: Remove PDF and PostScript files.
#
clean:	clean-abc
clean-abc:
	$(RM) $(ABC_SRC:.abc=.pdf) $(ABC_SRC:.abc=.ps)
	$(RM) $(ABC_SRC:.abc=*-[ABCDEFG][+b]*[-.]*)
	$(RM) $(ABC_SRC:.abc=[-+]8va.*)

#
# src-abc: --Define the "ABC_SRC" macro.
#
src:	src-abc
src-abc:	;	mk-filelist -n ABC_SRC *.abc
