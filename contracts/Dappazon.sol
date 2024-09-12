// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
    string public name;
    address public owner;
    struct Item {
        uint256 id;
        string name;
        uint256 cost;
        string category; 
        string image; 
        uint256 rating; 
        uint256 stock ;


    }
    struct Order {
        uint256 id;
        Item item; 
    }
    mapping(uint256 => Item) public items ; 
    mapping(address => uint256) public orderCount; 
    mapping(address => mapping(uint256 => Order)) public orders; 

    event List(string name, uint256 cost,uint256 quantity); 
     event Buy(address buyer, uint256 orderId, uint256 itemId);
    constructor() {
        name = "CryptoCart";
        owner = msg.sender;
    }

    // list products
    function list(
        uint256 _id,
        string memory _name,
        string memory _category,
        string memory _image,
        uint256 _cost,
        uint256 _rating,
        uint256 _stock
    ) public {
        require(owner == msg.sender);
        Item memory item = Item(_id,_name,_cost,_category,_image,_rating,_stock); 
        items[_id] = item; 
    }

    // buy products
    function buy(uint256 _id ) public payable {
           Item memory item = items[_id];

        // Require enough ether to buy item
        require(msg.value >= item.cost);

        // Require item is in stock
        require(item.stock > 0);

        // Create order
        Order memory order = Order(uint256(block.timestamp), item);

        // Add order for user
        orderCount[msg.sender]++; // <-- Order ID
        orders[msg.sender][orderCount[msg.sender]] = order;

        // Subtract stock
        items[_id].stock = item.stock - 1;

        // Emit event
        emit Buy(msg.sender, orderCount[msg.sender], item.id);
    }
    // withdraw funds
    function withdraw() public {
        require(msg.sender == owner);
        (bool success, ) = owner.call{value:address(this).balance}("");
        require(success);
    }
}
