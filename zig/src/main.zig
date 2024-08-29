const std = @import("std");
const DoublyLinkedList = @import("data-structures/doubly-linked-list.zig").DoublyLinkedList;

pub fn main() !void {
    var allocator = std.heap.page_allocator;

    var list = DoublyLinkedList{
        .head = null,
        .tail = null,
        .allocator = &allocator,
    };

    defer list.destroy();

    try list.append(10);
    try list.append(20);
    try list.append(30);
    try list.prepend(5);
    try list.insert_at(15, 2);

    std.debug.print("DoublyLinkedList: ", .{});
    list.print();
    std.debug.print("\n", .{});
}
