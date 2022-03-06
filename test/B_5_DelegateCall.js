const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("describe: DelegateCall", function () {
  it("Upgradeable Contracts", async function () {
    // Accounts managament
    const [account1] = await ethers.getSigners();

    // Deploy contracts
    const A = await ethers.getContractFactory("A");
    const a = await A.connect(account1).deploy();
    await a.deployed(); 
    const aAddress = a.address;

    const B = await ethers.getContractFactory("B");
    const b = await B.connect(account1).deploy();
    await b.deployed(); 
    const bAddress = b.address;
    
    console.log('-----------------------------------------------------------');
    console.log(`A Contract address: ${aAddress}`);
    console.log(`B Contract address: ${bAddress}`);
    console.log(`Account' 0 : ${account1.address}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Getting variables: ");
    console.log(`num:       ${await a.num()}`);
    console.log(`sender:    ${await a.sender()}`);
    console.log(`value:     ${await a.value()}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Set values at contract's vairables: ");
    const eth_to_send = ethers.utils.parseUnits("0.05", "ether");
    await a.connect(account1).setVars(bAddress, 100, {value: eth_to_send});
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Getting variables: ");
    console.log(`num:       ${await a.num()}`);
    console.log(`sender:    ${await a.sender()}`);
    console.log(`value:     ${await a.value()}`);
    console.log(" ");

  });
});