#
# abc-jazzchord.sed --Substitutions for jazz chords.
#
s/"\([A-G][b#]*\)ma*j7/"\1^/g
s/"\([A-G][b#]*\)min/"\1\\255/g
s/"\([A-G][b#]*\)dim/"\1\\272/g
s/"\([A-G][b#]*\)m7b5/"\1\\330/g
s/"\([A-G][b#]*\)m/"\1\\255/g
# bebop chords
s/"\([A-G][b#]*7\)#5#9/"\1\\345\\301/g
s/"\([A-G][b#]*7\)b9/"\1\\142 9/g
s/"\([A-G][b#]*7\)#9/"\1\\357 9/g
s/"\([A-G][b#]*\)aug/"\1+/g
s/"\([A-G][b#]*\)7#5/"\1+/g
#
s/"\([A-G][b#]*7*\)add/"\1@/g
# s/"\([A-G][b#]*7*\)sus/"\1\\541/g too big! can't ref this code point
s/"N.C."/"\\265"/g
