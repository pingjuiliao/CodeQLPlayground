#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* more_len = "Hello, world! This contains more than 20 bytes\n";
const char* less_len = "Hello, world!";
char fixed_size_global[20];


int main(int argc, char** argv) {
  char fixed_size_buf[20];
  char literal_init_buf[] = {'a', 'b', 'c'};
  size_t cpy_size;
  // BAD
  memcpy(fixed_size_global, more_len, strlen(more_len));
  
  // BAD
  size_t strlen_var = strlen(more_len);
  memcpy(fixed_size_buf, more_len, strlen_var);

  // BAD
  memcpy(fixed_size_global, more_len, 40);

  // BAD
  memcpy(fixed_size_buf, more_len, atoi(argv[1]));

  // BAD
  if (rand() % 2) {
    cpy_size = 20;
  } else {
    cpy_size = 40;
  }
  memcpy(fixed_size_buf, more_len, cpy_size);
  
  memcpy(literal_init_buf, more_len, cpy_size);
  
  /*
  char *buf = NULL;
  if (rand() % 2) {
    buf = fixed_size_buf;
  } else {
    buf = literal_init_buf;
  }
  memcpy(buf, more_len, cpy_size);
  */

  // BAD: OVERREAD
  // memcpy(fixed_size_buf, less_len, 20);

  // GOOD
  memcpy(fixed_size_buf, more_len, strlen(less_len));
  strlen_var = 10;
  memcpy(fixed_size_buf, more_len, strlen_var);

  memcpy(fixed_size_buf, more_len, 20);
  memcpy(fixed_size_buf, more_len, sizeof(fixed_size_buf));

  puts(less_len);

  return 0;
}
