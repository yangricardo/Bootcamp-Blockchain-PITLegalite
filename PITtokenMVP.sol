pragma solidity ^0.4.16;
//address1 = 0x96D77Af95B38375Cd8C6c8F835E509BC39CDa51D
//address2 = 0x936388c22d5b511631d2c720890de404EdCCCd29

contract PitMVP {
    
    mapping (address => uint256) public balanceOf;
    //mapa recebe um endereço e retorna quantos elementos possui    

    function PitMVP(uint256 initialSupply) public {
        balanceOf[msg.sender] = initialSupply;
    }
    
    function transfer(address _to, uint256 _value) public {
        //verifica se o sender realmente possui o suficiente para o envio
        require(balanceOf[msg.sender] >= _value);
        //trata overflow e underflow dos bites no caso de MAXINTEGER_256
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[_to] += _value; 
        balanceOf[msg.sender] -= _value; 
    }

}