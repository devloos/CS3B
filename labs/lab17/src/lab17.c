#include <stdio.h>
#include <string.h>

extern int string_length(char *arg);

int main() {
  char *str = "Cat in the hat.";

  printf("C String length: %li\n", strlen(str));
  printf("ASM String length: %i\n", string_length(str));

  return 0;
}
