-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity resonator_dds_accumulate is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ap_ce : IN STD_LOGIC;
    group_r : IN STD_LOGIC_VECTOR (7 downto 0);
    tonesgroup : IN STD_LOGIC_VECTOR (255 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (167 downto 0) );
end;


architecture behav of resonator_dds_accumulate is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_58 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001011000";
    constant ap_const_lv32_6C : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001101100";
    constant ap_const_lv32_6D : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001101101";
    constant ap_const_lv32_81 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010000001";
    constant ap_const_lv32_B : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001011";
    constant ap_const_lv32_15 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010101";
    constant ap_const_lv32_82 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010000010";
    constant ap_const_lv32_96 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010010110";
    constant ap_const_lv32_16 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010110";
    constant ap_const_lv32_20 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000100000";
    constant ap_const_lv32_97 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010010111";
    constant ap_const_lv32_AB : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010101011";
    constant ap_const_lv32_21 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000100001";
    constant ap_const_lv32_2B : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000101011";
    constant ap_const_lv32_AC : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010101100";
    constant ap_const_lv32_C0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000011000000";
    constant ap_const_lv32_2C : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000101100";
    constant ap_const_lv32_36 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000110110";
    constant ap_const_lv32_C1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000011000001";
    constant ap_const_lv32_D5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000011010101";
    constant ap_const_lv32_37 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000110111";
    constant ap_const_lv32_41 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001000001";
    constant ap_const_lv32_D6 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000011010110";
    constant ap_const_lv32_EA : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000011101010";
    constant ap_const_lv32_42 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001000010";
    constant ap_const_lv32_4C : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001001100";
    constant ap_const_lv32_EB : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000011101011";
    constant ap_const_lv32_FF : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000011111111";
    constant ap_const_lv32_4D : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001001101";
    constant ap_const_lv32_57 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001010111";
    constant ap_const_lv8_FF : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
    constant ap_const_lv32_29 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000101001";
    constant ap_const_lv32_2A : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000101010";
    constant ap_const_lv32_3E : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000111110";
    constant ap_const_lv32_3F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000111111";
    constant ap_const_lv32_53 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001010011";
    constant ap_const_lv32_54 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001010100";
    constant ap_const_lv32_68 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001101000";
    constant ap_const_lv32_69 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001101001";
    constant ap_const_lv32_7D : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001111101";
    constant ap_const_lv32_7E : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001111110";
    constant ap_const_lv32_92 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010010010";
    constant ap_const_lv32_93 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010010011";
    constant ap_const_lv32_A7 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000010100111";
    constant ap_const_lv10_0 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal acc_V : STD_LOGIC_VECTOR (167 downto 0) := "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    signal accumulator_V_address0 : STD_LOGIC_VECTOR (7 downto 0);
    signal accumulator_V_ce0 : STD_LOGIC;
    signal accumulator_V_we0 : STD_LOGIC;
    signal accumulator_V_address1 : STD_LOGIC_VECTOR (7 downto 0);
    signal accumulator_V_ce1 : STD_LOGIC;
    signal accumulator_V_q1 : STD_LOGIC_VECTOR (167 downto 0);
    signal group_read_reg_580 : STD_LOGIC_VECTOR (7 downto 0);
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal p_Result_s_reg_590 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_s_reg_590_pp0_iter1_reg : STD_LOGIC_VECTOR (20 downto 0);
    signal trunc_ln1245_fu_174_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal trunc_ln1245_reg_595 : STD_LOGIC_VECTOR (10 downto 0);
    signal trunc_ln1245_reg_595_pp0_iter1_reg : STD_LOGIC_VECTOR (10 downto 0);
    signal p_Result_123_1_reg_600 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_123_1_reg_600_pp0_iter1_reg : STD_LOGIC_VECTOR (20 downto 0);
    signal tmp_8_reg_605 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_8_reg_605_pp0_iter1_reg : STD_LOGIC_VECTOR (10 downto 0);
    signal p_Result_123_2_reg_610 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_123_2_reg_610_pp0_iter1_reg : STD_LOGIC_VECTOR (20 downto 0);
    signal tmp_9_reg_615 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_9_reg_615_pp0_iter1_reg : STD_LOGIC_VECTOR (10 downto 0);
    signal p_Result_123_3_reg_620 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_123_3_reg_620_pp0_iter1_reg : STD_LOGIC_VECTOR (20 downto 0);
    signal tmp_10_reg_625 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_10_reg_625_pp0_iter1_reg : STD_LOGIC_VECTOR (10 downto 0);
    signal p_Result_123_4_reg_630 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_123_4_reg_630_pp0_iter1_reg : STD_LOGIC_VECTOR (20 downto 0);
    signal tmp_11_reg_635 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_11_reg_635_pp0_iter1_reg : STD_LOGIC_VECTOR (10 downto 0);
    signal p_Result_123_5_reg_640 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_123_5_reg_640_pp0_iter1_reg : STD_LOGIC_VECTOR (20 downto 0);
    signal tmp_12_reg_645 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_12_reg_645_pp0_iter1_reg : STD_LOGIC_VECTOR (10 downto 0);
    signal p_Result_123_6_reg_650 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_123_6_reg_650_pp0_iter1_reg : STD_LOGIC_VECTOR (20 downto 0);
    signal tmp_13_reg_655 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_13_reg_655_pp0_iter1_reg : STD_LOGIC_VECTOR (10 downto 0);
    signal p_Result_123_7_reg_660 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_123_7_reg_660_pp0_iter1_reg : STD_LOGIC_VECTOR (20 downto 0);
    signal tmp_14_reg_665 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_14_reg_665_pp0_iter1_reg : STD_LOGIC_VECTOR (10 downto 0);
    signal add_ln223_fu_318_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal add_ln223_reg_670 : STD_LOGIC_VECTOR (7 downto 0);
    signal trunc_ln674_fu_323_p1 : STD_LOGIC_VECTOR (20 downto 0);
    signal trunc_ln674_reg_675 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_125_1_reg_681 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_125_2_reg_687 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_125_3_reg_693 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_125_4_reg_699 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_125_5_reg_705 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_125_6_reg_711 : STD_LOGIC_VECTOR (20 downto 0);
    signal p_Result_125_7_reg_717 : STD_LOGIC_VECTOR (20 downto 0);
    signal zext_ln573_3_fu_159_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal zext_ln573_fu_397_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal p_Result_121_7_fu_554_p9 : STD_LOGIC_VECTOR (167 downto 0);
    signal shl_ln_fu_410_p3 : STD_LOGIC_VECTOR (20 downto 0);
    signal shl_ln1245_1_fu_426_p3 : STD_LOGIC_VECTOR (20 downto 0);
    signal shl_ln1245_2_fu_442_p3 : STD_LOGIC_VECTOR (20 downto 0);
    signal shl_ln1245_3_fu_458_p3 : STD_LOGIC_VECTOR (20 downto 0);
    signal shl_ln1245_4_fu_474_p3 : STD_LOGIC_VECTOR (20 downto 0);
    signal shl_ln1245_5_fu_490_p3 : STD_LOGIC_VECTOR (20 downto 0);
    signal shl_ln1245_6_fu_506_p3 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_14_fu_518_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_12_fu_502_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_10_fu_486_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_8_fu_470_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_6_fu_454_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_4_fu_438_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_2_fu_422_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_fu_406_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal shl_ln1245_7_fu_542_p3 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_15_fu_549_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_13_fu_513_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_11_fu_497_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_9_fu_481_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_7_fu_465_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_5_fu_449_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_3_fu_433_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal add_ln712_1_fu_417_p2 : STD_LOGIC_VECTOR (20 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_idle_pp0_0to1 : STD_LOGIC;
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component resonator_dds_accumulate_accumulator_V IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (7 downto 0);
        ce0 : IN STD_LOGIC;
        we0 : IN STD_LOGIC;
        d0 : IN STD_LOGIC_VECTOR (167 downto 0);
        address1 : IN STD_LOGIC_VECTOR (7 downto 0);
        ce1 : IN STD_LOGIC;
        q1 : OUT STD_LOGIC_VECTOR (167 downto 0) );
    end component;



begin
    accumulator_V_U : component resonator_dds_accumulate_accumulator_V
    generic map (
        DataWidth => 168,
        AddressRange => 256,
        AddressWidth => 8)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => accumulator_V_address0,
        ce0 => accumulator_V_ce0,
        we0 => accumulator_V_we0,
        d0 => acc_V,
        address1 => accumulator_V_address1,
        ce1 => accumulator_V_ce1,
        q1 => accumulator_V_q1);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_enable_reg_pp0_iter1 <= ap_start;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_logic_1 = ap_ce))) then
                acc_V <= p_Result_121_7_fu_554_p9;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_ce) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                add_ln223_reg_670 <= add_ln223_fu_318_p2;
                group_read_reg_580 <= group_r;
                p_Result_123_1_reg_600 <= tonesgroup(129 downto 109);
                p_Result_123_1_reg_600_pp0_iter1_reg <= p_Result_123_1_reg_600;
                p_Result_123_2_reg_610 <= tonesgroup(150 downto 130);
                p_Result_123_2_reg_610_pp0_iter1_reg <= p_Result_123_2_reg_610;
                p_Result_123_3_reg_620 <= tonesgroup(171 downto 151);
                p_Result_123_3_reg_620_pp0_iter1_reg <= p_Result_123_3_reg_620;
                p_Result_123_4_reg_630 <= tonesgroup(192 downto 172);
                p_Result_123_4_reg_630_pp0_iter1_reg <= p_Result_123_4_reg_630;
                p_Result_123_5_reg_640 <= tonesgroup(213 downto 193);
                p_Result_123_5_reg_640_pp0_iter1_reg <= p_Result_123_5_reg_640;
                p_Result_123_6_reg_650 <= tonesgroup(234 downto 214);
                p_Result_123_6_reg_650_pp0_iter1_reg <= p_Result_123_6_reg_650;
                p_Result_123_7_reg_660 <= tonesgroup(255 downto 235);
                p_Result_123_7_reg_660_pp0_iter1_reg <= p_Result_123_7_reg_660;
                p_Result_125_1_reg_681 <= accumulator_V_q1(41 downto 21);
                p_Result_125_2_reg_687 <= accumulator_V_q1(62 downto 42);
                p_Result_125_3_reg_693 <= accumulator_V_q1(83 downto 63);
                p_Result_125_4_reg_699 <= accumulator_V_q1(104 downto 84);
                p_Result_125_5_reg_705 <= accumulator_V_q1(125 downto 105);
                p_Result_125_6_reg_711 <= accumulator_V_q1(146 downto 126);
                p_Result_125_7_reg_717 <= accumulator_V_q1(167 downto 147);
                p_Result_s_reg_590 <= tonesgroup(108 downto 88);
                p_Result_s_reg_590_pp0_iter1_reg <= p_Result_s_reg_590;
                tmp_10_reg_625 <= tonesgroup(43 downto 33);
                tmp_10_reg_625_pp0_iter1_reg <= tmp_10_reg_625;
                tmp_11_reg_635 <= tonesgroup(54 downto 44);
                tmp_11_reg_635_pp0_iter1_reg <= tmp_11_reg_635;
                tmp_12_reg_645 <= tonesgroup(65 downto 55);
                tmp_12_reg_645_pp0_iter1_reg <= tmp_12_reg_645;
                tmp_13_reg_655 <= tonesgroup(76 downto 66);
                tmp_13_reg_655_pp0_iter1_reg <= tmp_13_reg_655;
                tmp_14_reg_665 <= tonesgroup(87 downto 77);
                tmp_14_reg_665_pp0_iter1_reg <= tmp_14_reg_665;
                tmp_8_reg_605 <= tonesgroup(21 downto 11);
                tmp_8_reg_605_pp0_iter1_reg <= tmp_8_reg_605;
                tmp_9_reg_615 <= tonesgroup(32 downto 22);
                tmp_9_reg_615_pp0_iter1_reg <= tmp_9_reg_615;
                trunc_ln1245_reg_595 <= trunc_ln1245_fu_174_p1;
                trunc_ln1245_reg_595_pp0_iter1_reg <= trunc_ln1245_reg_595;
                trunc_ln674_reg_675 <= trunc_ln674_fu_323_p1;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage0_subdone, ap_reset_idle_pp0)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    accumulator_V_address0 <= zext_ln573_fu_397_p1(8 - 1 downto 0);
    accumulator_V_address1 <= zext_ln573_3_fu_159_p1(8 - 1 downto 0);

    accumulator_V_ce0_assign_proc : process(ap_enable_reg_pp0_iter2, ap_ce, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_logic_1 = ap_ce))) then 
            accumulator_V_ce0 <= ap_const_logic_1;
        else 
            accumulator_V_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    accumulator_V_ce1_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_ce, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_ce) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            accumulator_V_ce1 <= ap_const_logic_1;
        else 
            accumulator_V_ce1 <= ap_const_logic_0;
        end if; 
    end process;


    accumulator_V_we0_assign_proc : process(ap_enable_reg_pp0_iter2, ap_ce, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_logic_1 = ap_ce))) then 
            accumulator_V_we0 <= ap_const_logic_1;
        else 
            accumulator_V_we0 <= ap_const_logic_0;
        end if; 
    end process;

    add_ln223_fu_318_p2 <= std_logic_vector(unsigned(group_read_reg_580) + unsigned(ap_const_lv8_FF));
    add_ln712_10_fu_486_p2 <= std_logic_vector(unsigned(p_Result_125_5_reg_705) + unsigned(p_Result_123_5_reg_640_pp0_iter1_reg));
    add_ln712_11_fu_497_p2 <= std_logic_vector(unsigned(p_Result_125_5_reg_705) + unsigned(shl_ln1245_5_fu_490_p3));
    add_ln712_12_fu_502_p2 <= std_logic_vector(unsigned(p_Result_125_6_reg_711) + unsigned(p_Result_123_6_reg_650_pp0_iter1_reg));
    add_ln712_13_fu_513_p2 <= std_logic_vector(unsigned(p_Result_125_6_reg_711) + unsigned(shl_ln1245_6_fu_506_p3));
    add_ln712_14_fu_518_p2 <= std_logic_vector(unsigned(p_Result_125_7_reg_717) + unsigned(p_Result_123_7_reg_660_pp0_iter1_reg));
    add_ln712_15_fu_549_p2 <= std_logic_vector(unsigned(p_Result_125_7_reg_717) + unsigned(shl_ln1245_7_fu_542_p3));
    add_ln712_1_fu_417_p2 <= std_logic_vector(unsigned(trunc_ln674_reg_675) + unsigned(shl_ln_fu_410_p3));
    add_ln712_2_fu_422_p2 <= std_logic_vector(unsigned(p_Result_125_1_reg_681) + unsigned(p_Result_123_1_reg_600_pp0_iter1_reg));
    add_ln712_3_fu_433_p2 <= std_logic_vector(unsigned(p_Result_125_1_reg_681) + unsigned(shl_ln1245_1_fu_426_p3));
    add_ln712_4_fu_438_p2 <= std_logic_vector(unsigned(p_Result_125_2_reg_687) + unsigned(p_Result_123_2_reg_610_pp0_iter1_reg));
    add_ln712_5_fu_449_p2 <= std_logic_vector(unsigned(p_Result_125_2_reg_687) + unsigned(shl_ln1245_2_fu_442_p3));
    add_ln712_6_fu_454_p2 <= std_logic_vector(unsigned(p_Result_125_3_reg_693) + unsigned(p_Result_123_3_reg_620_pp0_iter1_reg));
    add_ln712_7_fu_465_p2 <= std_logic_vector(unsigned(p_Result_125_3_reg_693) + unsigned(shl_ln1245_3_fu_458_p3));
    add_ln712_8_fu_470_p2 <= std_logic_vector(unsigned(p_Result_125_4_reg_699) + unsigned(p_Result_123_4_reg_630_pp0_iter1_reg));
    add_ln712_9_fu_481_p2 <= std_logic_vector(unsigned(p_Result_125_4_reg_699) + unsigned(shl_ln1245_4_fu_474_p3));
    add_ln712_fu_406_p2 <= std_logic_vector(unsigned(trunc_ln674_reg_675) + unsigned(p_Result_s_reg_590_pp0_iter1_reg));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_subdone_assign_proc : process(ap_ce)
    begin
                ap_block_pp0_stage0_subdone <= (ap_const_logic_0 = ap_ce);
    end process;

        ap_block_state1_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_done_assign_proc : process(ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);
    ap_enable_reg_pp0_iter0 <= ap_start;

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_pp0_stage0, ap_idle_pp0)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_idle_pp0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_0to1_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0_0to1 <= ap_const_logic_1;
        else 
            ap_idle_pp0_0to1 <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_reset_idle_pp0_assign_proc : process(ap_start, ap_idle_pp0_0to1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_idle_pp0_0to1 = ap_const_logic_1))) then 
            ap_reset_idle_pp0 <= ap_const_logic_1;
        else 
            ap_reset_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_return <= (((((((add_ln712_14_fu_518_p2 & add_ln712_12_fu_502_p2) & add_ln712_10_fu_486_p2) & add_ln712_8_fu_470_p2) & add_ln712_6_fu_454_p2) & add_ln712_4_fu_438_p2) & add_ln712_2_fu_422_p2) & add_ln712_fu_406_p2);
    p_Result_121_7_fu_554_p9 <= (((((((add_ln712_15_fu_549_p2 & add_ln712_13_fu_513_p2) & add_ln712_11_fu_497_p2) & add_ln712_9_fu_481_p2) & add_ln712_7_fu_465_p2) & add_ln712_5_fu_449_p2) & add_ln712_3_fu_433_p2) & add_ln712_1_fu_417_p2);
    shl_ln1245_1_fu_426_p3 <= (tmp_8_reg_605_pp0_iter1_reg & ap_const_lv10_0);
    shl_ln1245_2_fu_442_p3 <= (tmp_9_reg_615_pp0_iter1_reg & ap_const_lv10_0);
    shl_ln1245_3_fu_458_p3 <= (tmp_10_reg_625_pp0_iter1_reg & ap_const_lv10_0);
    shl_ln1245_4_fu_474_p3 <= (tmp_11_reg_635_pp0_iter1_reg & ap_const_lv10_0);
    shl_ln1245_5_fu_490_p3 <= (tmp_12_reg_645_pp0_iter1_reg & ap_const_lv10_0);
    shl_ln1245_6_fu_506_p3 <= (tmp_13_reg_655_pp0_iter1_reg & ap_const_lv10_0);
    shl_ln1245_7_fu_542_p3 <= (tmp_14_reg_665_pp0_iter1_reg & ap_const_lv10_0);
    shl_ln_fu_410_p3 <= (trunc_ln1245_reg_595_pp0_iter1_reg & ap_const_lv10_0);
    trunc_ln1245_fu_174_p1 <= tonesgroup(11 - 1 downto 0);
    trunc_ln674_fu_323_p1 <= accumulator_V_q1(21 - 1 downto 0);
    zext_ln573_3_fu_159_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(group_r),64));
    zext_ln573_fu_397_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(add_ln223_reg_670),64));
end behav;
