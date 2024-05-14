package data_structures

import "fmt"

type nodeDoublyList struct {
	Value    int
	Next     *nodeDoublyList
	Previous *nodeDoublyList
}

type DoublyLinkedList struct {
	Head *nodeDoublyList
	Tail *nodeDoublyList
}

func (d *DoublyLinkedList) Prepend(value int) {
	newNode := &nodeDoublyList{Value: value}

	if d.Head == nil {
		d.Head = newNode
		d.Tail = newNode
	} else {
		newNode.Next = d.Head
		d.Head.Previous = newNode
		d.Head = newNode
	}
}

func (d *DoublyLinkedList) Append(value int) {
	newNode := &nodeDoublyList{Value: value}

	if d.Head == nil {
		d.Head = newNode
		d.Tail = newNode
	} else {
		newNode.Previous = d.Tail
		d.Tail.Next = newNode
		d.Tail = newNode
	}
}

func (d *DoublyLinkedList) InsertAt(value, index int) {
	newNode := &nodeDoublyList{Value: value}

	if index <= 0 || d.Head == nil {
		d.Prepend(value)
		return
	}

	current := d.Head
	for i := 0; i < index-1 && current.Next != nil; i++ {
		current = current.Next
	}

	if current.Next == nil {
		d.Append(value)
		return
	}

	newNode.Next = current.Next
	newNode.Previous = current
	current.Next.Previous = newNode
	current.Next = newNode
}

func (d *DoublyLinkedList) RemoveFirst() *nodeDoublyList {
	if d.Head == nil {
		return nil
	}

	temp := d.Head
	d.Head = d.Head.Next

	if d.Head == nil {
		d.Tail = nil
	} else {
		d.Head.Previous = nil
	}

	temp.Next = nil // clean removed node
	return temp
}

func (d *DoublyLinkedList) RemoveLast() *nodeDoublyList {
	if d.Head == nil {
		return nil
	}

	temp := d.Tail
	d.Tail = d.Tail.Previous

	if d.Tail == nil {
		d.Head = nil
	} else {
		d.Tail.Next = nil
	}

	temp.Previous = nil // clean removed node
	return temp
}

func (d *DoublyLinkedList) RemoveAt(index int) *nodeDoublyList {
	if d.Head == nil || index < 0 {
		return nil
	}

	if index == 0 {
		return d.RemoveFirst()
	}

	current := d.Head
	for i := 0; i < index && current != nil; i++ {
		current = current.Next
	}

	if current == nil {
		return nil
	}

	if current.Next == nil {
		return d.RemoveLast()
	}

	current.Previous.Next = current.Previous
	current.Next.Previous = current.Previous

	current.Previous = nil
	current.Next = nil
	return current
}

func (d *DoublyLinkedList) Get(index int) *nodeDoublyList {
	if index < 0 {
		return nil
	}

	current := d.Head
	for i := 0; i < index && current != nil; i++ {
		current = current.Next
	}

	return current
}

func (d *DoublyLinkedList) Print() {
	current := d.Head
	for current != nil {
		fmt.Print(current.Value)
		if current.Next != nil {
			fmt.Print(" <-> ")
		}
		current = current.Next
	}

	fmt.Println()
}
