#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* src = "Hello, world! This contains more than 20 bytes\n";

int main(int argc, char** argv) {
  char buf[20];
  strcpy(buf, src);
  return 0;
}
