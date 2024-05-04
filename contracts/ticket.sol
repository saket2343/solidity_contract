// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 < 0.9.0;
contract Ticket{
    uint ticketPrice;
    address owner;
    uint startDate;
    uint endDate;
    uint No_of_Tickets;
    mapping (address => uint ) public ticketHolders;
   // mapping (address => uint)  public balance;

    constructor() {
        owner = msg.sender;
    }

    function buyTickets(address _user, uint _amount) payable public{
        require(msg.value == ticketPrice * _amount,"Amount is less");
         require (No_of_Tickets > _amount, "Not enough no. of tickets");
         require(block.timestamp >= startDate && block.timestamp <= endDate," Sale end");
        ticketHolders[_user] = ticketHolders[_user] + _amount;

    }

    
    function Checking_Ticket_Balance() public view returns(uint){
        require(owner == msg.sender,"you are the not the owner");
       return address(this).balance;
    
    }

    function no_tickets_available(uint _Tickets, uint _price ,uint _startDate , uint _endDate) public {
        require(owner == msg.sender, "You are not the owner");
        No_of_Tickets=_Tickets;
        ticketPrice = _price;
        startDate = _startDate;
        endDate = _endDate;

    }
    function withdraw() public {
        require(msg.sender == owner, "your are not the owner");
        (bool success, ) = payable(owner).call{value: address(this).balance}("");
         require(success);
    }
}


