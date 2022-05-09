const fs = require("fs");
const solidityRegex = /pragma solidity \^\d+\.\d+\.\d+/

const verifierRegex = /contract Verifier/

let content = fs.readFileSync("./contracts/HelloWorldVerifier.sol", { encoding: 'utf-8' });
let bumped = content.replace(solidityRegex, 'pragma solidity ^0.8.0');
bumped = bumped.replace(verifierRegex, 'contract HelloWorldVerifier');

fs.writeFileSync("./contracts/HelloWorldVerifier.sol", bumped);

//  [assignment] add your own scripts below to modify the other verifier contracts you will build during the assignment
// const solidityRegex2 = /pragma solidity \^\d+\.\d+\.\d+/

// const verifierRegex2 = /contract Verifier/

// let content2 = fs.readFileSync("./contracts/Multiplier3.sol", { encoding: 'utf-8' });
// let bumped2 = content2.replace(solidityRegex2, 'pragma solidity ^0.8.0');
// bumped2 = bumped2.replace(verifierRegex2, 'contract Multiplier');

// fs.writeFileSync("./contracts/Multiplier.sol", bumped2);
