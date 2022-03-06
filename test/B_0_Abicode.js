const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("describe: ABICODE", function () {
  it("Should create examples making use of abi.encode()", async function () {
    // Accounts managament
    const [account1, account2] = await ethers.getSigners();

    // Deploy contracts
    const Contract_abicode = await ethers.getContractFactory("MyAbi");
    const contract = await Contract_abicode.connect(account1).deploy();
    await contract.deployed(); 
    const contractAddress = contract.address;
    
    console.log('-----------------------------------------------------------');
    console.log(`Contract address: ${contractAddress}`);
    console.log(`Account' 0 : ${account1.address}`);
    console.log(`Account' 1 : ${account2.address}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Load counting variable with default value.");
    expect(await contract.counting()).to.equal(0);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Getting abi.encode(): ");
    const string_abi_encode = await contract.connect(account2).get_abi_encode("0xdD870fA1b7C4700F2BD7f44238821C26f7392148", 12, "Hola KENNY", 156);
    console.log(string_abi_encode);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Getting abi.encodePackage(): ");
    const string_abi_encode_package = await contract.connect(account2).get_abi_encode_package("0xdD870fA1b7C4700F2BD7f44238821C26f7392148", 12, "Hola KENNY", 156, false);
    console.log(string_abi_encode_package);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Getting bytecode for adding value to counting variable with abi.encodeWithSelector and ( ) one space: ");
    const string_bytecode0 = await contract.connect(account2).get_sum_abi_0(66, 34);
    console.log(string_bytecode0);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Getting bytecode for adding value to counting variable with abi.encodeWithSignature: ");
    const string_bytecode = await contract.connect(account2).get_sum_abi_1(66, 34);
    console.log(string_bytecode);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Calling the function that actually add value to counting variable!: ");
    await contract.connect(account2).sum_xy_abi(string_bytecode);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Load counting variable with updated value.");
    expect(await contract.counting()).to.equal(100);
    console.log(" ");



  });
});