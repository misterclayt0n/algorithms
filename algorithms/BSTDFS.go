package algorithms

import (
	"fmt"

	ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func DFSPreOrder(node *ds.BSTNode) {
	if node == nil {
		return
	}

	fmt.Print(node.Value, "")
	DFSPreOrder(node.Left)
	DFSPreOrder(node.Right)
}

func DFSInOrder(node *ds.BSTNode) {
	if node == nil {
		return
	}

	DFSPreOrder(node.Left)
	fmt.Print(node.Value, "")
	DFSPreOrder(node.Right)
}

func DFSPostOrder(node *ds.BSTNode) {
	if node == nil {
		return
	}

	DFSPreOrder(node.Left)
	DFSPreOrder(node.Right)
	fmt.Print(node.Value, "")
}
