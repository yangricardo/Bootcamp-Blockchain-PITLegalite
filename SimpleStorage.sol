pragma solidity ^0.4.0;

contract SimpleStorage {
    uint storedData;
    
    /* Constructor */
    function SimpleStorage() {

    }

    function set(uint value) {
        storedData = value;
    }

    function get() constant returns (uint) {
        // constant, trata problema de performance, 
        // define que o valor é constante e retorna um `uint`
        return storedData;
    }

}