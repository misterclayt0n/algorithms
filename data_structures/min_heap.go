package data_structures

import "fmt"

type MinHeap struct {
	Array []int
}

func parent(index int) int {
	return (index - 1) / 2
}

func left(index int) int {
	return 2*index + 1
}

func right(index int) int {
	return 2*index + 2
}

func (h *MinHeap) swap(i1, i2 int) {
	h.Array[i1], h.Array[i2] = h.Array[i2], h.Array[i1]
}

func (h *MinHeap) Insert(key int) {
	h.Array = append(h.Array, key)
	h.heapifyUp(len(h.Array) - 1)
}

func (h *MinHeap) heapifyUp(index int) {
	for h.Array[parent(index)] > h.Array[index] {
		h.swap(parent(index), index)
		index = parent(index)
	}
}

func (h *MinHeap) Extract() int {
	if len(h.Array) == 0 {
		fmt.Println("Heap is empty")
		return -1
	}
	root := h.Array[0]
	last := len(h.Array) - 1
	h.Array[0] = h.Array[last]
	h.Array = h.Array[:last]
	h.heapifyDown(0)
	return root
}

func (h *MinHeap) heapifyDown(index int) {
	lastIndex := len(h.Array) - 1
	l, r := left(index), right(index)
	childToCompare := 0
	for l <= lastIndex {
		if l == lastIndex {
			childToCompare = l
		} else if h.Array[l] < h.Array[r] {
			childToCompare = l
		} else {
			childToCompare = r
		}
		if h.Array[index] > h.Array[childToCompare] {
			h.swap(index, childToCompare)
			index = childToCompare
			l, r = left(index), right(index)
		} else {
			return
		}
	}
}
