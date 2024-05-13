#include "../include/algorithms.h"

void insertionSort(quad arr[], int len) {
  for (int i = 1; i < len; i++) {
    int j = i;

    while (j > 0 && arr[j - 1] > arr[j]) {
      quad temp = arr[j - 1];
      arr[j - 1] = arr[j];
      arr[j] = temp;
      --j;
    }
  }
}

void BubbleSort(quad a[], int length) {
  int i, j;
  quad temp;

  for (i = 0; i < length; i++) {
    for (j = 0; j < length - i - 1; j++) {
      if (a[j + 1] < a[j]) {
        temp = a[j];
        a[j] = a[j + 1];
        a[j + 1] = temp;
      }
    }
  }
}