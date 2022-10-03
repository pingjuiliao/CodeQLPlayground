#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char** argv) {
  char buf[20];
  if (argc < 2) {
    fprintf(stderr, "[Usage]: %s <string>", argv[0]);
    exit(-1);
  }
  
  strncpy(buf, argv[1], strlen(argv[1]));
  return 0;
}
