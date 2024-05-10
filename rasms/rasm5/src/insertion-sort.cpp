void insertionSort(int arr[], int len) {
  for (int i = 0; i < len; ++i) {
    int j = i + 1;

    // we continue to swap until we find a place for arr[j]
    while (j >= 0 && arr[j - 1] > arr[j]) {
      int temp = arr[j - 1];
      arr[j - 1] = arr[j];
      arr[j] = temp;

      --j;
    }
  }
}