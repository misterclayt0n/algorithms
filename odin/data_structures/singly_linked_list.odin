package data_structures

import "core:fmt"
import "core:testing"

node_linked_list :: struct {
	value: i32,
	next:  ^node_linked_list,
}

singly_linked_list :: struct {
	head: ^node_linked_list,
}

prepend_singly_linked_list :: proc(
	ll: ^singly_linked_list,
	value: i32,
	allocator := context.allocator,
) {
	if ll == nil do return
	new_node := new(node_linked_list, allocator)
	new_node.next = ll.head
	new_node.value = value
	ll.head = new_node
}

print_singly_linked_list :: proc(ll: ^singly_linked_list) {
	current := ll.head
	for current != nil {
		fmt.printf("%d -> ", current.value)
		current = current.next
	}
	fmt.printf("NULL\n")
}

remove_first_singly_linked_list :: proc(ll: ^singly_linked_list) {
	if ll.head != nil do ll.head = ll.head.next
}

@(test)
test_prepend_singly_linked_list :: proc(t: ^testing.T) {
	list := singly_linked_list{}
	prepend_singly_linked_list(&list, 10)
	testing.expect(t, list.head != nil, "Head should not be nil after prepending to empty list")
	if list.head != nil {
		testing.expect_value(t, list.head.value, 10)
	}

	prepend_singly_linked_list(&list, 20)
	prepend_singly_linked_list(&list, 30)

	current := list.head
	expected := []i32{30, 20, 10}
	for i := 0; current != nil && i < len(expected); i += 1 {
		testing.expect_value(t, current.value, expected[i])
		current = current.next
	}
}

@(test)
test_remove_first_singly_linked_list :: proc(t: ^testing.T) {
	list := singly_linked_list{}
	prepend_singly_linked_list(&list, 10)
	prepend_singly_linked_list(&list, 20)
	prepend_singly_linked_list(&list, 30)

	remove_first_singly_linked_list(&list)
	testing.expect(t, list.head != nil, "Head should not be nil after removing first element")
	if list.head != nil {
		testing.expect_value(t, list.head.value, 20)
	}

	remove_first_singly_linked_list(&list)
	remove_first_singly_linked_list(&list)
	testing.expect(t, list.head == nil, "Head should be nil after removing all elements")

	remove_first_singly_linked_list(&list)
	testing.expect(t, list.head == nil, "Head should remain nil after removing from empty list")
}

@(test)
test_empty_singly_linked_list :: proc(t: ^testing.T) {
	list := singly_linked_list{}
	testing.expect(t, list.head == nil, "New list should have nil head")
}

@(test)
test_single_element_singly_linked_list :: proc(t: ^testing.T) {
	list := singly_linked_list{}
	prepend_singly_linked_list(&list, 42)

	testing.expect(t, list.head != nil, "Head should not be nil")
	if list.head != nil {
		testing.expect_value(t, list.head.value, 42)
		testing.expect(t, list.head.next == nil, "Next should be nil for single element")
	}
}
