package main

import (
	"fmt"

	al "github.com/misterclayt0n/go-algorithms/algorithms"
	// ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
	root := al.NewBinaryNode(10)
	root.Left = al.NewBinaryNode(20)
	root.Right = al.NewBinaryNode(30)
	root.Left.Left = al.NewBinaryNode(40)
	root.Right.Right = al.NewBinaryNode(50)
	root.Right.Left = al.NewBinaryNode(60)
	root.Left.Right = al.NewBinaryNode(70)

	needle := 30
	if al.Bfs(root, needle) {
		fmt.Printf("valor %d encontrado na árvore\n", needle)
	} else {
		fmt.Printf("valor %d não encontrado na árvore\n", needle)
	}
}
