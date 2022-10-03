#include <stdio.h>
#include <stdlib.h>

int 
main(int argc, char** argv) {
  char buf[20]; 
  int r = fgets(buf, 40, stdin);
  if (r == 0) {
    fprintf(stderr, "[Error] Failed on fgets\n");
    exit(-1);
  }
  return 0;
}
