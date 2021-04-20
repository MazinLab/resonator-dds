-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.1.1 (64-bit)
-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity resonator_dds_phase_to_sincos_wLUT_cos_lut_rom is 
    generic(
             DWIDTH     : integer := 17; 
             AWIDTH     : integer := 10; 
             MEM_SIZE    : integer := 1024
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          addr1      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce1       : in std_logic; 
          q1         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of resonator_dds_phase_to_sincos_wLUT_cos_lut_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
signal addr1_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 to 3=> "11111111111111111", 4 => "11111111111111110", 
    5 => "11111111111111100", 6 => "11111111111111010", 
    7 => "11111111111111000", 8 => "11111111111110110", 
    9 => "11111111111110100", 10 => "11111111111110001", 
    11 => "11111111111101101", 12 => "11111111111101010", 
    13 => "11111111111100110", 14 => "11111111111100010", 
    15 => "11111111111011101", 16 => "11111111111011001", 
    17 => "11111111111010011", 18 => "11111111111001110", 
    19 => "11111111111001000", 20 => "11111111111000010", 
    21 => "11111111110111100", 22 => "11111111110110101", 
    23 => "11111111110101110", 24 => "11111111110100111", 
    25 => "11111111110100000", 26 => "11111111110011000", 
    27 => "11111111110010000", 28 => "11111111110000111", 
    29 => "11111111101111110", 30 => "11111111101110101", 
    31 => "11111111101101100", 32 => "11111111101100010", 
    33 => "11111111101011000", 34 => "11111111101001110", 
    35 => "11111111101000011", 36 => "11111111100111000", 
    37 => "11111111100101101", 38 => "11111111100100001", 
    39 => "11111111100010110", 40 => "11111111100001001", 
    41 => "11111111011111101", 42 => "11111111011110000", 
    43 => "11111111011100011", 44 => "11111111011010110", 
    45 => "11111111011001000", 46 => "11111111010111010", 
    47 => "11111111010101011", 48 => "11111111010011101", 
    49 => "11111111010001110", 50 => "11111111001111111", 
    51 => "11111111001101111", 52 => "11111111001011111", 
    53 => "11111111001001111", 54 => "11111111000111111", 
    55 => "11111111000101110", 56 => "11111111000011101", 
    57 => "11111111000001011", 58 => "11111110111111010", 
    59 => "11111110111101000", 60 => "11111110111010101", 
    61 => "11111110111000011", 62 => "11111110110110000", 
    63 => "11111110110011100", 64 => "11111110110001001", 
    65 => "11111110101110101", 66 => "11111110101100001", 
    67 => "11111110101001100", 68 => "11111110100111000", 
    69 => "11111110100100010", 70 => "11111110100001101", 
    71 => "11111110011110111", 72 => "11111110011100001", 
    73 => "11111110011001011", 74 => "11111110010110100", 
    75 => "11111110010011110", 76 => "11111110010000110", 
    77 => "11111110001101111", 78 => "11111110001010111", 
    79 => "11111110000111111", 80 => "11111110000100110", 
    81 => "11111110000001110", 82 => "11111101111110100", 
    83 => "11111101111011011", 84 => "11111101111000001", 
    85 => "11111101110100111", 86 => "11111101110001101", 
    87 => "11111101101110010", 88 => "11111101101011000", 
    89 => "11111101100111100", 90 => "11111101100100001", 
    91 => "11111101100000101", 92 => "11111101011101001", 
    93 => "11111101011001100", 94 => "11111101010110000", 
    95 => "11111101010010011", 96 => "11111101001110101", 
    97 => "11111101001011000", 98 => "11111101000111010", 
    99 => "11111101000011011", 100 => "11111100111111101", 
    101 => "11111100111011110", 102 => "11111100110111111", 
    103 => "11111100110011111", 104 => "11111100110000000", 
    105 => "11111100101011111", 106 => "11111100100111111", 
    107 => "11111100100011110", 108 => "11111100011111101", 
    109 => "11111100011011100", 110 => "11111100010111010", 
    111 => "11111100010011001", 112 => "11111100001110110", 
    113 => "11111100001010100", 114 => "11111100000110001", 
    115 => "11111100000001110", 116 => "11111011111101010", 
    117 => "11111011111000111", 118 => "11111011110100011", 
    119 => "11111011101111110", 120 => "11111011101011010", 
    121 => "11111011100110101", 122 => "11111011100001111", 
    123 => "11111011011101010", 124 => "11111011011000100", 
    125 => "11111011010011110", 126 => "11111011001110111", 
    127 => "11111011001010001", 128 => "11111011000101001", 
    129 => "11111011000000010", 130 => "11111010111011010", 
    131 => "11111010110110010", 132 => "11111010110001010", 
    133 => "11111010101100010", 134 => "11111010100111001", 
    135 => "11111010100010000", 136 => "11111010011100110", 
    137 => "11111010010111100", 138 => "11111010010010010", 
    139 => "11111010001101000", 140 => "11111010000111101", 
    141 => "11111010000010010", 142 => "11111001111100111", 
    143 => "11111001110111011", 144 => "11111001110001111", 
    145 => "11111001101100011", 146 => "11111001100110111", 
    147 => "11111001100001010", 148 => "11111001011011101", 
    149 => "11111001010101111", 150 => "11111001010000001", 
    151 => "11111001001010011", 152 => "11111001000100101", 
    153 => "11111000111110111", 154 => "11111000111001000", 
    155 => "11111000110011000", 156 => "11111000101101001", 
    157 => "11111000100111001", 158 => "11111000100001001", 
    159 => "11111000011011001", 160 => "11111000010101000", 
    161 => "11111000001110111", 162 => "11111000001000110", 
    163 => "11111000000010100", 164 => "11110111111100010", 
    165 => "11110111110110000", 166 => "11110111101111101", 
    167 => "11110111101001011", 168 => "11110111100011000", 
    169 => "11110111011100100", 170 => "11110111010110000", 
    171 => "11110111001111100", 172 => "11110111001001000", 
    173 => "11110111000010100", 174 => "11110110111011111", 
    175 => "11110110110101010", 176 => "11110110101110100", 
    177 => "11110110100111110", 178 => "11110110100001000", 
    179 => "11110110011010010", 180 => "11110110010011011", 
    181 => "11110110001100100", 182 => "11110110000101101", 
    183 => "11110101111110101", 184 => "11110101110111110", 
    185 => "11110101110000101", 186 => "11110101101001101", 
    187 => "11110101100010100", 188 => "11110101011011011", 
    189 => "11110101010100010", 190 => "11110101001101000", 
    191 => "11110101000101110", 192 => "11110100111110100", 
    193 => "11110100110111010", 194 => "11110100101111111", 
    195 => "11110100101000100", 196 => "11110100100001000", 
    197 => "11110100011001101", 198 => "11110100010010001", 
    199 => "11110100001010100", 200 => "11110100000011000", 
    201 => "11110011111011011", 202 => "11110011110011110", 
    203 => "11110011101100000", 204 => "11110011100100010", 
    205 => "11110011011100100", 206 => "11110011010100110", 
    207 => "11110011001100111", 208 => "11110011000101001", 
    209 => "11110010111101001", 210 => "11110010110101010", 
    211 => "11110010101101010", 212 => "11110010100101010", 
    213 => "11110010011101010", 214 => "11110010010101001", 
    215 => "11110010001101000", 216 => "11110010000100111", 
    217 => "11110001111100101", 218 => "11110001110100011", 
    219 => "11110001101100001", 220 => "11110001100011111", 
    221 => "11110001011011100", 222 => "11110001010011001", 
    223 => "11110001001010110", 224 => "11110001000010010", 
    225 => "11110000111001110", 226 => "11110000110001010", 
    227 => "11110000101000110", 228 => "11110000100000001", 
    229 => "11110000010111100", 230 => "11110000001110110", 
    231 => "11110000000110001", 232 => "11101111111101011", 
    233 => "11101111110100101", 234 => "11101111101011110", 
    235 => "11101111100010111", 236 => "11101111011010000", 
    237 => "11101111010001001", 238 => "11101111001000001", 
    239 => "11101110111111001", 240 => "11101110110110001", 
    241 => "11101110101101001", 242 => "11101110100100000", 
    243 => "11101110011010111", 244 => "11101110010001101", 
    245 => "11101110001000100", 246 => "11101101111111010", 
    247 => "11101101110110000", 248 => "11101101101100101", 
    249 => "11101101100011010", 250 => "11101101011001111", 
    251 => "11101101010000100", 252 => "11101101000111000", 
    253 => "11101100111101100", 254 => "11101100110100000", 
    255 => "11101100101010100", 256 => "11101100100000111", 
    257 => "11101100010111010", 258 => "11101100001101100", 
    259 => "11101100000011111", 260 => "11101011111010001", 
    261 => "11101011110000010", 262 => "11101011100110100", 
    263 => "11101011011100101", 264 => "11101011010010110", 
    265 => "11101011001000111", 266 => "11101010111110111", 
    267 => "11101010110100111", 268 => "11101010101010111", 
    269 => "11101010100000110", 270 => "11101010010110110", 
    271 => "11101010001100101", 272 => "11101010000010011", 
    273 => "11101001111000010", 274 => "11101001101110000", 
    275 => "11101001100011110", 276 => "11101001011001011", 
    277 => "11101001001111000", 278 => "11101001000100101", 
    279 => "11101000111010010", 280 => "11101000101111110", 
    281 => "11101000100101011", 282 => "11101000011010110", 
    283 => "11101000010000010", 284 => "11101000000101101", 
    285 => "11100111111011000", 286 => "11100111110000011", 
    287 => "11100111100101110", 288 => "11100111011011000", 
    289 => "11100111010000010", 290 => "11100111000101011", 
    291 => "11100110111010101", 292 => "11100110101111110", 
    293 => "11100110100100110", 294 => "11100110011001111", 
    295 => "11100110001110111", 296 => "11100110000011111", 
    297 => "11100101111000111", 298 => "11100101101101110", 
    299 => "11100101100010101", 300 => "11100101010111100", 
    301 => "11100101001100011", 302 => "11100101000001001", 
    303 => "11100100110101111", 304 => "11100100101010101", 
    305 => "11100100011111010", 306 => "11100100010011111", 
    307 => "11100100001000100", 308 => "11100011111101001", 
    309 => "11100011110001101", 310 => "11100011100110001", 
    311 => "11100011011010101", 312 => "11100011001111001", 
    313 => "11100011000011100", 314 => "11100010110111111", 
    315 => "11100010101100010", 316 => "11100010100000100", 
    317 => "11100010010100110", 318 => "11100010001001000", 
    319 => "11100001111101010", 320 => "11100001110001011", 
    321 => "11100001100101100", 322 => "11100001011001101", 
    323 => "11100001001101110", 324 => "11100001000001110", 
    325 => "11100000110101110", 326 => "11100000101001110", 
    327 => "11100000011101101", 328 => "11100000010001100", 
    329 => "11100000000101011", 330 => "11011111111001010", 
    331 => "11011111101101000", 332 => "11011111100000110", 
    333 => "11011111010100100", 334 => "11011111001000010", 
    335 => "11011110111011111", 336 => "11011110101111100", 
    337 => "11011110100011001", 338 => "11011110010110101", 
    339 => "11011110001010010", 340 => "11011101111101101", 
    341 => "11011101110001001", 342 => "11011101100100101", 
    343 => "11011101011000000", 344 => "11011101001011011", 
    345 => "11011100111110101", 346 => "11011100110010000", 
    347 => "11011100100101010", 348 => "11011100011000100", 
    349 => "11011100001011101", 350 => "11011011111110110", 
    351 => "11011011110001111", 352 => "11011011100101000", 
    353 => "11011011011000001", 354 => "11011011001011001", 
    355 => "11011010111110001", 356 => "11011010110001001", 
    357 => "11011010100100000", 358 => "11011010010110111", 
    359 => "11011010001001110", 360 => "11011001111100101", 
    361 => "11011001101111011", 362 => "11011001100010001", 
    363 => "11011001010100111", 364 => "11011001000111101", 
    365 => "11011000111010010", 366 => "11011000101100111", 
    367 => "11011000011111100", 368 => "11011000010010001", 
    369 => "11011000000100101", 370 => "11010111110111001", 
    371 => "11010111101001101", 372 => "11010111011100000", 
    373 => "11010111001110100", 374 => "11010111000000111", 
    375 => "11010110110011001", 376 => "11010110100101100", 
    377 => "11010110010111110", 378 => "11010110001010000", 
    379 => "11010101111100010", 380 => "11010101101110011", 
    381 => "11010101100000100", 382 => "11010101010010101", 
    383 => "11010101000100110", 384 => "11010100110110110", 
    385 => "11010100101000111", 386 => "11010100011010110", 
    387 => "11010100001100110", 388 => "11010011111110110", 
    389 => "11010011110000101", 390 => "11010011100010100", 
    391 => "11010011010100010", 392 => "11010011000110001", 
    393 => "11010010110111111", 394 => "11010010101001101", 
    395 => "11010010011011010", 396 => "11010010001101000", 
    397 => "11010001111110101", 398 => "11010001110000010", 
    399 => "11010001100001110", 400 => "11010001010011010", 
    401 => "11010001000100111", 402 => "11010000110110010", 
    403 => "11010000100111110", 404 => "11010000011001001", 
    405 => "11010000001010100", 406 => "11001111111011111", 
    407 => "11001111101101010", 408 => "11001111011110100", 
    409 => "11001111001111110", 410 => "11001111000001000", 
    411 => "11001110110010010", 412 => "11001110100011011", 
    413 => "11001110010100100", 414 => "11001110000101101", 
    415 => "11001101110110110", 416 => "11001101100111110", 
    417 => "11001101011000110", 418 => "11001101001001110", 
    419 => "11001100111010110", 420 => "11001100101011101", 
    421 => "11001100011100100", 422 => "11001100001101011", 
    423 => "11001011111110010", 424 => "11001011101111000", 
    425 => "11001011011111110", 426 => "11001011010000100", 
    427 => "11001011000001010", 428 => "11001010110001111", 
    429 => "11001010100010100", 430 => "11001010010011001", 
    431 => "11001010000011110", 432 => "11001001110100010", 
    433 => "11001001100100110", 434 => "11001001010101010", 
    435 => "11001001000101110", 436 => "11001000110110001", 
    437 => "11001000100110101", 438 => "11001000010111000", 
    439 => "11001000000111010", 440 => "11000111110111101", 
    441 => "11000111100111111", 442 => "11000111011000001", 
    443 => "11000111001000011", 444 => "11000110111000100", 
    445 => "11000110101000110", 446 => "11000110011000111", 
    447 => "11000110001000111", 448 => "11000101111001000", 
    449 => "11000101101001000", 450 => "11000101011001000", 
    451 => "11000101001001000", 452 => "11000100111001000", 
    453 => "11000100101000111", 454 => "11000100011000110", 
    455 => "11000100001000101", 456 => "11000011111000100", 
    457 => "11000011101000010", 458 => "11000011011000001", 
    459 => "11000011000111111", 460 => "11000010110111100", 
    461 => "11000010100111010", 462 => "11000010010110111", 
    463 => "11000010000110100", 464 => "11000001110110001", 
    465 => "11000001100101101", 466 => "11000001010101010", 
    467 => "11000001000100110", 468 => "11000000110100010", 
    469 => "11000000100011101", 470 => "11000000010011001", 
    471 => "11000000000010100", 472 => "10111111110001111", 
    473 => "10111111100001010", 474 => "10111111010000100", 
    475 => "10111110111111110", 476 => "10111110101111000", 
    477 => "10111110011110010", 478 => "10111110001101100", 
    479 => "10111101111100101", 480 => "10111101101011110", 
    481 => "10111101011010111", 482 => "10111101001001111", 
    483 => "10111100111001000", 484 => "10111100101000000", 
    485 => "10111100010111000", 486 => "10111100000110000", 
    487 => "10111011110100111", 488 => "10111011100011110", 
    489 => "10111011010010110", 490 => "10111011000001100", 
    491 => "10111010110000011", 492 => "10111010011111001", 
    493 => "10111010001101111", 494 => "10111001111100101", 
    495 => "10111001101011011", 496 => "10111001011010001", 
    497 => "10111001001000110", 498 => "10111000110111011", 
    499 => "10111000100110000", 500 => "10111000010100100", 
    501 => "10111000000011001", 502 => "10110111110001101", 
    503 => "10110111100000001", 504 => "10110111001110100", 
    505 => "10110110111101000", 506 => "10110110101011011", 
    507 => "10110110011001110", 508 => "10110110001000001", 
    509 => "10110101110110011", 510 => "10110101100100110", 
    511 => "10110101010011000", 512 => "10110101000001010", 
    513 => "10110100101111100", 514 => "10110100011101101", 
    515 => "10110100001011110", 516 => "10110011111001111", 
    517 => "10110011101000000", 518 => "10110011010110001", 
    519 => "10110011000100001", 520 => "10110010110010010", 
    521 => "10110010100000010", 522 => "10110010001110001", 
    523 => "10110001111100001", 524 => "10110001101010000", 
    525 => "10110001010111111", 526 => "10110001000101110", 
    527 => "10110000110011101", 528 => "10110000100001011", 
    529 => "10110000001111010", 530 => "10101111111101000", 
    531 => "10101111101010110", 532 => "10101111011000011", 
    533 => "10101111000110001", 534 => "10101110110011110", 
    535 => "10101110100001011", 536 => "10101110001111000", 
    537 => "10101101111100100", 538 => "10101101101010001", 
    539 => "10101101010111101", 540 => "10101101000101001", 
    541 => "10101100110010101", 542 => "10101100100000000", 
    543 => "10101100001101011", 544 => "10101011111010111", 
    545 => "10101011101000001", 546 => "10101011010101100", 
    547 => "10101011000010111", 548 => "10101010110000001", 
    549 => "10101010011101011", 550 => "10101010001010101", 
    551 => "10101001110111111", 552 => "10101001100101000", 
    553 => "10101001010010001", 554 => "10101000111111011", 
    555 => "10101000101100011", 556 => "10101000011001100", 
    557 => "10101000000110101", 558 => "10100111110011101", 
    559 => "10100111100000101", 560 => "10100111001101101", 
    561 => "10100110111010100", 562 => "10100110100111100", 
    563 => "10100110010100011", 564 => "10100110000001010", 
    565 => "10100101101110001", 566 => "10100101011011000", 
    567 => "10100101000111110", 568 => "10100100110100100", 
    569 => "10100100100001010", 570 => "10100100001110000", 
    571 => "10100011111010110", 572 => "10100011100111011", 
    573 => "10100011010100001", 574 => "10100011000000110", 
    575 => "10100010101101011", 576 => "10100010011001111", 
    577 => "10100010000110100", 578 => "10100001110011000", 
    579 => "10100001011111100", 580 => "10100001001100000", 
    581 => "10100000111000100", 582 => "10100000100100111", 
    583 => "10100000010001010", 584 => "10011111111101110", 
    585 => "10011111101010001", 586 => "10011111010110011", 
    587 => "10011111000010110", 588 => "10011110101111000", 
    589 => "10011110011011010", 590 => "10011110000111100", 
    591 => "10011101110011110", 592 => "10011101100000000", 
    593 => "10011101001100001", 594 => "10011100111000010", 
    595 => "10011100100100011", 596 => "10011100010000100", 
    597 => "10011011111100101", 598 => "10011011101000101", 
    599 => "10011011010100101", 600 => "10011011000000110", 
    601 => "10011010101100101", 602 => "10011010011000101", 
    603 => "10011010000100101", 604 => "10011001110000100", 
    605 => "10011001011100011", 606 => "10011001001000010", 
    607 => "10011000110100001", 608 => "10011000011111111", 
    609 => "10011000001011110", 610 => "10010111110111100", 
    611 => "10010111100011010", 612 => "10010111001111000", 
    613 => "10010110111010110", 614 => "10010110100110011", 
    615 => "10010110010010001", 616 => "10010101111101110", 
    617 => "10010101101001011", 618 => "10010101010100111", 
    619 => "10010101000000100", 620 => "10010100101100000", 
    621 => "10010100010111101", 622 => "10010100000011001", 
    623 => "10010011101110101", 624 => "10010011011010000", 
    625 => "10010011000101100", 626 => "10010010110000111", 
    627 => "10010010011100010", 628 => "10010010000111101", 
    629 => "10010001110011000", 630 => "10010001011110011", 
    631 => "10010001001001101", 632 => "10010000110101000", 
    633 => "10010000100000010", 634 => "10010000001011100", 
    635 => "10001111110110101", 636 => "10001111100001111", 
    637 => "10001111001101000", 638 => "10001110111000010", 
    639 => "10001110100011011", 640 => "10001110001110100", 
    641 => "10001101111001100", 642 => "10001101100100101", 
    643 => "10001101001111101", 644 => "10001100111010110", 
    645 => "10001100100101110", 646 => "10001100010000110", 
    647 => "10001011111011101", 648 => "10001011100110101", 
    649 => "10001011010001100", 650 => "10001010111100011", 
    651 => "10001010100111010", 652 => "10001010010010001", 
    653 => "10001001111101000", 654 => "10001001100111111", 
    655 => "10001001010010101", 656 => "10001000111101011", 
    657 => "10001000101000001", 658 => "10001000010010111", 
    659 => "10000111111101101", 660 => "10000111101000010", 
    661 => "10000111010011000", 662 => "10000110111101101", 
    663 => "10000110101000010", 664 => "10000110010010111", 
    665 => "10000101111101100", 666 => "10000101101000000", 
    667 => "10000101010010101", 668 => "10000100111101001", 
    669 => "10000100100111101", 670 => "10000100010010001", 
    671 => "10000011111100101", 672 => "10000011100111000", 
    673 => "10000011010001100", 674 => "10000010111011111", 
    675 => "10000010100110010", 676 => "10000010010000101", 
    677 => "10000001111011000", 678 => "10000001100101011", 
    679 => "10000001001111101", 680 => "10000000111010000", 
    681 => "10000000100100010", 682 => "10000000001110100", 
    683 => "01111111111000110", 684 => "01111111100011000", 
    685 => "01111111001101001", 686 => "01111110110111011", 
    687 => "01111110100001100", 688 => "01111110001011101", 
    689 => "01111101110101110", 690 => "01111101011111111", 
    691 => "01111101001010000", 692 => "01111100110100000", 
    693 => "01111100011110001", 694 => "01111100001000001", 
    695 => "01111011110010001", 696 => "01111011011100001", 
    697 => "01111011000110001", 698 => "01111010110000000", 
    699 => "01111010011010000", 700 => "01111010000011111", 
    701 => "01111001101101110", 702 => "01111001010111101", 
    703 => "01111001000001100", 704 => "01111000101011011", 
    705 => "01111000010101010", 706 => "01110111111111000", 
    707 => "01110111101000110", 708 => "01110111010010100", 
    709 => "01110110111100011", 710 => "01110110100110000", 
    711 => "01110110001111110", 712 => "01110101111001100", 
    713 => "01110101100011001", 714 => "01110101001100111", 
    715 => "01110100110110100", 716 => "01110100100000001", 
    717 => "01110100001001110", 718 => "01110011110011010", 
    719 => "01110011011100111", 720 => "01110011000110011", 
    721 => "01110010110000000", 722 => "01110010011001100", 
    723 => "01110010000011000", 724 => "01110001101100100", 
    725 => "01110001010110000", 726 => "01110000111111011", 
    727 => "01110000101000111", 728 => "01110000010010010", 
    729 => "01101111111011110", 730 => "01101111100101001", 
    731 => "01101111001110100", 732 => "01101110110111110", 
    733 => "01101110100001001", 734 => "01101110001010100", 
    735 => "01101101110011110", 736 => "01101101011101001", 
    737 => "01101101000110011", 738 => "01101100101111101", 
    739 => "01101100011000111", 740 => "01101100000010000", 
    741 => "01101011101011010", 742 => "01101011010100100", 
    743 => "01101010111101101", 744 => "01101010100110110", 
    745 => "01101010001111111", 746 => "01101001111001000", 
    747 => "01101001100010001", 748 => "01101001001011010", 
    749 => "01101000110100011", 750 => "01101000011101011", 
    751 => "01101000000110100", 752 => "01100111101111100", 
    753 => "01100111011000100", 754 => "01100111000001100", 
    755 => "01100110101010100", 756 => "01100110010011100", 
    757 => "01100101111100011", 758 => "01100101100101011", 
    759 => "01100101001110010", 760 => "01100100110111001", 
    761 => "01100100100000000", 762 => "01100100001000111", 
    763 => "01100011110001110", 764 => "01100011011010101", 
    765 => "01100011000011100", 766 => "01100010101100010", 
    767 => "01100010010101001", 768 => "01100001111101111", 
    769 => "01100001100110101", 770 => "01100001001111011", 
    771 => "01100000111000001", 772 => "01100000100000111", 
    773 => "01100000001001101", 774 => "01011111110010010", 
    775 => "01011111011011000", 776 => "01011111000011101", 
    777 => "01011110101100011", 778 => "01011110010101000", 
    779 => "01011101111101101", 780 => "01011101100110010", 
    781 => "01011101001110110", 782 => "01011100110111011", 
    783 => "01011100100000000", 784 => "01011100001000100", 
    785 => "01011011110001001", 786 => "01011011011001101", 
    787 => "01011011000010001", 788 => "01011010101010101", 
    789 => "01011010010011001", 790 => "01011001111011101", 
    791 => "01011001100100000", 792 => "01011001001100100", 
    793 => "01011000110100111", 794 => "01011000011101011", 
    795 => "01011000000101110", 796 => "01010111101110001", 
    797 => "01010111010110100", 798 => "01010110111110111", 
    799 => "01010110100111010", 800 => "01010110001111101", 
    801 => "01010101110111111", 802 => "01010101100000010", 
    803 => "01010101001000100", 804 => "01010100110000111", 
    805 => "01010100011001001", 806 => "01010100000001011", 
    807 => "01010011101001101", 808 => "01010011010001111", 
    809 => "01010010111010001", 810 => "01010010100010011", 
    811 => "01010010001010100", 812 => "01010001110010110", 
    813 => "01010001011010111", 814 => "01010001000011001", 
    815 => "01010000101011010", 816 => "01010000010011011", 
    817 => "01001111111011100", 818 => "01001111100011101", 
    819 => "01001111001011110", 820 => "01001110110011110", 
    821 => "01001110011011111", 822 => "01001110000100000", 
    823 => "01001101101100000", 824 => "01001101010100001", 
    825 => "01001100111100001", 826 => "01001100100100001", 
    827 => "01001100001100001", 828 => "01001011110100001", 
    829 => "01001011011100001", 830 => "01001011000100001", 
    831 => "01001010101100001", 832 => "01001010010100000", 
    833 => "01001001111100000", 834 => "01001001100011111", 
    835 => "01001001001011111", 836 => "01001000110011110", 
    837 => "01001000011011101", 838 => "01001000000011100", 
    839 => "01000111101011011", 840 => "01000111010011010", 
    841 => "01000110111011001", 842 => "01000110100011000", 
    843 => "01000110001010110", 844 => "01000101110010101", 
    845 => "01000101011010100", 846 => "01000101000010010", 
    847 => "01000100101010000", 848 => "01000100010001111", 
    849 => "01000011111001101", 850 => "01000011100001011", 
    851 => "01000011001001001", 852 => "01000010110000111", 
    853 => "01000010011000101", 854 => "01000010000000010", 
    855 => "01000001101000000", 856 => "01000001001111110", 
    857 => "01000000110111011", 858 => "01000000011111001", 
    859 => "01000000000110110", 860 => "00111111101110011", 
    861 => "00111111010110001", 862 => "00111110111101110", 
    863 => "00111110100101011", 864 => "00111110001101000", 
    865 => "00111101110100101", 866 => "00111101011100010", 
    867 => "00111101000011110", 868 => "00111100101011011", 
    869 => "00111100010011000", 870 => "00111011111010100", 
    871 => "00111011100010001", 872 => "00111011001001101", 
    873 => "00111010110001010", 874 => "00111010011000110", 
    875 => "00111010000000010", 876 => "00111001100111110", 
    877 => "00111001001111010", 878 => "00111000110110110", 
    879 => "00111000011110010", 880 => "00111000000101110", 
    881 => "00110111101101010", 882 => "00110111010100110", 
    883 => "00110110111100001", 884 => "00110110100011101", 
    885 => "00110110001011000", 886 => "00110101110010100", 
    887 => "00110101011001111", 888 => "00110101000001011", 
    889 => "00110100101000110", 890 => "00110100010000001", 
    891 => "00110011110111100", 892 => "00110011011110111", 
    893 => "00110011000110010", 894 => "00110010101101101", 
    895 => "00110010010101000", 896 => "00110001111100011", 
    897 => "00110001100011110", 898 => "00110001001011000", 
    899 => "00110000110010011", 900 => "00110000011001110", 
    901 => "00110000000001000", 902 => "00101111101000011", 
    903 => "00101111001111101", 904 => "00101110110110111", 
    905 => "00101110011110010", 906 => "00101110000101100", 
    907 => "00101101101100110", 908 => "00101101010100000", 
    909 => "00101100111011010", 910 => "00101100100010100", 
    911 => "00101100001001110", 912 => "00101011110001000", 
    913 => "00101011011000010", 914 => "00101010111111100", 
    915 => "00101010100110110", 916 => "00101010001101111", 
    917 => "00101001110101001", 918 => "00101001011100011", 
    919 => "00101001000011100", 920 => "00101000101010110", 
    921 => "00101000010001111", 922 => "00100111111001001", 
    923 => "00100111100000010", 924 => "00100111000111011", 
    925 => "00100110101110101", 926 => "00100110010101110", 
    927 => "00100101111100111", 928 => "00100101100100000", 
    929 => "00100101001011001", 930 => "00100100110010010", 
    931 => "00100100011001011", 932 => "00100100000000100", 
    933 => "00100011100111101", 934 => "00100011001110110", 
    935 => "00100010110101111", 936 => "00100010011101000", 
    937 => "00100010000100001", 938 => "00100001101011001", 
    939 => "00100001010010010", 940 => "00100000111001011", 
    941 => "00100000100000011", 942 => "00100000000111100", 
    943 => "00011111101110100", 944 => "00011111010101101", 
    945 => "00011110111100101", 946 => "00011110100011101", 
    947 => "00011110001010110", 948 => "00011101110001110", 
    949 => "00011101011000110", 950 => "00011100111111111", 
    951 => "00011100100110111", 952 => "00011100001101111", 
    953 => "00011011110100111", 954 => "00011011011011111", 
    955 => "00011011000010111", 956 => "00011010101001111", 
    957 => "00011010010000111", 958 => "00011001110111111", 
    959 => "00011001011110111", 960 => "00011001000101111", 
    961 => "00011000101100111", 962 => "00011000010011111", 
    963 => "00010111111010111", 964 => "00010111100001111", 
    965 => "00010111001000110", 966 => "00010110101111110", 
    967 => "00010110010110110", 968 => "00010101111101110", 
    969 => "00010101100100101", 970 => "00010101001011101", 
    971 => "00010100110010101", 972 => "00010100011001100", 
    973 => "00010100000000100", 974 => "00010011100111011", 
    975 => "00010011001110011", 976 => "00010010110101010", 
    977 => "00010010011100010", 978 => "00010010000011001", 
    979 => "00010001101010001", 980 => "00010001010001000", 
    981 => "00010000110111111", 982 => "00010000011110111", 
    983 => "00010000000101110", 984 => "00001111101100101", 
    985 => "00001111010011101", 986 => "00001110111010100", 
    987 => "00001110100001011", 988 => "00001110001000011", 
    989 => "00001101101111010", 990 => "00001101010110001", 
    991 => "00001100111101000", 992 => "00001100100011111", 
    993 => "00001100001010111", 994 => "00001011110001110", 
    995 => "00001011011000101", 996 => "00001010111111100", 
    997 => "00001010100110011", 998 => "00001010001101010", 
    999 => "00001001110100001", 1000 => "00001001011011000", 
    1001 => "00001001000001111", 1002 => "00001000101000111", 
    1003 => "00001000001111110", 1004 => "00000111110110101", 
    1005 => "00000111011101100", 1006 => "00000111000100011", 
    1007 => "00000110101011010", 1008 => "00000110010010001", 
    1009 => "00000101111001000", 1010 => "00000101011111111", 
    1011 => "00000101000110110", 1012 => "00000100101101101", 
    1013 => "00000100010100100", 1014 => "00000011111011011", 
    1015 => "00000011100010001", 1016 => "00000011001001000", 
    1017 => "00000010101111111", 1018 => "00000010010110110", 
    1019 => "00000001111101101", 1020 => "00000001100100100", 
    1021 => "00000001001011011", 1022 => "00000000110010010", 
    1023 => "00000000011001001" );


begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

memory_access_guard_1: process (addr1) 
begin
      addr1_tmp <= addr1;
--synthesis translate_off
      if (CONV_INTEGER(addr1) > mem_size-1) then
           addr1_tmp <= (others => '0');
      else 
           addr1_tmp <= addr1;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
        if (ce1 = '1') then 
            q1 <= mem(CONV_INTEGER(addr1_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity resonator_dds_phase_to_sincos_wLUT_cos_lut is
    generic (
        DataWidth : INTEGER := 17;
        AddressRange : INTEGER := 1024;
        AddressWidth : INTEGER := 10);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0);
        address1 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce1 : IN STD_LOGIC;
        q1 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of resonator_dds_phase_to_sincos_wLUT_cos_lut is
    component resonator_dds_phase_to_sincos_wLUT_cos_lut_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR;
            addr1 : IN STD_LOGIC_VECTOR;
            ce1 : IN STD_LOGIC;
            q1 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    resonator_dds_phase_to_sincos_wLUT_cos_lut_rom_U :  component resonator_dds_phase_to_sincos_wLUT_cos_lut_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0,
        addr1 => address1,
        ce1 => ce1,
        q1 => q1);

end architecture;


