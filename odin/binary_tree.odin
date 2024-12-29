package main

import "core:fmt"

@(private = "file")
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
link_node_left :: proc(parent: ^node, left_child: ^node) {
	parent.left = left_child
}

@(private = "file")
link_node_right :: proc(parent: ^node, right_child: ^node) {
	parent.right = right_child
}

@(private = "file")
in_order_traversal :: proc(n: ^node) {
	if n == nil {
		return
	}

	in_order_traversal(n.left)
	fmt.println(n.value)
	in_order_traversal(n.right)
}
