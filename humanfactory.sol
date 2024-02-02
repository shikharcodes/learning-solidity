pragma solidity >=0.5.0 <0.6.0;

contract HumanFactory {

  event NewHuman(uint humanId, string name, uint dna);
  
  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  
  struct Human {
    string name;
    uint dna;
  }

  Human[] public humans;

  mapping (uint => address) public humanToOwner;
  mapping (address => uint) ownerHumanCount;

  function _createHuman(string memory _name, uint _dna) internal {
    uint id = humans.push(Human(_name, _dna)) - 1;
    humanToOwner[id] = msg.sender;
    ownerHumanCount[msg.sender]++;
    emit NewHuman(id, _name, _dna);
  }

  function _generateRandomDna(string memory _str) private view returns(uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  function createRandomHuman(string memory _name) public {
    require(ownerHumanCount[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    _createHuman(_name, randDna);
  }
}
