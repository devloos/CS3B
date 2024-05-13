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

Option getInput(const std::string &prefix);