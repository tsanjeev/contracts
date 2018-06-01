pragma solidity ^0.4.16;

contract TokenStorage {
    mapping (address => uint256) public balanceOf;
    mapping (address => string ) public restName;

    uint256 signUpTokens = 500000000000000000;

    function signUp(string rName) public {
        require(balanceOf[msg.sender] == 0);
        restName[msg.sender] = rName;
        sendTokens(msg.sender, signUpTokens);
    }

    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value);           // Check if the sender has enough
        require(balanceOf[_to] + _value >= balanceOf[_to]); // Check for overflows
        balanceOf[msg.sender] -= _value;                    // Subtract from the sender
        balanceOf[_to] += _value;                           // Add the same to the recipient
    }

    function depositTokens(uint tokens) {

    // add the deposited tokens into existing balance
        balanceOf[this]+= tokens;
    }

    //send out free BurgerCoin tokens
    //send tokens to Restaurants that sign up

    function sendTokens(address _to, uint256 numTokens) public
    {
        this.transfer(_to, numTokens);
    }
}
