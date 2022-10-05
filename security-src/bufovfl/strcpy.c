#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* global_constant = "Hello, world! This contains more than 20 bytes\n";

int main(int argc, char** argv) {
  const char* local_constant = "hello, world, this should be long enough.";
  size_t var_size = atoi(argv[1]);
  char stack_buf[20];
  char* heap_buf = malloc(20);
  char* user_heap_buf = malloc(var_size);

  // Fixed-size but BAD
  strcpy(stack_buf, global_constant);
  
  // Fixed-size but BAD
  strcpy(heap_buf, local_constant);
  
  // Variable-size: could be BAD
  strcpy(user_heap_buf, local_constant);

  // Variable-size: could be BAD
  char user_stack_buf[atoi(argv[1])];
  strcpy(user_stack_buf, local_constant);
  
  // Fixed-size and GOOD 
  strcpy(stack_buf, heap_buf);
  strcpy(heap_buf, stack_buf);

  // Variable-size: 2nd use of user_heap_buf seems ok...
  strcpy(user_heap_buf, stack_buf);
  
  // Variable-size: 3rd use of user_heap_buf is really weird....
  strcpy(user_heap_buf, stack_buf);
  
  // Fixed-size: GOOD
  strcpy(heap_buf, "hello");

  // Fixed-size: BAD
  strcpy(heap_buf, global_constant);

  // Variable-size: could be BAD
  strcpy(user_stack_buf, user_heap_buf);
  
  // Variable-size:
  strcpy(user_heap_buf, heap_buf);

  return 0;
}
