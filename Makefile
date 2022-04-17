lib.name = mniak
class.sources = lib/mniak.c
# datafiles = myclass1-help.pd myclass2-help.pd README.txt LICENSE.txt

PDLIBDIR=externals/

all: externals/mniak.pd_linux

include pd-lib-builder/Makefile.pdlibbuilder

mniak.pd_linux: post
externals/mniak.pd_linux: mniak.pd_linux
	mv mniak.pd_linux externals/mniak.pd_linux

