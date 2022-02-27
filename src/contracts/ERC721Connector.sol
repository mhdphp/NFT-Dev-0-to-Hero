// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

// since ERC721Enumerable.sol is already inheriting ERC721.sol
// ERC721Connector.sol is inheriting ERC721.sol through ERCEnumerable.sol

import './ERC721Metadata.sol';
//import './ERC721.sol';
import './ERC721Enumerable.sol';

contract ERC721Connector is ERC721Metadata, ERC721Enumerable {

    constructor(string memory name, string memory symbol) ERC721Metadata(name, symbol) {

    }
}
