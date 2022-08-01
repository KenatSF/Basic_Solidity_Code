const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("describe: This.function()", function () {
  it("Understanding msg.sender = account & msg.sender contractAddress", async function () {
    // Accounts managament
    const [account1, account2, account3, account4] = await ethers.getSigners();

    // Deploy contracts
    const Contract_Taker = await ethers.getContractFactory("Taker");
    const taker = await Contract_Taker.connect(account1).deploy();
    await taker.deployed(); 
    const contractAddress = taker.address;
    
    console.log('-----------------------------------------------------------');
    console.log(`Contract address: ${contractAddress}`);
    console.log(`Account' 1 : ${account1.address}`);
    console.log(`Account' 2 : ${account2.address}`);
    console.log(`Account' 3 : ${account3.address}`);
    console.log(`Account' 4 : ${account4.address}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Loading contract variables: ");
    console.log(`Owner:     ${await taker.owner()}`);
    console.log(`Invited:   ${await taker.invited()}`);
    console.log(`Counting:  ${await taker.counting()}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Adding value with msg.sender: ");
    console.log(`Account' 1 : ${account2.address}`);
    await taker.connect(account1).signed_sum(12);

    console.log('-----------------------------------------------------------');
    console.log("Loading contract variables: ");
    console.log(`Owner:     ${await taker.owner()}`);
    console.log(`Invited:   ${await taker.invited()}`);
    console.log(`Counting:  ${await taker.counting()}`);
    console.log(" ");
    
    console.log('-----------------------------------------------------------');
    console.log("Adding value with msg.sender: ");
    await taker.connect(account2).this_signer_sum(12);

    console.log('-----------------------------------------------------------');
    console.log("Loading contract variables: ");
    console.log(`Owner:     ${await taker.owner()}`);
    console.log(`Invited:   ${await taker.invited()}`);
    console.log(`Counting:  ${await taker.counting()}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Adding value with msg.sender: ");
    await taker.connect(account3).signed();

    console.log('-----------------------------------------------------------');
    console.log("Loading contract variables: ");
    console.log(`Owner:     ${await taker.owner()}`);
    console.log(`Invited:   ${await taker.invited()}`);
    console.log(`Counting:  ${await taker.counting()}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Adding value with msg.sender: ");
    await taker.connect(account4).signed_super();

    console.log('-----------------------------------------------------------');
    console.log("Loading contract variables: ");
    console.log(`Owner:     ${await taker.owner()}`);
    console.log(`Invited:   ${await taker.invited()}`);
    console.log(`Counting:  ${await taker.counting()}`);
    console.log(" ");


  });
});