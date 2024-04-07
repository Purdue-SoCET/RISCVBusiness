#include "utility.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>

typedef struct TreeNode {
    int value;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode node8 = {8, NULL, NULL};
TreeNode node7 = {7, NULL, NULL};
TreeNode node6 = {6, &node8, NULL};
TreeNode node5 = {5, NULL, &node7};
TreeNode node4 = {4, &node6, NULL};
TreeNode node3 = {3, NULL, &node5};
TreeNode node2 = {2, &node4, NULL};
TreeNode node1 = {1, &node2, &node3}; // Root node


/*  1
   / \
  2   3
 /     \
 4      5
/        \
6         7
/
8
*/

void hart0_main();
void hart1_main();
void traverseLeftRoot(TreeNode *node);
void traverseRight(TreeNode *node);
void my_itoa(int value, char* str, int base);


void hart0_main() {
    flag = 0;
    TreeNode* root = &node1;
    //print("Hello from hart0 - Starting left-root traversal!\n");
    if (root != NULL) {
        traverseLeftRoot(root);
    }
    flag = 1; 
}

void hart1_main() {
    hart1_done = 0;
    TreeNode* root = &node1;
    //print("Hello from hart1 - Starting right traversal!\n");
    if (root != NULL && root->right != NULL) {
        traverseRight(root->right);
    }
    hart1_done = 1; 
}

void traverseLeftRoot(TreeNode *node) {
    if (node == NULL) return;
    if (node->left != NULL) {
        traverseLeftRoot(node->left);
    }
    print("l"); 
}

void traverseRight(TreeNode *node) {
    if (node == NULL) return;
    print("r");
    traverseRight(node->right);
}

