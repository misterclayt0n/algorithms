#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    int value;
    struct Node* prev;
} Node;

typedef struct {
    Node* head;
} Stack;

Stack* createStack() {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->head = NULL;
    return stack;
}

int peek(Stack* stack) {
    if (stack->head == NULL) {
        return -1; 
    }
    return stack->head->value;
}

void push(Stack* stack, int value) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->value = value;
    newNode->prev = stack->head;
    stack->head = newNode;
}

int pop(Stack* stack) {
    if (stack->head == NULL) {
        return -1; 
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

    printf("Peek: %d\n", peek(stack)); 
    printf("Pop: %d\n", pop(stack));   
    printf("Peek: %d\n", peek(stack)); 
    printf("Pop: %d\n", pop(stack));   
    printf("Peek: %d\n", peek(stack)); 
    printf("Pop: %d\n", pop(stack));   
    printf("Peek: %d\n", peek(stack)); 

    free(stack); 

    return 0;
}
