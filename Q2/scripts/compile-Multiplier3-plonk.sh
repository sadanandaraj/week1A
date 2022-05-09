# #!/bin/bash

# # [assignment] create your own bash script to compile Multipler3.circom using PLONK below

# #!/bin/bash

# cd contracts/circuits

# mkdir Multipler3

# if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
#     echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
# else
#     echo 'Downloading powersOfTau28_hez_final_10.ptau'
#     wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
# fi

# echo "Compiling HelloWorld.circom..."

# # compile circuit
# circom Multiplier.circom --r1cs --wasm --sym --c
# snarkjs r1cs info Multiplier.r1cs

# node multiplier_js/generate_witness.js multiplier_js/multiplier.wasm in.json witness.wtns
# snarkjs wtns export json witness.wtns witness.json

# # Start a new zkey and make a contribution

# snarkjs plonk setup Multiplier.r1cs powersOfTau28_hez_final_10.ptau Multiplier.zkey
# snarkjs zkey export verificationkey Multiplier.zkey verification_key.json
# snarkjs plonk prove Multiplier.zkey witness.wtns proof.json public.json

# snarkjs plonk verify verification_key.json public.json proof.json

# # generate solidity contract
# snarkjs zkey export solidityverifier Multiplier.zkey verifier.sol

# snarkjs zkey export soliditycalldata public.json proof.json
# cd ../..

#!/bin/bash

# [assignment] create your own bash script to compile Multipler3.circom using PLONK below

#!/bin/bash

cd contracts/circuits

mkdir _plonk_Multipler3

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling HelloWorld.circom..."

# compile circuit
circom Multiplier.circom --r1cs --wasm --sym  -o _plonk_Multipler3
snarkjs r1cs info _plonk_Multipler3/Multiplier.r1cs

node _plonk_Multipler3/multiplier_js/generate_witness.js _plonk_Multipler3/multiplier_js/multiplier.wasm in.json _plonk_Multipler3/witness.wtns
snarkjs wtns export json _plonk_Multipler3/witness.wtns _plonk_Multipler3/witness.json

# Start a new zkey and make a contribution

snarkjs plonk setup _plonk_Multipler3/Multiplier.r1cs powersOfTau28_hez_final_10.ptau _plonk_Multipler3/Multiplier.zkey
snarkjs zkey export verificationkey _plonk_Multipler3/Multiplier.zkey _plonk_Multipler3/verification_key.json
snarkjs plonk prove _plonk_Multipler3/Multiplier.zkey _plonk_Multipler3/witness.wtns _plonk_Multipler3/proof.json _plonk_Multipler3/public.json

snarkjs plonk verify _plonk_Multipler3/verification_key.json _plonk_Multipler3/public.json _plonk_Multipler3/proof.json

# generate solidity contract
snarkjs zkey export solidityverifier _plonk_Multipler3/Multiplier.zkey _plonk_multiplier_verifier.sol

snarkjs zkey export soliditycalldata _plonk_Multipler3/public.json _plonk_Multipler3/proof.json
cd ../..
