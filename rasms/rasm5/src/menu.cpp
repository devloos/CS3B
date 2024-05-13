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

Option getInput(const std::string &prefix) {
  int option = -1;
  bool inputValid = false;

  while (inputValid == false) {
    try {
      std::cout << prefix;
      std::cin >> option;

      std::cin.clear();
      std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');

      if (std::cin.fail() || option < 1 || option > 6) {
        throw std::invalid_argument("[ERROR]: Option not valid! Try again.");
      }

      inputValid = true;
    } catch (std::exception &e) {
      std::cerr << e.what() << "\n\n";
    }
  }

  return (Option)option;
}