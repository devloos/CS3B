#include "../include/menu.h"
#include <exception>
#include <iostream>
#include <limits>

void printMenu() {
  std::cout << "<1> Load input file.\n";
  std::cout << "<2> Sort using C Bubblesort algorithm.\n";
  std::cout << "<3> Sort using Assembly Bubblesort algorithm.\n";
  std::cout << "<4> Sort using C insertionSort algorithm.\n";
  std::cout << "<5> Sort using Assembly insertionSort algorithm.\n";
  std::cout << "<6> Quit.\n";
}

void printHeader() {

  std::cout << "RASM5 C vs Assembly\n";
  std::cout << "File Element Count:           \n";

  std::cout << "C        Bubblesort Time:      \n";
  std::cout << "Assembly Bubblesort Time:      \n\n";

  std::cout << "C        Insertion Sort Time:  \n";
  std::cout << "Assembly Insertion Sort Time:  \n";
  std::cout << "------------------------------------------------\n";
}

Option getInput(std::string prefix) {
  int option = -1;
  bool inputValid = false;

  while (inputValid == false) {
    try {
      std::cout << prefix;
      std::cin >> option;

      std::cin.clear();
      std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');

      if (std::cin.fail() || option < 1 || option > 6) {
        throw std::invalid_argument("[ERROR]: Option not valid!");
      }

      inputValid = true;
    } catch (std::exception e) {
      std::cerr << e.what();
    }
  }

  return (Option)option;
}