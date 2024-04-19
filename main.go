package main

import (
	"fmt"

	al "github.com/misterclayt0n/go-algorithms/algorithms"
	// ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
	arr := []int{3, 6, 8, 10, 1, 2, 1}
	fmt.Println("Array original:", arr)
	fmt.Println("Array ordenado:", al.QuickSort(arr))
}
