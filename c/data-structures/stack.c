#include <stdio.h>
#include <stdlib.h>

// Define the node structure
typedef struct Node {
    int value;
    struct Node* prev;
} Node;

// Define the stack structure
typedef struct {
    Node* head;
} Stack;

// Function to create a new stack
Stack* createStack() {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->head = NULL;
    return stack;
}

// Function to peek at the top value of the stack
int peek(Stack* stack) {
    if (stack->head == NULL) {
        return -1; // Return -1 if the stack is empty
    }
    return stack->head->value;
}

// Function to push a new value onto the stack
void push(Stack* stack, int value) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->value = value;
    newNode->prev = stack->head;
    stack->head = newNode;
}

// Function to pop the top value from the stack
int pop(Stack* stack) {
    if (stack->head == NULL) {
        return -1; // Return -1 if the stack is empty
    }
    Node* temp = stack->head;
    int poppedValue = temp->value;
    stack->head = stack->head->prev;
    free(temp);
    return poppedValue;
}

int main() {
    Stack* stack = createStack();

    push(stack, 10);
    push(stack, 20);
    push(stack, 30);

    printf("Peek: %d\n", peek(stack)); // Should print 30
    printf("Pop: %d\n", pop(stack));   // Should print 30
    printf("Peek: %d\n", peek(stack)); // Should print 20
    printf("Pop: %d\n", pop(stack));   // Should print 20
    printf("Peek: %d\n", peek(stack)); // Should print 10
    printf("Pop: %d\n", pop(stack));   // Should print 10
    printf("Peek: %d\n", peek(stack)); // Should print -1

    free(stack); // Free the stack memory

    return 0;
}
