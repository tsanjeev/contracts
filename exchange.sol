pragma solidity ^0.4.17;
//contract address
//0xe8d98f8c9c2b0ab5e9d0aca26d914a7fc002a4de

contract BurgerToken {
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    function transfer(address _to, uint256 _value) public;
}


contract Exchange {

    uint256 exchangeRate = 100;
    uint256 decimals = 1000000000000000000;
    mapping ( address => uint256 ) public balanceOf;
    address tokenAddress = 0x5c87e1c456dcedfab139df81a7ca331bb0c14dda;

    function exchange() public payable {
        require(msg.value > 1 ether);
        uint256 toEther = msg.value/(1 ether);
        uint256 etherToBurgerToken = toEther * exchangeRate *  decimals;
        BurgerToken(tokenAddress).transfer(msg.sender, etherToBurgerToken);
        balanceOf[this] -= etherToBurgerToken;

    }

    function deposit(uint256 tokens) public {

        balanceOf[this]+= tokens;
        BurgerToken(tokenAddress).transferFrom(msg.sender, address(this), tokens);
    }

    function withdrawEther(address _to) public {
        _to.transfer(this.balance);
    }

}

/*

[
  {
    constant: true,
    inputs: [{ name: "", type: "address" }],
    name: "balanceOf",
    outputs: [{ name: "", type: "uint256" }],
    payable: false,
    stateMutability: "view",
    type: "function"
  },
  {
    constant: false,
    inputs: [{ name: "tokens", type: "uint256" }],
    name: "deposit",
    outputs: [],
    payable: false,
    stateMutability: "nonpayable",
    type: "function"
  },
  {
    constant: false,
    inputs: [],
    name: "exchange",
    outputs: [],
    payable: true,
    stateMutability: "payable",
    type: "function"
  }
]
*/
