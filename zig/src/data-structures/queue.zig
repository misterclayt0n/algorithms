const std = @import("std");

pub const Node = struct {
    value: i32,
    next: ?*Node, // could be a pointer or null

    pub fn create(allocator: *std.mem.Allocator, value: i32) !*Node {
        const node = try allocator.create(Node);
        node.* = Node{
            .value = value,
            .next = null,
        };

        return node;
    }

    pub fn destroy(self: *@This(), allocator: *std.mem.Allocator) void {
        allocator.destroy(self);
    }
};

pub const Queue = struct {
    head: ?*Node,
    tail: ?*Node,
    allocator: *std.mem.Allocator,

    pub fn create(allocator: *std.mem.Allocator) Queue {
        return Queue{
            .head = null,
            .tail = null,
            .allocator = allocator,
        };
    }

    pub fn enqueue(self: *@This(), value: i32) !void {
        const newNode = try Node.create(self.allocator, value);

        if (self.tail == null) {
            self.head = newNode;
            self.tail = newNode;
        } else {
            self.tail.?.next = newNode;
            self.tail = newNode;
        }
    }

    pub fn dequeue(self: *@This()) i32 {
        if (self.head == null) {
            return -1;
        }

        const removedValue = self.head.?.value;
        const oldHead = self.head;
        self.head = self.head.?.next;

        if (self.head == null) {
            self.tail = null;
        }

        if (oldHead) |head| {
            head.destroy(self.allocator);
        }

        return removedValue;
    }

    pub fn peek(self: *@This()) i32 {
        if (self.head == null) {
            return -1;
        }
        return self.head.?.value;
    }

    pub fn is_empty(self: *@This()) bool {
        return self.head == null;
    }

    pub fn destroy(self: *@This()) void {
        var current = self.head;
        while (current) |node| {
            const next = node.next;
            node.destroy(self.allocator);
            current = next;
        }
    }
};

test "Queue - basic operations" {
    var allocator = std.testing.allocator;

    var queue = Queue.create(&allocator);

    try std.testing.expect(queue.is_empty());

    try queue.enqueue(10);
    try queue.enqueue(20);
    try queue.enqueue(30);

    try std.testing.expect(queue.peek() == 10);

    try std.testing.expect(queue.dequeue() == 10);
    try std.testing.expect(queue.peek() == 20);

    try std.testing.expect(queue.dequeue() == 20);
    try std.testing.expect(queue.peek() == 30);

    try std.testing.expect(queue.dequeue() == 30);

    try std.testing.expect(queue.is_empty());

    try std.testing.expect(queue.dequeue() == -1);

    queue.destroy();
}

test "Queue - multiple enqueues and dequeues" {
    var allocator = std.testing.allocator;

    var queue = Queue.create(&allocator);

    try queue.enqueue(1);
    try queue.enqueue(2);
    try queue.enqueue(3);

    try std.testing.expect(queue.dequeue() == 1);
    try std.testing.expect(queue.dequeue() == 2);

    try queue.enqueue(4);
    try queue.enqueue(5);

    try std.testing.expect(queue.peek() == 3);
    try std.testing.expect(queue.dequeue() == 3);
    try std.testing.expect(queue.dequeue() == 4);
    try std.testing.expect(queue.dequeue() == 5);

    try std.testing.expect(queue.is_empty());

    queue.destroy();
}
