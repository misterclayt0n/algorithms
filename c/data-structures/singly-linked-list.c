#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
  int data;
  struct Node *next;
} Node;

typedef struct singly_linked_list {
  struct Node *head;
} singly_linked_list;

Node *create_node(int data) {
  Node *new_node = (Node *)malloc(sizeof(Node));

  if (new_node == NULL) {
    fprintf(stderr, "Error in reaching memory\n");
    exit(EXIT_FAILURE);
  }

  new_node->data = data;
  new_node->next = NULL;

  return new_node;
}

void prepend(singly_linked_list *list, int data) {
  Node *new_node = create_node(data);
  new_node->next = list->head;
  list->head = new_node;
}

void print_list(singly_linked_list *list) {
  Node *current = list->head;

  while (current != NULL) {
    printf("%d -> ", current->data);
    current = current->next;
  }

  printf("NULL\n");
}

void free_list(singly_linked_list *list) {
  Node *current = list->head;
  while (current != NULL) {
    Node *next = current->next;
    free(current);
    current = next;
  }

  list->head = NULL; // make sure that list's HEAD is NULL
}

void remove_first(singly_linked_list *list) {
  if (list->head != NULL) {
    list->head = list->head->next;
  }
}

int main() {
    // initialize with NULL
    singly_linked_list my_list = {NULL};

    prepend(&my_list, 10);
    prepend(&my_list, 20);
    prepend(&my_list, 30);
    prepend(&my_list, 40);
    prepend(&my_list, 50);

    print_list(&my_list);

    free_list(&my_list);

    return 0;
}
