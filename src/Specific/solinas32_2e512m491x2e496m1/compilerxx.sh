#!/bin/sh
set -eu

g++ -march=native -mtune=native -std=gnu++11 -O3 -flto -fomit-frame-pointer -fwrapv -Wno-attributes -Dmodulus_limbs='24' -Dmodulus_bytes_val='21 + 1/3' -Dlimb_t=uint32_t -Dlimb_weight_gaps_array='{22,21,21,22,21,21,22,21,21,22,21,21,22,21,21,22,21,21,22,21,21,22,21,21}' -Dmodulus_array='{0xfe,0x14,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff}' -Dq_mpz='(1_mpz<<512) - 491*(1_mpz<<496) - 1' "$@"