package main

import (
	// "fmt"

	// al "github.com/misterclayt0n/go-algorithms/algorithms"
	"fmt"

	ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
	AVLTree := ds.NewAVLTree()
	AVLTree.Insert(10)
	AVLTree.Insert(20)
	AVLTree.Insert(30)
	AVLTree.Insert(40)
	AVLTree.Insert(50)
	AVLTree.Insert(25)

	fmt.Println("pre-order traversal of the constructed AVL tree:")
    AVLTree.PreOrder(AVLTree.Root)
}
