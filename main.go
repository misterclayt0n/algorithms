package main

import (
	ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
	dll := ds.DoublyLinkedList{}
	dll.Append(10)
	dll.Append(20)
	dll.Append(30)
	dll.Print()
	dll.RemoveLast()
	dll.Print()
	dll.InsertAt(40, 1)
	dll.Print()
}
