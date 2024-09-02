const std = @import("std");
const hash = @import("data-structures/hash-map.zig");

pub fn main() !void {
    var map = try hash.Map.init();

    try map.insert("test", 32);
    try map.insert("test1", 16);
    try map.insert("test2", 8);
    try map.insert("test3", 2);

    const result: u32 = try map.get("test2");
    std.debug.print("Hello, world! {d}\n", .{result});
}
