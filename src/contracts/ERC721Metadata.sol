// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract ERC721Metadata {

    string private _name;
    string private _symbol;

    constructor(string memory named, string memory symbolified){
        _name = named;
        _symbol = symbolified;
    }

    // Only functions can be marked external. 
    // External functions are part of the contract interface and can be 
    // called from other contracts and transactions. 
    function name() external view returns(string memory){
        return _name;
    }

    function symbol() external view returns(string memory){
        return _symbol;
    }

}