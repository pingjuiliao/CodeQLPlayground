CC=gcc

all: hello.exe
%.exe: %.c
	$(CC) -o $@ $<
clean:
	rm $(wildcard *.exe)
