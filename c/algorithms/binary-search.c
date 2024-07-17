#include <stdio.h>
#include <stdbool.h>
#include <math.h>

bool binary_search(int array[], int x, int n) {
    int low = 0;
    int high = n;

    while (low < high) {
        int middle = (int)floor(low + (high - low) / 2.0);
        int value = array[middle];

        if (value == x) {
            printf("found it fellas!\n");
            return true;
        } else if (value > x) {
            high = middle;
        } else {
            low = middle + 1;
        }
    }

    printf("nope\n");
    return false;
}

int main() {
    int array[] = {1, 2, 3, 4, 5, 6, 7, 8, 99, 1010};

    int n = sizeof(array) / sizeof(array[0]);
    int x = 8;

    binary_search(array, x, n);

    return 0;
}
