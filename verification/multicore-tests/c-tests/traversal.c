#include "utility.h"
#include "fast_amo_emu.h"
#include <stdlib.h>

typedef struct TreeNode {
    uint32_t value;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

#define N 200
#if N == 5
    TreeNode node5 = {5, NULL, NULL};
    TreeNode node4 = {4, NULL, NULL};
    TreeNode node3 = {3, NULL, &node5};
    TreeNode node2 = {2, &node4, NULL};
    TreeNode node1 = {1, &node2, &node3};
#endif
#if N == 10
    TreeNode node10 = {10, NULL, NULL};
    TreeNode node9 = {9, NULL, NULL};
    TreeNode node8 = {8, &node10, NULL};
    TreeNode node7 = {7, NULL, &node9};
    TreeNode node6 = {6, &node8, NULL};
    TreeNode node5 = {5, NULL, &node7};
    TreeNode node4 = {4, &node6, NULL};
    TreeNode node3 = {3, NULL, &node5};
    TreeNode node2 = {2, &node4, NULL};
    TreeNode node1 = {1, &node2, &node3};
#endif
#if N == 20
    TreeNode node20 = {20, NULL, NULL};
    TreeNode node19 = {19, NULL, NULL};
    TreeNode node18 = {18, &node20, NULL};
    TreeNode node17 = {17, NULL, &node19};
    TreeNode node16 = {16, &node18, NULL};
    TreeNode node15 = {15, NULL, &node17};
    TreeNode node14 = {14, &node16, NULL};
    TreeNode node13 = {13, NULL, &node15};
    TreeNode node12 = {12, &node14, NULL};
    TreeNode node11 = {11, NULL, &node13};
    TreeNode node10 = {10, &node12, NULL};
    TreeNode node9 = {9, NULL, &node11};
    TreeNode node8 = {8, &node10, NULL};
    TreeNode node7 = {7, NULL, &node9};
    TreeNode node6 = {6, &node8, NULL};
    TreeNode node5 = {5, NULL, &node7};
    TreeNode node4 = {4, &node6, NULL};
    TreeNode node3 = {3, NULL, &node5};
    TreeNode node2 = {2, &node4, NULL};
    TreeNode node1 = {1, &node2, &node3};
#endif
#if N == 50
    TreeNode node50 = {50, NULL, NULL};
    TreeNode node49 = {49, NULL, NULL};
    TreeNode node48 = {48, &node50, NULL};
    TreeNode node47 = {47, NULL, &node49};
    TreeNode node46 = {46, &node48, NULL};
    TreeNode node45 = {45, NULL, &node47};
    TreeNode node44 = {44, &node46, NULL};
    TreeNode node43 = {43, NULL, &node45};
    TreeNode node42 = {42, &node44, NULL};
    TreeNode node41 = {41, NULL, &node43};
    TreeNode node40 = {40, &node42, NULL};
    TreeNode node39 = {39, NULL, &node41};
    TreeNode node38 = {38, &node40, NULL};
    TreeNode node37 = {37, NULL, &node39};
    TreeNode node36 = {36, &node38, NULL};
    TreeNode node35 = {35, NULL, &node37};
    TreeNode node34 = {34, &node36, NULL};
    TreeNode node33 = {33, NULL, &node35};
    TreeNode node32 = {32, &node34, NULL};
    TreeNode node31 = {31, NULL, &node33};
    TreeNode node30 = {30, &node32, NULL};
    TreeNode node29 = {29, NULL, &node31};
    TreeNode node28 = {28, &node30, NULL};
    TreeNode node27 = {27, NULL, &node29};
    TreeNode node26 = {26, &node28, NULL};
    TreeNode node25 = {25, NULL, &node27};
    TreeNode node24 = {24, &node26, NULL};
    TreeNode node23 = {23, NULL, &node25};
    TreeNode node22 = {22, &node24, NULL};
    TreeNode node21 = {21, NULL, &node23};
    TreeNode node20 = {20, &node22, NULL};
    TreeNode node19 = {19, NULL, &node21};
    TreeNode node18 = {18, &node20, NULL};
    TreeNode node17 = {17, NULL, &node19};
    TreeNode node16 = {16, &node18, NULL};
    TreeNode node15 = {15, NULL, &node17};
    TreeNode node14 = {14, &node16, NULL};
    TreeNode node13 = {13, NULL, &node15};
    TreeNode node12 = {12, &node14, NULL};
    TreeNode node11 = {11, NULL, &node13};
    TreeNode node10 = {10, &node12, NULL};
    TreeNode node9 = {9, NULL, &node11};
    TreeNode node8 = {8, &node10, NULL};
    TreeNode node7 = {7, NULL, &node9};
    TreeNode node6 = {6, &node8, NULL};
    TreeNode node5 = {5, NULL, &node7};
    TreeNode node4 = {4, &node6, NULL};
    TreeNode node3 = {3, NULL, &node5};
    TreeNode node2 = {2, &node4, NULL};
    TreeNode node1 = {1, &node2, &node3};
#endif
#if N == 100
    TreeNode node100 = {100, NULL, NULL};
    TreeNode node99 = {99, NULL, NULL};
    TreeNode node98 = {98, &node100, NULL};
    TreeNode node97 = {97, NULL, &node99};
    TreeNode node96 = {96, &node98, NULL};
    TreeNode node95 = {95, NULL, &node97};
    TreeNode node94 = {94, &node96, NULL};
    TreeNode node93 = {93, NULL, &node95};
    TreeNode node92 = {92, &node94, NULL};
    TreeNode node91 = {91, NULL, &node93};
    TreeNode node90 = {90, &node92, NULL};
    TreeNode node89 = {89, NULL, &node91};
    TreeNode node88 = {88, &node90, NULL};
    TreeNode node87 = {87, NULL, &node89};
    TreeNode node86 = {86, &node88, NULL};
    TreeNode node85 = {85, NULL, &node87};
    TreeNode node84 = {84, &node86, NULL};
    TreeNode node83 = {83, NULL, &node85};
    TreeNode node82 = {82, &node84, NULL};
    TreeNode node81 = {81, NULL, &node83};
    TreeNode node80 = {80, &node82, NULL};
    TreeNode node79 = {79, NULL, &node81};
    TreeNode node78 = {78, &node80, NULL};
    TreeNode node77 = {77, NULL, &node79};
    TreeNode node76 = {76, &node78, NULL};
    TreeNode node75 = {75, NULL, &node77};
    TreeNode node74 = {74, &node76, NULL};
    TreeNode node73 = {73, NULL, &node75};
    TreeNode node72 = {72, &node74, NULL};
    TreeNode node71 = {71, NULL, &node73};
    TreeNode node70 = {70, &node72, NULL};
    TreeNode node69 = {69, NULL, &node71};
    TreeNode node68 = {68, &node70, NULL};
    TreeNode node67 = {67, NULL, &node69};
    TreeNode node66 = {66, &node68, NULL};
    TreeNode node65 = {65, NULL, &node67};
    TreeNode node64 = {64, &node66, NULL};
    TreeNode node63 = {63, NULL, &node65};
    TreeNode node62 = {62, &node64, NULL};
    TreeNode node61 = {61, NULL, &node63};
    TreeNode node60 = {60, &node62, NULL};
    TreeNode node59 = {59, NULL, &node61};
    TreeNode node58 = {58, &node60, NULL};
    TreeNode node57 = {57, NULL, &node59};
    TreeNode node56 = {56, &node58, NULL};
    TreeNode node55 = {55, NULL, &node57};
    TreeNode node54 = {54, &node56, NULL};
    TreeNode node53 = {53, NULL, &node55};
    TreeNode node52 = {52, &node54, NULL};
    TreeNode node51 = {51, NULL, &node53};
    TreeNode node50 = {50, &node52, NULL};
    TreeNode node49 = {49, NULL, &node51};
    TreeNode node48 = {48, &node50, NULL};
    TreeNode node47 = {47, NULL, &node49};
    TreeNode node46 = {46, &node48, NULL};
    TreeNode node45 = {45, NULL, &node47};
    TreeNode node44 = {44, &node46, NULL};
    TreeNode node43 = {43, NULL, &node45};
    TreeNode node42 = {42, &node44, NULL};
    TreeNode node41 = {41, NULL, &node43};
    TreeNode node40 = {40, &node42, NULL};
    TreeNode node39 = {39, NULL, &node41};
    TreeNode node38 = {38, &node40, NULL};
    TreeNode node37 = {37, NULL, &node39};
    TreeNode node36 = {36, &node38, NULL};
    TreeNode node35 = {35, NULL, &node37};
    TreeNode node34 = {34, &node36, NULL};
    TreeNode node33 = {33, NULL, &node35};
    TreeNode node32 = {32, &node34, NULL};
    TreeNode node31 = {31, NULL, &node33};
    TreeNode node30 = {30, &node32, NULL};
    TreeNode node29 = {29, NULL, &node31};
    TreeNode node28 = {28, &node30, NULL};
    TreeNode node27 = {27, NULL, &node29};
    TreeNode node26 = {26, &node28, NULL};
    TreeNode node25 = {25, NULL, &node27};
    TreeNode node24 = {24, &node26, NULL};
    TreeNode node23 = {23, NULL, &node25};
    TreeNode node22 = {22, &node24, NULL};
    TreeNode node21 = {21, NULL, &node23};
    TreeNode node20 = {20, &node22, NULL};
    TreeNode node19 = {19, NULL, &node21};
    TreeNode node18 = {18, &node20, NULL};
    TreeNode node17 = {17, NULL, &node19};
    TreeNode node16 = {16, &node18, NULL};
    TreeNode node15 = {15, NULL, &node17};
    TreeNode node14 = {14, &node16, NULL};
    TreeNode node13 = {13, NULL, &node15};
    TreeNode node12 = {12, &node14, NULL};
    TreeNode node11 = {11, NULL, &node13};
    TreeNode node10 = {10, &node12, NULL};
    TreeNode node9 = {9, NULL, &node11};
    TreeNode node8 = {8, &node10, NULL};
    TreeNode node7 = {7, NULL, &node9};
    TreeNode node6 = {6, &node8, NULL};
    TreeNode node5 = {5, NULL, &node7};
    TreeNode node4 = {4, &node6, NULL};
    TreeNode node3 = {3, NULL, &node5};
    TreeNode node2 = {2, &node4, NULL};
    TreeNode node1 = {1, &node2, &node3};
#endif
#if N == 200
    TreeNode node200 = {200, NULL, NULL};
    TreeNode node199 = {199, NULL, NULL};
    TreeNode node198 = {198, &node200, NULL};
    TreeNode node197 = {197, NULL, &node199};
    TreeNode node196 = {196, &node198, NULL};
    TreeNode node195 = {195, NULL, &node197};
    TreeNode node194 = {194, &node196, NULL};
    TreeNode node193 = {193, NULL, &node195};
    TreeNode node192 = {192, &node194, NULL};
    TreeNode node191 = {191, NULL, &node193};
    TreeNode node190 = {190, &node192, NULL};
    TreeNode node189 = {189, NULL, &node191};
    TreeNode node188 = {188, &node190, NULL};
    TreeNode node187 = {187, NULL, &node189};
    TreeNode node186 = {186, &node188, NULL};
    TreeNode node185 = {185, NULL, &node187};
    TreeNode node184 = {184, &node186, NULL};
    TreeNode node183 = {183, NULL, &node185};
    TreeNode node182 = {182, &node184, NULL};
    TreeNode node181 = {181, NULL, &node183};
    TreeNode node180 = {180, &node182, NULL};
    TreeNode node179 = {179, NULL, &node181};
    TreeNode node178 = {178, &node180, NULL};
    TreeNode node177 = {177, NULL, &node179};
    TreeNode node176 = {176, &node178, NULL};
    TreeNode node175 = {175, NULL, &node177};
    TreeNode node174 = {174, &node176, NULL};
    TreeNode node173 = {173, NULL, &node175};
    TreeNode node172 = {172, &node174, NULL};
    TreeNode node171 = {171, NULL, &node173};
    TreeNode node170 = {170, &node172, NULL};
    TreeNode node169 = {169, NULL, &node171};
    TreeNode node168 = {168, &node170, NULL};
    TreeNode node167 = {167, NULL, &node169};
    TreeNode node166 = {166, &node168, NULL};
    TreeNode node165 = {165, NULL, &node167};
    TreeNode node164 = {164, &node166, NULL};
    TreeNode node163 = {163, NULL, &node165};
    TreeNode node162 = {162, &node164, NULL};
    TreeNode node161 = {161, NULL, &node163};
    TreeNode node160 = {160, &node162, NULL};
    TreeNode node159 = {159, NULL, &node161};
    TreeNode node158 = {158, &node160, NULL};
    TreeNode node157 = {157, NULL, &node159};
    TreeNode node156 = {156, &node158, NULL};
    TreeNode node155 = {155, NULL, &node157};
    TreeNode node154 = {154, &node156, NULL};
    TreeNode node153 = {153, NULL, &node155};
    TreeNode node152 = {152, &node154, NULL};
    TreeNode node151 = {151, NULL, &node153};
    TreeNode node150 = {150, &node152, NULL};
    TreeNode node149 = {149, NULL, &node151};
    TreeNode node148 = {148, &node150, NULL};
    TreeNode node147 = {147, NULL, &node149};
    TreeNode node146 = {146, &node148, NULL};
    TreeNode node145 = {145, NULL, &node147};
    TreeNode node144 = {144, &node146, NULL};
    TreeNode node143 = {143, NULL, &node145};
    TreeNode node142 = {142, &node144, NULL};
    TreeNode node141 = {141, NULL, &node143};
    TreeNode node140 = {140, &node142, NULL};
    TreeNode node139 = {139, NULL, &node141};
    TreeNode node138 = {138, &node140, NULL};
    TreeNode node137 = {137, NULL, &node139};
    TreeNode node136 = {136, &node138, NULL};
    TreeNode node135 = {135, NULL, &node137};
    TreeNode node134 = {134, &node136, NULL};
    TreeNode node133 = {133, NULL, &node135};
    TreeNode node132 = {132, &node134, NULL};
    TreeNode node131 = {131, NULL, &node133};
    TreeNode node130 = {130, &node132, NULL};
    TreeNode node129 = {129, NULL, &node131};
    TreeNode node128 = {128, &node130, NULL};
    TreeNode node127 = {127, NULL, &node129};
    TreeNode node126 = {126, &node128, NULL};
    TreeNode node125 = {125, NULL, &node127};
    TreeNode node124 = {124, &node126, NULL};
    TreeNode node123 = {123, NULL, &node125};
    TreeNode node122 = {122, &node124, NULL};
    TreeNode node121 = {121, NULL, &node123};
    TreeNode node120 = {120, &node122, NULL};
    TreeNode node119 = {119, NULL, &node121};
    TreeNode node118 = {118, &node120, NULL};
    TreeNode node117 = {117, NULL, &node119};
    TreeNode node116 = {116, &node118, NULL};
    TreeNode node115 = {115, NULL, &node117};
    TreeNode node114 = {114, &node116, NULL};
    TreeNode node113 = {113, NULL, &node115};
    TreeNode node112 = {112, &node114, NULL};
    TreeNode node111 = {111, NULL, &node113};
    TreeNode node110 = {110, &node112, NULL};
    TreeNode node109 = {109, NULL, &node111};
    TreeNode node108 = {108, &node110, NULL};
    TreeNode node107 = {107, NULL, &node109};
    TreeNode node106 = {106, &node108, NULL};
    TreeNode node105 = {105, NULL, &node107};
    TreeNode node104 = {104, &node106, NULL};
    TreeNode node103 = {103, NULL, &node105};
    TreeNode node102 = {102, &node104, NULL};
    TreeNode node101 = {101, NULL, &node103};
    TreeNode node100 = {100, &node102, NULL};
    TreeNode node99 = {99, NULL, &node101};
    TreeNode node98 = {98, &node100, NULL};
    TreeNode node97 = {97, NULL, &node99};
    TreeNode node96 = {96, &node98, NULL};
    TreeNode node95 = {95, NULL, &node97};
    TreeNode node94 = {94, &node96, NULL};
    TreeNode node93 = {93, NULL, &node95};
    TreeNode node92 = {92, &node94, NULL};
    TreeNode node91 = {91, NULL, &node93};
    TreeNode node90 = {90, &node92, NULL};
    TreeNode node89 = {89, NULL, &node91};
    TreeNode node88 = {88, &node90, NULL};
    TreeNode node87 = {87, NULL, &node89};
    TreeNode node86 = {86, &node88, NULL};
    TreeNode node85 = {85, NULL, &node87};
    TreeNode node84 = {84, &node86, NULL};
    TreeNode node83 = {83, NULL, &node85};
    TreeNode node82 = {82, &node84, NULL};
    TreeNode node81 = {81, NULL, &node83};
    TreeNode node80 = {80, &node82, NULL};
    TreeNode node79 = {79, NULL, &node81};
    TreeNode node78 = {78, &node80, NULL};
    TreeNode node77 = {77, NULL, &node79};
    TreeNode node76 = {76, &node78, NULL};
    TreeNode node75 = {75, NULL, &node77};
    TreeNode node74 = {74, &node76, NULL};
    TreeNode node73 = {73, NULL, &node75};
    TreeNode node72 = {72, &node74, NULL};
    TreeNode node71 = {71, NULL, &node73};
    TreeNode node70 = {70, &node72, NULL};
    TreeNode node69 = {69, NULL, &node71};
    TreeNode node68 = {68, &node70, NULL};
    TreeNode node67 = {67, NULL, &node69};
    TreeNode node66 = {66, &node68, NULL};
    TreeNode node65 = {65, NULL, &node67};
    TreeNode node64 = {64, &node66, NULL};
    TreeNode node63 = {63, NULL, &node65};
    TreeNode node62 = {62, &node64, NULL};
    TreeNode node61 = {61, NULL, &node63};
    TreeNode node60 = {60, &node62, NULL};
    TreeNode node59 = {59, NULL, &node61};
    TreeNode node58 = {58, &node60, NULL};
    TreeNode node57 = {57, NULL, &node59};
    TreeNode node56 = {56, &node58, NULL};
    TreeNode node55 = {55, NULL, &node57};
    TreeNode node54 = {54, &node56, NULL};
    TreeNode node53 = {53, NULL, &node55};
    TreeNode node52 = {52, &node54, NULL};
    TreeNode node51 = {51, NULL, &node53};
    TreeNode node50 = {50, &node52, NULL};
    TreeNode node49 = {49, NULL, &node51};
    TreeNode node48 = {48, &node50, NULL};
    TreeNode node47 = {47, NULL, &node49};
    TreeNode node46 = {46, &node48, NULL};
    TreeNode node45 = {45, NULL, &node47};
    TreeNode node44 = {44, &node46, NULL};
    TreeNode node43 = {43, NULL, &node45};
    TreeNode node42 = {42, &node44, NULL};
    TreeNode node41 = {41, NULL, &node43};
    TreeNode node40 = {40, &node42, NULL};
    TreeNode node39 = {39, NULL, &node41};
    TreeNode node38 = {38, &node40, NULL};
    TreeNode node37 = {37, NULL, &node39};
    TreeNode node36 = {36, &node38, NULL};
    TreeNode node35 = {35, NULL, &node37};
    TreeNode node34 = {34, &node36, NULL};
    TreeNode node33 = {33, NULL, &node35};
    TreeNode node32 = {32, &node34, NULL};
    TreeNode node31 = {31, NULL, &node33};
    TreeNode node30 = {30, &node32, NULL};
    TreeNode node29 = {29, NULL, &node31};
    TreeNode node28 = {28, &node30, NULL};
    TreeNode node27 = {27, NULL, &node29};
    TreeNode node26 = {26, &node28, NULL};
    TreeNode node25 = {25, NULL, &node27};
    TreeNode node24 = {24, &node26, NULL};
    TreeNode node23 = {23, NULL, &node25};
    TreeNode node22 = {22, &node24, NULL};
    TreeNode node21 = {21, NULL, &node23};
    TreeNode node20 = {20, &node22, NULL};
    TreeNode node19 = {19, NULL, &node21};
    TreeNode node18 = {18, &node20, NULL};
    TreeNode node17 = {17, NULL, &node19};
    TreeNode node16 = {16, &node18, NULL};
    TreeNode node15 = {15, NULL, &node17};
    TreeNode node14 = {14, &node16, NULL};
    TreeNode node13 = {13, NULL, &node15};
    TreeNode node12 = {12, &node14, NULL};
    TreeNode node11 = {11, NULL, &node13};
    TreeNode node10 = {10, &node12, NULL};
    TreeNode node9 = {9, NULL, &node11};
    TreeNode node8 = {8, &node10, NULL};
    TreeNode node7 = {7, NULL, &node9};
    TreeNode node6 = {6, &node8, NULL};
    TreeNode node5 = {5, NULL, &node7};
    TreeNode node4 = {4, &node6, NULL};
    TreeNode node3 = {3, NULL, &node5};
    TreeNode node2 = {2, &node4, NULL};
    TreeNode node1 = {1, &node2, &node3};
#endif

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
    traverse(root->right);;
    flag = sum == 20100;
}

void hart1_main() {
    hart1_done = 0;
    TreeNode* root = &node1;
    traverse(root->right);
    hart1_done = 1; 
}
