# Abckit --tools for manipulating "abc" format music files

ABC is a simple text format for describing music.  This project
contains a handful of commands for manipulating these files.  I use
them with make rules, which are defined in make include file.

## Installation

If you have devkit installed, you can install via make:

```bash
make installdirs install
```

However, there's not much here, and you can also simply install them
with the following commands:

```bash
prefix=/usr/local
installdir $prefix/bin
install -m 755 abc-index.sh        $prefix/bin/abc-index
install -m 755 abc-transpose.sh    $prefix/bin/abc-transpose
install -m 755 abc-jazzchord.sed   $prefix/bin/abc-jazzchord
```
