package main

import "core:fmt"
import "core:testing"

linear_search :: proc(array: []i32, x: i32) -> bool {
	for item in array {
		if item == x {
			fmt.printf("Found %d!!!\n", x)
			return true
		}
	}

	fmt.printfln("Nope.")
	return false
}

@(test)
test_linear_search_success :: proc(t: ^testing.T) {
	array := []i32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	ok := linear_search(array, 10)
	testing.expect(t, ok)
}

@(test)
test_linear_search_fail :: proc(t: ^testing.T) {
	array := []i32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	ok := linear_search(array, 20)
	testing.expect(t, !ok)
}
