pragma solidity ^0.4.24;

contract VoteManager {
    string public systemName = "TUL vote system";
    address public owner;

    struct Voter {
        bool isAllowed;
        bool hasVoted;
    }

    struct Candidate {
        bytes32 name;
        uint voteCount;
    }

    struct Ballot {
        bool isActive;
        uint candidatesSize;
        mapping(uint => Candidate) candidates;
        mapping(uint => Voter) voters;  //key means voter id (e.g. 210210)
    }

    Ballot[] public ballots;

    constructor() public {
        owner = msg.sender;

        // rest of the constructor is only example ballot;
        bytes32[] memory candidateNames = new bytes32[](2);
        candidateNames[0] = "A"; 
        candidateNames[1] = "B"; 

        uint[] memory voters = new uint[](1);
        voters[0] = 210183;

        //create new ballot
        ballots.push(Ballot(true, 2));
        Ballot storage createdBallot = ballots[ballots.length - 1];

        for(uint i = 0; i < 2; i++)
        {
            createdBallot.candidates[i] = Candidate({name: candidateNames[i], voteCount: 0});
        }

        for(uint v = 0; v < voters.length; v++)
        {
            createdBallot.voters[voters[v]] = Voter(true, false);
        }
    }

    function setSystemName(string memory x) public {
        systemName = x;
    }

    //TODO: possible security issue 
    function vote(uint ballotId, uint voterId, uint candidateId) public {
        require(ballots[ballotId].voters[voterId].isAllowed, "There is no such voter.");
        require(!ballots[ballotId].voters[voterId].hasVoted, "This voter has already voted.");

        ballots[ballotId].voters[voterId].hasVoted = true;
        ballots[ballotId].candidates[candidateId].voteCount++;
    }

    function endBallot(uint id) public onlyOwner {
        ballots[id].isActive = false;
    }

    function getBallots() public view returns(bool[] memory states, uint[] memory candidatesSizes) {
        bool[] memory ballotsState = new bool[](ballots.length);
        uint[] memory ballotsCandidatesSizes = new uint[](ballots.length);
        for(uint i = 0; i < ballots.length; i++)
        {
            ballotsState[i] = ballots[i].isActive;
            ballotsCandidatesSizes[i] = ballots[i].candidatesSize;
        }
        return (ballotsState, ballotsCandidatesSizes);
    }

    function getCandidateNamesForBallot(uint ballotIndex) public view returns(bytes32[] memory) {
        bytes32[] memory candidateNames = new bytes32[](ballots[ballotIndex].candidatesSize);
        for(uint i = 0; i < candidateNames.length; i++)
        {
            candidateNames[i] = ballots[ballotIndex].candidates[i].name;
        }

        return candidateNames;
    }

    function getCandidatsForBallot(uint ballotIndex) public view returns(bytes32[] memory names, uint[] memory voteCounts) {
        bytes32[] memory candidateNames = new bytes32[](ballots[ballotIndex].candidatesSize);
        uint[] memory candidatesVotes = new uint[](ballots[ballotIndex].candidatesSize);
        for(uint i = 0; i < candidateNames.length; i++)
        {
            candidateNames[i] = ballots[ballotIndex].candidates[i].name;
            candidatesVotes[i] = ballots[ballotIndex].candidates[i].voteCount;
        }

        return (candidateNames, candidatesVotes);
    }

    function getCandidateVoteCount(uint ballot, uint candidate) public view returns(uint) {
        return ballots[ballot].candidates[candidate].voteCount;
    }

    function getCandidate(uint ballot, uint candidate) public view returns(bytes32 name, uint voteCount) {
        return (ballots[ballot].candidates[candidate].name, ballots[ballot].candidates[candidate].voteCount);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Owner-only method.");
        _;
    }
}