// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './ERC721.sol'; // in order to get access to the _mint function

contract ERC721Enumerable is ERC721 {

    uint256[] private _allTokens;

    // mapping from tokenId to position (index) in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;
    // mapping from owner to list (array) of all owned tokenIds
    mapping(uint256 => uint256[]) private _ownedTokens;
    // mapping from tokenId to index of the owner tokens list
    mapping(uint256 => uint256) private _owenedTokensIndex;


    /// @notice Enumerate valid NFTs
    /// @dev Throws if `_index` >= `totalSupply()`.
    /// @param _index A counter less than `totalSupply()`
    /// @return The token identifier for the `_index`th NFT,
    ///  (sort order not specified)
    function tokenByIndex(uint256 _index) external view returns (uint256){

    }

    /// @notice Enumerate NFTs assigned to an owner
    /// @dev Throws if `_index` >= `balanceOf(_owner)` or if
    ///  `_owner` is the zero address, representing invalid NFTs.
    /// @param _owner An address where we are interested in NFTs owned by them
    /// @param _index A counter less than `balanceOf(_owner)`
    /// @return The token identifier for the `_index`th NFT assigned to `_owner`,
    ///   (sort order not specified)
    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256){

    }

    function _mint(address to, uint256 tokenId) internal override(ERC721){
        // access the _mint() function from ERC721.sol contract
        super._mint(to, tokenId);

        _addTokensToTotalSupply(tokenId);
    }

    function _addTokensToTotalSupply(uint256 tokenId) private{
        _allTokens.push(tokenId);
    }

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() external view returns (uint256){
        return _allTokens.length;

    }
}