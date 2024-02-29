#!/usr/bin/bash

rm strided/*

./gen_ldst_test.py strided/stride_twice_eew_e8_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --stride 4
./gen_ldst_test.py strided/stride_twice_eew_e32_single_reg.S --indexing_mode strided --enc_width e32 --vl 4 --vsew e32 --vlmul m1 --stride 8

./gen_ldst_test.py strided/stride_twice_eew_e8_double_reg.S --indexing_mode strided --enc_width e8 --vl 32 --vsew e8 --vlmul m2 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_double_reg.S --indexing_mode strided --enc_width e16 --vl 16 --vsew e16 --vlmul m2 --stride 4
./gen_ldst_test.py strided/stride_twice_eew_e32_double_reg.S --indexing_mode strided --enc_width e32 --vl 8 --vsew e32 --vlmul m2 --stride 8

./gen_ldst_test.py strided/stride_twice_eew_e8_quad_reg.S --indexing_mode strided --enc_width e8 --vl 64 --vsew e8 --vlmul m4 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_quad_reg.S --indexing_mode strided --enc_width e16 --vl 32 --vsew e16 --vlmul m4 --stride 4
./gen_ldst_test.py strided/stride_twice_eew_e32_quad_reg.S --indexing_mode strided --enc_width e32 --vl 16 --vsew e32 --vlmul m4 --stride 8

./gen_ldst_test.py strided/stride_twice_eew_e8_octo_reg.S --indexing_mode strided --enc_width e8 --vl 128 --vsew e8 --vlmul m8 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_octo_reg.S --indexing_mode strided --enc_width e16 --vl 64 --vsew e16 --vlmul m8 --stride 4
./gen_ldst_test.py strided/stride_twice_eew_e32_octo_reg.S --indexing_mode strided --enc_width e32 --vl 32 --vsew e32 --vlmul m8 --stride 8

./gen_ldst_test.py strided/stride_twice_eew_e8_half_reg.S --indexing_mode strided --enc_width e8 --vl 8 --vsew e8 --vlmul mf2 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_half_reg.S --indexing_mode strided --enc_width e16 --vl 4 --vsew e16 --vlmul mf2 --stride 4
./gen_ldst_test.py strided/stride_twice_eew_e32_half_reg.S --indexing_mode strided --enc_width e32 --vl 2 --vsew e32 --vlmul mf2 --stride 8

./gen_ldst_test.py strided/stride_twice_eew_e8_fourth_reg.S --indexing_mode strided --enc_width e8 --vl 4 --vsew e8 --vlmul mf4 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_fourth_reg.S --indexing_mode strided --enc_width e16 --vl 2 --vsew e16 --vlmul mf4 --stride 4
./gen_ldst_test.py strided/stride_twice_eew_e32_fourth_reg.S --indexing_mode strided --enc_width e32 --vl 1 --vsew e32 --vlmul mf4 --stride 8

./gen_ldst_test.py strided/stride_twice_eew_e8_eighth_reg.S --indexing_mode strided --enc_width e8 --vl 2 --vsew e8 --vlmul mf8 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_eighth_reg.S --indexing_mode strided --enc_width e16 --vl 1 --vsew e16 --vlmul mf8 --stride 4

./gen_ldst_test.py strided/stride_twice_eew_e8_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --stride 4
./gen_ldst_test.py strided/stride_twice_eew_e32_odd_len.S --indexing_mode strided --enc_width e32 --vl 7 --vsew e32 --vlmul m2 --stride 8

./gen_ldst_test.py strided/stride_twice_eew_e8_4B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 12 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_4B_align_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --base_offset 12 --stride 4
./gen_ldst_test.py strided/stride_twice_eew_e32_4B_align_single_reg.S --indexing_mode strided --enc_width e32 --vl 4 --vsew e32 --vlmul m1 --base_offset 12 --stride 8

./gen_ldst_test.py strided/stride_twice_eew_e8_2B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 14 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_2B_align_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --base_offset 14 --stride 4

./gen_ldst_test.py strided/stride_twice_eew_e8_1B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 13 --stride 8

./gen_ldst_test.py strided/stride_twice_eew_e8_4B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 12 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_4B_align_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --base_offset 12 --stride 4
./gen_ldst_test.py strided/stride_twice_eew_e32_4B_align_odd_len.S --indexing_mode strided --enc_width e32 --vl 7 --vsew e32 --vlmul m2 --base_offset 12 --stride 8

./gen_ldst_test.py strided/stride_twice_eew_e8_2B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 14 --stride 2
./gen_ldst_test.py strided/stride_twice_eew_e16_2B_align_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --base_offset 14 --stride 4

./gen_ldst_test.py strided/stride_twice_eew_e8_1B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 13 --stride 2


./gen_ldst_test.py strided/stride_thrice_eew_e8_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --stride 6
./gen_ldst_test.py strided/stride_thrice_eew_e32_single_reg.S --indexing_mode strided --enc_width e32 --vl 4 --vsew e32 --vlmul m1 --stride 12

./gen_ldst_test.py strided/stride_thrice_eew_e8_double_reg.S --indexing_mode strided --enc_width e8 --vl 32 --vsew e8 --vlmul m2 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_double_reg.S --indexing_mode strided --enc_width e16 --vl 16 --vsew e16 --vlmul m2 --stride 6
./gen_ldst_test.py strided/stride_thrice_eew_e32_double_reg.S --indexing_mode strided --enc_width e32 --vl 8 --vsew e32 --vlmul m2 --stride 12

./gen_ldst_test.py strided/stride_thrice_eew_e8_quad_reg.S --indexing_mode strided --enc_width e8 --vl 64 --vsew e8 --vlmul m4 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_quad_reg.S --indexing_mode strided --enc_width e16 --vl 32 --vsew e16 --vlmul m4 --stride 6
./gen_ldst_test.py strided/stride_thrice_eew_e32_quad_reg.S --indexing_mode strided --enc_width e32 --vl 16 --vsew e32 --vlmul m4 --stride 12

./gen_ldst_test.py strided/stride_thrice_eew_e8_octo_reg.S --indexing_mode strided --enc_width e8 --vl 128 --vsew e8 --vlmul m8 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_octo_reg.S --indexing_mode strided --enc_width e16 --vl 64 --vsew e16 --vlmul m8 --stride 6
./gen_ldst_test.py strided/stride_thrice_eew_e32_octo_reg.S --indexing_mode strided --enc_width e32 --vl 32 --vsew e32 --vlmul m8 --stride 12

./gen_ldst_test.py strided/stride_thrice_eew_e8_half_reg.S --indexing_mode strided --enc_width e8 --vl 8 --vsew e8 --vlmul mf2 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_half_reg.S --indexing_mode strided --enc_width e16 --vl 4 --vsew e16 --vlmul mf2 --stride 6
./gen_ldst_test.py strided/stride_thrice_eew_e32_half_reg.S --indexing_mode strided --enc_width e32 --vl 2 --vsew e32 --vlmul mf2 --stride 12

./gen_ldst_test.py strided/stride_thrice_eew_e8_fourth_reg.S --indexing_mode strided --enc_width e8 --vl 4 --vsew e8 --vlmul mf4 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_fourth_reg.S --indexing_mode strided --enc_width e16 --vl 2 --vsew e16 --vlmul mf4 --stride 6
./gen_ldst_test.py strided/stride_thrice_eew_e32_fourth_reg.S --indexing_mode strided --enc_width e32 --vl 1 --vsew e32 --vlmul mf4 --stride 12

./gen_ldst_test.py strided/stride_thrice_eew_e8_eighth_reg.S --indexing_mode strided --enc_width e8 --vl 2 --vsew e8 --vlmul mf8 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_eighth_reg.S --indexing_mode strided --enc_width e16 --vl 1 --vsew e16 --vlmul mf8 --stride 6

./gen_ldst_test.py strided/stride_thrice_eew_e8_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --stride 6
./gen_ldst_test.py strided/stride_thrice_eew_e32_odd_len.S --indexing_mode strided --enc_width e32 --vl 7 --vsew e32 --vlmul m2 --stride 12

./gen_ldst_test.py strided/stride_thrice_eew_e8_4B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 12 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_4B_align_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --base_offset 12 --stride 6
./gen_ldst_test.py strided/stride_thrice_eew_e32_4B_align_single_reg.S --indexing_mode strided --enc_width e32 --vl 4 --vsew e32 --vlmul m1 --base_offset 12 --stride 12

./gen_ldst_test.py strided/stride_thrice_eew_e8_2B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 14 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_2B_align_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --base_offset 14 --stride 6

./gen_ldst_test.py strided/stride_thrice_eew_e8_1B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 13 --stride 3

./gen_ldst_test.py strided/stride_thrice_eew_e8_4B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 12 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_4B_align_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --base_offset 12 --stride 6
./gen_ldst_test.py strided/stride_thrice_eew_e32_4B_align_odd_len.S --indexing_mode strided --enc_width e32 --vl 7 --vsew e32 --vlmul m2 --base_offset 12 --stride 12

./gen_ldst_test.py strided/stride_thrice_eew_e8_2B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 14 --stride 3
./gen_ldst_test.py strided/stride_thrice_eew_e16_2B_align_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --base_offset 14 --stride 6

./gen_ldst_test.py strided/stride_thrice_eew_e8_1B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 13 --stride 3


./gen_ldst_test.py strided/stride_negative_e8_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --stride -6
./gen_ldst_test.py strided/stride_negative_e32_single_reg.S --indexing_mode strided --enc_width e32 --vl 4 --vsew e32 --vlmul m1 --stride -12

./gen_ldst_test.py strided/stride_negative_e8_double_reg.S --indexing_mode strided --enc_width e8 --vl 32 --vsew e8 --vlmul m2 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_double_reg.S --indexing_mode strided --enc_width e16 --vl 16 --vsew e16 --vlmul m2 --stride -6
./gen_ldst_test.py strided/stride_negative_e32_double_reg.S --indexing_mode strided --enc_width e32 --vl 8 --vsew e32 --vlmul m2 --stride -12

./gen_ldst_test.py strided/stride_negative_e8_quad_reg.S --indexing_mode strided --enc_width e8 --vl 64 --vsew e8 --vlmul m4 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_quad_reg.S --indexing_mode strided --enc_width e16 --vl 32 --vsew e16 --vlmul m4 --stride -6
./gen_ldst_test.py strided/stride_negative_e32_quad_reg.S --indexing_mode strided --enc_width e32 --vl 16 --vsew e32 --vlmul m4 --stride -12

./gen_ldst_test.py strided/stride_negative_e8_octo_reg.S --indexing_mode strided --enc_width e8 --vl 128 --vsew e8 --vlmul m8 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_octo_reg.S --indexing_mode strided --enc_width e16 --vl 64 --vsew e16 --vlmul m8 --stride -6
./gen_ldst_test.py strided/stride_negative_e32_octo_reg.S --indexing_mode strided --enc_width e32 --vl 32 --vsew e32 --vlmul m8 --stride -12

./gen_ldst_test.py strided/stride_negative_e8_half_reg.S --indexing_mode strided --enc_width e8 --vl 8 --vsew e8 --vlmul mf2 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_half_reg.S --indexing_mode strided --enc_width e16 --vl 4 --vsew e16 --vlmul mf2 --stride -6
./gen_ldst_test.py strided/stride_negative_e32_half_reg.S --indexing_mode strided --enc_width e32 --vl 2 --vsew e32 --vlmul mf2 --stride -12

./gen_ldst_test.py strided/stride_negative_e8_fourth_reg.S --indexing_mode strided --enc_width e8 --vl 4 --vsew e8 --vlmul mf4 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_fourth_reg.S --indexing_mode strided --enc_width e16 --vl 2 --vsew e16 --vlmul mf4 --stride -6
./gen_ldst_test.py strided/stride_negative_e32_fourth_reg.S --indexing_mode strided --enc_width e32 --vl 1 --vsew e32 --vlmul mf4 --stride -12

./gen_ldst_test.py strided/stride_negative_e8_eighth_reg.S --indexing_mode strided --enc_width e8 --vl 2 --vsew e8 --vlmul mf8 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_eighth_reg.S --indexing_mode strided --enc_width e16 --vl 1 --vsew e16 --vlmul mf8 --stride -6

./gen_ldst_test.py strided/stride_negative_e8_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --stride -6
./gen_ldst_test.py strided/stride_negative_e32_odd_len.S --indexing_mode strided --enc_width e32 --vl 7 --vsew e32 --vlmul m2 --stride -12

./gen_ldst_test.py strided/stride_negative_e8_4B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 12 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_4B_align_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --base_offset 12 --stride -6
./gen_ldst_test.py strided/stride_negative_e32_4B_align_single_reg.S --indexing_mode strided --enc_width e32 --vl 4 --vsew e32 --vlmul m1 --base_offset 12 --stride -12

./gen_ldst_test.py strided/stride_negative_e8_2B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 14 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_2B_align_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --base_offset 14 --stride -6

./gen_ldst_test.py strided/stride_negative_e8_1B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 13 --stride -3

./gen_ldst_test.py strided/stride_negative_e8_4B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 12 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_4B_align_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --base_offset 12 --stride -6
./gen_ldst_test.py strided/stride_negative_e32_4B_align_odd_len.S --indexing_mode strided --enc_width e32 --vl 7 --vsew e32 --vlmul m2 --base_offset 12 --stride -12

./gen_ldst_test.py strided/stride_negative_e8_2B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 14 --stride -3
./gen_ldst_test.py strided/stride_negative_e16_2B_align_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --base_offset 14 --stride -6

./gen_ldst_test.py strided/stride_negative_e8_1B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 13 --stride -3



./gen_ldst_test.py strided/stride_zero_e8_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --stride 0
./gen_ldst_test.py strided/stride_zero_e32_single_reg.S --indexing_mode strided --enc_width e32 --vl 4 --vsew e32 --vlmul m1 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_double_reg.S --indexing_mode strided --enc_width e8 --vl 32 --vsew e8 --vlmul m2 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_double_reg.S --indexing_mode strided --enc_width e16 --vl 16 --vsew e16 --vlmul m2 --stride 0
./gen_ldst_test.py strided/stride_zero_e32_double_reg.S --indexing_mode strided --enc_width e32 --vl 8 --vsew e32 --vlmul m2 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_quad_reg.S --indexing_mode strided --enc_width e8 --vl 64 --vsew e8 --vlmul m4 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_quad_reg.S --indexing_mode strided --enc_width e16 --vl 32 --vsew e16 --vlmul m4 --stride 0
./gen_ldst_test.py strided/stride_zero_e32_quad_reg.S --indexing_mode strided --enc_width e32 --vl 16 --vsew e32 --vlmul m4 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_octo_reg.S --indexing_mode strided --enc_width e8 --vl 128 --vsew e8 --vlmul m8 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_octo_reg.S --indexing_mode strided --enc_width e16 --vl 64 --vsew e16 --vlmul m8 --stride 0
./gen_ldst_test.py strided/stride_zero_e32_octo_reg.S --indexing_mode strided --enc_width e32 --vl 32 --vsew e32 --vlmul m8 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_half_reg.S --indexing_mode strided --enc_width e8 --vl 8 --vsew e8 --vlmul mf2 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_half_reg.S --indexing_mode strided --enc_width e16 --vl 4 --vsew e16 --vlmul mf2 --stride 0
./gen_ldst_test.py strided/stride_zero_e32_half_reg.S --indexing_mode strided --enc_width e32 --vl 2 --vsew e32 --vlmul mf2 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_fourth_reg.S --indexing_mode strided --enc_width e8 --vl 4 --vsew e8 --vlmul mf4 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_fourth_reg.S --indexing_mode strided --enc_width e16 --vl 2 --vsew e16 --vlmul mf4 --stride 0
./gen_ldst_test.py strided/stride_zero_e32_fourth_reg.S --indexing_mode strided --enc_width e32 --vl 1 --vsew e32 --vlmul mf4 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_eighth_reg.S --indexing_mode strided --enc_width e8 --vl 2 --vsew e8 --vlmul mf8 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_eighth_reg.S --indexing_mode strided --enc_width e16 --vl 1 --vsew e16 --vlmul mf8 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --stride 0
./gen_ldst_test.py strided/stride_zero_e32_odd_len.S --indexing_mode strided --enc_width e32 --vl 7 --vsew e32 --vlmul m2 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_4B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 12 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_4B_align_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --base_offset 12 --stride 0
./gen_ldst_test.py strided/stride_zero_e32_4B_align_single_reg.S --indexing_mode strided --enc_width e32 --vl 4 --vsew e32 --vlmul m1 --base_offset 12 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_2B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 14 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_2B_align_single_reg.S --indexing_mode strided --enc_width e16 --vl 8 --vsew e16 --vlmul m1 --base_offset 14 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_1B_align_single_reg.S --indexing_mode strided --enc_width e8 --vl 16 --vsew e8 --vlmul m1 --base_offset 13 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_4B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 12 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_4B_align_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --base_offset 12 --stride 0
./gen_ldst_test.py strided/stride_zero_e32_4B_align_odd_len.S --indexing_mode strided --enc_width e32 --vl 7 --vsew e32 --vlmul m2 --base_offset 12 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_2B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 14 --stride 0
./gen_ldst_test.py strided/stride_zero_e16_2B_align_odd_len.S --indexing_mode strided --enc_width e16 --vl 11 --vsew e16 --vlmul m4 --base_offset 14 --stride 0

./gen_ldst_test.py strided/stride_zero_e8_1B_align_odd_len.S --indexing_mode strided --enc_width e8 --vl 19 --vsew e8 --vlmul m8 --base_offset 13 --stride 0
