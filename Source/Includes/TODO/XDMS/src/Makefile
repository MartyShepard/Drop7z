

#  xDMS  Makefile


# If you use another compiler change the following line:
CC = gcc


OBJS= u_heavy.o xdms.o u_deep.o u_init.o u_quick.o u_medium.o u_rle.o \
      tables.o pfile.o maketbl.o getbits.o crc_csum.o

CFLAGS = -O3 -Wall
LFLAGS = -s

xdms: $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o xdms 

getbits.o: getbits.c cdata.h getbits.h
	$(CC) $(CFLAGS) -c getbits.c -o getbits.o

tables.o: tables.c cdata.h
	$(CC) $(CFLAGS) -c tables.c -o tables.o

maketbl.o: maketbl.c cdata.h maketbl.h
	$(CC) $(CFLAGS) -c maketbl.c -o maketbl.o

crc_csum.o: crc_csum.c cdata.h crc_csum.h
	$(CC) $(CFLAGS) -c crc_csum.c -o crc_csum.o

u_rle.o: u_rle.c cdata.h u_rle.h
	$(CC) $(CFLAGS) -c u_rle.c -o u_rle.o

u_quick.o: u_quick.c cdata.h u_quick.h getbits.h
	$(CC) $(CFLAGS) -c u_quick.c -o u_quick.o

u_medium.o: u_medium.c cdata.h u_medium.h getbits.h tables.h cdata.h
	$(CC) $(CFLAGS) -c u_medium.c -o u_medium.o

u_deep.o: u_deep.c cdata.h u_deep.h getbits.h
	$(CC) $(CFLAGS) -c u_deep.c -o u_deep.o

u_heavy.o: u_heavy.c cdata.h u_heavy.h getbits.h maketbl.h
	$(CC) $(CFLAGS) -c u_heavy.c -o u_heavy.o

u_init.o: u_init.c cdata.h u_init.h u_quick.h u_medium.h u_deep.h u_heavy.h
	$(CC) $(CFLAGS) -c u_init.c -o u_init.o

xdms.o: xdms.c cdata.h pfile.h crc_csum.h
	$(CC) $(CFLAGS) -c xdms.c -o xdms.o

pfile.o: pfile.c cdata.h u_rle.h u_quick.h u_medium.h u_deep.h \
         u_heavy.h u_init.h crc_csum.h pfile.h
	$(CC) $(CFLAGS) -c pfile.c -o pfile.o


