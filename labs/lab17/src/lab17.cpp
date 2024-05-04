#include <iostream>
#include <string.h>

extern "C" int string_length(const char *arg);

int main() {
  const char *str = "Cat in the hat.";

  std::cout << "C String length: " << strlen(str) << "\n";
  std::cout << "ASM String length: " << string_length(str) << "\n";

  return 0;
}
