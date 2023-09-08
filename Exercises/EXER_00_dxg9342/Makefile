# Dalio, Brian A.
# dalioba
# 2023-08-01
#-----------------------------------------------------------------
PROJS    = hello.exe leaky.exe overread.exe

#-----------------------------------------------------------------
CC       = gcc

SANFLAGS = -fsanitize=address

CFLAGS   = -g -Wall -Wextra $(SANFLAGS)
LDFLAGS  = $(SANFLAGS)
LDLIBS   = -lm

#-----------------------------------------------------------------
%.o : %.c
	$(CC) $(CFLAGS) -c $^

%.exe : %.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

#-----------------------------------------------------------------
all : $(PROJS)

#-----------------------------------------------------------------
clean:
	rm -f *.o $(PROJS)

#-----------------------------------------------------------------
# address sanitizor works different
# enable leak detection
# don't install gcc through homebrew
# look up: "macos leak sanitizer"
# stackoverflow.com/questions/53456304/mac-os-leaks-sanitzer
