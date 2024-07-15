package algorithms

import "fmt"

func LinearSearch(array []int, x int) bool {
	for i := 0; i < len(array); i++ {
		if array[i] == x {
			fmt.Println("true")
			return true
		}
	}
	fmt.Println("false")

	return false
}
