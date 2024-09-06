const std = @import("std");
const hash = @import("data-structures/hash-map.zig");
const bubble = @import("algorithms/bubble_sort.zig").bubbleSort;

pub fn main() !void {
    var map = try hash.HashMap.init();
    var array = [_]i32{ 1000, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

    bubble(&array);

    try map.insert("test", 32);
    try map.insert("test1", 16);
    try map.insert("test2", 8);
    try map.insert("test3", 2);

    const result: u32 = try map.get("test2");
    std.debug.print("Hello, world! {d}\n", .{result});
}
