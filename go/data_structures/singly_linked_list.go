package data_structures

import (
	"fmt"
)

// type node
type nodeLinkedList struct {
	Value int
	Next  *nodeLinkedList
}

// type linkedlist
type SinglyLinkedList struct {
	Head *nodeLinkedList
}

// insert at the beginning -> prepend
func (ll *SinglyLinkedList) Prepend(value int) {
	newNode := &nodeLinkedList{Value: value}

	newNode.Next = ll.Head
	ll.Head = newNode
}

func (ll *SinglyLinkedList) Print() {
	// first nodeLinkedList
	current := ll.Head

	for current != nil {
		fmt.Print(current.Value, "->")
		current = current.Next
	}
}

func (ll *SinglyLinkedList) RemoveFirst() {
	if ll.Head != nil {
		ll.Head = ll.Head.Next
	}
}
