package algorithms

import (
	"container/heap"
	"fmt"
	"math"
)

type Edge struct {
	node   int
	weight int
}

type Graph map[int][]Edge

type Item struct {
	node     int
	priority int
	index    int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].priority < pq[j].priority
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].index = i
	pq[j].index = j
}

func (pq *PriorityQueue) Push(x interface{}) {
	n := len(*pq)
	item := x.(*Item)
	item.index = n
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	old[n-1] = nil  // avoid leaking memory
	item.index = -1 // safety
	*pq = old[0 : n-1]
	return item
}

func (pq *PriorityQueue) update(item *Item, node, priority int) {
	item.node = node
	item.priority = priority
	heap.Fix(pq, item.index)
}

func Dijkstra(graph Graph, start int) map[int]int {
	dist := make(map[int]int)
	for node := range graph {
		dist[node] = math.MaxInt32
	}
	dist[start] = 0

	pq := make(PriorityQueue, 0)
	heap.Init(&pq)
	heap.Push(&pq, &Item{node: start, priority: 0})

	for pq.Len() > 0 {
		item := heap.Pop(&pq).(*Item)
		current := item.node

		for _, edge := range graph[current] {
			alt := dist[current] + edge.weight
			if alt < dist[edge.node] {
				dist[edge.node] = alt
				heap.Push(&pq, &Item{node: edge.node, priority: alt})
			}
		}
	}

	return dist
}

func Test() {
	graph := Graph{
		0: {{1, 1}, {2, 4}},
		1: {{2, 2}, {3, 5}},
		2: {{3, 1}},
		3: {},
	}
	start := 0
	dist := Dijkstra(graph, start)

	for node, distance := range dist {
		fmt.Printf("Distância do nó %d para o nó %d é %d\n", start, node, distance)
	}
}
