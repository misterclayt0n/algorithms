package main

import (
	// al "github.com/misterclayt0n/go-algorithms/algorithms"
	"fmt"

	ds "github.com/misterclayt0n/go-algorithms/data_structures"
)

func main() {
	fmt.Println("Grafo usando Lista de Adjacência:")
	listGraph := ds.NewAdjacentListGraph()
	listGraph.AddEdge(0, 1)
	listGraph.AddEdge(0, 2)
	listGraph.AddEdge(1, 3)
	listGraph.AddEdge(2, 4)
	listGraph.Print()

	fmt.Println("BFS a partir do vértice 0:")
	listGraph.BFS(0)
}
