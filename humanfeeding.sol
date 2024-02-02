pragma solidity >=0.5.0 <0.6.0;

import "./humanfactory.sol";

// creating an interface to use the Cryptokitty contract

contract KittyInterface {

  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes  
  );
    
}

contract HumanFeeding is HumanFactory {

  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;

  KittyInterface kittyContract = kittyInterface(ckAddress);
  
  function feedAndMultiply(uint _humanId, uint _targetDna) public {
    require(msg.sender == humanToOwner[_humanId]);
    Human storage myHuman = humans[_humanId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myHuman.dna + _targetDna) / 2;
    _createHuman("NoName", newDna);
  }

  function feedOnKitty(uint _humanId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_humanId, kittyDna);
  }
  
}
