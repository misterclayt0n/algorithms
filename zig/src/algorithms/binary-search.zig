const std = @import("std");

pub fn binary_search(array: []const i32, x: i32) bool {
    var low: usize = 0;
    var high: usize = array.len;

    while (low < high) {
        const middle: usize = @divTrunc(low + (high - low), 2);
        const value = array[middle];

        if (value == x) {
            std.debug.print("found it fellas\n", .{});
            return true;
        } else if (value > x) {
            high = middle;
        } else {
            low = middle + 1;
        }
    }

    std.debug.print("nope\n", .{});
    return false;
}

test "binary search test" {
    const array = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1000 };
    const expect = std.testing.expect;

    try expect(binary_search(&array, 1) == true);
    try expect(binary_search(&array, 1000) == true);
    try expect(binary_search(&array, 5000) == false);
}
