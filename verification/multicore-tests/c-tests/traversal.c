#include "utility.h"
#include <stdlib.h>
#include <stdio.h>

typedef struct TreeNode {
    int value;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

#define MAX_NODES 16
typedef struct {
    TreeNode pool[MAX_NODES];
    char used[MAX_NODES];
} TreeNodePool;

TreeNodePool globalPool = {{0}, {0}};

void hart0_main();
void hart1_main();
void TraverseLeftNRoot(TreeNode *node);
void TraverseRight(TreeNode *node);
void PrintValue(int value);
TreeNode* createNode(int value, TreeNodePool *pool); 
TreeNode* createSampleTree(TreeNodePool *pool);
TreeNode* allocate_node(TreeNodePool *pool);
void free_node(TreeNodePool *pool, TreeNode *node);

TreeNode* createNode(int value, TreeNodePool *pool) {
    TreeNode* newNode = allocate_node(pool);
    if (!newNode) {
        return NULL;
    }
    newNode->value = value;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

TreeNode* createSampleTree(TreeNodePool *pool) {
    TreeNode* root = createNode(10, pool);
    root->left = createNode(5, pool);
    root->right = createNode(15, pool);
    root->left->left = createNode(3, pool);
    root->left->right = createNode(7, pool);
    root->right->right = createNode(18, pool);

    return root;
}

void hart0_main() {
    flag = 0;
    TreeNode* root = createSampleTree(&globalPool); // Pass the global pool
    print("Hello from hart0 - Starting left-root traversal!\n");
    TraverseLeftNRoot(root);
    flag = 1;
}

void hart1_main() {
    hart1_done = 0;
    TreeNode* root = createSampleTree(&globalPool); // Pass the global pool
    print("Hello from hart1 - Starting right traversal!\n");
    TraverseRight(root);
    hart1_done = 1;
}

void TraverseLeftNRoot(TreeNode *node) {
    if (node == NULL) return;
    TraverseLeftNRoot(node->left);
    PrintValue(node->value); 
}

void TraverseRight(TreeNode *node) {
    if (node == NULL) return;
    TraverseRight(node->right); //go right
    PrintValue(node->value); 
}

void PrintValue(int value) {
    char buffer[12]; 
    print(buffer);
}

TreeNode* allocate_node(TreeNodePool *pool) {
    for (int i = 0; i < MAX_NODES; i++) {
        if (!pool->used[i]) {
            pool->used[i] = 1;
            return &pool->pool[i];
        }
    }
    return NULL;
}

void free_node(TreeNodePool *pool, TreeNode *node) {
    int index = node - pool->pool;
    if (index >= 0 && index < MAX_NODES) {
        pool->used[index] = 0;
    }
}
