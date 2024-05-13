#pragma once
#include <string>

enum struct Option {
  Load = 1,
  BubbleSortC,
  BubbleSortAsm,
  InsertionSortC,
  InsertionSortAsm,
  Quit,
};

void printMenu();
void printHeader();

Option getInput(std::string prefix);