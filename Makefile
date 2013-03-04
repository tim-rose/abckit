#
# Makefile --Build rules for "abckit", ABC format music tools..
#
#
PACKAGE	= abckit
VERSION	= 0.0
RELEASE	= 0
ARCH	= all
SRC_LANG	= sh nroff

SH_SRC = abc-index.sh abc-transpose.sh
SED_SRC = abc-jazzchord.sed

include devkit.mk package.mk

installdirs:	$(man1dir) $(bindir)
install:	$(MAN1_SRC:%.1=$(man1dir)/%.1)
install:	$(SH_SRC:%.sh=$(bindir)/%)
install:	$(SED_SRC:%.sed=$(bindir)/%)
install:	$(C_MAIN:$(archdir)/%=$(bindir)/%)
