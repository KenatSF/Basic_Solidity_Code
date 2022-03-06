const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("describe: Fallback Function", function () {
  it("For a better understanding of two sending methods, compile it in REMIX", async function () {
    // Accounts managament
    const [account1, account2, account3] = await ethers.getSigners();

    // Deploy contracts
    const FallbackContract = await ethers.getContractFactory("Fallback");
    const fallbackContract = await FallbackContract.connect(account1).deploy();
    await fallbackContract.deployed(); 
    const fallbackContractAddress = fallbackContract.address;

    const SendFallbackContract = await ethers.getContractFactory("SendToFallback");
    const sendFallbackContract = await SendFallbackContract.connect(account1).deploy();
    await sendFallbackContract.deployed(); 
    const sendFallbackContractAddress = sendFallbackContract.address;
    
    console.log('-----------------------------------------------------------');
    console.log(`FallBack Contract address: ${fallbackContractAddress}`);
    console.log(`SendFallBack Contract address: ${sendFallbackContractAddress}`);
    console.log(`Account' 0 : ${account1.address}`);
    console.log(`Account' 1 : ${account2.address}`);
    console.log(`Account' 2 : ${account3.address}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Sending some ETH transferToFallback(): ");
    const eth_to_send = ethers.utils.parseUnits("0.5", "ether");
    await sendFallbackContract.connect(account3).transferToFallback(fallbackContractAddress, {value: eth_to_send});
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Sending some ETH callFallback(): ");
    await sendFallbackContract.connect(account3).callFallback(fallbackContractAddress, {value: eth_to_send});
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Getting FallBack contract balance: ");
    const balance = await fallbackContract.getBalance()
    console.log(`Balance : ${balance}`);
    console.log(" ");

  });
});