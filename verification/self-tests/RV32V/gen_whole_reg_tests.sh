#!/usr/bin/bash

rm whole_reg/*

./gen_ldst_test.py whole_reg/v_whole_reg_e8_single_reg.S --enc_width e8 --indexing_mode whole_reg --nfields 1
./gen_ldst_test.py whole_reg/v_whole_reg_e16_single_reg.S --enc_width e16 --indexing_mode whole_reg --nfields 1
./gen_ldst_test.py whole_reg/v_whole_reg_e32_single_reg.S --enc_width e32 --indexing_mode whole_reg --nfields 1

./gen_ldst_test.py whole_reg/v_whole_reg_e8_double_reg.S --enc_width e8 --indexing_mode whole_reg --nfields 2
./gen_ldst_test.py whole_reg/v_whole_reg_e16_double_reg.S --enc_width e16 --indexing_mode whole_reg --nfields 2
./gen_ldst_test.py whole_reg/v_whole_reg_e32_double_reg.S --enc_width e32 --indexing_mode whole_reg --nfields 2

./gen_ldst_test.py whole_reg/v_whole_reg_e8_quad_reg.S --enc_width e8 --indexing_mode whole_reg --nfields 4
./gen_ldst_test.py whole_reg/v_whole_reg_e16_quad_reg.S --enc_width e16 --indexing_mode whole_reg --nfields 4
./gen_ldst_test.py whole_reg/v_whole_reg_e32_quad_reg.S --enc_width e32 --indexing_mode whole_reg --nfields 4

./gen_ldst_test.py whole_reg/v_whole_reg_e8_octo_reg.S --enc_width e8 --indexing_mode whole_reg --nfields 8
./gen_ldst_test.py whole_reg/v_whole_reg_e16_octo_reg.S --enc_width e16 --indexing_mode whole_reg --nfields 8
./gen_ldst_test.py whole_reg/v_whole_reg_e32_octo_reg.S --enc_width e32 --indexing_mode whole_reg --nfields 8

./gen_ldst_test.py whole_reg/v_whole_reg_e8_4B_align_single_reg.S --enc_width e8 --base_offset 12 --indexing_mode whole_reg --nfields 1
./gen_ldst_test.py whole_reg/v_whole_reg_e16_4B_align_single_reg.S --enc_width e16 --base_offset 12 --indexing_mode whole_reg --nfields 1
./gen_ldst_test.py whole_reg/v_whole_reg_e32_4B_align_single_reg.S --enc_width e32 --base_offset 12 --indexing_mode whole_reg --nfields 1

./gen_ldst_test.py whole_reg/v_whole_reg_e8_2B_align_single_reg.S --enc_width e8 --base_offset 14 --indexing_mode whole_reg --nfields 1
./gen_ldst_test.py whole_reg/v_whole_reg_e16_2B_align_single_reg.S --enc_width e16 --base_offset 14 --indexing_mode whole_reg --nfields 1

./gen_ldst_test.py whole_reg/v_whole_reg_e8_1B_align_single_reg.S --enc_width e8 --base_offset 13 --indexing_mode whole_reg --nfields 1

./gen_ldst_test.py whole_reg/v_whole_reg_e8_4B_align_double_reg.S --enc_width e8 --base_offset 12 --indexing_mode whole_reg --nfields 2
./gen_ldst_test.py whole_reg/v_whole_reg_e16_4B_align_double_reg.S --enc_width e16 --base_offset 12 --indexing_mode whole_reg --nfields 2
./gen_ldst_test.py whole_reg/v_whole_reg_e32_4B_align_double_reg.S --enc_width e32 --base_offset 12 --indexing_mode whole_reg --nfields 2

./gen_ldst_test.py whole_reg/v_whole_reg_e8_2B_align_double_reg.S --enc_width e8 --base_offset 14 --indexing_mode whole_reg --nfields 2
./gen_ldst_test.py whole_reg/v_whole_reg_e16_2B_align_double_reg.S --enc_width e16 --base_offset 14 --indexing_mode whole_reg --nfields 2

./gen_ldst_test.py whole_reg/v_whole_reg_e8_1B_align_double_reg.S --enc_width e8 --base_offset 13 --indexing_mode whole_reg --nfields 2

./gen_ldst_test.py whole_reg/v_whole_reg_e8_4B_align_quad_reg.S --enc_width e8 --base_offset 12 --indexing_mode whole_reg --nfields 4
./gen_ldst_test.py whole_reg/v_whole_reg_e16_4B_align_quad_reg.S --enc_width e16 --base_offset 12 --indexing_mode whole_reg --nfields 4
./gen_ldst_test.py whole_reg/v_whole_reg_e32_4B_align_quad_reg.S --enc_width e32 --base_offset 12 --indexing_mode whole_reg --nfields 4

./gen_ldst_test.py whole_reg/v_whole_reg_e8_2B_align_quad_reg.S --enc_width e8 --base_offset 14 --indexing_mode whole_reg --nfields 4
./gen_ldst_test.py whole_reg/v_whole_reg_e16_2B_align_quad_reg.S --enc_width e16 --base_offset 14 --indexing_mode whole_reg --nfields 4

./gen_ldst_test.py whole_reg/v_whole_reg_e8_1B_align_quad_reg.S --enc_width e8 --base_offset 13 --indexing_mode whole_reg --nfields 4

./gen_ldst_test.py whole_reg/v_whole_reg_e8_4B_align_octo_reg.S --enc_width e8 --base_offset 12 --indexing_mode whole_reg --nfields 8
./gen_ldst_test.py whole_reg/v_whole_reg_e16_4B_align_octo_reg.S --enc_width e16 --base_offset 12 --indexing_mode whole_reg --nfields 8
./gen_ldst_test.py whole_reg/v_whole_reg_e32_4B_align_octo_reg.S --enc_width e32 --base_offset 12 --indexing_mode whole_reg --nfields 8

./gen_ldst_test.py whole_reg/v_whole_reg_e8_2B_align_octo_reg.S --enc_width e8 --base_offset 14 --indexing_mode whole_reg --nfields 8
./gen_ldst_test.py whole_reg/v_whole_reg_e16_2B_align_octo_reg.S --enc_width e16 --base_offset 14 --indexing_mode whole_reg --nfields 8

./gen_ldst_test.py whole_reg/v_whole_reg_e8_1B_align_octo_reg.S --enc_width e8 --base_offset 13 --indexing_mode whole_reg --nfields 8
