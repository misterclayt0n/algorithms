const std = @import("std");
const ls = @import("data-structures/singly-linked-list.zig");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    var list = ls.SinglyLinkedList.create(&allocator);
    defer list.destroy();

    try list.prepend(10);
    try list.prepend(20);
    try list.prepend(30);
    try list.prepend(40);

    list.remove_first();

    try list.print();
}
