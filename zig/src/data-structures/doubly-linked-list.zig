const std = @import("std");

const Node = struct {
    value: i32,
    next: ?*Node,
    prev: ?*Node,

    pub fn create(allocator: *std.mem.Allocator, value: i32) !*Node {
        const node = try allocator.create(Node);
        node.* = Node{
            .value = value,
            .next = null,
            .prev = null,
        };

        return node;
    }

    pub fn destroy(self: *@This(), allocator: *std.mem.Allocator) void {
        allocator.destroy(self);
    }
};

pub const DoublyLinkedList = struct {
    head: ?*Node,
    tail: ?*Node,
    allocator: *std.mem.Allocator,

    pub fn prepend(self: *@This(), value: i32) !void {
        const new_node = try Node.create(self.allocator, value);

        if (self.head == null) {
            self.head = new_node;
            self.tail = new_node;
        } else {
            new_node.next = self.head;
            self.head.?.prev = new_node;
            self.head = new_node;
        }
    }

    pub fn append(self: *@This(), value: i32) !void {
        const new_node = try Node.create(self.allocator, value);

        if (self.head == null) {
            self.head = new_node;
            self.tail = new_node;
        } else {
            new_node.prev = self.tail;
            self.tail.?.next = new_node;
            self.tail = new_node;
        }
    }

    pub fn insert_at(self: *@This(), value: i32, index: i32) !void {
        if (index <= 0 and self.head == null) {
            try self.prepend(value);
            return;
        }

        var current = self.head;
        var current_index: i32 = 0;

        while (current_index < index - 1 and current.?.next != null) {
            current = current.?.next;
            current_index += 1;
        }

        if (current.?.next == null) {
            try self.append(value);
            return;
        }

        const new_node = try Node.create(self.allocator, value);

        new_node.next = current.?.next;
        new_node.prev = current;
        current.?.next.?.prev = new_node;
        current.?.next = new_node;
    }

    pub fn remove_first(self: *@This()) ?*Node {
        if (self.head == null) {
            return null;
        }

        var temp = self.head;
        self.head = self.head.?.next;

        if (self.head == null) {
            self.tail = null;
        } else {
            self.head.?.prev = null;
        }

        temp.?.next = null; // clean removed node
        return temp;
    }

    pub fn remove_last(self: *@This()) ?*Node {
        if (self.tail == null) {
            return null;
        }

        var temp = self.tail;
        self.tail = self.tail.?.prev;

        if (self.tail == null) {
            self.head = null;
        } else {
            self.tail.?.next = null;
        }

        temp.?.prev = null; // clean removed node
        return temp;
    }

    pub fn remove_at(self: *@This(), index: i32) ?*Node {
        if (self.head == null or index < 0) {
            return null;
        }

        if (index == 0) {
            return self.remove_first();
        }

        var current = self.head;
        var i: usize = 0;
        while (i < index and current != null) : (i += 1) {
            current = current.?.next;
        }

        if (current == null) {
            return null;
        }

        if (current.?.next == null) {
            return self.remove_last();
        }

        current.?.prev.?.next = current.?.next;
        current.?.next.?.prev = current.?.prev;

        current.?.prev = null;
        current.?.next = null;
        return current;
    }

    pub fn get(self: *@This(), index: i32) ?*Node {
        if (index < 0) {
            return null;
        }

        var current = self.head;
        var i: usize = 0;
        while (i < index and current != null) : (i += 1){
            current = current.?.next;
        }

        return current;
    }

    pub fn print(self: *@This()) void {
        var current = self.head;

        while (current != null) {
            std.debug.print("{d}", .{current.?.value});
            if (current.?.next != null) {
                std.debug.print(" <-> ", .{});
            }
            current = current.?.next;
        }
    }

    pub fn destroy(self: *@This()) void {
        var current = self.head;
        while (current) |node| {
            const next = node.next;
            node.destroy(self.allocator);
            current = next;
        }

        std.debug.print("\n", .{});
    }
};

test "DoublyLinkedList - prepend operation" {
    var allocator = std.testing.allocator;

    var list = DoublyLinkedList{
        .head = null,
        .tail = null,
        .allocator = &allocator,
    };

    defer list.destroy();

    try std.testing.expect(list.head == null);
    try std.testing.expect(list.tail == null);

    try list.prepend(10);

    try std.testing.expect(list.head != null);
    try std.testing.expect(list.head.?.value == 10);

    try list.prepend(20);

    try std.testing.expect(list.head != null);
    try std.testing.expect(list.head.?.value == 20);
    try std.testing.expect(list.head.?.next.?.value == 10);

    try std.testing.expect(list.tail != null);
    try std.testing.expect(list.tail.?.value == 10);
    try std.testing.expect(list.tail.?.next == null);
}

test "DoublyLinkedList - append operation" {
    var allocator = std.testing.allocator;

    var list = DoublyLinkedList{
        .head = null,
        .tail = null,
        .allocator = &allocator,
    };

    defer list.destroy();

    try std.testing.expect(list.head == null);
    try std.testing.expect(list.tail == null);

    try list.append(10);

    try std.testing.expect(list.head != null);
    try std.testing.expect(list.tail != null);
    try std.testing.expect(list.head == list.tail);
    try std.testing.expect(list.head.?.value == 10);

    try list.append(20);

    try std.testing.expect(list.tail != null);
    try std.testing.expect(list.tail.?.value == 20);

    try std.testing.expect(list.head.?.next.?.value == 20);

    try list.append(30);

    try std.testing.expect(list.tail != null);
    try std.testing.expect(list.tail.?.value == 30);
    try std.testing.expect(list.tail.?.prev.?.value == 20);
    try std.testing.expect(list.head.?.next.?.next.?.value == 30);
}

test "DoublyLinkedList - insert_at operation" {
    var allocator = std.testing.allocator;

    var list = DoublyLinkedList{
        .head = null,
        .tail = null,
        .allocator = &allocator,
    };

    defer list.destroy();

    try list.insert_at(10, 0);
    try std.testing.expect(list.head.?.value == 10);
    try std.testing.expect(list.tail.?.value == 10);

    try list.insert_at(30, 1);
    try std.testing.expect(list.tail.?.value == 30);
    try std.testing.expect(list.head.?.next.?.value == 30);

    try list.insert_at(20, 1);
    try std.testing.expect(list.head.?.next.?.value == 20);
    try std.testing.expect(list.head.?.next.?.next.?.value == 30);

    try std.testing.expect(list.head.?.value == 10);
    try std.testing.expect(list.head.?.next.?.value == 20);
    try std.testing.expect(list.head.?.next.?.next.?.value == 30);
    try std.testing.expect(list.tail.?.value == 30);
}

test "DoublyLinkedList - remove_first operation" {
    var allocator = std.testing.allocator;

    var list = DoublyLinkedList{
        .head = null,
        .tail = null,
        .allocator = &allocator,
    };

    defer list.destroy();

    var removed_node = list.remove_first();
    try std.testing.expect(removed_node == null);

    try list.append(10);
    try list.append(20);
    try list.append(30);

    removed_node = list.remove_first();
    try std.testing.expect(removed_node != null);
    try std.testing.expect(removed_node.?.value == 10);
    removed_node.?.destroy(&allocator);

    removed_node = list.remove_first();
    try std.testing.expect(removed_node != null);
    try std.testing.expect(removed_node.?.value == 20);
    removed_node.?.destroy(&allocator);

    removed_node = list.remove_first();
    try std.testing.expect(removed_node != null);
    try std.testing.expect(removed_node.?.value == 30);
    removed_node.?.destroy(&allocator);

    try std.testing.expect(list.head == null);
    try std.testing.expect(list.tail == null);

    removed_node = list.remove_first();
    try std.testing.expect(removed_node == null);
}

test "DoublyLinkedList - remove_last operation" {
    var allocator = std.testing.allocator;

    var list = DoublyLinkedList{
        .head = null,
        .tail = null,
        .allocator = &allocator,
    };

    defer list.destroy();

    var removed_node = list.remove_last();
    try std.testing.expect(removed_node == null);

    try list.append(10);
    try list.append(20);
    try list.append(30);

    removed_node = list.remove_last();
    try std.testing.expect(removed_node != null);
    try std.testing.expect(removed_node.?.value == 30);
    removed_node.?.destroy(&allocator);

    removed_node = list.remove_last();
    try std.testing.expect(removed_node != null);
    try std.testing.expect(removed_node.?.value == 20);
    removed_node.?.destroy(&allocator);

    removed_node = list.remove_last();
    try std.testing.expect(removed_node != null);
    try std.testing.expect(removed_node.?.value == 10);
    removed_node.?.destroy(&allocator);

    try std.testing.expect(list.head == null);
    try std.testing.expect(list.tail == null);

    removed_node = list.remove_last();
    try std.testing.expect(removed_node == null);
}

test "DoublyLinkedList - remove_at operation" {
    var allocator = std.testing.allocator;

    var list = DoublyLinkedList{
        .head = null,
        .tail = null,
        .allocator = &allocator,
    };

    defer list.destroy();

    var removed_node = list.remove_at(0);
    try std.testing.expect(removed_node == null);

    try list.append(10);
    try list.append(20);
    try list.append(30);
    try list.append(40);

    removed_node = list.remove_at(0);
    try std.testing.expect(removed_node != null);
    try std.testing.expect(removed_node.?.value == 10);
    removed_node.?.destroy(&allocator);

    try std.testing.expect(list.head.?.value == 20);

    removed_node = list.remove_at(1);
    try std.testing.expect(removed_node != null);
    try std.testing.expect(removed_node.?.value == 30);
    removed_node.?.destroy(&allocator);

    try std.testing.expect(list.head.?.value == 20);
    try std.testing.expect(list.head.?.next.?.value == 40);

    removed_node = list.remove_at(1);
    try std.testing.expect(removed_node != null);
    try std.testing.expect(removed_node.?.value == 40);
    removed_node.?.destroy(&allocator);

    try std.testing.expect(list.head.?.value == 20);
    try std.testing.expect(list.head == list.tail);

    removed_node = list.remove_at(0);
    try std.testing.expect(removed_node != null);
    try std.testing.expect(removed_node.?.value == 20);
    removed_node.?.destroy(&allocator);

    try std.testing.expect(list.head == null);
    try std.testing.expect(list.tail == null);

    removed_node = list.remove_at(0);
    try std.testing.expect(removed_node == null);
}

test "DoublyLinkedList - get operation" {
    var allocator = std.testing.allocator;

    var list = DoublyLinkedList{
        .head = null,
        .tail = null,
        .allocator = &allocator,
    };

    defer list.destroy();

    var node = list.get(0);
    try std.testing.expect(node == null);

    try list.append(10);
    try list.append(20);
    try list.append(30);

    node = list.get(0);
    try std.testing.expect(node != null);
    try std.testing.expect(node.?.value == 10);

    node = list.get(1);
    try std.testing.expect(node != null);
    try std.testing.expect(node.?.value == 20);

    node = list.get(2);
    try std.testing.expect(node != null);
    try std.testing.expect(node.?.value == 30);

    node = list.get(3);
    try std.testing.expect(node == null);

    node = list.get(-1);
    try std.testing.expect(node == null);
}
