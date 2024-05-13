#pragma once
#include "algorithms.h"
#include "menu.h"
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <exception>
#include <chrono>

typedef long long quad;

extern "C" void insertion_sort(quad arr[], int len);
extern "C" void bubble_sort(quad arr[], int len);