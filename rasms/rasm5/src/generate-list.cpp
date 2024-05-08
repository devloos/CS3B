#include <fstream>
#include <iostream>
#include <random>

const int LIST_SIZE = 200000;

int main() {
  std::ofstream outFile("input.txt");

  std::random_device rseed;
  std::mt19937 rng(rseed());
  std::uniform_int_distribution<int> dist(INT32_MIN, INT32_MAX);

  for (int i = 0; i < LIST_SIZE; ++i) {
    outFile << dist(rng) << "\n";
  }

  outFile.close();

  return 0;
}