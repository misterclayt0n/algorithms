const std = @import("std");

pub fn bubbleSort(array: []i32) void {
    var i: usize = 0;
    var j: usize = 0;

    while (i < array.len) : (i += 1) {
        while (j < array.len - 1 - i) : (j += 1) {
            if (array[j]  > array[j + 1]) {
                const tmp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = tmp;
            }
        }
    }

    std.debug.print("{d}\n", .{array});
}
