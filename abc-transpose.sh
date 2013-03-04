#!/bin/sh
#
# ABC-TRANSPOSE --Utility for transposing "abc" music files.
#
# Remarks:
# This is just a cheezy wrapper aournd abc2abc.
#
usage="Usage: abc-transpose [-T key] file..."
abc_opts=-b

trap "rm -f abc-transpose-$$.tmp" 0

log_message() { printf "$@"; printf "\n"; } >&2
notice()      { log_message "$@"; }
info()        { if [ "$verbose" ]; then log_message "$@"; fi; }
debug()       { if [ "$debug" ]; then log_message "$@"; fi; }
log_quit()    { notice "$@"; exit 1 ; }

#
# transpose_name() --Echo the key for transposition as a  delta from "C"
#
transpose_name()
{
    case $1 in
    -1|+11) echo "Db";;
    -2|+10) echo "D";;
    -3|+9)  echo "Eb";;
    -4|+8)  echo "E";;
    -5|+7)  echo "F";;
    -6|+6)  echo "F#";;
    -7|+5)  echo "G";;
    -8|+4)  echo "Ab";;
    -9|+3)  echo "A";;
    -10|+2) echo "Bb";;
    -11|+1) echo "B";;
    esac
}

#
# transpose_delta() --Echo the transposition delta for an instrument.
#
transpose_delta()
{
    case $1 in
    C#|Db) echo "-1";;
    D)	   echo "-2";;
    D#|Eb) echo "-3";;
    E)     echo "-4";;
    F)     echo "-5";;
    F#|Gb) echo "+6";;
    G)     echo "+5";;
    G#|Ab) echo "+4";;
    A)     echo "+3";;
    A#|Bb) echo "+2";;
    B)     echo "+1";;
    esac
}

#
# process command-line options
#
while getopts "ben:rst:T:vq_" c
do
    case $c in
    [bers])	abc_opts="${abc_opts} -$c";;
    n)	abc_opts="${abc_opts} -$c $OPTARG";;
    t)	title="(transposed for $(transpose_name $OPTARG) instrument)"
	abc_opts="${abc_opts} -$c $OPTARG";;
    T)	title="(transposed for $OPTARG instrument)"
	abc_opts="${abc_opts} -t $(transpose_delta $OPTARG)";;
    v)	verbose=1; debug=;;
    q)	verbose=; debug=;;
    _)	verbose=1; debug=1;;
    \?)	echo $usage >&2
	exit 2;;
    esac
done
shift $(($OPTIND - 1))


if abc2abc $1 $abc_opts >abc-transpose-$$.tmp; then
    awk "
BEGIN { 
    new_tune=1; 
    seen_title=0;
    in_title=0;
}
/^$/ { 
    new_tune=1;
    seen_title=0
}

/^T:/ {
    if (!seen_title) {
        in_title=1;
    }
    seen_title=1;
}

/^[^T]/ {
    if (in_title) {
        in_title=0
        print \"T:$title\"
    }
}
{
    print
}
" abc-transpose-$$.tmp 
fi

