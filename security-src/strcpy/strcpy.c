#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* global_constant = "Hello, world! This contains more than 20 bytes\n";

char global_variable[20];

int main(int argc, char** argv) {
  const char* local_constant = "hello, world, this should be long enough.";
  size_t var_size = atoi(argv[1]);
  char stack_buf[20];
  char* heap_buf = malloc(20);
  char* user_heap_buf = malloc(var_size);

  // BAD
  strcpy(stack_buf, global_constant);
  
  // BAD
  strcpy(heap_buf, local_constant);
  
  // UNKNOWN
  strcpy(user_heap_buf, local_constant);

  // UNKNOWN
  char user_stack_buf[atoi(argv[1])];
  strcpy(user_stack_buf, local_constant);
  
  // UNKNOWN: they are not guaranteed to be terminated on size.
  strcpy(stack_buf, heap_buf);
  
  // UNKNOWN: ditto
  strcpy(heap_buf, stack_buf);

  // UNKNOWN
  strcpy(user_heap_buf, stack_buf);
  
  // UNKNOWN: 3rd use of user_heap_buf is really weird....
  strcpy(user_heap_buf, stack_buf);
  
  // GOOD
  strcpy(heap_buf, "hello");

  // GOOD
  strcpy(heap_buf, global_constant);

  // UNKNOWN
  strcpy(user_stack_buf, user_heap_buf);
  
  // UNKNOWN
  strcpy(user_heap_buf, heap_buf);
  
  // UNKNOWN
  strcpy(user_heap_buf, global_variable);

  // UNKNOWN
  strcpy(user_stack_buf, global_variable);

  // UNKNOWN
  strcpy(stack_buf, global_variable);

  // GOOD
  strcpy(global_variable, "hello");

  return 0;
}
