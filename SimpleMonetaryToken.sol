// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// Fix and static interest rate monetary token
// interest rate is for each blocks
// interest rate can not be changed
// static monetary supply 100000 is minted to the creator account
contract MonetaryToken {

 mapping(address => uint) monetaryBaseBalance; 
 // total amount for all of the minted monetary base
 uint public totalMonetaryBase;
 // interest rate per block - interpreted as yearly pecent 
 uint public interestPerBlock;
 // time in block height as the system starts
 uint startingBlock;

 constructor() {
   // starting block is set at deployment
   startingBlock = block.number;
   // all monetary base is minted to the creator account 
   monetaryBaseBalance[msg.sender] = 100000;
 }

 // getting the balance of an account
 function getBalance(address who) public view returns (uint) {
  // calculate multiplication of interest rate from the start time of the 
  // percentual information, blocktime and the seconds of the year are also calculated
  uint multiplicator = ((block.number - startingBlock) * interestPerBlock) / (100 * 3153600);
  // calculate balance based on multiplication 
  uint balance = (monetaryBaseBalance[who] *  multiplicator); 
  return balance;
 }

 // transfer from the sneder's account to another one
 function transfer(address to, uint amount) public {
  // calculate multiplication of interest rate from the start time of the 
  // percentual information, blocktime and the seconds of the year are also calculated
  uint multiplicator = ((block.number - startingBlock) * interestPerBlock) / (100 * 3153600);
  // calculate the transferable amount in terms of the monetary base
  uint amountToTransferInMonetaryBase = amount / multiplicator;
  // decrease the sender account with the monetary base
  monetaryBaseBalance[msg.sender] -= amountToTransferInMonetaryBase;
  // increase the recipient account with the monetary base
  monetaryBaseBalance[to] += amountToTransferInMonetaryBase;
 }


}
