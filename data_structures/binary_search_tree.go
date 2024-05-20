package data_structures

import "fmt"

type BSTNode struct {
	Value int
	Left  *BSTNode
	Right *BSTNode
}

func NewBSTNode(value int) *BSTNode {
	return &BSTNode{Value: value}
}

func (n *BSTNode) Insert(value int) {
	if value < n.Value {
		if n.Left == nil {
			n.Left = &BSTNode{Value: value}
		} else {
			n.Left.Insert(value)
		}
	} else {
		if n.Right == nil {
			n.Right = &BSTNode{Value: value}
		} else {
			n.Right.Insert(value)
		}
	}
}

func (n *BSTNode) Search(value int) bool {
	if n == nil {
		return false
	}

	if value < n.Value {
		return n.Left.Search(value)
	} else if value > n.Value {
		return n.Right.Search(value)
	}
	return true
}

func (n *BSTNode) findMin() *BSTNode {
	current := n

	for current.Left != nil {
		current = current.Left
	}

	return current
}

func (n *BSTNode) Remove(value int) *BSTNode {
	if n == nil {
		return nil
	}

	if value < n.Value {
		n.Left = n.Left.Remove(value)
	} else if value > n.Value {
		n.Right = n.Right.Remove(value)
	} else {
		// case 1 - node without children
		if n.Left == nil && n.Right == nil {
			return nil
		}
		// case 2 - node with 1 child
		if n.Left == nil {
			return n.Right
		}
		if n.Right == nil {
			return n.Left
		}
		// case 3 - node with 2 children
		// find smallest value in the right subtree
		minRight := n.Right.findMin()
		n.Value = minRight.Value
		n.Right = n.Right.Remove(minRight.Value)
	}
	return n
}

func (n *BSTNode) PrintInOrder() {
	if n == nil {
		return
	}

	n.Left.PrintInOrder()
	fmt.Print(n.Value, " ")
	n.Right.PrintInOrder()
}
