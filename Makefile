ifeq (${OS}, Windows_NT)
#   SHELL=pwsh.exe
  PDBINDIR=D:\ProgramFiles\Purr Data\bin
endif


lib.name = mniak
class.sources = plugin/mniak.c
# datafiles = myclass1-help.pd myclass2-help.pd README.txt LICENSE.txt
ldflags = lib/muslib.o

CC=gcc
PDLIBDIR=${CURDIR}/externals
PDINCLUDEDIR=${CURDIR}/pure-data/src

PLUGINEXT=pd_linux
ifeq (${OS}, Windows_NT)
	PLUGINEXT=dll
endif

all: ${PDLIBDIR}/mniak.${PLUGINEXT}

include pd-lib-builder/Makefile.pdlibbuilder

### Go Library
lib/muslib.o: export CGO_ENABLED = 1
lib/muslib_go.h: lib/muslib.o
lib/muslib.o: lib/muslib.go
	go build -o lib/muslib.o -buildmode=c-shared lib/muslib.go


### PD Plugin
mniak.${PLUGINEXT}: lib/muslib.o post
ifeq (${OS}, Windows_NT)
	${PDLIBDIR}/mniak.${PLUGINEXT}: mniak.${PLUGINEXT}
		move mniak.${PLUGINEXT} ${PDLIBDIR}/mniak.${PLUGINEXT}
else
	${PDLIBDIR}/mniak.${PLUGINEXT}: mniak.${PLUGINEXT}
		mv mniak.${PLUGINEXT} ${PDLIBDIR}/mniak.${PLUGINEXT}
endif


### Tests
test-on-pd: lib/mniak.${PLUGINEXT} test-hello.pd
	pd test-hello.pd

test-c: lib/test_c.exe
	lib/test_c.exe

lib/test_c.exe: lib/test.c lib/muslib.o lib/muslib_go.h
	${CC} lib/test.c -o lib/test_c.exe lib/muslib.o 

	