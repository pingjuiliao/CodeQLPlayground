#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int
main(int argc, char** argv) {
  char buf[20];
  if (argc < 2) {
    exit(-1);
  }
  ssize_t r = read(0, buf, atoi(argv[1]));
  if (r == 0) {
    fprintf(stderr, "[Error] cannot read files\n");
    exit(-1);
  }
  return 0;
}
