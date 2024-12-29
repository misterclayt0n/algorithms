package main

import "core:fmt"

@(private = "file")
node :: struct {
	value: i32,
	left:  ^node,
	right: ^node,
}

create_node :: proc(value: i32, allocator := context.allocator) -> ^node {
	node := new(node)
	node.value = value
	node.left = nil
	node.right = nil

	return node
}

link_node_left :: proc(parent: ^node, left_child: ^node) {
	parent.left = left_child
}

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

main :: proc() {
	node1 := create_node(10)
	node2 := create_node(20)
	node3 := create_node(30)

	link_node_left(node1, node2)
	link_node_right(node1, node3)

	in_order_traversal(node1)
}
