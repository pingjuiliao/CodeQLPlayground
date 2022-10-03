#include <stdio.h>
#include <unistd.h>

int
main(int argc, char** argv) {
  char buf[20];
  ssize_t r = read(0, buf, 40);
  if (r == 0) {
    fprintf(stderr, "[Error] cannot read files\n");
    exit(-1);
  }
  return 0;
}
