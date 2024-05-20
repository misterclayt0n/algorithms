package main

import (
	// al "github.com/misterclayt0n/go-algorithms/algorithms"
	"fmt"

	ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
	root := ds.NewBSTNode(10)
	root.Insert(5)
	root.Insert(15)
	root.Insert(3)
	root.Insert(7)
	root.Insert(12)
	root.Insert(17)

	// Impressão da BST em ordem
	fmt.Println("Árvore em ordem:")
	root.PrintInOrder() // Output: 3 5 7 10 12 15 17
	fmt.Println()

	// Busca de valores
	fmt.Println("Busca 7:", root.Search(7))  // Output: true
	fmt.Println("Busca 9:", root.Search(9))  // Output: false

	// Remoção de valores
	root.Remove(5)
	fmt.Println("Árvore em ordem após remover 5:")
	root.PrintInOrder() // Output: 3 7 10 12 15 17
	fmt.Println()
}
