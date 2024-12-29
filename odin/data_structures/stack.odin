package data_structures

import "core:testing"
import "core:fmt"

node_stack :: struct {
	value: i32,
	prev:     ^node_stack,
}

stack :: struct {
	head: ^node_stack,
}

peek_stack :: proc(s: ^stack) -> i32 {
	if s.head == nil do return -1
	return s.head.value
}

push_stack :: proc(s: ^stack, value: i32) {
	new_node := node_stack { value = value, prev = s.head }
	s.head^ = new_node
}

pop_stack :: proc (s: ^stack) -> i32 {
	if s.head == nil do return -1 
	popped_value := s.head.value
	s.head = s.head.prev
	return popped_value
}

@(test)
test_stack :: proc(t: ^testing.T) {
	start_node := node_stack {
		value = 10,
		prev = nil
	}
	stack := stack { head = &start_node }

	push_stack(&stack, 20)
	testing.expect(t, stack.head.value == 20)

	push_stack(&stack, 30)
	testing.expect(t, stack.head.value == 30)

	push_stack(&stack, 40)
	testing.expect(t, stack.head.value == 40)

	popped_value := pop_stack(&stack)
	testing.expect(t, popped_value == 40)
}

