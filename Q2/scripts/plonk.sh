#!/bin/bash

# [assignment] create your own bash script to compile Multipler3.circom using PLONK below

#!/bin/bash

cd contracts/circuits

mkdir Multiplier3

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling HelloWorld.circom..."

# compile circuit
circom Multiplier3.circom --r1cs --wasm --sym --c
snarkjs r1cs info Multiplier3.r1cs

node Multiplier3/generate_witness.js Multiplier3_js/Multiplier3.wasm in.json witness.wtns
snarkjs wtns export json witness.wtns witness.json

# Start a new zkey and make a contribution

snarkjs plonk setup Multiplier3.r1cs powersOfTau28_hez_final_10.ptau Multiplier3.zkey
snarkjs zkey export verificationkey Multiplier3.zkey verification_key.json
snarkjs plonk prove Multiplier3.zkey witness.wtns proof.json public.json

snarkjs plonk verify verification_key.json public.json proof.json

# generate solidity contract
snarkjs zkey export solidityverifier Multiplier3.zkey verifier.sol

snarkjs zkey export soliditycalldata public.json proof.json
cd ../..