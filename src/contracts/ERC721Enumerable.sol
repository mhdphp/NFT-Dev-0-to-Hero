// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './ERC721.sol'; // in order to get access to the _mint and other functions
import './interfaces/IERC721Enumerable.sol';


contract ERC721Enumerable is IERC721Enumerable, ERC721, {

    uint256[] private _allTokens;

    // mapping from tokenId to position (index) in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;
    // mapping from owner address to list (array) of all owned tokenIds
    mapping(address => uint256[]) private _ownedTokens;
    // mapping from tokenId to index of the owner tokens list
    mapping(uint256 => uint256) private _owenedTokensIndex;


    /// @notice Enumerate valid NFTs
    /// @dev Throws if `_index` >= `totalSupply()`.
    /// @param _index A counter less than `totalSupply()`
    /// @return The token identifier for the `_index`th NFT,
    ///  (sort order not specified)
    function tokenByIndex(uint256 _index) public view override returns (uint256){
        require(_index <= totalSupply(), 'global index is out of bounds!');
        return _allTokens[_index];
    }

    /// @notice Enumerate NFTs assigned to an owner
    /// @dev Throws if `_index` >= `balanceOf(_owner)` or if
    ///  `_owner` is the zero address, representing invalid NFTs.
    /// @param _owner An address where we are interested in NFTs owned by them
    /// @param _index A counter less than `balanceOf(_owner)`
    /// @return The token identifier for the `_index`th NFT assigned to `_owner`,
    ///   (sort order not specified)
    function tokenOfOwnerByIndex(address _owner, uint256 _index) public view override returns (uint256){
        require(_index <= balanceOf(_owner), 'owner index is out of bounds!');
        return _ownedTokens[_owner][_index];
    }

    function _mint(address to, uint256 tokenId) internal override(ERC721){
        // access the _mint() function from ERC721.sol contract
        super._mint(to, tokenId);

        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _addTokensToAllTokenEnumeration(uint256 tokenId) private{
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private{
        // 1. add address and token id to the _ownedTokens
        _ownedTokens[to].push(tokenId);
        // 2. ownedTokensIndex token id set to address of ownedTokens position
        _owenedTokensIndex[tokenId] = _ownedTokens[to].length;
        // 3. execute this function with minting
    }

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() public view override returns (uint256){
        return _allTokens.length;
    }
}