package algorithms

import "fmt"

func BubbleSort(array []int) {
	for i := 0; i < len(array); i++ {
		for j := 0; j < len(array)-1-i; j++ {
			if array[j] > array[j+1] {
				tmp := array[j]
				array[j] = array[j+1]
				array[j+1] = tmp
			}
		}
	}

	fmt.Printf("%d\n", array)
}
