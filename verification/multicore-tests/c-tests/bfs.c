#include "utility.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <limits.h> 

#define MAX_VERTICES 100
#define CAPACITY 1000 

typedef struct {
    int adjMatrix[MAX_VERTICES][MAX_VERTICES]; 
    int visited[MAX_VERTICES];      
    int numVertices;
} Graph;

Graph graph = {
    .adjMatrix = {
        // Vertices: 0  1  2  3  4
        {0, 1, 0, 0, 1}, // Vertex 0 is connected to Vertex 1 and Vertex 4
        {1, 0, 1, 0, 0}, // Vertex 1 is connected to Vertex 0 and Vertex 2
        {0, 1, 0, 1, 0}, // Vertex 2 is connected to Vertex 1 and Vertex 3
        {0, 0, 1, 0, 1}, // Vertex 3 is connected to Vertex 2 and Vertex 4
        {1, 0, 0, 1, 0}  // Vertex 4 is connected to Vertex 0 and Vertex 3
    },
    .visited = {0}, // All unvisited at the beginning
    .numVertices = 5
};

struct Queue {
    int front, rear, size;
    unsigned capacity;
    int array[CAPACITY]; // Statically allocated array
};

struct Queue* queue = NULL;

int main();
void hart0_main();
void hart1_main();
void bfs_visit(int startVertex, int hart_id, int total_harts, struct Queue* queue);
void createQueue(struct Queue* queue, unsigned capacity);
int isFull(struct Queue* queue);
int isEmpty(struct Queue* queue);
void enqueue(struct Queue* queue, int item);
int dequeue(struct Queue* queue);
int front(struct Queue* queue);
int rear(struct Queue* queue);

int main() {
    createQueue(queue, 100);

    hart0_main(); 
    hart1_main(); 
}

void hart0_main() {
     bfs_visit(0, 0, 2, queue);
}

void hart1_main() {
    bfs_visit(0, 1, 2, queue);
}

void bfs_visit(int startVertex, int hart_id, int total_harts, struct Queue* queue) {
    // Initialization by Hart 0
    if (hart_id == 0) {
        graph.visited[startVertex] = 1;
        enqueue(queue, startVertex);
    }
    // Hart 1 waits until Hart 0 has enqueued
    if (hart_id == 1) {
        while (graph.visited[startVertex] == 0);
    }

    while (!isEmpty(queue)) {
        int currentVertex = dequeue(queue);
        if (currentVertex == INT_MIN) continue; // empty dequeue

        // Processing vertices
        for (int i = 0; i < graph.numVertices; i++) {
            if (graph.adjMatrix[currentVertex][i] == 1 && !graph.visited[i]) {
                graph.visited[i] = 1;
                enqueue(queue, i);
            }
        }
        if (hart_id == 0) {
            flag = 1; // Signal to Hart 1
            while (!hart1_done); // Wait for Hart 1
            hart1_done = 0; // Reset for next
        } else {
            while (!flag); // Wait for Hart 0
            hart1_done = 1; // Signal to Hart 0
            flag = 0; // Reset for
        }
    }
}

//Queue functions
void createQueue(struct Queue* queue, unsigned capacity)
{
    queue->capacity = capacity;
    queue->front = queue->size = 0;
    queue->rear = capacity - 1; // Important for the circular queue logic
}

// Function to check if the queue is full
int isFull(struct Queue* queue)
{
    return (queue->size == queue->capacity);
}

// Function to check if the queue is empty
int isEmpty(struct Queue* queue)
{
    return (queue->size == 0);
}

// Function to add an item to the queue
void enqueue(struct Queue* queue, int item)
{
    if (isFull(queue))
        return;
    queue->rear = (queue->rear + 1) % queue->capacity;
    queue->array[queue->rear] = item;
    queue->size = queue->size + 1;
}

// Function to remove an item from the queue
int dequeue(struct Queue* queue)
{
    if (isEmpty(queue))
        return INT_MIN;
    int item = queue->array[queue->front];
    queue->front = (queue->front + 1) % queue->capacity;
    queue->size = queue->size - 1;
    return item;
}

// Function to get the front of the queue
int front(struct Queue* queue)
{
    if (isEmpty(queue))
        return INT_MIN;
    return queue->array[queue->front];
}

// Function to get the rear of the queue
int rear(struct Queue* queue)
{
    if (isEmpty(queue))
        return INT_MIN;
    return queue->array[queue->rear];
}