const std = @import("std");

pub fn linear_search(array: []const i32, x: i32) bool {
    for (array) |item| {
        if (item == x) {
            return true;
        }
    }

    return false;
}

test "linear search test" {
    const array = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1000 };
    const expect = std.testing.expect;

    try expect(linear_search(&array, 1) == true);
    try expect(linear_search(&array, 1000) == true);
    try expect(linear_search(&array, 5000) == false);
}
