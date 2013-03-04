#
# Makefile --Build rules for ABC files.
#
MK_SRC = abc.mk
subdir	= lang

include devkit.mk 

$(includedir)/%:	%;		$(INSTALL_FILE) $< $@

installdirs:		$(includedir)
install:		$(MK_SRC:%=$(includedir)/%)
