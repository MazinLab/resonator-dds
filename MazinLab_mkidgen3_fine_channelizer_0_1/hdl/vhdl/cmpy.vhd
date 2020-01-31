-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2019.2.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cmpy is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ar_V_read : IN STD_LOGIC_VECTOR (15 downto 0);
    ai_V_read : IN STD_LOGIC_VECTOR (15 downto 0);
    br_V_read : IN STD_LOGIC_VECTOR (15 downto 0);
    bi_V_read : IN STD_LOGIC_VECTOR (15 downto 0);
    ap_return_0 : OUT STD_LOGIC_VECTOR (15 downto 0);
    ap_return_1 : OUT STD_LOGIC_VECTOR (15 downto 0);
    ap_ce : IN STD_LOGIC );
end;


architecture behav of cmpy is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_1F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011111";
    constant ap_const_lv32_1E : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011110";
    constant ap_const_lv32_20 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000100000";
    constant ap_const_lv14_0 : STD_LOGIC_VECTOR (13 downto 0) := "00000000000000";
    constant ap_const_lv32_F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001111";
    constant ap_const_lv32_E : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001110";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv2_3 : STD_LOGIC_VECTOR (1 downto 0) := "11";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv16_7FFF : STD_LOGIC_VECTOR (15 downto 0) := "0111111111111111";
    constant ap_const_lv16_8000 : STD_LOGIC_VECTOR (15 downto 0) := "1000000000000000";

    signal sext_ln1116_fu_68_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter3 : BOOLEAN;
    signal ap_block_state5_pp0_stage0_iter4 : BOOLEAN;
    signal ap_block_state6_pp0_stage0_iter5 : BOOLEAN;
    signal ap_block_state7_pp0_stage0_iter6 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal sext_ln1118_fu_72_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal sext_ln1118_1_fu_76_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal sext_ln1118_1_reg_613 : STD_LOGIC_VECTOR (31 downto 0);
    signal sext_ln1116_1_fu_80_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal sext_ln1116_1_reg_619 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_574_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal p_Val2_s_reg_625 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_580_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal p_Val2_6_reg_630 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_586_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal p_Val2_5_reg_636 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_592_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal ret_V_reg_642 : STD_LOGIC_VECTOR (31 downto 0);
    signal ret_V_reg_642_pp0_iter4_reg : STD_LOGIC_VECTOR (31 downto 0);
    signal p_Result_s_reg_650 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_s_reg_650_pp0_iter4_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_s_reg_650_pp0_iter5_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln718_fu_91_p1 : STD_LOGIC_VECTOR (13 downto 0);
    signal trunc_ln718_reg_656 : STD_LOGIC_VECTOR (13 downto 0);
    signal p_Result_1_reg_661 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_1_reg_661_pp0_iter4_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal Range2_all_ones_1_reg_667 : STD_LOGIC_VECTOR (0 downto 0);
    signal Range2_all_ones_1_reg_667_pp0_iter4_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal Range2_all_ones_1_reg_667_pp0_iter5_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln1192_fu_114_p2 : STD_LOGIC_VECTOR (31 downto 0);
    attribute use_dsp48 : string;
    attribute use_dsp48 of add_ln1192_fu_114_p2 : signal is "no";
    signal add_ln1192_reg_674 : STD_LOGIC_VECTOR (31 downto 0);
    signal add_ln1192_reg_674_pp0_iter4_reg : STD_LOGIC_VECTOR (31 downto 0);
    signal ret_V_1_fu_118_p2 : STD_LOGIC_VECTOR (32 downto 0);
    signal ret_V_1_reg_683 : STD_LOGIC_VECTOR (32 downto 0);
    signal ret_V_1_reg_683_pp0_iter4_reg : STD_LOGIC_VECTOR (32 downto 0);
    signal p_Result_4_reg_688 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_4_reg_688_pp0_iter4_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_4_reg_688_pp0_iter5_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln718_1_fu_132_p1 : STD_LOGIC_VECTOR (13 downto 0);
    signal trunc_ln718_1_reg_694 : STD_LOGIC_VECTOR (13 downto 0);
    signal p_Result_3_reg_699 : STD_LOGIC_VECTOR (1 downto 0);
    signal p_Result_3_reg_699_pp0_iter4_reg : STD_LOGIC_VECTOR (1 downto 0);
    signal r_1_fu_146_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal r_1_reg_705 : STD_LOGIC_VECTOR (0 downto 0);
    signal r_2_fu_151_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal r_2_reg_710 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Val2_4_fu_194_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Val2_4_reg_715 : STD_LOGIC_VECTOR (15 downto 0);
    signal carry_1_fu_214_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal carry_1_reg_721 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_2_fu_219_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_2_reg_727 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln786_fu_262_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln786_reg_732 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Val2_9_fu_313_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Val2_9_reg_738 : STD_LOGIC_VECTOR (15 downto 0);
    signal carry_3_fu_333_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal carry_3_reg_744 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_6_fu_339_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_6_reg_750 : STD_LOGIC_VECTOR (0 downto 0);
    signal Range1_all_ones_1_fu_354_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal Range1_all_ones_1_reg_755 : STD_LOGIC_VECTOR (0 downto 0);
    signal Range1_all_zeros_fu_359_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal Range1_all_zeros_reg_761 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln786_2_fu_391_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln786_2_reg_766 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal lhs_V_fu_108_p1 : STD_LOGIC_VECTOR (32 downto 0);
    signal rhs_V_fu_111_p1 : STD_LOGIC_VECTOR (32 downto 0);
    signal tmp_fu_165_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_72_fu_177_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal r_fu_172_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln415_fu_184_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Val2_3_fu_156_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal zext_ln415_fu_190_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal tmp_73_fu_200_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln416_1_fu_208_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_76_fu_227_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln416_2_fu_240_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln416_1_fu_245_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln779_fu_234_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln416_fu_251_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal deleted_ones_fu_257_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_78_fu_277_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_80_fu_296_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln412_fu_291_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln415_1_fu_303_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Val2_8_fu_268_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal zext_ln415_1_fu_309_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal tmp_81_fu_319_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_5_fu_284_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln416_fu_327_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_84_fu_364_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal Range2_all_ones_fu_347_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln779_1_fu_371_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln779_fu_377_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal deleted_ones_1_fu_383_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln785_fu_401_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln785_fu_405_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln785_1_fu_410_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln781_fu_397_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln786_fu_421_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln786_fu_426_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal underflow_fu_432_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal overflow_fu_415_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln340_17_fu_443_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln340_fu_437_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln340_13_fu_448_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal select_ln340_fu_454_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal select_ln388_fu_461_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal deleted_zeros_fu_476_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln785_2_fu_485_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln785_1_fu_491_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln785_3_fu_496_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln781_1_fu_481_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln786_1_fu_507_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal xor_ln786_16_fu_512_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal underflow_1_fu_518_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal overflow_1_fu_501_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln340_18_fu_529_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln340_15_fu_523_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln340_16_fu_534_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal select_ln340_4_fu_540_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal select_ln388_4_fu_547_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal select_ln340_32_fu_468_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal select_ln340_33_fu_554_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_574_p0 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_574_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_580_p0 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_586_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_592_p0 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_592_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_574_ce : STD_LOGIC;
    signal grp_fu_580_ce : STD_LOGIC;
    signal grp_fu_586_ce : STD_LOGIC;
    signal grp_fu_592_ce : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;
    signal ar_V_read_int_reg : STD_LOGIC_VECTOR (15 downto 0);
    signal ai_V_read_int_reg : STD_LOGIC_VECTOR (15 downto 0);
    signal br_V_read_int_reg : STD_LOGIC_VECTOR (15 downto 0);
    signal bi_V_read_int_reg : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_return_0_int_reg : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_return_1_int_reg : STD_LOGIC_VECTOR (15 downto 0);

    component fine_channelizer_bkb IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (15 downto 0);
        din1 : IN STD_LOGIC_VECTOR (15 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component fine_channelizer_cud IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        din2_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (15 downto 0);
        din1 : IN STD_LOGIC_VECTOR (15 downto 0);
        din2 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;



begin
    fine_channelizer_bkb_U10 : component fine_channelizer_bkb
    generic map (
        ID => 1,
        NUM_STAGE => 3,
        din0_WIDTH => 16,
        din1_WIDTH => 16,
        dout_WIDTH => 32)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_574_p0,
        din1 => grp_fu_574_p1,
        ce => grp_fu_574_ce,
        dout => grp_fu_574_p2);

    fine_channelizer_bkb_U11 : component fine_channelizer_bkb
    generic map (
        ID => 1,
        NUM_STAGE => 3,
        din0_WIDTH => 16,
        din1_WIDTH => 16,
        dout_WIDTH => 32)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_580_p0,
        din1 => bi_V_read_int_reg,
        ce => grp_fu_580_ce,
        dout => grp_fu_580_p2);

    fine_channelizer_bkb_U12 : component fine_channelizer_bkb
    generic map (
        ID => 1,
        NUM_STAGE => 3,
        din0_WIDTH => 16,
        din1_WIDTH => 16,
        dout_WIDTH => 32)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => ai_V_read_int_reg,
        din1 => grp_fu_586_p1,
        ce => grp_fu_586_ce,
        dout => grp_fu_586_p2);

    fine_channelizer_cud_U13 : component fine_channelizer_cud
    generic map (
        ID => 1,
        NUM_STAGE => 3,
        din0_WIDTH => 16,
        din1_WIDTH => 16,
        din2_WIDTH => 32,
        dout_WIDTH => 32)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_592_p0,
        din1 => grp_fu_592_p1,
        din2 => p_Val2_s_reg_625,
        ce => grp_fu_592_ce,
        dout => grp_fu_592_p3);





    ap_ce_reg_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            ap_ce_reg <= ap_ce;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_ce_reg) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                Range1_all_ones_1_reg_755 <= Range1_all_ones_1_fu_354_p2;
                Range1_all_zeros_reg_761 <= Range1_all_zeros_fu_359_p2;
                Range2_all_ones_1_reg_667 <= grp_fu_592_p3(31 downto 31);
                Range2_all_ones_1_reg_667_pp0_iter4_reg <= Range2_all_ones_1_reg_667;
                Range2_all_ones_1_reg_667_pp0_iter5_reg <= Range2_all_ones_1_reg_667_pp0_iter4_reg;
                add_ln1192_reg_674 <= add_ln1192_fu_114_p2;
                add_ln1192_reg_674_pp0_iter4_reg <= add_ln1192_reg_674;
                and_ln786_2_reg_766 <= and_ln786_2_fu_391_p2;
                and_ln786_reg_732 <= and_ln786_fu_262_p2;
                carry_1_reg_721 <= carry_1_fu_214_p2;
                carry_3_reg_744 <= carry_3_fu_333_p2;
                p_Result_1_reg_661 <= grp_fu_592_p3(30 downto 30);
                p_Result_1_reg_661_pp0_iter4_reg <= p_Result_1_reg_661;
                p_Result_2_reg_727 <= p_Val2_4_fu_194_p2(15 downto 15);
                p_Result_3_reg_699 <= ret_V_1_fu_118_p2(32 downto 31);
                p_Result_3_reg_699_pp0_iter4_reg <= p_Result_3_reg_699;
                p_Result_4_reg_688 <= ret_V_1_fu_118_p2(32 downto 32);
                p_Result_4_reg_688_pp0_iter4_reg <= p_Result_4_reg_688;
                p_Result_4_reg_688_pp0_iter5_reg <= p_Result_4_reg_688_pp0_iter4_reg;
                p_Result_6_reg_750 <= p_Val2_9_fu_313_p2(15 downto 15);
                p_Result_s_reg_650 <= grp_fu_592_p3(31 downto 31);
                p_Result_s_reg_650_pp0_iter4_reg <= p_Result_s_reg_650;
                p_Result_s_reg_650_pp0_iter5_reg <= p_Result_s_reg_650_pp0_iter4_reg;
                p_Val2_4_reg_715 <= p_Val2_4_fu_194_p2;
                p_Val2_5_reg_636 <= grp_fu_586_p2;
                p_Val2_6_reg_630 <= grp_fu_580_p2;
                p_Val2_9_reg_738 <= p_Val2_9_fu_313_p2;
                p_Val2_s_reg_625 <= grp_fu_574_p2;
                r_1_reg_705 <= r_1_fu_146_p2;
                r_2_reg_710 <= r_2_fu_151_p2;
                ret_V_1_reg_683 <= ret_V_1_fu_118_p2;
                ret_V_1_reg_683_pp0_iter4_reg <= ret_V_1_reg_683;
                ret_V_reg_642 <= grp_fu_592_p3;
                ret_V_reg_642_pp0_iter4_reg <= ret_V_reg_642;
                sext_ln1116_1_reg_619 <= sext_ln1116_1_fu_80_p1;
                sext_ln1118_1_reg_613 <= sext_ln1118_1_fu_76_p1;
                trunc_ln718_1_reg_694 <= trunc_ln718_1_fu_132_p1;
                trunc_ln718_reg_656 <= trunc_ln718_fu_91_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_ce)) then
                ai_V_read_int_reg <= ai_V_read;
                ar_V_read_int_reg <= ar_V_read;
                bi_V_read_int_reg <= bi_V_read;
                br_V_read_int_reg <= br_V_read;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_ce_reg)) then
                ap_return_0_int_reg <= select_ln340_32_fu_468_p3;
                ap_return_1_int_reg <= select_ln340_33_fu_554_p3;
            end if;
        end if;
    end process;
    Range1_all_ones_1_fu_354_p2 <= "1" when (p_Result_3_reg_699_pp0_iter4_reg = ap_const_lv2_3) else "0";
    Range1_all_zeros_fu_359_p2 <= "1" when (p_Result_3_reg_699_pp0_iter4_reg = ap_const_lv2_0) else "0";
    Range2_all_ones_fu_347_p3 <= ret_V_1_reg_683_pp0_iter4_reg(32 downto 32);
    add_ln1192_fu_114_p2 <= std_logic_vector(signed(p_Val2_6_reg_630) + signed(p_Val2_5_reg_636));
    and_ln415_1_fu_303_p2 <= (tmp_80_fu_296_p3 and or_ln412_fu_291_p2);
    and_ln415_fu_184_p2 <= (tmp_72_fu_177_p3 and r_fu_172_p2);
    and_ln779_fu_377_p2 <= (xor_ln779_1_fu_371_p2 and Range2_all_ones_fu_347_p3);
    and_ln781_1_fu_481_p2 <= (carry_3_reg_744 and Range1_all_ones_1_reg_755);
    and_ln781_fu_397_p2 <= (carry_1_reg_721 and Range2_all_ones_1_reg_667_pp0_iter5_reg);
    and_ln786_2_fu_391_p2 <= (p_Result_6_fu_339_p3 and deleted_ones_1_fu_383_p3);
    and_ln786_fu_262_p2 <= (p_Result_2_fu_219_p3 and deleted_ones_fu_257_p2);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state1_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state4_pp0_stage0_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state5_pp0_stage0_iter4 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state6_pp0_stage0_iter5 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state7_pp0_stage0_iter6 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_return_0_assign_proc : process(select_ln340_32_fu_468_p3, ap_ce_reg, ap_return_0_int_reg)
    begin
        if ((ap_const_logic_0 = ap_ce_reg)) then 
            ap_return_0 <= ap_return_0_int_reg;
        elsif ((ap_const_logic_1 = ap_ce_reg)) then 
            ap_return_0 <= select_ln340_32_fu_468_p3;
        end if; 
    end process;


    ap_return_1_assign_proc : process(select_ln340_33_fu_554_p3, ap_ce_reg, ap_return_1_int_reg)
    begin
        if ((ap_const_logic_0 = ap_ce_reg)) then 
            ap_return_1 <= ap_return_1_int_reg;
        elsif ((ap_const_logic_1 = ap_ce_reg)) then 
            ap_return_1 <= select_ln340_33_fu_554_p3;
        end if; 
    end process;

    carry_1_fu_214_p2 <= (xor_ln416_1_fu_208_p2 and p_Result_1_reg_661_pp0_iter4_reg);
    carry_3_fu_333_p2 <= (xor_ln416_fu_327_p2 and p_Result_5_fu_284_p3);
    deleted_ones_1_fu_383_p3 <= 
        and_ln779_fu_377_p2 when (carry_3_fu_333_p2(0) = '1') else 
        Range1_all_ones_1_fu_354_p2;
    deleted_ones_fu_257_p2 <= (or_ln416_fu_251_p2 and Range2_all_ones_1_reg_667_pp0_iter4_reg);
    deleted_zeros_fu_476_p3 <= 
        Range1_all_ones_1_reg_755 when (carry_3_reg_744(0) = '1') else 
        Range1_all_zeros_reg_761;

    grp_fu_574_ce_assign_proc : process(ap_block_pp0_stage0_11001, ap_ce_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_ce_reg))) then 
            grp_fu_574_ce <= ap_const_logic_1;
        else 
            grp_fu_574_ce <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_574_p0 <= sext_ln1116_fu_68_p1(16 - 1 downto 0);
    grp_fu_574_p1 <= sext_ln1118_fu_72_p1(16 - 1 downto 0);

    grp_fu_580_ce_assign_proc : process(ap_block_pp0_stage0_11001, ap_ce_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_ce_reg))) then 
            grp_fu_580_ce <= ap_const_logic_1;
        else 
            grp_fu_580_ce <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_580_p0 <= sext_ln1116_fu_68_p1(16 - 1 downto 0);

    grp_fu_586_ce_assign_proc : process(ap_block_pp0_stage0_11001, ap_ce_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_ce_reg))) then 
            grp_fu_586_ce <= ap_const_logic_1;
        else 
            grp_fu_586_ce <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_586_p1 <= sext_ln1118_fu_72_p1(16 - 1 downto 0);

    grp_fu_592_ce_assign_proc : process(ap_block_pp0_stage0_11001, ap_ce_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_ce_reg))) then 
            grp_fu_592_ce <= ap_const_logic_1;
        else 
            grp_fu_592_ce <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_592_p0 <= sext_ln1116_1_reg_619(16 - 1 downto 0);
    grp_fu_592_p1 <= sext_ln1118_1_reg_613(16 - 1 downto 0);
        lhs_V_fu_108_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(p_Val2_5_reg_636),33));

    or_ln340_13_fu_448_p2 <= (or_ln340_17_fu_443_p2 or and_ln781_fu_397_p2);
    or_ln340_15_fu_523_p2 <= (underflow_1_fu_518_p2 or overflow_1_fu_501_p2);
    or_ln340_16_fu_534_p2 <= (or_ln340_18_fu_529_p2 or and_ln781_1_fu_481_p2);
    or_ln340_17_fu_443_p2 <= (xor_ln785_1_fu_410_p2 or and_ln786_reg_732);
    or_ln340_18_fu_529_p2 <= (xor_ln785_3_fu_496_p2 or and_ln786_2_reg_766);
    or_ln340_fu_437_p2 <= (underflow_fu_432_p2 or overflow_fu_415_p2);
    or_ln412_fu_291_p2 <= (tmp_78_fu_277_p3 or r_2_reg_710);
    or_ln416_1_fu_245_p2 <= (xor_ln416_2_fu_240_p2 or tmp_73_fu_200_p3);
    or_ln416_fu_251_p2 <= (xor_ln779_fu_234_p2 or or_ln416_1_fu_245_p2);
    or_ln785_1_fu_491_p2 <= (xor_ln785_2_fu_485_p2 or p_Result_6_reg_750);
    or_ln785_fu_405_p2 <= (xor_ln785_fu_401_p2 or p_Result_2_reg_727);
    or_ln786_1_fu_507_p2 <= (and_ln786_2_reg_766 or and_ln781_1_fu_481_p2);
    or_ln786_fu_421_p2 <= (and_ln786_reg_732 or and_ln781_fu_397_p2);
    overflow_1_fu_501_p2 <= (xor_ln785_3_fu_496_p2 and or_ln785_1_fu_491_p2);
    overflow_fu_415_p2 <= (xor_ln785_1_fu_410_p2 and or_ln785_fu_405_p2);
    p_Result_2_fu_219_p3 <= p_Val2_4_fu_194_p2(15 downto 15);
    p_Result_5_fu_284_p3 <= add_ln1192_reg_674_pp0_iter4_reg(30 downto 30);
    p_Result_6_fu_339_p3 <= p_Val2_9_fu_313_p2(15 downto 15);
    p_Val2_3_fu_156_p4 <= ret_V_reg_642_pp0_iter4_reg(30 downto 15);
    p_Val2_4_fu_194_p2 <= std_logic_vector(unsigned(p_Val2_3_fu_156_p4) + unsigned(zext_ln415_fu_190_p1));
    p_Val2_8_fu_268_p4 <= add_ln1192_reg_674_pp0_iter4_reg(30 downto 15);
    p_Val2_9_fu_313_p2 <= std_logic_vector(unsigned(p_Val2_8_fu_268_p4) + unsigned(zext_ln415_1_fu_309_p1));
    r_1_fu_146_p2 <= "0" when (trunc_ln718_reg_656 = ap_const_lv14_0) else "1";
    r_2_fu_151_p2 <= "0" when (trunc_ln718_1_reg_694 = ap_const_lv14_0) else "1";
    r_fu_172_p2 <= (tmp_fu_165_p3 or r_1_reg_705);
    ret_V_1_fu_118_p2 <= std_logic_vector(signed(lhs_V_fu_108_p1) + signed(rhs_V_fu_111_p1));
        rhs_V_fu_111_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(p_Val2_6_reg_630),33));

    select_ln340_32_fu_468_p3 <= 
        select_ln340_fu_454_p3 when (or_ln340_13_fu_448_p2(0) = '1') else 
        select_ln388_fu_461_p3;
    select_ln340_33_fu_554_p3 <= 
        select_ln340_4_fu_540_p3 when (or_ln340_16_fu_534_p2(0) = '1') else 
        select_ln388_4_fu_547_p3;
    select_ln340_4_fu_540_p3 <= 
        ap_const_lv16_7FFF when (or_ln340_15_fu_523_p2(0) = '1') else 
        p_Val2_9_reg_738;
    select_ln340_fu_454_p3 <= 
        ap_const_lv16_7FFF when (or_ln340_fu_437_p2(0) = '1') else 
        p_Val2_4_reg_715;
    select_ln388_4_fu_547_p3 <= 
        ap_const_lv16_8000 when (underflow_1_fu_518_p2(0) = '1') else 
        p_Val2_9_reg_738;
    select_ln388_fu_461_p3 <= 
        ap_const_lv16_8000 when (underflow_fu_432_p2(0) = '1') else 
        p_Val2_4_reg_715;
        sext_ln1116_1_fu_80_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(ai_V_read_int_reg),32));

        sext_ln1116_fu_68_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(ar_V_read_int_reg),32));

        sext_ln1118_1_fu_76_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(bi_V_read_int_reg),32));

        sext_ln1118_fu_72_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(br_V_read_int_reg),32));

    tmp_72_fu_177_p3 <= ret_V_reg_642_pp0_iter4_reg(14 downto 14);
    tmp_73_fu_200_p3 <= p_Val2_4_fu_194_p2(15 downto 15);
    tmp_76_fu_227_p3 <= ret_V_reg_642_pp0_iter4_reg(31 downto 31);
    tmp_78_fu_277_p3 <= add_ln1192_reg_674_pp0_iter4_reg(15 downto 15);
    tmp_80_fu_296_p3 <= add_ln1192_reg_674_pp0_iter4_reg(14 downto 14);
    tmp_81_fu_319_p3 <= p_Val2_9_fu_313_p2(15 downto 15);
    tmp_84_fu_364_p3 <= add_ln1192_reg_674_pp0_iter4_reg(31 downto 31);
    tmp_fu_165_p3 <= ret_V_reg_642_pp0_iter4_reg(15 downto 15);
    trunc_ln718_1_fu_132_p1 <= add_ln1192_fu_114_p2(14 - 1 downto 0);
    trunc_ln718_fu_91_p1 <= grp_fu_592_p3(14 - 1 downto 0);
    underflow_1_fu_518_p2 <= (xor_ln786_16_fu_512_p2 and p_Result_4_reg_688_pp0_iter5_reg);
    underflow_fu_432_p2 <= (xor_ln786_fu_426_p2 and p_Result_s_reg_650_pp0_iter5_reg);
    xor_ln416_1_fu_208_p2 <= (tmp_73_fu_200_p3 xor ap_const_lv1_1);
    xor_ln416_2_fu_240_p2 <= (p_Result_1_reg_661_pp0_iter4_reg xor ap_const_lv1_1);
    xor_ln416_fu_327_p2 <= (tmp_81_fu_319_p3 xor ap_const_lv1_1);
    xor_ln779_1_fu_371_p2 <= (tmp_84_fu_364_p3 xor ap_const_lv1_1);
    xor_ln779_fu_234_p2 <= (tmp_76_fu_227_p3 xor ap_const_lv1_1);
    xor_ln785_1_fu_410_p2 <= (p_Result_s_reg_650_pp0_iter5_reg xor ap_const_lv1_1);
    xor_ln785_2_fu_485_p2 <= (deleted_zeros_fu_476_p3 xor ap_const_lv1_1);
    xor_ln785_3_fu_496_p2 <= (p_Result_4_reg_688_pp0_iter5_reg xor ap_const_lv1_1);
    xor_ln785_fu_401_p2 <= (carry_1_reg_721 xor Range2_all_ones_1_reg_667_pp0_iter5_reg);
    xor_ln786_16_fu_512_p2 <= (or_ln786_1_fu_507_p2 xor ap_const_lv1_1);
    xor_ln786_fu_426_p2 <= (or_ln786_fu_421_p2 xor ap_const_lv1_1);
    zext_ln415_1_fu_309_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(and_ln415_1_fu_303_p2),16));
    zext_ln415_fu_190_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(and_ln415_fu_184_p2),16));
end behav;
