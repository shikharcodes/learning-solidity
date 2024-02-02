pragma solidity >=0.5.0 <0.6.0;

contract HumanFactory {
  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  
  struct Human {
    string name;
    uint dna;
  }

  Human[] public humans;

  event NewHuman(uint humanId, string name, uint dna);

  function _createHuman(string memory _name, uint _dna) private {
    uint id = humans.push(Human(_name, _dna));
    emit NewHuman(id, _name, _dna);
  }

  function _generateRandomDna(string memory _str) private view returns(uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  function createRandomHuman(string memory _name) public {
    uint randDna = _generateRandomDna(_name);
    _createHuman(_name, randDna);
  }
}
