#include "../include/main.h"

void printList(std::vector<int> &list) {
  for (auto num : list) {
    std::cout << num << "\n";
  }
}

int main() {
  std::vector<int> list = {4, 4, 2, 1, 6, 9};

  Option option;

  do {
    printHeader();
    printMenu();

    option = getInput(std::string("Enter option: "));

    switch (option) {
      case Option::Load:
        std::cout << "Loading!\n";
        break;
      case Option::BubbleSortC:
        BubbleSort(list.data(), list.size());
        break;
      case Option::BubbleSortAsm:
        bubble_sort(list.data(), list.size());
        break;
      case Option::InsertionSortC:
        insertionSort(list.data(), list.size());
        break;
      case Option::InsertionSortAsm:
        insertion_sort(list.data(), list.size());
        break;
      case Option::Quit:
        std::cout << "Thank you!\n";
        break;
    }

    std::cout << "\n\n\n";
  } while (option != Option::Quit);

  return 0;
}