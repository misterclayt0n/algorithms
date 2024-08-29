const std = @import("std");

const Node = struct {
    value: i32,
    prev: ?*Node, // could be a pointer or null

    pub fn create(allocator: *std.mem.Allocator, value: i32) !*Node {
        const node = try allocator.create(Node);
        node.* = Node{
            .value = value,
            .prev = null,
        };

        return node;
    }

    pub fn destroy(self: *@This(), allocator: *std.mem.Allocator) void {
        allocator.destroy(self);
    }
};

pub const Stack = struct {
    head: ?*Node,
    allocator: *std.mem.Allocator,

    pub fn peek(self: *@This()) i32 {
        if (self.head == null) {
            return -1;
        }

        return self.head.?.value;
    }

    pub fn push(self: *@This(), value: i32) !void {
        const newNode = try Node.create(self.allocator, value);
        newNode.prev = self.head;
        self.head = newNode;
    }

    pub fn pop(self: *@This()) i32 {
        if (self.head == null) {
            return -1;
        }

        const poppedValue = self.head.?.value;
        const oldHead = self.head;
        self.head = self.head.?.prev;

        if (oldHead) |head| {
            head.destroy(self.allocator);
        }

        return poppedValue;
    }

    pub fn destroy(self: *@This()) void {
        var current = self.head;
        while (current) |node| {
            const next = node.prev;
            node.destroy(self.allocator);
            current = next;
        }
    }
};

test "Stack - basic operations" {
    var allocator = std.testing.allocator;

    var stack = Stack{
        .head = null,
        .allocator = &allocator,
    };

    try std.testing.expect(stack.peek() == -1);

    try stack.push(10);
    try stack.push(20);
    try stack.push(30);

    try std.testing.expect(stack.peek() == 30);

    try std.testing.expect(stack.pop() == 30);
    try std.testing.expect(stack.peek() == 20);

    try std.testing.expect(stack.pop() == 20);
    try std.testing.expect(stack.peek() == 10);

    try std.testing.expect(stack.pop() == 10);

    try std.testing.expect(stack.peek() == -1);

    try std.testing.expect(stack.pop() == -1);

    stack.destroy();
}

test "Stack - multiple pushes and pops" {
    var allocator = std.testing.allocator;

    var stack = Stack{
        .head = null,
        .allocator = &allocator,
    };

    try stack.push(1);
    try stack.push(2);
    try stack.push(3);

    try std.testing.expect(stack.pop() == 3);
    try std.testing.expect(stack.pop() == 2);

    try stack.push(4);
    try stack.push(5);

    try std.testing.expect(stack.peek() == 5);
    try std.testing.expect(stack.pop() == 5);
    try std.testing.expect(stack.pop() == 4);
    try std.testing.expect(stack.pop() == 1);

    try std.testing.expect(stack.peek() == -1);
    try std.testing.expect(stack.pop() == -1);

    stack.destroy();
}
