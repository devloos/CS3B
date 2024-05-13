#include "../include/main.h"

void saveList(const std::string &fileName, std::vector<quad> &list) {
  std::ofstream outFile(fileName);

  for (auto num : list) {
    outFile << num << "\n";
  }

  outFile.close();
}

void readList(const std::string &fileName, std::vector<quad> &list) {
  std::ifstream inFile(fileName);

  while (!inFile.eof()) {
    quad num = 0;
    inFile >> num;

    if (inFile.fail()) {
      throw std::invalid_argument("[ERROR]: Read invalid number");
    }

    list.push_back(num);
  }

  inFile.close();
}

int benchmarkAlgo(void (*func) (quad arr[], int len), quad arr[], int len) {
  using std::chrono::high_resolution_clock;
  using std::chrono::duration_cast;
  using std::chrono::seconds;

  auto t1 = high_resolution_clock::now();
  func(arr, len);
  auto t2 = high_resolution_clock::now();

  // get delta T
  auto secs = duration_cast<seconds>(t2 - t1);

  return secs.count();
}

int main() {
  std::vector<quad> list;

  Option option;
  int c_bubblesort_time = 0;
  int a_bubblesort_time = 0;
  int c_insertionsort_time = 0;
  int a_insertionsort_time = 0;

  do {
    std::cout << "RASM5 C vs Assembly\n";
    std::cout << "File Element Count:            " << list.size() << "\n";
    std::cout << "------------------------------------------------\n";
    std::cout << "C        Bubblesort Time:      " << c_bubblesort_time << " secs\n";
    std::cout << "Assembly Bubblesort Time:      " << a_bubblesort_time << " secs\n\n";

    std::cout << "C        Insertion Sort Time:  " << c_insertionsort_time << " secs\n";
    std::cout << "Assembly Insertion Sort Time:  " << a_insertionsort_time << " secs\n";
    std::cout << "------------------------------------------------\n";

    printMenu();

    std::vector<quad> copiedList = list;

    option = getInput("Enter option: ");

    switch (option) {
      case Option::Load:
        readList("input.txt", list);
        break;
      case Option::BubbleSortC:
        c_bubblesort_time = benchmarkAlgo(BubbleSort, copiedList.data(), copiedList.size());
        saveList("c_bubblesort.txt", copiedList);
        break;
      case Option::BubbleSortAsm:
        a_bubblesort_time = benchmarkAlgo(bubble_sort, copiedList.data(), copiedList.size());
        saveList("a_bubblesort.txt", copiedList);
        break;
      case Option::InsertionSortC:
        c_insertionsort_time = benchmarkAlgo(insertionSort, copiedList.data(), copiedList.size());
        saveList("c_insertionsort.txt", copiedList);
        break;
      case Option::InsertionSortAsm:
        a_insertionsort_time = benchmarkAlgo(insertion_sort, copiedList.data(), copiedList.size());
        saveList("a_insertionsort.txt", copiedList);
        break;
      case Option::Quit:
        std::cout << "Thank you!\n";
        break;
    }

    system("clear");
  } while (option != Option::Quit);

  return 0;
}