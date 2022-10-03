#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
  char buf[20];
  char* p = fgets(buf, 20, stdin);
  if (!p) {
    fprintf(stderr, "[Error]: Failed on fgets.");
    exit(-1);
  }
  if (buf[0] == 'h') {
    if (buf[1] == 'e')
      if (buf[2] == 'l')
        if (buf[3] == 'l')
          if (buf[4] == 'o')
            puts("flags");
    if (buf[0] == '1') {
      // do nothing
    }
  }

  return 0;
}
