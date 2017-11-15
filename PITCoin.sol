pragma solidity ^0.4.11;


contract Owned {

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner);   
        _;
    }

    function Owned() {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) onlyOwner {
        owner = newOwner;
    }

}


contract PITCoin is Owned {
    
    mapping (address=>uint256) public minutesBank; // this is minutes, hour/60
    address[] public studentsArray; // endereços dos estudantes
    uint256 public totalSupply; //total dos coins
    string public name; // nome do token
    string public symbol; // simbolo abreviado
    uint8 public decimals; // decimals

    //log de minutos criados
    event MinutesCreated(address from, uint256 amount);
    //log de minutos transferidos
    event MinutesTransferred(address from, address to, uint256 amount);
    //log de minutos transferidos
    event MinutesBurned(address burnedAddress, address burnerAddress, string message, uint256 amount);

    function PITCoin(uint256 initialSupply, string tokenName, uint8 decimalsUnits, string tokenSymbols)  public {
        minutesBank[msg.sender] = initialSupply;
        totalSupply = initialSupply;
        name = tokenName;
        symbol = tokenSymbols;
        decimals = decimalsUnits;
    }

    modifier onlyPitStudents {
        bool studentsFound = false;
        for (uint i = 0; i < studentsArray.length; i++) {
            if (msg.sender == studentsArray[i]) {
                studentsFound = true;
                break;
            }
        }
        require(studentsFound);
        _;
    }

    function createMinutes(uint256 _amount) onlyPitStudents {
        require(minutesBank[msg.sender] <= minutesBank[msg.sender] + _amount); //checa overflow do quadro de horários
        minutesBank[msg.sender] += _amount;
        totalSupply += _amount;
        MinutesCreated(msg.sender, _amount);
    }

    function transfer(address _to, uint256 _value) {
        require(minutesBank[msg.sender] >= _value);
        require(minutesBank[_to] <= minutesBank
        [_to] + _value);

        minutesBank[_to] += _value;
        minutesBank[msg.sender] -= _value;
        
        MinutesTransferred(msg.sender, _to, _value);
    }

    function burn(uint256 _amountToBurn, string _message) {
        require(minutesBank[msg.sender] >= _amountToBurn);
        minutesBank[msg.sender] -= _amountToBurn;
        totalSupply -= _amountToBurn;
        MinutesBurned(msg.sender, msg.sender, _message, _amountToBurn);
    }

    function crazyOwnerBurnedMyCoins(uint256 minutesToBurn, address unluckyStudent, string reason) onlyOwner {
        require(minutesBank[unluckyStudent] >= minutesToBurn);
        minutesBank[unluckyStudent] -= minutesToBurn;
        totalSupply -= minutesToBurn;
        MinutesBurned(unluckyStudent, owner, reason, minutesToBurn);
    }

    function addStudent(address studentAddress) onlyOwner {
        studentsArray.push(studentAddress);
    }

}