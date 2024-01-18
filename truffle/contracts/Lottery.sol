// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Lottery {

    address[] players;
    address public manager;

    /**
    @dev Constructor of the contract which assigns the message sender to a variable.
    */
    constructor(){
        manager = msg.sender;
    }
    
    /**
    @dev Allows the user to enter the lottery.
    When the prize of entry (0.1 ether = 100000000 Gwei) is paid,
    the user is added to the array of players.
     */
    function enter() public payable {
        require(msg.value == 0.1 ether);
        players.push(msg.sender);
    }

    /**
    @dev Generates a random number and returns it. It is initiated in the pickWinner() method.
     */
    function random() public view returns(uint256){
        //return uint256(keccak256(abi.encodePacked(block.timestamp,msg.sender,seed))) ;
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    /**
    @dev This method picks a winner from the array using the "random()" method.
    Once picked, the balance of the contract is transfered to the winner.
    This method uses the "restricted()" modifier which
    */
    function pickWinner() public restricted(){
        uint arrayIndex = random() % players.length;
        payable(players[arrayIndex]).transfer(address(this).balance);
        players = new address[](0);
    }
    /**
    @dev This method returns the array with the addresses of the participants in the lottery.
    */
    function getPlayers() public view returns(address[] memory){
        return players;
    }
    /**
    @dev This modifier ensures that the initiator of a method is the one who deployed the contract.
    This modifier is used in the pick winner method.
    */
    modifier restricted(){
        require(msg.sender == manager);
        _;
    }
}