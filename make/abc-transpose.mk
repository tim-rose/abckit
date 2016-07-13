
ABC_TRANSPOSE ?= abc-transpose
#
# %-8va: --Shift the key of a tune by an entire octave.
#
%+8va.abc: %.abc;	  abc2abc $*.abc -r -b -t +12 > $@
%-8va.abc: %.abc;	  abc2abc $*.abc -r -b -t -12 > $@

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
%-Db.abc:	%.abc; $(ABC_TRANSPOSE) -T Db $*.abc > $@
%-D.abc:	%.abc; $(ABC_TRANSPOSE) -T D $*.abc > $@
%-Eb.abc:	%.abc; $(ABC_TRANSPOSE) -T Eb $*.abc > $@
%-E.abc:	%.abc; $(ABC_TRANSPOSE) -T E $*.abc > $@
%-F.abc:	%.abc; $(ABC_TRANSPOSE) -T F $*.abc > $@
%-F+.abc:	%.abc; $(ABC_TRANSPOSE) -T 'F#' $*.abc > $@
%-G.abc:	%.abc; $(ABC_TRANSPOSE) -T G $*.abc > $@
%-Ab.abc:	%.abc; $(ABC_TRANSPOSE) -T Ab $*.abc > $@
%-A.abc:	%.abc; $(ABC_TRANSPOSE) -T A $*.abc > $@
%-Bb.abc:	%.abc; $(ABC_TRANSPOSE) -T Bb $*.abc > $@
%-B.abc:	%.abc; $(ABC_TRANSPOSE) -T B $*.abc > $@


#
# clean: Remove auto-transposed ABC/PDF files.
#
clean:	clean-abc
clean-abc:
	$(RM) $(ABC_SRC:%.abc=%*-[ABCDEFG][+b]*.abc)
	$(RM) $(ABC_SRC:%.abc=%*[-+]8va.abc)
	$(RM) $(ABC_SRC:%.abc=%*-jc.abc)
