package main

import (
	// al "github.com/misterclayt0n/go-algorithms/algorithms"
	"fmt"

	ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
	m := &ds.MinHeap{}

	fmt.Println(m)

	m.Insert(10)
	m.Insert(20)
	m.Insert(30)
	m.Insert(5)
	m.Insert(40)
	m.Insert(50)

	fmt.Println(m.Array)

	fmt.Println("Extracted:", m.Extract())
	fmt.Println(m.Array)
}
