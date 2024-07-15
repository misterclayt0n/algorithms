package algorithms

import "container/list"

type BinaryNode struct {
	Value int
	Left  *BinaryNode
	Right *BinaryNode
}

func NewBinaryNode(value int) *BinaryNode {
	return &BinaryNode{Value: value}
}

func Bfs(head *BinaryNode, needle int) bool {
	if head == nil {
		return false
	}

	// queue to control nodes to be visited
	queue := list.New()
	queue.PushBack(head)

	for queue.Len() > 0 {
		current := queue.Remove(queue.Front()).(*BinaryNode)

		if current.Value == needle {
			return true
		}

		if current.Left != nil {
			queue.PushBack(current.Left)
		}

		if current.Right != nil {
			queue.PushBack(current.Right)
		}
	}

	return false
}
