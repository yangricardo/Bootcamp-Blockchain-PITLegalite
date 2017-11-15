pragma solidity ^0.4.0;

contract StorageGasChallenge {
    uint storedDataU;
    uint256 storedDataU256;

    function setU(uint x) public {
        storedDataU = x;
    }
    function setU256(uint256 x) public {
        storedDataU256 = x;
    }

    function getU() public constant returns (uint) {
        return storedDataU;
    }
    
    function getU256() public constant returns (uint256) {
        return storedDataU256;
    }

    function increaseStorageBy(int value) public {
      for(int i = 0; i < value; i++){
        storedDataU += 1;
      }
    }

    function decreaseStorageBy(int value) public {
      for(int i = 0; i < value; i++){
        storedDataU -= 1;
      }
    }
    
    function uintIncreaseStorageBy(uint value) public {
      storedDataU += value;
    }

    function uintDecreaseStorageBy(uint value) public {
      storedDataU -= value;
    }
    
    function uint256IncreaseStorageBy(uint256 value) public {
      storedDataU256 += value;
    }

    function uint256DecreaseStorageBy(uint256 value) public {
      storedDataU256 -= value;
    }
    

    function isOdd(uint256 num) public returns (bool) {
      if (num == 2**256 - 1) {
        return true;
      } else if (num == 0) {
        return false;
      }

      return isOdd(num + 2);
    }

    function isOdd2(uint256 num) public pure returns (bool) {
      return (num % 2 == 1) ? true : false; 
    }

    function isOdd3(uint256 num) public pure returns (bool) {
      return (num & 1) == 1;
    }


}