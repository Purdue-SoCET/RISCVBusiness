#include "utility.h"
#include "fast_amo_emu.h"
#include <stdlib.h>

typedef struct TreeNode {
    uint32_t value;
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

uint32_t sum = 0;

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

void traverse(TreeNode *node) {
    if (node == NULL) return;
    if (node->left != NULL) {
        traverse(node->left);
    }
    if (node->right != NULL) {
        traverse(node->right);
    }
    atomic_add(&sum, node->value);
}

void hart0_main() {
    flag = 0;
    TreeNode* root = &node1;
    atomic_add(&sum, root->value);
    traverse(root->left);
    wait_for_hart1_done();
    flag = sum == 36;
}

void hart1_main() {
    hart1_done = 0;
    TreeNode* root = &node1;
    traverse(root->right);
    hart1_done = 1; 
}
