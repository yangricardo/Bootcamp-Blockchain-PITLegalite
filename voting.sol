pragma solidity ^0.4.15;

contract Voting {
    /*Variaveis de Estado*/
    
    // dicionários de votos
    mapping (bytes32 => uint8) public votesReceived;
    //vetor de candidatos
    bytes32[] public candidateList;

    event logTotalVotesFor(address victim);
   
    /*Construtor*/
    function Voting (bytes32[] candidateNames) public {
        candidateList = candidateNames;
    }
    
    /*Modifiers*/
    modifier onlyValidCandidate(bytes32 candidate) {
        require(validCandidate(candidate));
        _;
    }

    /*funções*/
    function totalVotesFor (bytes32 candidate) public onlyValidCandidate(candidate) returns(uint8) {
        return votesReceived[candidate];
    }

    function voteForCandidate (bytes32 candidate) public onlyValidCandidate(candidate) {
        //require(no overflow)
        votesReceived[candidate] += 1;
    }
    
    function validCandidate (bytes32 candidate) public returns(bool) {
        for (uint i = 0; i < candidateList.length; i++) {
            if (candidate == candidateList[i]) {
                return true;
            }
        }
        return false;
    }
    
    

}