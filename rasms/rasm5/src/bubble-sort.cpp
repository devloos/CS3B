void bubbleSort(int arr[], int len) {

  for (int i = 0; i < len; ++i) {
    // condition subtracts one from the end every outer iteration
    for (int j = 1; j < len - i; ++j) {
      // if left is greater than right then swap
      if (arr[j - 1] > arr[j]) {
        int temp = arr[j - 1];
        arr[j - 1] = arr[j];
        arr[j] = temp;
      }
    }
  }

  return;
}