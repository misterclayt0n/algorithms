const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub const Node = struct {
    data: i32,
    next: ?*Node, // next could be a pointer to Node or null

    pub fn create(allocator: *std.mem.Allocator, data: i32) !*Node {
        const node = try allocator.create(Node);
        node.* = Node{
            .data = data,
            .next = null
        };

        return node;
    }

    pub fn destroy(self: *@This(), allocator: *std.mem.Allocator) void {
        allocator.destroy(self);
    }
};

pub const SinglyLinkedList = struct {
    head: ?*Node,
    allocator: *std.mem.Allocator,

    pub fn create(allocator: *std.mem.Allocator) SinglyLinkedList {
        return SinglyLinkedList{ .head = null, .allocator = allocator };
    }

    pub fn prepend(self: *@This(), data: i32) !void {
        const new_node = try Node.create(self.allocator, data);
        new_node.next = self.head;
        self.head = new_node;
    }

    pub fn destroy(self: *@This()) void {
        var current = self.head;
        while (current) |node| {
            const next = node.next;
            node.destroy(self.allocator);
            current = next;
        }
    }

    pub fn print(self: *@This()) !void {
        var current = self.head;

        while(current) |node| {
            try stdout.print("{} -> ", .{node.data});
            current = node.next;
        }

        try stdout.print("null\n", .{});
    }

    pub fn remove_first(self: *@This()) void {
        if (self.head) |first_node| {
            self.head = first_node.next;
            first_node.destroy(self.allocator);
        }
    }
};
