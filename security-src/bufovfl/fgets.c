#include <stdio.h>
#include <stdlib.h>

int 
main(int argc, char** argv) {
  char buf[20];
  if (argc < 2) {
    exit(-1);
  }
  char* p = fgets(buf, atoi(argv[1]), stdin);
  if (!p) {
    fprintf(stderr, "[Error] Failed on fgets\n");
    exit(-1);
  }
  return 0;
}
