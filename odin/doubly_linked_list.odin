package main

import "core:fmt"

@(private = "file")
node :: struct {
	value: i32,
	next:  ^node,
	prev:  ^node,
}

doubly_linked_list :: struct {
	head: ^node,
	tail: ^node
}

@(private = "file")
prepend :: proc(ll: ^doubly_linked_list, value: i32, allocator := context.allocator) {
	new_node := new(node)
	new_node.value = value
	new_node.next = ll.head
	new_node.prev = nil
	ll.head = new_node
}

@(private = "file")
print :: proc(ll: ^doubly_linked_list) {
	current := ll.head
	for current != nil {
		fmt.printf("%d ->", current^.value)
		current = current.next
	}
	fmt.println("NULL")
}

main :: proc() {
	list := new(doubly_linked_list)

    prepend(list, 10);
    prepend(list, 20);
    prepend(list, 30);
    prepend(list, 40);
    prepend(list, 50);

    print(list);
}
