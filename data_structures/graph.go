package data_structures

import (
	"fmt"
)

type AdjacentMatrixGraph struct {
	vertices int
	matrix   [][]int
}

func NewAdjacentMatrixGraph(vertices int) *AdjacentMatrixGraph {
	matrix := make([][]int, vertices)
	for i := range matrix {
		matrix[i] = make([]int, vertices)
	}

	return &AdjacentMatrixGraph{
		vertices: vertices,
		matrix:   matrix,
	}
}

type AdjacentListGraph struct {
	vertices map[int][]int
}

func NewAdjacentListGraph() *AdjacentListGraph {
	return &AdjacentListGraph{
		vertices: make(map[int][]int),
	}
}

func (g *AdjacentListGraph) AddEdge(v1, v2 int) {
	g.vertices[v1] = append(g.vertices[v1], v2)
	g.vertices[v2] = append(g.vertices[v2], v1)
}

func (g *AdjacentListGraph) Print() {
	for vertex, edges := range g.vertices {
		fmt.Printf("%d -> %v\n", vertex, edges)
	}
}

func (g *AdjacentListGraph) BFS(start int) {
	visited := make(map[int]bool)
	queue := &Queue{}
	queue.Enqueue(start)

	for !queue.IsEmpty() {
		vertex := queue.Dequeue()

		if !visited[vertex] {
			fmt.Print(vertex, " ")
			visited[vertex] = true
			for _, neighbor := range g.vertices[vertex] {
				if !visited[neighbor] {
					queue.Enqueue(neighbor)
				}
			}
		}
	}

	fmt.Println()
}

func (g *AdjacentListGraph) DFS(start int) {
	visited := make(map[int]bool)
	g.dfsUtil(start, visited)
	fmt.Println()
}

func (g *AdjacentListGraph) dfsUtil(v int, visited map[int]bool) {
	visited[v] = true
	fmt.Print(v, " ")

	for _, neighbor := range g.vertices[v] {
		if !visited[neighbor] {
			g.dfsUtil(neighbor, visited)
		}
	}
}
