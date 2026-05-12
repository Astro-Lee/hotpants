#############################################################
# CFITSIO detection: pkg-config > environment > defaults
#
ifeq ($(shell pkg-config --exists cfitsio && echo yes),yes)
  CFITSIO_CFLAGS = $(shell pkg-config --cflags cfitsio)
  CFITSIO_LIBS   = $(shell pkg-config --libs cfitsio)
else
  CFITSIOINCDIR ?= /usr/local/include
  CFITSIOLIBDIR ?= /usr/local/lib
  CFITSIO_CFLAGS = -I$(CFITSIOINCDIR)
  CFITSIO_LIBS   = -L$(CFITSIOLIBDIR) -lcfitsio
endif

#
#
#############################################################
# INSTALL PATHS
#
PREFIX  ?= /usr/local
DESTDIR ?=

#
#
#############################################################
# COMPILATION OPTIONS
#

# standard usage
COPTS = -funroll-loops -fcommon -O3 -ansi -std=c99 -pedantic-errors -Wall $(CFITSIO_CFLAGS) -D_GNU_SOURCE
LIBS  = $(CFITSIO_LIBS) -lm

# compiler
CC    = gcc

#
#
#############################################################
# BUILD TARGETS
#

STDH  = functions.h globals.h defaults.h
ALL   = main.o vargs.o alard.o functions.o

all:	hotpants extractkern maskim

hotpants: $(ALL)
	$(CC) $(ALL) -o hotpants $(LIBS) $(COPTS)

main.o: $(STDH) main.c
	$(CC) $(COPTS) -c main.c

alard.o: $(STDH) alard.c
	$(CC) $(COPTS) -c alard.c

functions.o: $(STDH) functions.c
	$(CC) $(COPTS) -c functions.c

vargs.o: $(STDH) vargs.c
	$(CC) $(COPTS) -c vargs.c

extractkern: extractkern.o
	$(CC) extractkern.o -o extractkern $(LIBS) $(COPTS)

extractkern.o: $(STDH) extractkern.c
	$(CC) $(COPTS) -c extractkern.c

maskim: maskim.o
	$(CC) maskim.o -o maskim $(LIBS) $(COPTS)

maskim.o: $(STDH) maskim.c
	$(CC) $(COPTS) -c maskim.c

install:
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 0755 hotpants $(DESTDIR)$(PREFIX)/bin/hotpants
	install -m 0755 maskim $(DESTDIR)$(PREFIX)/bin/maskim
	install -m 0755 extractkern $(DESTDIR)$(PREFIX)/bin/extractkern

clean:
	rm -f *.o
	rm -f *~ .*~
	rm -f hotpants
	rm -f extractkern
	rm -f maskim

.PHONY: all install clean
