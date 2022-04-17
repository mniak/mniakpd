lib.name = mniak
class.sources = lib/mniak.c
# datafiles = myclass1-help.pd myclass2-help.pd README.txt LICENSE.txt
ldflags = lib/mniak_go.o

PDLIBDIR=externals/

all: externals/mniak.pd_linux

include pd-lib-builder/Makefile.pdlibbuilder

mniak.pd_linux: lib/mniak_go.o post
externals/mniak.pd_linux: mniak.pd_linux
	mv mniak.pd_linux externals/mniak.pd_linux


lib/mniak_go.h: lib/mniak_go.o
lib/mniak_go.o: lib/mniak.go
	CGO_ENABLED=1 go build -o lib/mniak_go.o -buildmode=c-shared lib/mniak.go

test-on-pd: lib/mniak.pd_linux test-hello.pd
	pd test-hello.pd

test-c: lib/test_c.exe
	lib/test_c.exe

lib/test_c.exe: lib/test.c lib/mniak_go.o lib/mniak_go.h
	gcc lib/test.c -o lib/test_c.exe lib/mniak_go.o 

	