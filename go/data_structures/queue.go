package data_structures

type nodeQueue struct {
	value int
	next  *nodeQueue
}

type Queue struct {
	head *nodeQueue
	tail *nodeQueue
}

func (q *Queue) Enqueue(value int) {
	newNode := &nodeQueue{value: value}
	if q.tail == nil {
		q.head = newNode
		q.tail = newNode
	} else {
		q.tail.next = newNode
		q.tail = newNode
	}
}

func (q *Queue) Dequeue() int {
	if q.head == nil {
		return -1
	}
	removedValue := q.head.value
	q.head = q.head.next
	if q.head == nil {
		q.tail = nil
	}
	return removedValue
}

func (q *Queue) Peek() int {
	if q.head == nil {
		return -1
	}
	return q.head.value
}

func (q *Queue) IsEmpty() bool {
	return q.head == nil
}
