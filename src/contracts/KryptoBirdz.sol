// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './ERC721Connector.sol';

// inherit all contracts from ERC721Connector
contract Kryptobird is ERC721Connector {

    // array to store our nfts
    string[] public kryptoBirdz;

    // check if the tokenId exists
    // save the imgs in a mapping structure
    mapping(string => bool) _kryptoBirdzExists;

    function mint(string memory _kryptoBird) public {
        // check if the _kryptoBird already exists / has been minted
        require(!_kryptoBirdzExists[_kryptoBird], "Error: _kryptoBird already exists");
        // uint256	_id = kryptoBirdz.push(_kryptoBird); deprecated
        kryptoBirdz.push(_kryptoBird);
        uint _id = kryptoBirdz.length - 1;

        // use the function from ERC721
        _mint(msg.sender, _id);
    }
   
    constructor() ERC721Connector('KryptoBird','KBIRDZ') {
       
    }
}
