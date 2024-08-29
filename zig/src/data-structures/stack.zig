const std = @import("std");

const Node = struct {
    value: i32,
    prev: ?*Node, // could be a pointer or null

    pub fn create(allocator: *std.mem.Allocator, value: i32) !*Node {
        const node = try allocator.create(Node);
        node.* = Node{
            .value = value,
            .prev = null
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
        self.head = newNode;
    }

    pub fn pop(self: *@This()) i32 {
        if (self.head == null) {
            return -1;
        }

        const poppedValue = self.head.?.value;
        self.head = self.head.?.prev;
        return poppedValue;
    }
};

test "Stack - basic operations" {
    var allocator = std.testing.allocator;

    var stack = Stack{
        .head = null,
        .allocator = &allocator,
    };

    // Testa se a pilha está vazia inicialmente
    try std.testing.expect(stack.peek() == -1);

    // Adiciona elementos na pilha
    try stack.push(10);
    try stack.push(20);
    try stack.push(30);

    // Verifica o elemento no topo da pilha
    try std.testing.expect(stack.peek() == 30);

    // Remove o elemento do topo da pilha e verifica se o próximo está correto
    try std.testing.expect(stack.pop() == 30);
    try std.testing.expect(stack.peek() == 20);

    // Remove mais um elemento
    try std.testing.expect(stack.pop() == 20);
    try std.testing.expect(stack.peek() == 10);

    // Remove o último elemento
    try std.testing.expect(stack.pop() == 10);

    // Verifica se a pilha está vazia após remover todos os elementos
    try std.testing.expect(stack.peek() == -1);

    // Tenta remover de uma pilha vazia
    try std.testing.expect(stack.pop() == -1);
}

test "Stack - multiple pushes and pops" {
    var allocator = std.testing.allocator;

    var stack = Stack{
        .head = null,
        .allocator = &allocator,
    };

    // Adiciona múltiplos elementos
    try stack.push(1);
    try stack.push(2);
    try stack.push(3);

    // Remove os elementos e verifica se a ordem está correta
    try std.testing.expect(stack.pop() == 3);
    try std.testing.expect(stack.pop() == 2);

    // Adiciona mais elementos
    try stack.push(4);
    try stack.push(5);

    // Verifica o estado da pilha
    try std.testing.expect(stack.peek() == 5);
    try std.testing.expect(stack.pop() == 5);
    try std.testing.expect(stack.pop() == 4);
    try std.testing.expect(stack.pop() == 1);

    // Verifica se a pilha está vazia
    try std.testing.expect(stack.peek() == -1);
    try std.testing.expect(stack.pop() == -1);
}
