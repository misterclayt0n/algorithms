package main

import (
	// "fmt"

	// al "github.com/misterclayt0n/go-algorithms/algorithms"
	"fmt"

	ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
    tree := ds.NewRedBlackTree()
    tree.Insert(10)
    tree.Insert(20)
    tree.Insert(30)
    tree.Insert(40)
    tree.Insert(50)
    tree.Insert(25)

    fmt.Println("pre-order traversal of the constructed red-black tree:")
    tree.PreOrder(tree.Root)
}
