package data_structures

import (
	"fmt"
)

// type node
type Node struct {
	Value int
	Next  *Node
}

// type linkedlist
type SinglyLinkedList struct {
	Head *Node
}

// insert at the beginning -> prepend
func (ll *SinglyLinkedList) Prepend(value int) {
	newNode := &Node{Value: value}

	newNode.Next = ll.Head
	ll.Head = newNode
}

func (ll *SinglyLinkedList) Print() {
	// first node
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
