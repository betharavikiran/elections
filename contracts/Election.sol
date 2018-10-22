pragma solidity 0.4.24;

// Mapping is to looking up using key values
// In case a candidate does not exist for a given id, block chain returns null.

contract Election {
    // Model a Candidate
    struct Candidate {
      uint  id;
      string name;
      uint voteCount;
    }

    event votedEvent(
        uint indexed _candidateId
    );

    mapping(address => bool) public voters;
    // Read/Write Candidates
    // mapping is like an associative array or hash that associates key value pairs.
    // since mapping does not track number of records, we need to keep track seperately.
    mapping(uint => Candidate) public candidates;

    // Store candidates count
    uint public candidatesCount;

    // Constructor
    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public {
        require(!voters[msg.sender]);

        require(_candidateId > 0 && _candidateId <= candidatesCount);

        voters[msg.sender] = true;

        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }


}