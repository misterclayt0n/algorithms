package algorithms

import (
	"fmt"
	"math"
)

func BinarySearch(array []int, x int) bool {
	low := 0.0
	high := float64(len(array))

	for low < high {
		middle := math.Floor(low + (high-low)/2)
		value := array[int64(middle)]

		if value == x {
			fmt.Println("found it!!")
			return true
		} else if value > x {
			high = middle
		} else {
			low = middle + 1
		}
	}

	fmt.Println("nope")
	return false
}
