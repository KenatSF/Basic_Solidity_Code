const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("describe: CallOtherContract", function () {
  it("Make use of to.call{value: }()", async function () {
    // Accounts managament
    const [account1] = await ethers.getSigners();

    // Deploy contracts
    const Callee = await ethers.getContractFactory("Callee");
    const callee = await Callee.connect(account1).deploy();
    await callee.deployed(); 
    const calleeAddress = callee.address;

    const Caller = await ethers.getContractFactory("Caller");
    const caller = await Caller.connect(account1).deploy();
    await caller.deployed(); 
    const callerAddress = caller.address;

    console.log('-----------------------------------------------------------');
    console.log(`Callee Contract address: ${calleeAddress}`);
    console.log(`Caller Contract address: ${calleeAddress}`);
    console.log(`Account' 0 : ${account1.address}`);
    console.log(" ");
    
    console.log('-----------------------------------------------------------');
    console.log(`X value:                ${await callee.x()}`);
    console.log(`Getting Callee balance: ${await callee.getBalance()}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Sending ETH value: ");
    const eth_to_send = ethers.utils.parseUnits("2", "ether");
    await caller.setX_and_sendETH(calleeAddress, 12, {value: eth_to_send})
    console.log(" ");


    console.log('-----------------------------------------------------------');
    console.log(`X value:                ${await callee.x()}`);
    console.log(`Getting Callee balance: ${await callee.getBalance()}`);
    console.log(" ");

  });
});