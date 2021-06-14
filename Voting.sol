pragma solidity >=0.7.0 <0.9.0;

contract Vote {
    
    //structure
    struct candidator{
        string name;
        uint upVote;
    }
    
    //variable
    bool live;
    address owner;
    candidator[] public candidatorlist;
    
    
    
    //mapping
    mapping(address => bool) Voted;
    
    
    //event
    event AddCandidator(string name);
    event UpVote(string candidator, uint upVote);
    event FinishVote(bool live);
    event Voting(address owner);
    
    //modifier
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    //constructor
    constructor() public {
        owner = msg.sender;
        live = true;
        
        emit Voting(owner);
    }
    
    
    //candidator
    function addCandidator(string _name) public onlyOwner{
        require(live == true);
        require(candidatorlist.length < 5);
        candidatorlist.push(candidator(_name, 0));
        
            //emit event
            emit AddCandidator(_name); 
    }
    //voting
    function upVote(uint _indexOfCandidator) public{
        require(_indexOfCandidator < candidatorlist.length);
        require(Voted[msg.sender] == false);
        candidatorlist[_indexOfCandidator].upVote++;
        
        Voted[msg.sender] = true;
        
        
        emit UpVote(candidatorlist[_indexOfCandidator].name, candidatorlist[_indexOfCandidator].upVote);
    }
    //finish
    function finishVote() public onlyOwner{
        live = false;
        
        emit FinishVote(live);
    }
}
