package data_structures

type nodeStack struct {
	value int
	prev  *nodeStack
}

type Stack struct {
	head *nodeStack
}

func (s *Stack) Peek() int {
	if s.head == nil {
		return -1
	}

	return s.head.value
}

func (s *Stack) Push(value int) {
	newNode := &nodeStack{value: value, prev: s.head}
	s.head = newNode
}

func (s *Stack) Pop() int {
	if s.head == nil {
		return -1
	}

	poppedValue := s.head.value
	s.head = s.head.prev
	return poppedValue
}
