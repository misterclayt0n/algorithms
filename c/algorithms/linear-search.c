#include <stdbool.h>
#include <stdio.h>

bool linear_search(int array[], int x, int array_size) {
  for (int i = 0; i < array_size; i++) {
    if (array[i] == x) {
      printf("found it :)\n");
      return true;
    }
  }

  printf("didn't found it :(\n");
  return false;
}

int main() {
  int array[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10000};
  int x = 10001;
  int n = sizeof(array) / sizeof(array[0]);

  linear_search(array, x, n);
  return 0;
}
