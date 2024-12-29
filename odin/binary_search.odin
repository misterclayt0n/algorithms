package main

import "core:fmt"
import "core:math"
import "core:testing"

binary_search :: proc(array: []i32, x: i32) -> bool {
	low := 0.0
	high := cast(f64)len(array)

	for low < high {
		middle := math.floor_f64(low + (high - low) / 2)
		value := array[cast(i32)middle]

		if value == x {
			fmt.println("gotcha bitch!")
			return true
		} else if value > x {
			high = middle
		} else {
			low = middle + 1
		}
 	}

	fmt.println("nope")
	return false
}

@(test)
test_binary_search_success :: proc(t: ^testing.T) {
	array := []i32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	ok := binary_search(array, 10)
	testing.expect(t, ok)
}

@(test)
test_binary_search_fail :: proc(t: ^testing.T) {
	array := []i32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	ok := binary_search(array, 11)
	testing.expect(t, !ok)
}
