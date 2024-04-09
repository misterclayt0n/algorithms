package main

import (
	"fmt"
	// al "github.com/misterclayt0n/go-algorithms/algorithms"
	ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
	s := ds.Stack{}
	s.Push(10)
	s.Push(20)
	s.Push(30)

	fmt.Println("Current Top:", s.Peek()) // Deve mostrar "3"
	fmt.Println("Pop:", s.Pop())          // Deve mostrar "3"
	fmt.Println("Pop:", s.Pop())          // Deve mostrar "2"
	fmt.Println("Pop:", s.Pop())          // Deve mostrar "1"
}
