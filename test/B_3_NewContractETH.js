const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("describe: new Contract() with ETH", function () {
  it("Understanding msg.sender = account & msg.sender contractAddress plus new Contract() plus sending ETH at the constructor()", async function () {
    // Accounts managament
    const [account1, account2] = await ethers.getSigners();

    // Deploy contracts
    const Contract_Taker = await ethers.getContractFactory("Taker2");
    const taker = await Contract_Taker.connect(account1).deploy();
    await taker.deployed(); 
    const contractAddress = taker.address;
    
    console.log('-----------------------------------------------------------');
    console.log(`Contract address: ${contractAddress}`);
    console.log(`Account' 0 : ${account1.address}`);
    console.log(`Account' 1 : ${account2.address}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Loading contract variables: ");
    console.log(`Owner:     ${await taker.owner()}`);
    console.log(`Invited:   ${await taker.invited()}`);
    console.log(`Counting:  ${await taker.counting()}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Adding value with msg.sender = account2");
    await taker.connect(account2)._signed_sum(12);

    console.log('-----------------------------------------------------------');
    console.log("Loading contract variables: ");
    console.log(`Owner:     ${await taker.owner()}`);
    console.log(`Invited:   ${await taker.invited()}`);
    console.log(`Counting:  ${await taker.counting()}`);
    console.log(" ");
    
    console.log('-----------------------------------------------------------');
    console.log("Deploy new contract!: ");
    const eth_to_send = ethers.utils.parseUnits("5", "ether");
    await taker.connect(account2).create_contract({value: eth_to_send});
    const new_contract_address = await taker.novo();
    console.log(`NEW Contract address: ${new_contract_address}`);

    console.log('-----------------------------------------------------------');
    console.log("Loading NEW contract variables: ");
    console.log(`Novo Owner:     ${await taker.novo_get_owner()}`);
    console.log(`Novo Invited:   ${await taker.novo_get_invited()}`);
    console.log(`Novo Counting:  ${await taker.novo_get_counting()}`);
    console.log(`Novo balance:   ${await taker.novo_get_balance()}`);
    console.log(" ");

    console.log('-----------------------------------------------------------');
    console.log("Adding value with msg.sender = contractAddress");
    await taker.connect(account2).novo_singed_sum(66);

    console.log('-----------------------------------------------------------');
    console.log("Loading NEW contract variables: ");
    console.log(`Novo Owner:     ${await taker.novo_get_owner()}`);
    console.log(`Novo Invited:   ${await taker.novo_get_invited()}`);
    console.log(`Novo Counting:  ${await taker.novo_get_counting()}`);
    console.log(`Novo balance:   ${await taker.novo_get_balance()}`);
    console.log(" ");


  });
});