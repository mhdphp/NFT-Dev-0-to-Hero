// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './ERC721Connector.sol';

// inherit all in ERC721Connector
contract Kryptobird is ERC721Connector {

    // Inherit the name and symbol from ERC721Connector
    // so that the name is KryptoBird, and symbol is KBIRDZ

    constructor() ERC721Connector('KryptoBird','KBIRDZ') {
       
    }
}
