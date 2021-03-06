// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './interfaces/IERC721Metadata.sol';
import './ERC165.sol';


contract ERC721Metadata is IERC721Metadata, ERC165{
    string private _name;
    string private _symbol;

    constructor(string memory named, string memory symbolified){
        _registerInterface(bytes4(
            keccak256('name(bytes4)')^
            keccak256('symbol(bytes4)')
        ));
        _name = named;
        _symbol = symbolified;
    }

    // Only functions can be marked external. 
    // External functions are part of the contract interface and can be 
    // called from other contracts and transactions. 
    function name() external view override returns(string memory){
        return _name;
    }

    function symbol() external view override returns(string memory){
        return _symbol;
    }
}
