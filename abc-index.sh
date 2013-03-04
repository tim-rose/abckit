#!/bin/sh
#
# ABC-INDEX --Merge a list of ABC files.
#
# Contents:
#
# Remarks:
# Really all we need to do is munge the "X" index records.
# 
usage="abc-index [-n] [-x=start] file.abc..."

log_message() { printf "$@"; printf "\n"; } >&2
notice()      { log_message "$@"; }
info()        { if [ "$verbose" ]; then log_message "$@"; fi; }
debug()       { if [ "$debug" ]; then log_message "$@"; fi; }
log_quit()    { notice "$@"; exit 1 ; }

#
# process command-line options
#
while getopts "nx:vq_" c
do
    case $c in
    [bers])	abc_opts="${abc_opts} -$c";;
    n)	new_page=1;;
    x)	index=$OPTARG;;
    v)	verbose=1; debug=;;
    q)	verbose=; debug=;;
    _)	verbose=1; debug=1;;
    \?)	echo $usage >&2
	exit 2;;
    esac
done
shift $(($OPTIND - 1))

for file; do
    if [ -f "$file" ]; then
	info 'abc-index: %s' "$file"
    else
	warning '%s: no such file' "$file"
	continue
    fi
    if [ "$new_page" ]; then
	echo "%%newpage"
    fi
    while read line; do
	case "$line" in
	X:*)
	    echo "X: $index"
	    index=$(($index+1))
	    ;;
	*)
	    echo "$line"
	    ;;
	esac
    done <$file
    echo ""			# blank line separates tunes
done
