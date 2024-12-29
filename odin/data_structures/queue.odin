package data_structures

import "core:testing"

node_queue :: struct {
	value: i32,
	next:  ^node_queue,
}

queue :: struct {
	head: ^node_queue,
	tail: ^node_queue,
}

enqueue :: proc(q: ^queue, value: i32, allocator := context.allocator) {
	new_node := new(node_queue, allocator)
	new_node.value = value
	new_node.next = nil
	
	if q.tail == nil {
		q.head = new_node
		q.tail = new_node
	} else {
		q.tail.next = new_node
		q.tail = new_node
	}
}

denqueue :: proc(q: ^queue) -> i32 {
	if q.head == nil do return -1 
	removed_value := q.head.value
	q.head = q.head.next
	if q.head == nil do q.tail = nil
	return removed_value
}

peek_queue :: proc(q: ^queue) -> i32 {
	if q.head == nil do return -1 
	return q.head.value
} 

@(test)
test_empty_queue :: proc(t: ^testing.T) {
    q := queue{}
    testing.expect(t, q.head == nil, "New queue should have nil head")
    testing.expect(t, q.tail == nil, "New queue should have nil tail")
    
    // Test operations on empty queue
    testing.expect_value(t, peek_queue(&q), -1)
    testing.expect_value(t, denqueue(&q), -1)
}

@(test)
test_single_element :: proc(t: ^testing.T) {
    q := queue{}
    enqueue(&q, 42)
    
    // Check structure
    testing.expect(t, q.head != nil, "Head should not be nil after enqueue")
    testing.expect(t, q.tail != nil, "Tail should not be nil after enqueue")
    testing.expect(t, q.head == q.tail, "Head and tail should be same for single element")
    
    // Check values
    testing.expect_value(t, peek_queue(&q), 42)
    testing.expect_value(t, denqueue(&q), 42)
    
    // Check queue is empty after dequeue
    testing.expect(t, q.head == nil, "Head should be nil after dequeue")
    testing.expect(t, q.tail == nil, "Tail should be nil after dequeue")
}

@(test)
test_multiple_elements :: proc(t: ^testing.T) {
    q := queue{}
    
    // Enqueue multiple elements
    enqueue(&q, 10)
    enqueue(&q, 20)
    enqueue(&q, 30)
    
    // Check FIFO order
    testing.expect_value(t, peek_queue(&q), 10)
    testing.expect_value(t, denqueue(&q), 10)
    testing.expect_value(t, peek_queue(&q), 20)
    testing.expect_value(t, denqueue(&q), 20)
    testing.expect_value(t, denqueue(&q), 30)
    
    // Queue should be empty after all dequeues
    testing.expect(t, q.head == nil, "Head should be nil after all dequeues")
    testing.expect(t, q.tail == nil, "Tail should be nil after all dequeues")
}

@(test)
test_enqueue_after_dequeue :: proc(t: ^testing.T) {
    q := queue{}
    
    // Enqueue and dequeue operations
    enqueue(&q, 10)
    enqueue(&q, 20)
    testing.expect_value(t, denqueue(&q), 10)
    
    enqueue(&q, 30)
    testing.expect_value(t, denqueue(&q), 20)
    testing.expect_value(t, denqueue(&q), 30)
    
    // Queue should be empty
    testing.expect(t, q.head == nil)
    testing.expect(t, q.tail == nil)
    
    // Enqueue after empty
    enqueue(&q, 40)
    testing.expect_value(t, peek_queue(&q), 40)
}

@(test)
test_tail_behavior :: proc(t: ^testing.T) {
    q := queue{}
    
    // Test tail updates correctly
    enqueue(&q, 10)
    old_tail := q.tail
    enqueue(&q, 20)
    testing.expect(t, old_tail != q.tail, "Tail should update on enqueue")
    testing.expect(t, q.tail.next == nil, "Tail's next should always be nil")
    
    // Test tail updates on dequeue to empty
    denqueue(&q)
    denqueue(&q)
    testing.expect(t, q.tail == nil, "Tail should be nil when queue is empty")
}

