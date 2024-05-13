#include <fstream>
#include <iostream>
#include <random>
#include <climits>


const int LIST_SIZE = 200000;

int main() {
  std::ofstream outFile("input.txt");

  /**
   * A standard interface to a platform-specific non-deterministic
   * random number generator (if any are available).
   */
  std::random_device rseed;

  // A generalized feedback shift register discrete random number generator.
  std::mt19937 rng(rseed());

  // A discrete random distribution on the range @f$[min, max]@f$ with equal
  std::uniform_int_distribution<long long> dist(LLONG_MIN, LLONG_MAX);

  for (int i = 0; i < LIST_SIZE; ++i) {
    outFile << dist(rng) << "\n";
  }

  outFile.close();

  return 0;
}