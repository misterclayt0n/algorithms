package data_structures

import "fmt"

type BinaryTreeNode struct {
	Value int
	Left  *BinaryTreeNode
	Right *BinaryTreeNode
}

func NewBinaryTreeNode(value int) *BinaryTreeNode {
	return &BinaryTreeNode{Value: value}
}

func (b *BinaryTreeNode) InOrder() {
	if b == nil {
		return
	}

	b.Left.InOrder()
	fmt.Println(b.Value)
	b.Right.InOrder()
}

func (b *BinaryTreeNode) PreOrder() {
	if b == nil {
		return
	}

	fmt.Println(b.Value)
	b.Left.PreOrder()
	b.Right.PreOrder()
}

func (b *BinaryTreeNode) PostOrder() {
	if b == nil {
		return
	}

	b.Left.PostOrder()
	b.Right.PostOrder()
	fmt.Println(b.Value)
}

func (b *BinaryTreeNode) Insert(value int) {
	if value <= b.Value {
		if b.Left == nil {
			b.Left = NewBinaryTreeNode(value)
		} else {
			b.Left.Insert(value)
		}
	} else {
		if b.Right == nil {
			b.Right = NewBinaryTreeNode(value)
		} else {
			b.Right.Insert(value)
		}
	}
}
