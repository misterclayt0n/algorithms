package main

import (
	"fmt"

	ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
	root := ds.NewBinaryTreeNode(10)
	root.Insert(20)
	root.Insert(30)
	root.Insert(40)

	fmt.Println("In-order traversal:")
	root.InOrder()

	fmt.Println("Pre-order traversal:")
	root.PreOrder()

	fmt.Println("Post-order traversal:")
	root.PostOrder()
}
