package main

import "core:fmt"

node :: struct {
	value: i32,
	left:  ^node,
	right: ^node,
}

@(private = "file")
create_node :: proc(value: i32, allocator := context.allocator) -> ^node {
	node := new(node)

	node.value = value
	node.left = nil
	node.right = nil

	return node
}

@(private = "file")
insert :: proc(n: ^node, value: i32) {
	if value < n.value {
		if n.left == nil {
			n.left = create_node(value)
		} else {
			insert(n.left, value)
		}
	} else {
		if n.right == nil {
			n.right = create_node(value)
		} else {
			insert(n.right, value)
		}
	}
}

@(private = "file")
search :: proc(n: ^node, value: i32) -> bool {
	if n == nil do return false

	if value < n.value {
		return search(n.left, value)
	} else {
		return search(n.right, value)
	}

	return true
}

@(private = "file")
find_min :: proc(n: ^node) -> ^node {
	current := n

	for current.left != nil {
		current = current.left
	}

	return current
}

remove :: proc(n: ^node, value: i32) -> ^node {
	if n == nil do return nil

	if value < n.value {
		n.left = remove(n.left, value)
	} else {
		// Case 1: Node without children.
		if n.left == nil && n.right == nil do return nil

		// Case 2: Node with 1 child.
		if n.left == nil do return n.right

		if n.right == nil do return n.left

		// Case 3: Node with 2 children.
		// Find the smallest value in the right subtree.
		min_right := find_min(n.right)
		n.value = min_right.value
		n.right = remove(n.right, min_right.value)
	}

	return n
}

print_in_order :: proc(n: ^node, indent: i32 = 0) {
	if n == nil do return

	print_in_order(n.left, indent + 4)
	fmt.print(n.value, " ")
	print_in_order(n.right)
}

main :: proc() {
	node1 := create_node(10)

	insert(node1, 20)
	insert(node1, 30)
	insert(node1, 40)
	insert(node1, 60)
	insert(node1, 100)
	print_in_order(node1)
}
