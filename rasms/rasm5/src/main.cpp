#include "../include/main.h"

// Function to save a list of numbers to a file.
void saveList(const std::string &fileName, NotSTL::Vector<quad> &list) {
  std::ofstream outFile(fileName);  // Open a file for output.

  // Iterate over the list and write each number followed by a newline.
  for (auto num : list) {
    outFile << num << "\n";
  }

  outFile.close();  // Close the file stream.
}

// Function to read a list of numbers from a file into a NotSTL::Vector.
void readList(const std::string &fileName, NotSTL::Vector<quad> &list) {
  std::ifstream inFile(fileName);  // Open a file for input.

  // Read numbers from the file until EOF.
  while (!inFile.eof()) {
    quad num = 0;
    inFile >> num;  // Attempt to read a number.

    // Check if the read operation failed, typically due to invalid data.
    if (inFile.fail()) {
      throw std::invalid_argument("[ERROR]: Read invalid number");
    }

    list.push_back(num);  // Add the number to the list.
  }

  inFile.close();  // Close the file stream.
}

// Function to measure the time taken by a sorting algorithm function.
int benchmarkAlgo(void (*func) (quad arr[], int len), quad arr[], int len) {
  using std::chrono::high_resolution_clock;
  using std::chrono::duration_cast;
  using std::chrono::seconds;

  // Record start time.
  auto t1 = high_resolution_clock::now();
  func(arr, len);  // Execute the sorting function.
  // Record end time.
  auto t2 = high_resolution_clock::now();

  // Calculate the duration in seconds.
  auto secs = duration_cast<seconds>(t2 - t1);

  return secs.count();  // Return the duration in seconds.
}

// Main function that drives the program.
int main() {
  NotSTL::Vector<quad> list;  // Create an instance of a vector to store the numbers.

  Option option;  // Variable to store user-selected options from the menu.
  // Time variables for different sorting methods.
  int c_bubblesort_time = 0;
  int a_bubblesort_time = 0;
  int c_insertionsort_time = 0;
  int a_insertionsort_time = 0;

  // Repeat until the user selects the option to quit.
  do {
    // Display the current status and options.
    std::cout << "RASM5 C vs Assembly\n";
    std::cout << "File Element Count:            " << list.size() << "\n";
    std::cout << "------------------------------------------------\n";
    std::cout << "C        Bubblesort Time:      " << c_bubblesort_time << " secs\n";
    std::cout << "Assembly Bubblesort Time:      " << a_bubblesort_time << " secs\n\n";

    std::cout << "C        Insertion Sort Time:  " << c_insertionsort_time << " secs\n";
    std::cout << "Assembly Insertion Sort Time:  " << a_insertionsort_time << " secs\n";
    std::cout << "------------------------------------------------\n";

    printMenu();  // Display menu options.

    NotSTL::Vector<quad> copiedList = list;  // Create a copy of the list for sorting.

    option = getInput("Enter option: ");  // Get user input.

    // Switch-case to handle user options.
    switch (option) {
      case Option::Load:
        readList("input.txt", list);  // Load list from a file.
        break;
      case Option::BubbleSortC:
        // Benchmark and save results of C bubble sort.
        c_bubblesort_time = benchmarkAlgo(BubbleSort, copiedList.data(), copiedList.size());
        saveList("c_bubblesort.txt", copiedList);
        break;
      case Option::BubbleSortAsm:
        // Benchmark and save results of assembly bubble sort.
        a_bubblesort_time = benchmarkAlgo(bubble_sort, copiedList.data(), copiedList.size());
        saveList("a_bubblesort.txt", copiedList);
        break;
      case Option::InsertionSortC:
        // Benchmark and save results of C insertion sort.
        c_insertionsort_time = benchmarkAlgo(insertionSort, copiedList.data(), copiedList.size());
        saveList("c_insertionsort.txt", copiedList);
        break;
      case Option::InsertionSortAsm:
        // Benchmark and save results of assembly insertion sort.
        a_insertionsort_time = benchmarkAlgo(insertion_sort, copiedList.data(), copiedList.size());
        saveList("a_insertionsort.txt", copiedList);
        break;
      case Option::Quit:
        std::cout << "Thank you!\n";  // Farewell message.
        break;
    }

    std::cout << "\n";
  } while (option != Option::Quit);  // Loop until quit option is selected.

  return 0;  // End of program.
}
