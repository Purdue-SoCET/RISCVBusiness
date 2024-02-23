./gen_ldst_test.py unit_stride/v_unit_stride_e8_single_reg.S --enc_width e8 --vl 16 --vsew e8 --vlmul m1
./gen_ldst_test.py unit_stride/v_unit_stride_e16_single_reg.S --enc_width e16 --vl 8 --vsew e16 --vlmul m1
./gen_ldst_test.py unit_stride/v_unit_stride_e32_single_reg.S --enc_width e32 --vl 4 --vsew e32 --vlmul m1

./gen_ldst_test.py unit_stride/v_unit_stride_e8_double_reg.S --enc_width e8 --vl 32 --vsew e8 --vlmul m2
./gen_ldst_test.py unit_stride/v_unit_stride_e16_double_reg.S --enc_width e16 --vl 16 --vsew e16 --vlmul m2
./gen_ldst_test.py unit_stride/v_unit_stride_e32_double_reg.S --enc_width e32 --vl 8 --vsew e32 --vlmul m2

./gen_ldst_test.py unit_stride/v_unit_stride_e8_quad_reg.S --enc_width e8 --vl 64 --vsew e8 --vlmul m4
./gen_ldst_test.py unit_stride/v_unit_stride_e16_quad_reg.S --enc_width e16 --vl 32 --vsew e16 --vlmul m4
./gen_ldst_test.py unit_stride/v_unit_stride_e32_quad_reg.S --enc_width e32 --vl 16 --vsew e32 --vlmul m4

./gen_ldst_test.py unit_stride/v_unit_stride_e8_octo_reg.S --enc_width e8 --vl 128 --vsew e8 --vlmul m8
./gen_ldst_test.py unit_stride/v_unit_stride_e16_octo_reg.S --enc_width e16 --vl 64 --vsew e16 --vlmul m8
./gen_ldst_test.py unit_stride/v_unit_stride_e32_octo_reg.S --enc_width e32 --vl 32 --vsew e32 --vlmul m8

./gen_ldst_test.py unit_stride/v_unit_stride_e8_half_reg.S --enc_width e8 --vl 8 --vsew e8 --vlmul mf2
./gen_ldst_test.py unit_stride/v_unit_stride_e16_half_reg.S --enc_width e16 --vl 4 --vsew e16 --vlmul mf2
./gen_ldst_test.py unit_stride/v_unit_stride_e32_half_reg.S --enc_width e32 --vl 2 --vsew e32 --vlmul mf2

./gen_ldst_test.py unit_stride/v_unit_stride_e8_fourth_reg.S --enc_width e8 --vl 4 --vsew e8 --vlmul mf4
./gen_ldst_test.py unit_stride/v_unit_stride_e16_fourth_reg.S --enc_width e16 --vl 2 --vsew e16 --vlmul mf4
./gen_ldst_test.py unit_stride/v_unit_stride_e32_fourth_reg.S --enc_width e32 --vl 1 --vsew e32 --vlmul mf4

./gen_ldst_test.py unit_stride/v_unit_stride_e8_eighth_reg.S --enc_width e8 --vl 2 --vsew e8 --vlmul mf8
./gen_ldst_test.py unit_stride/v_unit_stride_e16_eighth_reg.S --enc_width e16 --vl 1 --vsew e16 --vlmul mf8

./gen_ldst_test.py unit_stride/v_unit_stride_e8_odd_len.S --enc_width e8 --vl 19 --vsew e8 --vlmul m8
./gen_ldst_test.py unit_stride/v_unit_stride_e16_odd_len.S --enc_width e16 --vl 11 --vsew e16 --vlmul m4
./gen_ldst_test.py unit_stride/v_unit_stride_e32_odd_len.S --enc_width e32 --vl 7 --vsew e32 --vlmul m2
