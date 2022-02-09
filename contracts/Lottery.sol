// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Lottery {

  address payable[] public players;
  address payable public manager;

  constructor() {
    manager = payable(msg.sender);
  }

  receive() external payable {
    require(msg.value == 0.01 ether, 'value must equal 0.01 ether');
    players.push(payable(msg.sender ));
  }

  function getBalance() public view returns(uint){
    require(msg.sender == manager, 'only manager can see balance');
    return address(this).balance;
  }

  function random() public view returns(uint){
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
  }

  function pickWinner() public {
    require(msg.sender == manager, 'only manager can pick a winner');
    require(players.length >= 3);

    uint r = random();
    address payable winner;

    uint index = r % players.length;
    winner = players[index];

    uint managerFee = (getBalance() * 10 ) / 100;
    uint winnerPrize = (getBalance() * 90 ) / 100;
    
    winner.transfer(winnerPrize);
    
    payable(manager).transfer(managerFee);

    players = new address payable[](0);
    
  }

}

// Just so you have a simple definition for all those access classifiers:

//     public - all can access
//     external - Cannot be accessed internally, only externally
//     internal - only this contract and contracts deriving from it can access
//     private - can be accessed only from this contract

// As you can notice private is a subset of internal and external is a subset of public.