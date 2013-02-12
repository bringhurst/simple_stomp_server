BUILT_SOURCES = stomp.h
PARSER = stomp.y stomp.l
AM_YFLAGS = -d

INCLUDES = -I$(top_srcdir)

bin_PROGRAMS = stompd
stompd_SOURCES = stomp.y stompd.c
stompd_LDADD = $(LEXLIB)
stompd_LDFLAGS = $(LIB_LDFLAGS)
