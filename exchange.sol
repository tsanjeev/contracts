pragma solidity ^0.4.17;
//contract address
//0xd00504bb029b044e0488fa2b9749043960422b24

contract BurgerToken {
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    function transfer(address _to, uint256 _value) public;
}


contract Exchange {

    uint256 exchangeRate = 100;
    uint256 decimals = 1000000000000000000;
    mapping ( address => uint256 ) public balanceOf;
    address tokenAddress = 0x170969B6D0C7005872C4EaD9805dAbd10f4E8641;
    address addressToSendEther = 0x7303efc3b94bb9d7d37511303a5108601d9a82ff;


    function exchange() public payable {
        require(msg.value > 1 ether);
        uint256 toEther = msg.value/(1 ether);
        addressToSendEther.transfer(this.balance);
        uint256 etherToBurgerToken = toEther * exchangeRate *  decimals;
        BurgerToken(tokenAddress).transfer(msg.sender, etherToBurgerToken);
        balanceOf[this] -= etherToBurgerToken;

    }

    function deposit(uint256 tokens) public {

        balanceOf[this]+= tokens;
        BurgerToken(tokenAddress).transferFrom(msg.sender, address(this), tokens);
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
