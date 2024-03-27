#include "utility.h"

void hart0_main();
void hart1_main();
void TraverseLeftNRoot(TreeNode *node);
void TraverseRight(TreeNode *node);
void PrintValue(int value);
TreeNode* createNode(int value);
TreeNode* createSampleTree();

typedef struct TreeNode {
    int value;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

extern int32_t hart0_done, hart1_done;

void hart0_main() {
    TreeNode* root = createSampleTree(); //gave both harts the same tree
    print("Hello from hart0 - Starting left-root traversal!\n");
    TraverseLeftNRoot(root);
    hart0_done = 1; 
}

void hart1_main() {
    TreeNode* root = createSampleTree(); //gave both harts the same tree
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
    sprintf(buffer, "%d\n", value);
    print(buffer);
}

TreeNode* createNode(int value) {
    TreeNode* newNode = (TreeNode*) malloc(sizeof(TreeNode));
    if (!newNode) {
        perror("Failed to allocate memory for new node");
        exit(EXIT_FAILURE);
    }
    newNode->value = value;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

TreeNode* createSampleTree() {
    TreeNode* root = createNode(10);
    root->left = createNode(5);
    root->right = createNode(15);
    root->left->left = createNode(3);
    root->left->right = createNode(7);
    root->right->right = createNode(18);

    return root;
}